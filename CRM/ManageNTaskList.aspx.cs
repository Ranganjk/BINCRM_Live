using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Globalization;
using PMS;
using System.Drawing;
using System.Security.Cryptography;
using System.IO;
using System.Data.Common;
using System.Text;
using System.Net;
using Telerik.Charting;
using System.Web.Services;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.Collections;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.UI.DataVisualization.Charting;

public partial class ManageNTaskList : System.Web.UI.Page
{
    string Desig;
    string QSUserName;
    string QSPassword;
    string strUserLevel;
    int LMode;
    DataTable dtTemp = new DataTable();
    SQLProcs sqlobj = new SQLProcs();

    public static DataTable dtTargets;
    public static DataSet dsTarget;
    public static DataSet dsEmpDet;
    public static DataSet dsTargetDet;


    DataSet dsGrid = new DataSet();

    #region Page Pre-Init: force uplevel browser setting
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (BrowserCompatibility.IsUplevel)
        {
            Page.ClientTarget = "uplevel";
        }
    }
    #endregion


    protected void Page_Load(object sender, EventArgs e)
    {
        string strcnfresultid = CnfResult.ClientID.ToString();
        if (Session["UserID"] == null)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }       

        btnNewBiz.Visible = false;
       
        rwLeadSource.VisibleOnPageLoad = true;
        rwLeadSource.Visible = false;

        rwReference.VisibleOnPageLoad = true;
        rwReference.Visible = false;


        rwDiary.VisibleOnPageLoad = true;
        rwDiary.Visible = false;

        rwCustomerProfile.VisibleOnPageLoad = true;
        rwCustomerProfile.Visible = false;


        rwBusinessDashboard.VisibleOnPageLoad = true;
        rwBusinessDashboard.Visible = false;

        rwAddCustomer.VisibleOnPageLoad = true;
        rwAddCustomer.Visible = false;

        rwStatusHelp.VisibleOnPageLoad = true;
        rwStatusHelp.Visible = false;

        rwwelcome.VisibleOnPageLoad = true;
        rwwelcome.Visible = false;
      
        QSUserName = Session["UserID"].ToString();
        HDLoginUser.Value = Session["UserID"].ToString();
       // Session["UserID"] = HDLoginUser.Value.ToString();
    

        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;

        rwSSavetime.VisibleOnPageLoad = true;
        rwSSavetime.Visible = false;

        rwReferenceHelp.VisibleOnPageLoad = true;
        rwReferenceHelp.Visible = false;

        rwChangeStatus.VisibleOnPageLoad = true;
        rwChangeStatus.Visible = false;

        rwROL.VisibleOnPageLoad = true;
        rwROL.Visible = false;

        rwServicedetails.VisibleOnPageLoad = true;
        rwServicedetails.Visible = false;

        rwGraph.VisibleOnPageLoad = true;
        rwGraph.Visible = false;

        lblLoginDays.Visible = false;
        if (!IsPostBack)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }        
            dtpTaskDate1.SelectedDate = DateTime.Now.Date;

            LoadMasters();          
            LoadDDL1();
            LoadDDL2();
            
            LoadTrackOn();        

           // LoadCompanyDetails();

            //LoadProspectCount();         
            //LoadSaveTime();

            lblnrf.Visible = false;
            btnCUpate.Visible = false;
            btnContacts.Visible = false;
            btnservice.Visible = false;

            ddlTaskList1.SelectedIndex = 1;
            ddlTaskList2.SelectedIndex = 1;

            dtpchangestatusfollowupdate.MinDate = DateTime.Today;
            btnChangeStatus.Enabled = false;         

            lblnotesentry.Text = "Note:Whatever you write in the box above will be recorded as a diary entry for the prospect. Please write atleast 6 characters.";

            //LoadDefault();
            AddAttributes();
            LoginDetails(QSUserName);

            //if (Session["EditProfile"] != null)
            //{
            //    RadTabStrip1.SelectedIndex = 3;
            //    RadMultiPage1.SelectedIndex = 5;
            //    //LoadCustomerProfile();
            //}

            DataSet dswelcome = sqlobj.SQLExecuteDataset("SP_Remindnote");
            int iusercount = Convert.ToInt32(dswelcome.Tables[0].Rows[0]["usercount"].ToString());
            int icustomercount = Convert.ToInt32(dswelcome.Tables[1].Rows[0]["customercount"].ToString());

            if (iusercount == 1 || icustomercount == 1)
            {
                rwwelcome.CssClass = "availability";
                rwwelcome.Visible = true;
            }
            else
            {
                string strUserLevel = Session["UserLevel"].ToString();
                if ((strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head"))
                {
                    LoadGraph();
                }    
            }
            ddlCountry.SelectedValue = RegionInfo.CurrentRegion.DisplayName;
            //wsgetLatestbtn_Click(sender, e);
            btnMyTasks_Click(sender, e);
            RdGrd_TaskDetDir2.Visible = false;
            RdGrd_TaskDetDir1.Visible = true;
            //btnView_Click2(sender, e);         
        }
    }

    private void LoadGraph()
    {
        BindEnquiriesChart();
        BindQuotationsChart();
        LoadWorkProgressSummary();
        rwGraph.Visible = true;
    }


    private void LoadWorkProgressSummary()
    {
        try
        {

            DataSet dsworkprogresssummary = sqlobj.SQLExecuteDataset("SP_IGWorkInProgresssummary");

            if (dsworkprogresssummary.Tables[0].Rows.Count > 0)
            {



                // color list

                List<string> colorList = new List<string>();
                colorList.Add("Red");
                colorList.Add("Green");
                colorList.Add("Yellow");
                colorList.Add("Purple");
                colorList.Add("Orange");
                colorList.Add("Blue");
                colorList.Add("Brown");
                colorList.Add("Teal");
                colorList.Add("SkyBlue");
                colorList.Add("Flusia");
                colorList.Add("Pink");


                DataTable dtbc = dsworkprogresssummary.Tables[0];

                Legend celegneds = new Legend("WorkProgressSummary");
                ;

                //storing total rows count to loop on each Record
                string[] XPointMember = new string[dtbc.Rows.Count];
                int[] YPointMember = new int[dtbc.Rows.Count];

                for (int count = 0; count < dtbc.Rows.Count; count++)
                {


                    cWorkProgressSummary.Series["WorkProgressSummary"].Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
                    //cWorkProgressSummary.Series["WorkProgressSummary"].Points[count].Color = Color.FromName(colorList[count]);


                }



                cWorkProgressSummary.Series["WorkProgressSummary"].ChartType = SeriesChartType.Column;



                cWorkProgressSummary.Legends.Add(celegneds);


                cWorkProgressSummary.Series["WorkProgressSummary"].IsVisibleInLegend = true;
                cWorkProgressSummary.Series["WorkProgressSummary"].IsValueShownAsLabel = true;
                cWorkProgressSummary.Series["WorkProgressSummary"].ToolTip = "#VALX  - #VALY";

                cWorkProgressSummary.Legends["WorkProgressSummary"].LegendStyle = LegendStyle.Table;
                cWorkProgressSummary.Legends["WorkProgressSummary"].TableStyle = LegendTableStyle.Wide;
                cWorkProgressSummary.Legends["WorkProgressSummary"].Docking = Docking.Bottom;

                cWorkProgressSummary.Series[0].YValuesPerPoint = 1;

                cWorkProgressSummary.BackColor = Color.AliceBlue;
                cWorkProgressSummary.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;



                cWorkProgressSummary.Titles.Add("Work Progress Summary");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void BindEnquiriesChart()
    {
        DataSet dsbcenquiries = sqlobj.SQLExecuteDataset("SP_BarchartEnquiries",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
            );


        List<string> colorList = new List<string>();
        colorList.Add("Orange");
        colorList.Add("Green");
        colorList.Add("Red");
        colorList.Add("Yellow");
        colorList.Add("Purple");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");


        DataTable dtbc = dsbcenquiries.Tables[0];

        Legend celegneds = new Legend("Enquiries");
        Series cqseries = new Series("Enquiries");


        //storing total rows count to loop on each Record
        string[] XPointMember = new string[dtbc.Rows.Count];
        int[] YPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtbc.Rows.Count; count++)
        {

            cqseries.Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
            cqseries.Points[count].Color = Color.FromName(colorList[count]);

            //storing Values for X axis
            //XPointMember[count] = dtbc.Rows[count]["Type"].ToString();
            //storing values for Y Axis
            //YPointMember[count] = Convert.ToInt32(dtbc.Rows[count]["Count"]);



        }

        //binding chart control
        // cQuotations.Series[0].Points.DataBindXY(XPointMember, YPointMember);

        //Setting width of line
        //cQuotations.Series[0].BorderWidth = 10;
        //setting Chart type 
        //cQuotations.Series[0].ChartType = SeriesChartType.Column;



        cqseries.ChartType = SeriesChartType.Pie;


        cEnquiries.Legends.Add(celegneds);
        cEnquiries.Series.Add(cqseries);

        cEnquiries.Series["Enquiries"].IsVisibleInLegend = true;
        cEnquiries.Series["Enquiries"].IsValueShownAsLabel = true;
        cEnquiries.Series["Enquiries"].ToolTip = "#VALX  - #VALY";



        cEnquiries.Legends["Enquiries"].LegendStyle = LegendStyle.Table;
        cEnquiries.Legends["Enquiries"].TableStyle = LegendTableStyle.Wide;
        cEnquiries.Legends["Enquiries"].Docking = Docking.Bottom;

        cEnquiries.BackColor = Color.AliceBlue;
        cEnquiries.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

        cEnquiries.Titles.Add("Enquiries");

        dsbcenquiries.Dispose();


    }

    private void BindQuotationsChart()
    {
        DataSet dsbcenquiries = sqlobj.SQLExecuteDataset("SP_BarChartQuotations",
          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
          );


        // color list

        List<string> colorList = new List<string>();
        colorList.Add("Orange");
        colorList.Add("Green");
        colorList.Add("Blue");
        colorList.Add("Brown");
        colorList.Add("Teal");
        colorList.Add("Purple");
        colorList.Add("Red");
        colorList.Add("Yellow");
        colorList.Add("SkyBlue");
        colorList.Add("Flusia");
        colorList.Add("Pink");


        // Count

        DataTable dtbc = dsbcenquiries.Tables[0];

        Legend celegneds = new Legend("Quotation");
        Series cqseries = new Series("Quotation");

        //storing total rows count to loop on each Record
        string[] XPointMember = new string[dtbc.Rows.Count];
        int[] YPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtbc.Rows.Count; count++)
        {

            cqseries.Points.AddXY(dtbc.Rows[count]["Type"].ToString(), Convert.ToInt32(dtbc.Rows[count]["Count"]));
            cqseries.Points[count].Color = Color.FromName(colorList[count]);

        }



        cqseries.ChartType = SeriesChartType.Pie;



        cQuotations.Legends.Add(celegneds);
        cQuotations.Series.Add(cqseries);



        cQuotations.Series["Quotation"].IsValueShownAsLabel = true;
        cQuotations.Series["Quotation"].ToolTip = "#VALX  - #VALY";

        //cQuotations.Legends["Quotaion"].CellColumns.Add(new LegendCellColumn("Name", LegendCellColumnType.Text, "#LEGENDTEXT"));

        //cQuotations.Legends["Quotation"].DockedToChartArea = "Default";
        //cQuotations.Series["Quotation"].IsVisibleInLegend = true;



        // cQuotations.Legends["Quotation"].LegendStyle = LegendStyle.Table;
        // cQuotations.Legends["Quotation"].TableStyle = LegendTableStyle.Wide;
        //cQuotations.Legends["Quotation"].Docking = Docking.Bottom;

        cQuotations.Legends["Quotation"].LegendStyle = LegendStyle.Table;
        cQuotations.Legends["Quotation"].TableStyle = LegendTableStyle.Wide;
        cQuotations.Legends["Quotation"].Docking = Docking.Bottom;


        cQuotations.BackColor = Color.AliceBlue;
        cQuotations.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;


        cQuotations.Titles.Add("Quotations - Count");



        // Value


        DataTable dtqv = dsbcenquiries.Tables[0];

        Legend cqvlegneds = new Legend("QuotationValue");
        Series cqvseries = new Series("QuotationValue");

        //storing total rows count to loop on each Record
        string[] XqvPointMember = new string[dtbc.Rows.Count];
        int[] YqvPointMember = new int[dtbc.Rows.Count];

        for (int count = 0; count < dtqv.Rows.Count; count++)
        {

            cqvseries.Points.AddXY(dtqv.Rows[count]["Type"].ToString(), Convert.ToInt32(dtqv.Rows[count]["value"]));
            cqvseries.Points[count].Color = Color.FromName(colorList[count]);

        }



        cqvseries.ChartType = SeriesChartType.Pie;

        cQuotationsValue.Legends.Add(cqvlegneds);
        cQuotationsValue.Series.Add(cqvseries);


        cQuotationsValue.Series["QuotationValue"].IsVisibleInLegend = true;
        cQuotationsValue.Series["QuotationValue"].IsValueShownAsLabel = true;
        cQuotationsValue.Series["QuotationValue"].ToolTip = "#VALX  - #VALY";




        cQuotationsValue.Legends["QuotationValue"].LegendStyle = LegendStyle.Table;
        cQuotationsValue.Legends["QuotationValue"].TableStyle = LegendTableStyle.Wide;
        cQuotationsValue.Legends["QuotationValue"].Docking = Docking.Bottom;

        cQuotationsValue.BackColor = Color.AliceBlue;
        cQuotationsValue.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;

        cQuotationsValue.Titles.Add("Quotations - Value");


        dsbcenquiries.Dispose();

    }

    private void AddAttributes()
    {
        Button2.Attributes.Add("onclick", "javascript:return NavigateNewTask('" + wsgetLatestbtn.ClientID + "');");
        Button1.Attributes.Add("onclick", "javascript:return NavigateNewTask('" + wsgetLatestbtn.ClientID + "');");
        btnnewenquiry.Attributes.Add("onclick", "javascript:return NavigateNewEnquiry('" + wsgetLatestbtn.ClientID + "');");
        btnbymenewenquiry.Attributes.Add("onclick", "javascript:return NavigateNewEnquiry('" + wsgetLatestbtn.ClientID + "');");
        //btnAddContacts.Attributes.Add("click", "javascript:return Validate();");
        
        btnSTSave.Attributes.Add("onclick", "javascript: return ConfirmSave();");
        btnROLSave.Attributes.Add("onclick", "javascript: return ConfirmMsg();");
        btnLSSave.Attributes.Add("onclick", "javascript: return ConfirmMsg();");
        btnCSave.Attributes.Add("onclick", "javascript: return ConfirmMsg();");
        btnAddService.Attributes.Add("onclick", "javascript: return ConfirmServiceMsg();");
        btnChangeStatusUpdate.Attributes.Add("onclick", "javascript: return ConfirmStatusUpdateMsg();");
        btnROLUpdate.Attributes.Add("onclick", "javascript: return ConfirmUpdateMsg();");
        btnCUpate.Attributes.Add("onclick", "javascript: return ConfirmUpdateMsg();");
    }

    private void LoginDetails(string UserName)
    {
        StringBuilder sbLogin = new StringBuilder();
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsLoginDays = sqlobj.SQLExecuteDataset("proc_getLoginAuditDays",
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UserName });
            if (dsLoginDays.Tables[0].Rows.Count > 0)
            {
                if (dsLoginDays.Tables[0].Rows[0][0].ToString() != "0")
                {
                    sbLogin.AppendLine(dsLoginDays.Tables[0].Rows[0][0].ToString());
                    sbLogin.AppendLine(Environment.NewLine);
                    lblLoginDays.Visible = true;
                    lblLoginDays.Text = sbLogin.ToString();
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "HideLabel();", true);
                }

            }        
        }
        catch (Exception ex)
        {
        }
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        //custom logic that does not require confirmation
        RadWindowManager1.RadConfirm("Are you sure you want to perform this action?", "confirmCallbackFn", 300, 200, null, "Confirm");
        //no further logic is here. The necessary data can be stored in hidden fields or in the session for later use.
    }

    protected void LoadMasters()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster1",
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = QSUserName });
            DataSet dsROL = sqlobj.SQLExecuteDataset("proc_GetROLCount",
                    new SqlParameter() { ParameterName = "@StaffName", SqlDbType = SqlDbType.VarChar, Value = QSUserName });
            if (dsROL.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt16(dsROL.Tables[0].Rows[0][0].ToString()) != 0 || Convert.ToInt16(dsROL.Tables[0].Rows[1][0].ToString()) != 0)
                {
                    lblLikeandrecog.Text = "Recognition (" + dsROL.Tables[0].Rows[0][0].ToString() + ")" + "/" + "Like (" + dsROL.Tables[0].Rows[1][0].ToString() + ")";
                }
            }

            if (dsMasters.Tables[0].Rows.Count > 0)
            {
                Session["StaffName"] = Convert.ToString(dsMasters.Tables[0].Rows[0]["StaffName"].ToString());
            }

            if (dsMasters.Tables[1].Rows.Count > 0)
            {
                strUserLevel = dsMasters.Tables[1].Rows[0]["UserLevel"].ToString();

                Session["UserLevel"] = strUserLevel.ToString();
                if (!(strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head"))
                {
                    btnCSave.Visible = false;
                    btnCUpate.Visible = false;
                    btnLSSave.Visible = false;
                }
            }

            if (dsMasters.Tables[2].Rows.Count > 0)
            {
                ddlCCustStatus.DataSource = dsMasters.Tables[2];
                ddlCCustStatus.Dispose();
            }

            if (dsMasters.Tables[3].Rows.Count > 0)
            {
                ddlBudget.Items.Clear();
                ddlBudget.DataSource = dsMasters.Tables[3];
                ddlBudget.DataValueField = "Budgetdesc";
                ddlBudget.DataTextField = "Budgetdesc";
                ddlBudget.DataBind();
                ddlBudget.Dispose();
                ddlBudget.Items.Insert(0, "");
            }

            if (dsMasters.Tables[4].Rows.Count > 0)
            {
                ddlACManager.Items.Clear();

                ddlACManager.DataSource = dsMasters.Tables[4];
                ddlACManager.DataValueField = "UserName";
                ddlACManager.DataTextField = "StaffName";
                ddlACManager.DataBind();
                ddlACManager.Items.Insert(0, "");
            }

            if (dsMasters.Tables[5].Rows.Count != 0)
            {
                lbloncomingfollowupstatus.Text = "Alert! You have various followups coming up.";
                lbloncomingfollowupstatus.BackColor = Color.White;
                lbloncomingfollowupstatus.ForeColor = Color.Red;
            }
            else
            {
                lbloncomingfollowupstatus.Text = "No followups scheduled for now in the next 7 days.";
                lbloncomingfollowupstatus.BackColor = Color.White;
                lbloncomingfollowupstatus.ForeColor = Color.Green;
            }

            if (dsMasters.Tables[6].Rows.Count != 0)
            {
                lbloverdurefollowupstatus.Text = "There are overdue followups, please attend to them";
                lbloverdurefollowupstatus.BackColor = Color.White;
                lbloverdurefollowupstatus.ForeColor = Color.Red;
            }
            else
            {
                lbloverdurefollowupstatus.Text = "Great! There are no overdue followups";
                lbloverdurefollowupstatus.BackColor = Color.White;
                lbloverdurefollowupstatus.ForeColor = Color.Green;
            }

            if (dsMasters.Tables[7].Rows.Count != 0)
            {
                lbloverduetaskstatus.Text = "Alert! There are delays in work completion.";
                lbloverduetaskstatus.BackColor = Color.White;
                lbloverduetaskstatus.ForeColor = Color.Red;
            }
            else
            {
                lbloverduetaskstatus.Text = "All activities on schedule. No delays!";
                lbloverduetaskstatus.BackColor = Color.White;
                lbloverduetaskstatus.ForeColor = Color.Green;
            }


            if (dsMasters.Tables[8].Rows.Count > 0)
            {
                string strISCM = dsMasters.Tables[8].Rows[0]["ISCM"].ToString();

                if (strISCM == "True")
                {
                    //btnNewBiz.Visible = true;
                    btnBusinessDashboard.Visible = true;
                }
                else
                {
                    btnNewBiz.Visible = false;
                    btnBusinessDashboard.Visible = false;
                }
            }
        }
        catch(SqlException ex)
        {
            WebMsgBox.Show("Please check your internet connection");
            return;
        }
    }

    protected void ISEnableViewPoint()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCompanyInformation = new DataSet();
        dsCompanyInformation = sqlobj.SQLExecuteDataset("sp_LoadCompanyInformation");
        if (dsCompanyInformation.Tables[0].Rows.Count > 0)
        {
            string strISCM = dsCompanyInformation.Tables[0].Rows[0]["ISCM"].ToString();
            if (strISCM == "True")
            {
                btnNewBiz.Visible = true;
            }
            else
            {
                btnNewBiz.Visible = false;
            }
        }
        dsCompanyInformation.Dispose();
    }
    protected void LoadCompanyDetails()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCompanyDetails = new DataSet();

        dsCompanyDetails = sqlobj.SQLExecuteDataset("SP_GetCompanyDetails");
        if (dsCompanyDetails.Tables[0].Rows.Count != 0)
        {
            Session["ProductName"] = dsCompanyDetails.Tables[0].Rows[0]["productname"].ToString();
            Session["ProductByLine"] = dsCompanyDetails.Tables[0].Rows[0]["productbyline"].ToString();
            Session["Version"] = dsCompanyDetails.Tables[0].Rows[0]["versionnumber"].ToString();
            Session["CompanyName"] = dsCompanyDetails.Tables[0].Rows[0]["companyname"].ToString();      
        }
        dsCompanyDetails.Dispose();
    }

    protected void LoadStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsoncomingfollowupdate = new DataSet();
        DataSet dsoverdurefolloupdate = new DataSet();
        DataSet dsoverduetasks = new DataSet();

        dsoncomingfollowupdate = sqlobj.SQLExecuteDataset("sp_CountOnComingFollowup");

        if (dsoncomingfollowupdate.Tables[0].Rows.Count != 0)
        {
            lbloncomingfollowupstatus.Text = "[OnComing Followups exist]";
            lbloncomingfollowupstatus.BackColor = Color.White;
            lbloncomingfollowupstatus.ForeColor = Color.Red;
        }
        else
        {
            lbloncomingfollowupstatus.Text = "[No OnComing Followups]";
            lbloncomingfollowupstatus.BackColor = Color.White;
            lbloncomingfollowupstatus.ForeColor = Color.Green;

        }

        dsoncomingfollowupdate.Dispose();

        dsoverdurefolloupdate = sqlobj.SQLExecuteDataset("sp_CountOverdueFollowup");


        if (dsoverdurefolloupdate.Tables[0].Rows.Count != 0)
        {
            lbloverdurefollowupstatus.Text = "[Followups Overdue]";
            lbloverdurefollowupstatus.BackColor = Color.White;
            lbloverdurefollowupstatus.ForeColor = Color.Red;
        }
        else
        {
            lbloverdurefollowupstatus.Text = "[No Overdue Followups]";
            lbloverdurefollowupstatus.BackColor = Color.White;
            lbloverdurefollowupstatus.ForeColor = Color.Green;
        }

        dsoverdurefolloupdate.Dispose();

        dsoverduetasks = sqlobj.SQLExecuteDataset("sp_CountOverdueTasks");

        if (dsoverduetasks.Tables[0].Rows.Count != 0)
        {
            lbloverduetaskstatus.Text = "[Overdue tasks exist]";
            lbloverduetaskstatus.BackColor = Color.White;
            lbloverduetaskstatus.ForeColor = Color.Red;
        }
        else
        {
            lbloverduetaskstatus.Text = "[No Overdue tasks]";
            lbloverduetaskstatus.BackColor = Color.White;
            lbloverduetaskstatus.ForeColor = Color.Red;
        }

        dsoverduetasks.Dispose();

    }

    protected void LoadProspectCount()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectCount = new DataSet();

        dsProspectCount = sqlobj.SQLExecuteDataset("sp_prospectcount");
        if (dsProspectCount.Tables[0].Rows.Count != 0)
        {
            //lblLead.Text = "Leads:" + dsProspectCount.Tables[0].Rows[0]["Lead"].ToString();
            //lblCustomer.Text = "Customers:" + dsProspectCount.Tables[0].Rows[0]["Customer"].ToString();
            //lblVendor.Text = "Vendors:" + dsProspectCount.Tables[0].Rows[0]["Vendor"].ToString();
            //lblOther.Text = "Others:" + dsProspectCount.Tables[0].Rows[0]["Other"].ToString();


        }

        dsProspectCount.Dispose();
    }

    protected void GetUserDet()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsUserDet = new DataSet();
            dsUserDet = sqlobj.SQLExecuteDataset("SP_FetchUserDet",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = QSUserName });

            //lblUser.Text = dsUserDet.Tables[0].Rows[0]["UserDet"].ToString();
            Session["StaffName"] = Convert.ToString(dsUserDet.Tables[0].Rows[0]["StaffName"].ToString());
            dsUserDet.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void FetchPassword()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsPassword = new DataSet();
            dsPassword = sqlobj.SQLExecuteDataset("SP_FetchPassword",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = QSUserName });

            QSPassword = dsPassword.Tables[0].Rows[0]["Password"].ToString();
            dsPassword.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    protected void LoadCompleInDays()
    {
        List<string> CDays = new List<string>() { "0", "1", "2", "3", "4", "5" };
        foreach (string Days in CDays)
        {
            //ddlComplDays.Items.Add(Days);            
        }
    }
  

    protected void btnExit_Click(object sender, EventArgs e)
    {
        InsertUsageLog();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
    protected void InsertUsageLog()
    {
        SQLProcs sqlobj = new SQLProcs();
        sqlobj.ExecuteSQLNonQuery("SP_LoginAudit",
                                      new SqlParameter() { ParameterName = "@Script", SqlDbType = SqlDbType.NVarChar, Value = "/ManageNTaskList.aspx" },
                                      new SqlParameter() { ParameterName = "@User", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                      new SqlParameter() { ParameterName = "@Action", SqlDbType = SqlDbType.NVarChar, Value = "Logout" },
                                      new SqlParameter() { ParameterName = "@Table", SqlDbType = SqlDbType.NVarChar, Value = GetIP4Address() });
    }
    public static string GetIP4Address()
    {
        string IP4Address = String.Empty;

        foreach (IPAddress IPA in Dns.GetHostAddresses(HttpContext.Current.Request.UserHostAddress))
        {
            if (IPA.AddressFamily.ToString() == "InterNetwork")
            {
                IP4Address = IPA.ToString();
                break;
            }
        }

        if (IP4Address != String.Empty)
        {
            return IP4Address;
        }

        foreach (IPAddress IPA in Dns.GetHostAddresses(Dns.GetHostName()))
        {
            if (IPA.AddressFamily.ToString() == "InterNetwork")
            {
                IP4Address = IPA.ToString();
                break;
            }
        }

        return IP4Address;
    }
    protected void btnMore_Click(object sender, EventArgs e)
    {
        //Response.Redirect("http://bincrm.com/vaudit/login.vbhtml/?Username=" + QSUserName + "&Password=" + QSPassword);
        Response.Redirect("http://cpc.covaiproperty.com/builderscrmadmintest/login.vbhtml/?Username=" + QSUserName + "&Password=" + QSPassword);
    }

    protected void btnhome_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageNTaskList.aspx?UserName=" + Session["UserID"].ToString());
    }

    //Page view 1
    protected void LoadDefaultPage()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsUserDet = new DataSet();
            dsUserDet = sqlobj.SQLExecuteDataset("SP_FetchHomePage",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = QSUserName });
            string HomePage = dsUserDet.Tables[0].Rows[0]["HomePageView"].ToString();
            dsUserDet.Dispose();
            if (HomePage == "1")
            {
                LMode = 9;              
            }

            else if (HomePage == "2")
            {
                LMode = 3;            
            }            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
   
    protected void btnTasksLess_Click(object sender, EventArgs e)
    {
        LoadDefaultPage();
    }

    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        if(e.Tab.SelectedIndex.ToString() == "1")
        {
            //btnView1_Click(sender, e);
            btnMyTasks_Click(sender, e);
        }
        else if(e.Tab.SelectedIndex.ToString() == "2")
        {            
            btnView2_Click(sender, e);
        }
        else if(e.Tab.SelectedIndex.ToString() == "3")
        {
            LoadCCustStatus();
            LoadLeadSource();
            LoadCampaign();
            LoadProspectDetails();
            LoadLeadCategory();
            LoadSaveTime();
        }
    }

    //Page view 1 ends


    //Page view 3

    protected void LoadDDL1()
    {
        ListItem[] items = new ListItem[5];
        items[0] = new ListItem("Please Select", "0");
        items[1] = new ListItem("In Progress", "1");
        items[2] = new ListItem("Priority Tasks", "7");
        items[3] = new ListItem("Done last 7 days", "2");
        items[4] = new ListItem("Completed (30Days Range)", "3");

        ddlTaskList1.Items.AddRange(items);
        ddlTaskList1.DataBind();

    }  

    protected void RdGrd_ProjectSel_ItemDataBound1(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {
            Telerik.Web.UI.GridDataItem item = e.Item as Telerik.Web.UI.GridDataItem;
            if (item != null)
            {
                if (!item.Cells[10].Text.Equals("&nbsp;"))
                {
                    if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("04"))
                    {
                        item.Cells[9].ForeColor = Color.Red;
                        item.Cells[10].ForeColor = Color.Red;
                        item.Cells[9].Font.Bold = true;
                        item.Cells[10].Font.Bold = true;
                    }
                    else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("03"))
                    {
                        item.Cells[9].ForeColor = Color.Red;
                        item.Cells[10].ForeColor = Color.Red;
                        item.Cells[9].Font.Bold = true;
                        item.Cells[10].Font.Bold = true;
                    }
                    else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("02"))
                    {
                        item.Cells[9].ForeColor = Color.Brown;
                        item.Cells[10].ForeColor = Color.Brown;
                    }



                }             

                if (item.Cells[14].Text.Equals("Hot") || item.Cells[14].Text.Equals("Very Hot"))
                {
                    item.Cells[14].ForeColor = Color.Red;
                }
                string GetDate = item.Cells[6].Text;
                string CurrDate = DateTime.Now.ToString("dd/MM/yyyy");

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ClearGrid1(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem itm in RdGrd_TaskDetDir1.Items)
            {

                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");

                if (chk.Checked == true)
                {
                    chk.Checked = false;
                }
            }
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private void LoadDefault()
    {
        HDUserID.Value = QSUserName;
        SQLProcs sqlobj = new SQLProcs();
        string StaffID = QSUserName;
        Session["StaffID"] = QSUserName;
        string StaffName = QSUserName;

        RdGrd_TaskDetDir1.Visible = true;     
        btnTaskDetDir1.Visible = true;      

        if (ddlTaskList1.SelectedIndex == 2 || ddlTaskList1.SelectedIndex == 3)
        {
            btnNewPing1.Visible = true;            
            btnNewPing2.Visible = false;
        }
        else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
        {
            btnNewPing1.Visible = true;           
            btnNewPing2.Visible = false;
            dtpTaskDate1.Visible = false;
        }
     
        LoadTaskDetDir1(StaffID);

        RadTabStrip1.SelectedIndex = 0;
        RadMultiPage1.SelectedIndex = 1;


        lblHelp11.Visible = true;        
        lblHelp44.Visible = false;
    }
   

    protected void LoadTaskDetDir1(string StaffID)
    {
        //RdGrd_TaskDetDir1.DataSource = null;
        //RdGrd_TaskDetDir1.DataBind();

        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTargetDet = null;
        dsTargetDet = sqlobj.SQLExecuteDataset("SP_FetchTaskDetDir3",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = ddlTaskList1.SelectedValue },
            new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NVarChar, Value = StaffID },
            new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpTaskDate1.SelectedDate },
            new SqlParameter() { ParameterName = "@FilterReference", SqlDbType = SqlDbType.NVarChar, Value = ddlMyTasksReference.SelectedValue == "All" ? null : ddlMyTasksReference.SelectedValue }
            );
        if (dsTargetDet.Tables[0].Rows.Count > 0)
        {
            dtTemp.Dispose();
            RdGrd_TaskDetDir1.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            lblmytaskscount.Text = "  Count:" + TypeRCount;
            RdGrd_TaskDetDir1.DataBind();
            ViewState["MyTasks"] = dsTargetDet.Tables[0];           
            dsTargetDet.Dispose();
        }
        else
        {
            RdGrd_TaskDetDir1.DataSource = null;
            RdGrd_TaskDetDir1.DataBind();
            //RdGrd_TaskDetDir1.Visible = false;
            lblmytaskscount.Text = "  Count:0";
            ViewState["MyTasks"] = dsTargetDet.Tables[0];          
        }
        RdGrd_TaskDetDir1.Visible = true;
    }


    protected void ddlTaskList1_Change(object sender, EventArgs e)
    {
        if (ddlTaskList1.SelectedIndex == 3 && RdGrd_TaskDetDir1.Visible == true)
        {
            dtpTaskDate1.Visible = true;
            btnNewPing1.Visible = true;

        }
        else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
        {
            dtpTaskDate1.Visible = false;
            btnNewPing1.Visible = true;            
            btnNewPing2.Visible = false;
        }
        else if (RdGrd_TaskDetDir1.Visible == true)
        {
            dtpTaskDate1.Visible = false;
            btnNewPing1.Visible = true;           
            btnNewPing2.Visible = false;
            btnTaskDetDir1.Visible = false;
        }
    }

    //Page view 3 ends

    //Page view 4
    protected void LoadDDL2()
    {
        ListItem[] items = new ListItem[4];
        items[0] = new ListItem("Please Select", "0");
        items[1] = new ListItem(" In progress", "1");
        items[2] = new ListItem("Done last 7 days", "2");
        items[3] = new ListItem("Completed (30 days range)", "3");

        ddlTaskList2.Items.AddRange(items);
        ddlTaskList2.DataBind();

    }
   

    protected void RdGrd_ProjectSel_ItemDataBound2(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        Telerik.Web.UI.GridDataItem item = e.Item as Telerik.Web.UI.GridDataItem;

        if (item != null)
        {
            if (!item.Cells[10].Text.Equals("&nbsp;"))
            {
                if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("04"))
                {
                    item.Cells[9].ForeColor = Color.Red;
                    item.Cells[10].ForeColor = Color.Red;
                    item.Cells[9].Font.Bold = true;
                    item.Cells[10].Font.Bold = true;
                }
                else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("03"))
                {
                    item.Cells[9].ForeColor = Color.Red;
                    item.Cells[10].ForeColor = Color.Red;
                    item.Cells[9].Font.Bold = true;
                    item.Cells[10].Font.Bold = true;
                }
                else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("02"))
                {
                    item.Cells[9].ForeColor = Color.Brown;
                    item.Cells[10].ForeColor = Color.Brown;
                }

            }           

            if (item.Cells[14].Text.Equals("Hot") || item.Cells[14].Text.Equals("Very Hot"))
            {
                item.Cells[14].ForeColor = Color.Red;
            }      

            string GetDate = item.Cells[6].Text;
            string CurrDate = DateTime.Now.ToString("dd/MM/yyyy");

        }
    }



    protected void ClearGrid2(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem itm in RdGrd_TaskDetDir2.Items)
            {

                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");

                if (chk.Checked == true)
                {
                    chk.Checked = false;
                }
            }
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    protected void btnView_Click2(object sender, EventArgs e)
    {
        
    }
    protected void LoadTaskDetDir2(string StaffID)
    {
        strUserLevel = Session["UserLevel"].ToString();
        if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTargetDet = null;

            if (chkShowAll.Checked == true)
            {
                dsTargetDet = sqlobj.SQLExecuteDataset("SP_FetchDelgateDetForShowAll",
                    new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = ddlTaskList2.SelectedValue },
                    new SqlParameter() { ParameterName = "@FilterReference", SqlDbType = SqlDbType.NVarChar, Value = ddlbymereference.SelectedValue == "All" ? null : ddlbymereference.SelectedValue }
                    );
            }
            else
            {
                dsTargetDet = sqlobj.SQLExecuteDataset("SP_FetchDelgateDetFor1and2",
                    new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = ddlTaskList2.SelectedValue },
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = StaffID },
                    new SqlParameter() { ParameterName = "@FilterReference", SqlDbType = SqlDbType.NVarChar, Value = ddlbymereference.SelectedValue == "All" ? null : ddlbymereference.SelectedValue }
                    );
            }
            if (dsTargetDet != null)
            {
                dtTemp.Dispose();
                RdGrd_TaskDetDir2.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblbymecount.Text = "  Count:" + TypeRCount;
                RdGrd_TaskDetDir2.DataBind();
                dsTargetDet.Dispose();
                ViewState["ByMe"] = dsTargetDet.Tables[0];
                RdGrd_TaskDetDir2.Visible = true;
            }
            else
            {
                RdGrd_TaskDetDir2.DataSource = null;
                RdGrd_TaskDetDir2.DataBind();
                RdGrd_TaskDetDir2.Visible = false;
                lblbymecount.Text = "  Count:0";
                ViewState["ByMe"] = dsTargetDet.Tables[0];               
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTargetDet = null;
            dsTargetDet = sqlobj.SQLExecuteDataset("SP_FetchDelgateDet",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = ddlTaskList2.SelectedValue },
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = StaffID });

            if (dsTargetDet != null)
            {
                dtTemp.Dispose();
                RdGrd_TaskDetDir2.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblbymecount.Text = "Count:" + TypeRCount;
                RdGrd_TaskDetDir2.DataBind();
                dsTargetDet.Dispose();
                RdGrd_TaskDetDir2.Visible = true;
                ViewState["ByMe"] = dsTargetDet.Tables[0];
            }
            else
            {
                RdGrd_TaskDetDir2.DataSource = null;
                RdGrd_TaskDetDir2.DataBind();
                ViewState["ByMe"] = dsTargetDet.Tables[0];
                WebMsgBox.Show("There are no records to display");
            }
        }
    }

    protected void ddlTaskList2_Change(object sender, EventArgs e)
    {
        if (ddlTaskList2.SelectedIndex == 3 && RdGrd_TaskDetDir2.Visible == true)
        {
            dtpTaskDate1.Visible = true;
            btnNewPing2.Visible = true;           
            btnNewPing1.Visible = false;
        }
        else if (ddlTaskList2.SelectedIndex == 4 || ddlTaskList2.SelectedIndex == 5)
        {
            dtpTaskDate1.Visible = true;
            btnNewPing2.Visible = true;           
            btnNewPing1.Visible = false;
        }
        else if (RdGrd_TaskDetDir2.Visible == true)
        {
            dtpTaskDate1.Visible = false;
            btnNewPing2.Visible = true;          
            btnNewPing1.Visible = false;
        }
    }

    //Page view 4 ends

    //Page view 5

   

    protected void RdGrd_ProjectSel_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        Telerik.Web.UI.GridDataItem item = e.Item as Telerik.Web.UI.GridDataItem;

        if (item != null)
        {
            if (!item.Cells[10].Text.Equals("&nbsp;"))
            {
                if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("04"))
                {
                    item.Cells[9].ForeColor = Color.Red;
                    item.Cells[10].ForeColor = Color.Red;
                    item.Cells[9].Font.Bold = true;
                    item.Cells[10].Font.Bold = true;
                }
                else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("03"))
                {
                    item.Cells[9].ForeColor = Color.Red;
                    item.Cells[10].ForeColor = Color.Red;
                    item.Cells[9].Font.Bold = true;
                    item.Cells[10].Font.Bold = true;
                }
                else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("02"))
                {
                    item.Cells[9].ForeColor = Color.Brown;
                    item.Cells[10].ForeColor = Color.Brown;
                }
            }
            string GetDate = item.Cells[6].Text;
            string CurrDate = DateTime.Now.ToString("dd/MM/yyyy");

        }
    } 

    //Page view 8 

    protected void LoadCCustStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        ddlCCustStatus.Items.Clear();

        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 16 });
        ddlCCustStatus.DataSource = dsCCustStatus.Tables[0];
        ddlCCustStatus.DataValueField = "StatusCode";
        ddlCCustStatus.DataTextField = "StatusDesc";
        ddlCCustStatus.DataBind();

        ddlCCustStatus.Dispose();
        ddlCCustStatus.Items.Insert(0, "Please Select");
        ddlCCustStatus.SelectedIndex = 0;
    }

    protected void LoadCSearchStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 16 });
        ddlSearchType.DataSource = dsCCustStatus.Tables[0];
        ddlSearchType.DataValueField = "StatusCode";
        ddlSearchType.DataTextField = "StatusDesc";
        ddlSearchType.DataBind();
        ddlCCustStatus.Dispose();
    }


    protected void LoadfilterProspectStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("sp_getsmr4status");
        ddlCCustStatus.DataSource = dsCCustStatus.Tables[0];
        ddlCCustStatus.Dispose();
    }


    protected void LoadLeadSource()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 17 });

        ddlLeadSource.Items.Clear();

        ddlLeadSource.DataSource = dsCCustStatus.Tables[0];
        ddlLeadSource.DataValueField = "LeadKey";
        ddlLeadSource.DataTextField = "LeadKey";
        ddlLeadSource.DataBind();
        ddlLeadSource.Dispose();

        ddlLeadSource.Items.Insert(0, "");

        gvMLeadSource.DataSource = dsCCustStatus.Tables[0];
        gvMLeadSource.DataBind();

    }

    protected void LoadCampaign()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 18 });

        ddlCompaign.Items.Clear();

        if (dsCCustStatus.Tables[0].Rows.Count > 0)
        {
            ddlCompaign.DataSource = dsCCustStatus.Tables[0];
            ddlCompaign.DataValueField = "Campaignvalue";
            ddlCompaign.DataTextField = "Campaignvalue";
            ddlCompaign.DataBind();
            ddlCompaign.Dispose();
        }
        ddlCompaign.Items.Insert(0, "");
    }

    protected void LoadBudget()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 19 });
        ddlBudget.DataSource = dsCCustStatus.Tables[0];
        ddlBudget.DataValueField = "Budgetdesc";
        ddlBudget.DataTextField = "Budgetdesc";
        ddlBudget.DataBind();
        ddlBudget.Dispose();
    }

    private void LoadProspectDetails()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_ProspectDetails");
        if (dsCCustStatus.Tables[0].Rows.Count > 0)
        {
            lbltotalcount.Text = "Count:" + dsCCustStatus.Tables[0].Rows.Count;
        }
        else
        {
            lbltotalcount.Text = "Count:0";
        }
        gvProspectDetails.DataSource = dsCCustStatus;
        gvProspectDetails.DataBind();
    }

    private void LoadLeadCategory()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsleadcategory = new DataSet();
        dsleadcategory = sqlobj.SQLExecuteDataset("SP_LoadCategory");
        ddlVipImp.Items.Clear();
        if (dsleadcategory.Tables[0].Rows.Count != 0)
        {
            ddlVipImp.DataSource = dsleadcategory;
            ddlVipImp.DataValueField = "Category";
            ddlVipImp.DataTextField = "Category";
            ddlVipImp.DataBind();
        }
        dsleadcategory.Dispose();
        ddlVipImp.Items.Insert(0, "");
    }

    protected void LoadTrackOn()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup_new");
        ddlTrackon.Items.Clear();

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {
            ddlTrackon.DataSource = dsTrackon.Tables[0];
            ddlTrackon.DataValueField = "TrackonDesc";
            ddlTrackon.DataTextField = "TrackGroup";
            ddlTrackon.DataBind();

            ddlMyTasksReference.DataSource = dsTrackon.Tables[0];
            ddlMyTasksReference.DataValueField = "TrackonDesc";
            ddlMyTasksReference.DataTextField = "TrackonDesc";
            ddlMyTasksReference.DataBind();

            ddlMyTasksReference.Items.Insert(0, "All");

            ddlbymereference.DataSource = dsTrackon.Tables[0];
            ddlbymereference.DataValueField = "TrackonDesc";
            ddlbymereference.DataTextField = "TrackonDesc";
            ddlbymereference.DataBind();

            ddlbymereference.Items.Insert(0, "All");
        }

        dsTrackon.Dispose();

        ddlTrackon.Items.Insert(0, "");
    }

    protected void LoadACManager()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsACManager = new DataSet();
        dsACManager = sqlobj.SQLExecuteDataset("SP_LoadACManager");

        ddlACManager.Items.Clear();

        if (dsACManager.Tables[0].Rows.Count != 0)
        {
            ddlACManager.DataSource = dsACManager.Tables[0];
            ddlACManager.DataValueField = "UserName";
            ddlACManager.DataTextField = "StaffName";
            ddlACManager.DataBind();
        }
        ddlACManager.Dispose();
        ddlACManager.Items.Insert(0, "");
    }  
    protected void btnCSave_Click(object sender, EventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();
        if (CnfResult.Value == "true")
        {
            if (txtCustName.Text != String.Empty && txtMob.Text != string.Empty)
            {

                string CustomerName;
                string EmailId;
                if (txtCustName.Text == string.Empty)
                {
                    CustomerName = "0";
                }
                else
                {
                    CustomerName = txtCustName.Text;
                }

                if (txtEml.Text == string.Empty)
                {
                    EmailId = "0";
                }
                else
                {
                    EmailId = txtEml.Text;
                }
                try
                {
                    Boolean viapost = false;
                    Boolean viamail = false;
                    Boolean viasms = false;

                    if (txtCustName.Text == "" || txtMob.Text == "")
                    {
                        WebMsgBox.Show("Please select or enter mandatory fields.");
                    }
                    else if (IsProspectExisting(txtCustName.Text, txtMob.Text))
                    {
                        WebMsgBox.Show("This prospect name and mobile-no combination exists.");
                    }
                    else
                    {
                        string strCampaign;
                        string strLeadSource;
                        string strBudget;
                        strCampaign = ddlCompaign.SelectedValue;
                        strLeadSource = ddlLeadSource.Text;
                        strBudget = ddlBudget.SelectedValue;
                        string strNotes = "";

                        if (ddlCompaign.SelectedValue != "")
                        {
                            strNotes = " #Campaign-" + ddlCompaign.SelectedValue;
                        }
                        if (ddlLeadSource.SelectedValue != "")
                        {
                            strNotes = strNotes.ToString() + " #LeadSource-" + ddlLeadSource.SelectedValue;
                        }
                        if (ddlTrackon.SelectedValue != "")
                        {
                            strNotes = strNotes.ToString() + " #Reference-" + ddlTrackon.SelectedValue;
                        }
                        string struid = Session["UserID"].ToString();

                        sqlobj.ExecuteSQLNonQuery("SP_insertprospects",
                                           new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlTitle.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtCustName.Text },
                                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCCustStatus.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue },
                                           new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorNo.Text },
                                           new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = txtStreet.Text },
                                           new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = txtCity.Text },
                                           new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = txtPostalCode.Text },
                                           new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = txtState.Text },
                                           new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = ddlCountry.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = txtPhoneNo.Text },
                                           new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtMob.Text },
                                           new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = txtEml.Text },
                                           new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = txtEml2.Text },
                                           new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlGender.SelectedValue == "" ? null : ddlGender.SelectedValue },
                                           new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                                           new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = ddlVipImp.SelectedValue == "" ? null : ddlVipImp.SelectedValue },

                                           new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = strNotes.ToString() + " " + txtNotes.Text },
                                           new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = ddlLeadSource.SelectedValue == "" ? null : ddlLeadSource.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = ddlCompaign.SelectedValue == "" ? null : ddlCompaign.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = ddlBudget.SelectedValue == "" ? null : ddlBudget.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = txtReq.Text },
                                           new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue == "" ? null : ddlTrackon.SelectedValue },

                                           new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                           new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = txtCompanyName.Text },
                                           new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = ddlACManager.SelectedValue == "" ? null : ddlACManager.SelectedValue }

                                           );                  


                        LoadProspectCount();
                        LoadPagingProspectDetails();                      
                        WebMsgBox.Show("New Profile Added.");
                        CClearScr();
                    }
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }
            }
            else
            {
                WebMsgBox.Show("Please enter the mandatory fields");
            }
        }
    }

    protected void btnGoogleMap_Click(object sender, EventArgs e)
    {
        string strlocation = txtStreet.Text + ",+" + txtCity.Text + ",+" + txtState.Text + ",+" + ddlCountry.Text;
        strlocation = strlocation.Replace(" ", "");   
        string url = "https://maps.google.co.in/maps/place/" + strlocation.ToString() + "";
        string s = "window.open('" + url + "', 'popup_window', 'width=800,height=600,left=250,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    protected void FindCoordinates()
    {
        string url = "http://maps.google.com/maps/api/geocode/xml?address=" + txtStreet.Text + "," + txtCity.Text + "," + txtState.Text + "," + ddlCountry.SelectedValue + "&sensor=false";
        WebRequest request = WebRequest.Create(url);
        using (WebResponse response = (HttpWebResponse)request.GetResponse())
        {
            using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                DataSet dsResult = new DataSet();
                dsResult.ReadXml(reader);
                DataTable dtCoordinates = new DataTable();
                dtCoordinates.Columns.AddRange(new DataColumn[4] { new DataColumn("Id", typeof(int)),
                        new DataColumn("Address", typeof(string)),
                        new DataColumn("Latitude",typeof(string)),
                        new DataColumn("Longitude",typeof(string)) });
                foreach (DataRow row in dsResult.Tables["result"].Rows)
                {
                    string geometry_id = dsResult.Tables["geometry"].Select("result_id = " + row["result_id"].ToString())[0]["geometry_id"].ToString();
                    DataRow location = dsResult.Tables["location"].Select("geometry_id = " + geometry_id)[0];
                    dtCoordinates.Rows.Add(row["result_id"], row["formatted_address"], location["lat"], location["lng"]);
                }
            }


        }
    }

    protected void btnCUpdate_Click(object sender, EventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();
        if (CnfResult.Value == "true")
        {
            if (txtCustName.Text != String.Empty && txtMob.Text != string.Empty)
            {

                string CustomerName;
                string EmailId;
                if (txtCustName.Text == string.Empty)
                {
                    CustomerName = "0";
                }
                else
                {
                    CustomerName = txtCustName.Text;
                }

                if (txtEml.Text == string.Empty)
                {
                    EmailId = "0";
                }
                else
                {
                    EmailId = txtEml.Text;
                }
                try
                {

                    Boolean viapost = false;
                    Boolean viamail = false;
                    Boolean viasms = false;
                


                    if (txtCustName.Text == "" || txtMob.Text == "")
                    {

                        WebMsgBox.Show("Please select or enter mandatory fields.");

                    }             
                    else
                    {

                        string strCampaign;
                        string strLeadSource;
                        string strBudget;

                        strCampaign = ddlCompaign.SelectedValue;
                        strLeadSource = ddlLeadSource.Text;
                        strBudget = ddlBudget.SelectedValue;

                        string strNotes = "";

                        if (ddlCompaign.SelectedValue != "")
                        {
                            strNotes = "#Campaign-" + ddlCompaign.SelectedValue;
                        }
                        if (ddlLeadSource.SelectedValue != "")
                        {
                            strNotes = strNotes.ToString() + "#LeadSource-" + ddlLeadSource.SelectedValue;
                        }
                        if (ddlTrackon.SelectedValue != "")
                        {
                            strNotes = strNotes.ToString() + "#Reference-" + ddlTrackon.SelectedValue;
                        }


                        sqlobj.ExecuteSQLNonQuery("SP_updateprospects",
                                           new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlTitle.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtCustName.Text },
                                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCCustStatus.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue },
                                           new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorNo.Text },
                                           new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = txtStreet.Text },
                                           new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = txtCity.Text },
                                           new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = txtPostalCode.Text },
                                           new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = txtState.Text },
                                           new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = ddlCountry.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = txtPhoneNo.Text },
                                           new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtMob.Text },
                                           new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = txtEml.Text },
                                           new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = txtEml2.Text },

                                           new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlGender.SelectedValue == "" ? null : ddlGender.SelectedValue },
                                           new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                                           new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = ddlVipImp.SelectedValue },

                                           new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = strNotes.ToString() + " " + txtNotes.Text },
                                           new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = ddlLeadSource.SelectedValue == "" ? null : ddlLeadSource.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = ddlCompaign.SelectedValue == "" ? null : ddlCompaign.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = ddlBudget.SelectedValue == "" ? null : ddlBudget.SelectedValue },
                                           new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = txtReq.Text },
                                           new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue == "" ? null : ddlTrackon.SelectedValue },

                                           new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["ProspectRSN"] },
                                           new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = txtCompanyName.Text },
                                           new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = ddlACManager.SelectedValue == "" ? null : ddlACManager.SelectedValue }
                                           );




                        foreach (GridViewRow row in gvContacts.Rows)
                        {
                            string customerrsn = gvContacts.DataKeys[row.RowIndex].Value.ToString();


                            sqlobj.ExecuteSQLNonQuery("SP_Updateprcontacts",
                                               new SqlParameter() { ParameterName = "@ContactName", SqlDbType = SqlDbType.NChar, Value = gvContacts.Rows[row.RowIndex].Cells[0].Text },
                                               new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.NChar, Value = Session["ProspectRSN"].ToString() },
                                               new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[1].Text },
                                               new SqlParameter() { ParameterName = "@EMAILID", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[2].Text },
                                               new SqlParameter() { ParameterName = "@PhoneNo", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[3].Text },
                                               new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[4].Text },
                                               new SqlParameter() { ParameterName = "@Department", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[5].Text },
                                               new SqlParameter() { ParameterName = "@Location", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[6].Text },
                                               new SqlParameter() { ParameterName = "@SMS", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[8].Text },
                                               new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[9].Text },
                                               new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = gvContacts.Rows[row.RowIndex].Cells[7].Text },
                                               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = customerrsn.ToString() }

                                              );
                        }
                    }

                    LoadProspectCount();
                    LoadPagingProspectDetails();
                    WebMsgBox.Show("Profile modified.");
                    CClearScr();
                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }
            }
            else
            {
                WebMsgBox.Show("Please enter the mandatory fields");
            }
        }
    }


    protected void btnSaveHidden_Click(object sender, EventArgs e)
    {
        //Do Something
        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "script", "alert('You clicked Hidden Save');", true);
    }
    protected void btnCancelHidden_Click(object sender, EventArgs e)
    {
        //Do Something
        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "script", "alert('You clicked Hidden Cancel');", true);

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Session["TaskType"] = "FromDirect";    

    }

    protected void gvProspectDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void LoadCustomerProfile()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["customerid"].ToString() });

        if (dsCCustStatus.Tables[0].Rows.Count > 0)
        {
            ddlTitle.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();

            txtCustName.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();

            ddlCCustStatus.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();

            ddlCCustStatus.Enabled = false;
            ddlType.Enabled = false;
            ddlType.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

            txtCompanyName.Text = dsCCustStatus.Tables[0].Rows[0]["CompanyName"].ToString();
            txtDoorNo.Text = dsCCustStatus.Tables[0].Rows[0]["DoorNo"].ToString();
            txtStreet.Text = dsCCustStatus.Tables[0].Rows[0]["Street"].ToString();
            txtCity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
            txtPostalCode.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();
            txtState.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
            ddlCountry.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Country"].ToString();
            txtPhoneNo.Text = dsCCustStatus.Tables[0].Rows[0]["Phone"].ToString();
            txtMob.Text = dsCCustStatus.Tables[0].Rows[0]["Mobile"].ToString();
            txtEml.Text = dsCCustStatus.Tables[0].Rows[0]["Email"].ToString();
            txtEml2.Text = dsCCustStatus.Tables[0].Rows[0]["Email2"].ToString();
            ddlGender.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();

            string strManager = dsCCustStatus.Tables[0].Rows[0]["ACManager"].ToString();

            if (strManager != "")
            {
                ddlACManager.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["ACManager"].ToString();

            }
            btnChangeStatus.Enabled = true;          


            if (dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString() != "Please Select")
            {
                ddlVipImp.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();
            }


            txtNotes.Text = dsCCustStatus.Tables[0].Rows[0]["Notes"].ToString();


            if (dsCCustStatus.Tables[0].Rows[0]["LeadSource"].ToString() != "Please Select")
            {
                ddlLeadSource.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["LeadSource"].ToString();
            }
            string strcampaign = dsCCustStatus.Tables[0].Rows[0]["Campaign"].ToString();

            if (strcampaign != "Please Select" || strcampaign != "")
            {
                ddlCompaign.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Campaign"].ToString();
            }
            string strbudget = dsCCustStatus.Tables[0].Rows[0]["Budget"].ToString();
            if (strbudget != "")
            {
                ddlBudget.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Budget"].ToString();
            }

            txtReq.Text = dsCCustStatus.Tables[0].Rows[0]["Requirements"].ToString();

            string strprojectcode = dsCCustStatus.Tables[0].Rows[0]["ProjectCode"].ToString();
            if (strprojectcode != "")
            {
                ddlTrackon.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["ProjectCode"].ToString();
            }

            btnCSave.Visible = false;
            btnCUpate.Visible = true;
        }
    }

    protected void gvProspectDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            CClearScr();
            RadWindowManager1.Visible = true;

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LoadCCustStatus();

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    //btnAddContacts.Enabled = true;

                    btnContacts.Visible = true;
                    btnservice.Visible = true;

                    ddlTitle.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();

                    txtCustName.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();

                    ddlType.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    LoadProspectTypes();

                    ddlCCustStatus.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();

                    ddlCCustStatus.Enabled = false;
                    ddlType.Enabled = false;

                    txtCompanyName.Text = dsCCustStatus.Tables[0].Rows[0]["CompanyName"].ToString();
                    txtDoorNo.Text = dsCCustStatus.Tables[0].Rows[0]["DoorNo"].ToString();
                    txtStreet.Text = dsCCustStatus.Tables[0].Rows[0]["Street"].ToString();
                    txtCity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
                    txtPostalCode.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();
                    txtState.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
                    ddlCountry.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Country"].ToString();
                    txtPhoneNo.Text = dsCCustStatus.Tables[0].Rows[0]["Phone"].ToString();
                    txtMob.Text = dsCCustStatus.Tables[0].Rows[0]["Mobile"].ToString();
                    txtEml.Text = dsCCustStatus.Tables[0].Rows[0]["Email"].ToString();
                    txtEml2.Text = dsCCustStatus.Tables[0].Rows[0]["Email2"].ToString();
                    ddlGender.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();

                    string strManager = dsCCustStatus.Tables[0].Rows[0]["ACManager"].ToString();

                    if (strManager != "")
                    {
                        ddlACManager.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["ACManager"].ToString();

                    }
                    btnChangeStatus.Enabled = true;

                    if (dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString() != "Please Select")
                    {
                        ddlVipImp.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();
                    }

                    txtNotes.Text = dsCCustStatus.Tables[0].Rows[0]["Notes"].ToString();

                    if (dsCCustStatus.Tables[0].Rows[0]["LeadSource"].ToString() != "Please Select")
                    {
                        ddlLeadSource.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["LeadSource"].ToString();
                    }
                    string strcampaign = dsCCustStatus.Tables[0].Rows[0]["Campaign"].ToString();

                    if (strcampaign != "Please Select" || strcampaign != "")
                    {
                        ddlCompaign.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Campaign"].ToString();
                    }
                    string strbudget = dsCCustStatus.Tables[0].Rows[0]["Budget"].ToString();
                    if (strbudget != "")
                    {
                        ddlBudget.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["Budget"].ToString();
                    }

                    txtReq.Text = dsCCustStatus.Tables[0].Rows[0]["Requirements"].ToString();

                    string strprojectcode = dsCCustStatus.Tables[0].Rows[0]["ProjectCode"].ToString();
                    if (strprojectcode != "")
                    {
                        ddlTrackon.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["ProjectCode"].ToString();
                    }

                    LoadExistingContacts(Session["ProspectRSN"].ToString());

                    btnCSave.Visible = false;
                    btnCUpate.Visible = true;
                }
            }
            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                Label lbltype = (Label)mygrid.Rows[index].Cells[4].FindControl("lblType");


                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                Session["DiaryFrom"] = "CustomerGrid";

                LoadProspectDiary(istaffid.ToString());

                if (gvDiary.Rows.Count > 0)
                {
                    rwDiary.Visible = true;
                }        


            }
            else if (e.CommandName == "NewTask")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                Label lbltype = (Label)mygrid.Rows[index].Cells[4].FindControl("lblType");


                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                Session["TaskType"] = "FromProspect";

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    Session["Reference"] = dsCCustStatus.Tables[0].Rows[0]["ProjectCode"].ToString();
                }

                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "NavigateNewTask();", true);

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadExistingContacts(string prospectrsn)
    {
        string strrsn = prospectrsn.ToString();

        DataSet dsExistingContacts = sqlobj.SQLExecuteDataset("LoadExistingContacts",
             new SqlParameter() { ParameterName = "@prospects_RSN", SqlDbType = SqlDbType.BigInt, Value = prospectrsn.ToString() });

        if (dsExistingContacts.Tables[0].Rows.Count > 0)
        {
            gvContacts.DataSource = dsExistingContacts;
            gvContacts.DataBind();
        }

    }

    protected void gvProsepctDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvProspectDetails.PageIndex = e.NewPageIndex;
        LoadPagingProspectDetails();

        if (Session["PagingMode"] == "Check")
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();


            for (int i = 0; i < gvProspectDetails.Rows.Count; i++)
            {
                Int32 RSN = Convert.ToInt32(gvProspectDetails.DataKeys[i].Value.ToString());

                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_CheckFollowupdate", new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    gvProspectDetails.Rows[i].Cells[7].Text = dsCCustStatus.Tables[0].Rows[0]["Followupdate"].ToString();

                }

            }
        }
        else if (Session["PagingMode"] == "TagCheck")
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();


            for (int i = 0; i < gvProspectDetails.Rows.Count; i++)
            {
                Int32 RSN = Convert.ToInt32(gvProspectDetails.DataKeys[i].Value.ToString());

                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_Check#Tag", new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    gvProspectDetails.Rows[i].Cells[8].Text = dsCCustStatus.Tables[0].Rows[0]["TrackOn"].ToString();
                }

            }
        }
    }

    private void LoadPagingProspectDetails()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_SearchProspectDetails", new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtSearchProspect.Text },
            new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.NVarChar, Value = ddlSearchType.SelectedValue },
            new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtSearchMobile.Text });

        gvProspectDetails.DataSource = dsCCustStatus;
        gvProspectDetails.DataBind();
    }

    protected void btnFollowupCheck_Click(object sender, EventArgs e)
    {

        Session["PagingMode"] = "Check";
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        for (int i = 0; i < gvProspectDetails.Rows.Count; i++)
        {
            Int32 RSN = Convert.ToInt32(gvProspectDetails.DataKeys[i].Value.ToString());

            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_CheckFollowupdate", new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                gvProspectDetails.Rows[i].Cells[7].Text = dsCCustStatus.Tables[0].Rows[0]["Followupdate"].ToString();

            }

        }
    }

    private bool IsProspectExisting(string prospectname, string mobile)
    {
        bool IsExisting;
        SQLProcs sqlobj = new SQLProcs();
        DataSet dspe = new DataSet();
        dspe = sqlobj.SQLExecuteDataset("SP_CheckExistingProspect",
            new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = prospectname },
            new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = mobile });
        if (dspe.Tables[0].Rows.Count > 0)
        {
            IsExisting = true;
        }
        else
        {
            IsExisting = false;
        }
        return IsExisting;
    }

    protected void CClearScr()
    {
        txtCustName.Text = string.Empty;
        txtMob.Text = string.Empty;
        txtReq.Text = string.Empty;
        txtCity.Text = string.Empty;
        txtState.Text = string.Empty;
        txtEml.Text = string.Empty;
        txtCompanyName.Text = string.Empty;
        txtDoorNo.Text = string.Empty;
        txtStreet.Text = string.Empty;
        txtPostalCode.Text = string.Empty;
        txtPhoneNo.Text = string.Empty;
        txtEml.Text = string.Empty;
        txtEml2.Text = string.Empty;

        txtNotes.Text = string.Empty;   
        ddlBudget.SelectedIndex = 0;
        ddlLeadSource.SelectedIndex = 0;
        ddlTrackon.SelectedIndex = 0;
        ddlCCustStatus.SelectedIndex = 0;
        ddlCompaign.SelectedIndex = 0;
        ddlGender.SelectedIndex = 0;
        ddlType.SelectedIndex = 0;
        ddlVipImp.SelectedIndex = 0;
        ddlCCustStatus.SelectedIndex = 0;       
        ddlCountry.SelectedValue = RegionInfo.CurrentRegion.DisplayName;
        ddlTitle.SelectedIndex = 0;
        ddlCCustStatus.Enabled = true;
        ddlType.Enabled = true;
        btnCSave.Visible = true;
        btnCUpate.Visible = false;
        btnContacts.Visible = false;
        btnservice.Visible = false;
        LoadCCustStatus();
        gvContacts.DataSource = null;
        gvContacts.DataBind();
    }
    protected void btnCClear_Click(object sender, EventArgs e)
    {
        CClearScr();
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        CClearScr();
    }
    //page view 8 ends

    protected void imgAddLeadSource_Click(object sender, EventArgs e)
    {
        rwLeadSource.Enabled = true;
        rwLeadSource.Visible = true;
    }

    protected void btnNewLeadSource_Click(object sender, EventArgs e)
    {
        rwLeadSource.Enabled = true;
        rwLeadSource.Visible = true;
    }

    private void ClearLeadSource()
    {
        txtAddLeadKey.Text = "";
    }
    protected void btnLSSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtAddLeadKey.Text))
            {
                WebMsgBox.Show("Please enter the leadsource details");
                rwLeadSource.Visible = true;
                return;
            }
            if (CnfResult.Value != "true")
            {
                rwLeadSource.Visible = true;
                return;
            }
            SQLProcs sqlobj = new SQLProcs();

            sqlobj.ExecuteSQLNonQuery("SP_InsertLeadSource",
                                                             new SqlParameter() { ParameterName = "@LeadKey", SqlDbType = SqlDbType.NVarChar, Value = txtAddLeadKey.Text },
                                                             new SqlParameter() { ParameterName = "@LeadValue", SqlDbType = SqlDbType.NVarChar, Value = "" }

                                                             );
            rwLeadSource.Visible = false;
            LoadLeadSource();
            WebMsgBox.Show("New LeadSource Added.");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvProspectDetails_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='highlight'");

            e.Row.Attributes.Add("onmouseout", "this.className='normal'");

        }
    }
    
    protected void imgReference_Click(object sender, EventArgs e)
    {
        rwReference.Visible = true;
    }

    protected void btnLSClear_Click(object sender, EventArgs e)
    {
        try
        {
            ClearLeadSource();
            rwLeadSource.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void LoadStatusHistory(double ProspectRSN)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStatusHistory = new DataSet();
        dsStatusHistory = sqlobj.SQLExecuteDataset("SP_GetProspectStatus", new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.BigInt, Value = ProspectRSN });

        if (dsStatusHistory.Tables[0].Rows.Count != 0)
        {
            gvStatusHistory.DataSource = dsStatusHistory;
            gvStatusHistory.DataBind();
        }

        dsStatusHistory.Dispose();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Session["PagingMode"] = "Search";
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_SearchProspectDetails", new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtSearchProspect.Text },
            new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.NVarChar, Value = ddlSearchType.SelectedValue },
            new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtSearchMobile.Text });
        if (dsCCustStatus != null)
        {
            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {

                lblnrf.Visible = false;
                lbltotalcount.Text = "Count:" + dsCCustStatus.Tables[0].Rows.Count;
                gvProspectDetails.DataSource = dsCCustStatus;
                gvProspectDetails.DataBind();
            }
            else
            {               
                lblnrf.Visible = true;
                gvProspectDetails.DataSource = null;
                gvProspectDetails.DataBind();
                lbltotalcount.Text = "Count:0";
            }
        }
        else
        {           
            lblnrf.Visible = true;
            gvProspectDetails.DataSource = null;
            gvProspectDetails.DataBind();
            lbltotalcount.Text = "Count:0";
        }
    }

    protected void btnSearchMobileNo_Click(object sender, EventArgs e)
    {
        if (txtMob.Text != "")
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_SearchProspectMobileNo", new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtMob.Text }
                );

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                WebMsgBox.Show("Mobile No. is present in the database");
            }
            else
            {
                WebMsgBox.Show("This is a new Mobile No.");
            }
        }
        else
        {
            WebMsgBox.Show("Please enter a new Mobile No.");
        }
    }

    protected void LoadProspectDiary(string prospectrsn)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectDiary = new DataSet();
        dsProspectDiary = sqlobj.SQLExecuteDataset("SP_GetProspectDiary", new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = prospectrsn.ToString() });
        if (dsProspectDiary.Tables[0].Rows.Count > 0)
        {
            lbldiaryheadName.Text = dsProspectDiary.Tables[0].Rows[0]["name"].ToString();
            string DiaryFrom = "CustomerGrid";
            if (DiaryFrom == Session["DiaryFrom"].ToString())
            {
                lbldiarycount.Visible = true;
                lbldiarycount.Text = "Count :" + dsProspectDiary.Tables[1].Rows[0]["count"].ToString();
            }
            else
            {
                lbldiarycount.Visible = false;
            }
            gvDiary.DataSource = dsProspectDiary;
            gvDiary.DataBind();
        }
        else
        {
            gvDiary.DataSource = null;
            gvDiary.DataBind();
            rwDiary.Visible = false;
            WebMsgBox.Show("Sorry, there are no activity entries present.");
        }

    }

    protected void onDataBound(object sender, EventArgs e)
    {
        string DiaryFrom = "CustomerGrid";

        if (DiaryFrom == Session["DiaryFrom"].ToString())
        {
            gvDiary.Columns[0].Visible = true;

            for (int i = gvDiary.Rows.Count - 1; i > 0; i--)
            {
                GridViewRow row = gvDiary.Rows[i];
                LinkButton lbrow = (LinkButton)gvDiary.Rows[i].FindControl("lbltaskid");
                GridViewRow previousRow = gvDiary.Rows[i - 1];
                LinkButton lbprow = (LinkButton)gvDiary.Rows[i - 1].FindControl("lbltaskid");

                for (int j = 0; j < 1; j++)
                {
                    if (lbrow.Text == lbprow.Text)
                    {
                        if (previousRow.Cells[j].RowSpan == 0)
                        {
                            if (row.Cells[j].RowSpan == 0)
                            {
                                previousRow.Cells[j].RowSpan += 2;
                                previousRow.Cells[8].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[j].RowSpan = row.Cells[j].RowSpan + 1;
                                previousRow.Cells[8].RowSpan = row.Cells[8].RowSpan + 1;
                            }
                            row.Cells[j].Visible = false;
                            row.Cells[8].Visible = false;

                        }
                    }
                }

            }
        }
        else
        {
            gvDiary.Columns[0].Visible = false;

            for (int i = gvDiary.Rows.Count - 1; i > 0; i--)
            {
                GridViewRow row = gvDiary.Rows[i];

                GridViewRow previousRow = gvDiary.Rows[i - 1];
                for (int j = 1; j < 2; j++)
                {
                    if (row.Cells[j].Text == previousRow.Cells[j].Text)
                    {
                        if (previousRow.Cells[j].RowSpan == 0)
                        {
                            if (row.Cells[j].RowSpan == 0)
                            {
                                previousRow.Cells[j].RowSpan += 2;
                                previousRow.Cells[8].RowSpan += 2;
                            }
                            else
                            {
                                previousRow.Cells[j].RowSpan = row.Cells[j].RowSpan + 1;
                                previousRow.Cells[8].RowSpan = row.Cells[8].RowSpan + 1;
                            }
                            row.Cells[j].Visible = false;
                            row.Cells[8].Visible = false;

                        }
                    }
                }


            }

            foreach (GridViewRow rows in gvDiary.Rows)
            {
                string sTaskid = rows.Cells[0].Text;

                DataSet dsYSIP = sqlobj.SQLExecuteDataset("SP_GetActivityStatus", new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = rows.Cells[0].Text });

                if (dsYSIP != null)
                {

                    if (dsYSIP.Tables[0].Rows.Count > 0)
                    {
                        string aStatus = dsYSIP.Tables[0].Rows[0]["Status"].ToString();

                        if (aStatus == "00")
                        {
                            rows.Cells[0].ForeColor = Color.DarkBlue;
                        }
                        else if (aStatus == "01")
                        {
                            rows.Cells[0].ForeColor = Color.DarkBlue;
                        }
                    }
                    dsYSIP.Dispose();
                }
            }
        }
    }

    protected void OnDiaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvDiary.PageIndex = e.NewPageIndex;
        LoadProspectDiary(Session["ProspectRSN"].ToString());
        rwDiary.Visible = true;
    }

    protected void btnDiaryClose_Click(object sender, EventArgs e)
    {
        rwDiary.Visible = false;
    }

    protected void btnSearchClear_Click(object sender, EventArgs e)
    {
        LoadProspectDetails();
        lblnrf.Visible = false;
        txtSearchMobile.Text = "";
        txtSearchProspect.Text = "";
        ddlSearchType.SelectedIndex = 0;
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadProspectTypes();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadProspectTypes()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        ddlCCustStatus.Items.Clear();

        if (ddlType.SelectedItem.Text == "PROSPECT")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 16 });
        }
        else if (ddlType.SelectedItem.Text == "VENDOR")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 25 });
        }
        else if (ddlType.SelectedItem.Text == "OTHER")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 23 });
        }
        else if (ddlType.SelectedItem.Text == "CUSTOMER")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 24 });
        }

        ddlCCustStatus.DataSource = dsCCustStatus.Tables[0];
        ddlCCustStatus.DataValueField = "StatusCode";
        ddlCCustStatus.DataTextField = "StatusDesc";
        ddlCCustStatus.DataBind();
        ddlCCustStatus.Dispose();

        ddlCCustStatus.Items.Insert(0, "Please Select");
    }

    protected void btnLSClose_Click(object sender, EventArgs e)
    {
        rwLeadSource.Visible = false;
    }

    protected void btnRefClose_Click(object sender, EventArgs e)
    {
        rwReference.Visible = false;
    }


    protected void btnReferenceHelp_Click(object sender, EventArgs e)
    {
        DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
          new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });

        if (dsremarks.Tables[0].Rows.Count > 0)
        {
            if (dsremarks.Tables[0].Rows[0]["HelpText"].ToString() != null)
            {
                lblrefhelp.Text = dsremarks.Tables[0].Rows[0]["HelpText"].ToString();

            }
            else
            {
                lblrefhelp.Text = "";
            }
        }

        rwReferenceHelp.Visible = true;
    }

    public SortDirection direction
    {
        get
        {
            if (ViewState["directionState"] == null)
            {
                ViewState["directionState"] = SortDirection.Ascending;
            }
            return (SortDirection)ViewState["directionState"];
        }
        set
        {
            ViewState["directionState"] = value;
        }
    }

    protected void btnCPClose_Click(object sender, EventArgs e)
    {
        rwCustomerProfile.Visible = false;
    }

    private void HighlightColor(GridView gvname, int cellno)
    {
        double startingvalue = 0;
        double checkvalue = 0;
        Int32 previousindex = 0;
        double finalvalue = 0;

        foreach (GridViewRow row in gvname.Rows)
        {

            Int32 ri = row.RowIndex;

            if (ri == 0)
            {
                startingvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);
                gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;
            }
            if (ri != 0)
            {
                checkvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

                if (checkvalue != 0)
                {

                    if (checkvalue > startingvalue)
                    {
                        gvname.Rows[previousindex].BackColor = Color.White;

                        gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;

                        finalvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

                        startingvalue = finalvalue;

                        Session["FinalValue"] = finalvalue;

                        previousindex = ri;


                    }
                }
            }

        }

        foreach (GridViewRow row in gvname.Rows)
        {
            Int32 ri = row.RowIndex;

            startingvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

            if (Session["FinalValue"] != null)
            {
                finalvalue = Convert.ToDouble(Session["FinalValue"].ToString());

                if (finalvalue == startingvalue)
                {
                    gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;
                }
            }
        }
    }

    protected void onLeadSourcePaging(object sender, GridViewPageEventArgs e)
    {
        gvMLeadSource.PageIndex = e.NewPageIndex;
        LoadLeadSource();
    }

    protected void gvLeadSourceSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        decimal TotalSales = (decimal)0.0;
        if (e.Row.RowType == DataControlRowType.DataRow)
            // if row type is DataRow, add ProductSales value to TotalSales
            TotalSales += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "LeadCount"));
        else if (e.Row.RowType == DataControlRowType.Footer)
            // If row type is footer, show calculated total value
            // Since this example uses sales in dollars, I formatted output as currency
            e.Row.Cells[1].Text = String.Format("{0:c}", TotalSales);
    }

    protected void ExcelExport(DataTable dt, int strRpt, string rptType)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsH = new DataSet();
            DataSet dsFetch = new DataSet();

            string StoredProcedure = "";
            string TemplateFile = "";
            int LineNumber = 0;
            int ColCount = 0;

            dsH = sqlp.SQLExecuteDataset("SP_DispRptDetails",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                new SqlParameter() { ParameterName = "@Report", SqlDbType = SqlDbType.BigInt, Direction = ParameterDirection.Input, Value = strRpt });

            StoredProcedure = Convert.ToString(dsH.Tables[0].Rows[0]["StoredProcedure"]);
            TemplateFile = Convert.ToString(dsH.Tables[0].Rows[0]["TemplateFile"]);
            LineNumber = Convert.ToInt16(dsH.Tables[0].Rows[0]["LineNumber"]);
            ColCount = Convert.ToInt16(dsH.Tables[2].Rows[0]["ColCount"]);
            String FileName = TemplateFile + "_" + rptType + "_" + Session["Userid"].ToString() + "_" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + "_" + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + ".xls";

            dsFetch = sqlp.SQLExecuteDataset("SP_FetchParam",
            new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 });
            string templateFilePath = Server.MapPath(@dsFetch.Tables[0].Rows[0]["paramvalue"] + TemplateFile + ".xltx");

            dsFetch = sqlp.SQLExecuteDataset("SP_FetchParam",
            new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 2 });
            String newFilePath = Server.MapPath(@dsFetch.Tables[0].Rows[0]["paramvalue"] + FileName);

            FileInfo newFile = new FileInfo(newFilePath);
            FileInfo template = new FileInfo(templateFilePath);
            using (ExcelPackage xlPackage = new ExcelPackage(newFile, template))
            {
                foreach (ExcelWorksheet aworksheet in xlPackage.Workbook.Worksheets)
                {
                    aworksheet.Cell(1, 1).Value = aworksheet.Cell(1, 1).Value;
                }
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets[1];
                int startrow = LineNumber;
                int row = 0;
                int col = 0;
                for (int j = 0; j < ColCount; j++)
                {
                    col++;
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        row = startrow + i;
                        ExcelCell cell = worksheet.Cell(row, col);
                        cell.Value = dt.Rows[i][j].ToString();
                        //xlPackage.Save();
                    }
                }
                for (int iCol = 1; iCol <= ColCount; iCol++)
                {
                    ExcelCell cell = worksheet.Cell(startrow - 2, iCol);
                    for (int iRow = startrow; iRow <= row; iRow++)
                    {
                        worksheet.Cell(iRow, iCol).StyleID = cell.StyleID;
                    }
                }
                xlPackage.Save();
            }
            string attachment = "attachment; filename=" + newFilePath;
            HttpContext.Current.Response.Clear();
            //HttpContext.Current.Response.AddHeader("content-disposition", attachment);
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + FileName + ";");
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            //HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.TransmitFile(newFilePath);
            //HttpContext.Current.Response.Flush();
            //HttpContext.Current.Response.End();
            HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
            HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
            HttpContext.Current.ApplicationInstance.CompleteRequest(); // Causes ASP.NET to bypass all events and filtering in the HTTP pipeline chain of execution and directly execute the EndRequest event.

        }
        catch (Exception ex)
        {
            SQLProcs sqlpd = new SQLProcs();
            DataSet dsd = new DataSet();

            dsd = sqlpd.SQLExecuteDataset("insert_debug",
               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ex.Message.ToString() });
            if (dsd != null)
            {
            }
        }
    }

    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }

    protected void gvSaveTime_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string st = mygrid.Rows[index].Cells[1].Text;
                if (txtNotes.Text != "")
                {
                    txtNotes.Text = txtNotes.Text + " " + st.ToString();
                }
                else
                {
                    txtNotes.Text = txtNotes.Text + st.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtInfo.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please enter Save time information');", true);
                rwSaveTime.Visible = true;
                return;
            }
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                           new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                           );

            LoadSaveTime();
            STClear();          
            rwSaveTime.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        STClear();
        rwSaveTime.Visible = true;
    }
    protected void LoadSaveTime()
    {
        DataSet dsSaveTime = new DataSet();
        dsSaveTime = sqlobj.SQLExecuteDataset("SP_GetSaveTimeEntry");
        ddlsavetime.Items.Clear();
        if (dsSaveTime.Tables[0].Rows.Count != 0)
        {
            gvSaveTime.DataSource = dsSaveTime;
            gvSaveTime.DataBind();

            ddlsavetime.DataSource = dsSaveTime;
            ddlsavetime.DataTextField = "Savetimeentry";
            ddlsavetime.DataValueField = "Savetimeentry";
            ddlsavetime.DataBind();
        }

        ddlsavetime.Items.Insert(0, "");   
        dsSaveTime.Dispose();
    }

    protected void LoadSSaveTime()
    {
        DataSet dsSSaveTime = new DataSet();
        dsSSaveTime = sqlobj.SQLExecuteDataset("SP_GetSaveTimeEntry");

        if (dsSSaveTime.Tables[0].Rows.Count != 0)
        {
            gvSSaveTime.DataSource = dsSSaveTime;
            gvSSaveTime.DataBind();
        }  
        dsSSaveTime.Dispose();
    }

    private void STClear()
    {
        txtInfo.Text = "";
        //txtstremarks.Text = "";
    }

    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
    }

    protected void mnu_MenuItemClick(Object sender, MenuEventArgs e)
    {
        // Display the text of the menu item selected by the user.

        WebMsgBox.Show(e.Item.Text);
    }

    protected void RDQuickLinks_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {


        if (e.Item.Text == "Reference")
        {
            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
            {
                rwReference.Visible = true;

            }

        }

        if (e.Item.Text == "SM Reports")
        {
            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
            {
                Response.Redirect("SMReports.aspx");
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('SMReports.aspx');", true);
            }
        }
        else if (e.Item.Text == "WM Reports")
        {
            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
            {
                Response.Redirect("WMReports.aspx");
            }

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('WMReports.aspx');", true);
        }
        else if (e.Item.Text == "SMX Reports")
        {
            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {
                Response.Redirect("SMXReports.aspx");
            }

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('SMXReports.aspx');", true);
        }
        else if (e.Item.Text == "WMX Reports")
        {
            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
            {
                Response.Redirect("WMXReports.aspx");
            }

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('WMXReports.aspx');", true);
        }
    }

  
    public void Export(string fileName, GridView[] gvs)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        HttpContext.Current.Response.ContentType = "application/ms-excel";

        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);

        foreach (GridView gv in gvs)
        {

            //   Create a form to contain the grid
            Table table = new Table();
            table.GridLines = gv.GridLines;
            //   add the header row to the table
            if (!(gv.HeaderRow == null))
            {
                PrepareControlForExport(gv.HeaderRow);
                table.Rows.Add(gv.HeaderRow);
            }         
            foreach (GridViewRow row in gv.Rows)
            {
                PrepareControlForExport(row);
                table.Rows.Add(row);
            }
            //   add the footer row to the table
            if (!(gv.FooterRow == null))
            {
                PrepareControlForExport(gv.FooterRow);
                table.Rows.Add(gv.FooterRow);
            }
            //   render the table into the htmlwriter
            table.RenderControl(htw);
        }
        //   render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString());
        HttpContext.Current.Response.End();
    }


    private static void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {
            Control current = control.Controls[i];
            if (current is LinkButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
            }
            else if (current is ImageButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
            }
            else if (current is HyperLink)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
            }
            else if (current is DropDownList)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
            }
            else if (current is CheckBox)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
            }


            if (current.HasControls())
            {
                PrepareControlForExport(current);
            }
        }
    }

    // Chanage status in Manage Leads Start

    protected void btnChangeStatus_Click(object sender, EventArgs e)
    {
        string strUserLevel = Session["UserLevel"].ToString();

        if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator" || strUserLevel == "3Department Head")
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsStatusHistory = new DataSet();
            dsStatusHistory = sqlobj.SQLExecuteDataset("SP_GetProspectDetails", new SqlParameter() { ParameterName = "RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ProspectRSN"].ToString() });

            if (dsStatusHistory.Tables[0].Rows.Count != 0)
            {
                lblCustomerName.Text = dsStatusHistory.Tables[0].Rows[0]["Name"].ToString();
                lblCurrentStatusName.Text = dsStatusHistory.Tables[0].Rows[0]["StatusDesc"].ToString();
                //ddlNewStatus.SelectedValue = dsStatusHistory.Tables[0].Rows[0]["Status"].ToString();

                if (lblCurrentStatusName.Text == "7CUS" || lblCurrentStatusName.Text == "OTHR" || lblCurrentStatusName.Text == "VNDR")
                {
                    rwChangeStatus.Visible = false;
                }
                else
                {
                    LoadUpdateStatus();
                    rwChangeStatus.Visible = true;
                }
            }
            dsStatusHistory.Dispose();
            DataSet dsCCustStatus = sqlobj.SQLExecuteDataset("SP_Checklsufflag",
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lbllsufstatus.Text = "You can either move the prospect to another status within the sales cycle or upgrade the status as customer.";
            }
            else
            {
                lbllsufstatus.Text = "You cannot change the status as customer. However you can choose any other status codes.";
            }
            LoadStatusHistory(Convert.ToDouble(Session["ProspectRSN"]));
        }
        else
        {
            WebMsgBox.Show("Access denied");
        }
    }

    protected void LoadUpdateStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("sp_fetchstatus",
            new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = lblCurrentStatusName.Text });
        ddlNewStatus.DataSource = dsCCustStatus.Tables[0];
        ddlNewStatus.DataValueField = "StatusCode";
        ddlNewStatus.DataTextField = "StatusDesc";
        ddlNewStatus.DataBind();
        dsCCustStatus.Dispose();
    }


    protected void btnChangeStatusUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                SQLProcs sqlobj = new SQLProcs();
                string strType = "";
                string IsAllow = "";
                if (ddlNewStatus.SelectedValue == "7CUS")
                {
                    DataSet dsCCustStatus = sqlobj.SQLExecuteDataset("SP_Checklsufflag",
                             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
                    if (dsCCustStatus.Tables[0].Rows.Count > 0)
                    {
                        strType = "CUSTOMER";
                        IsAllow = "Yes";
                    }
                    else
                    {
                        IsAllow = "No";
                    }
                }
                else if (ddlNewStatus.SelectedValue == "OTHR")
                {
                    strType = "OTHER";
                    IsAllow = "Yes";

                }
                else if (ddlNewStatus.SelectedValue == "VNDR")
                {
                    strType = "VENDOR";
                    IsAllow = "Yes";
                }
                else
                {
                    strType = "PROSPECT";
                    IsAllow = "Yes";
                }

                if (IsAllow == "Yes")
                {

                    sqlobj.ExecuteSQLNonQuery("SP_UpdateStatus",

                                                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["ProspectRSN"].ToString()) },
                                                      new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                      new SqlParameter() { ParameterName = "@M_Date", SqlDbType = SqlDbType.DateTime, Value = System.DateTime.Now },
                                                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlNewStatus.SelectedValue },
                                                      new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() });



                    sqlobj.ExecuteSQLNonQuery("sp_TrackerentryforChangeStatus",
                                                     new SqlParameter() { ParameterName = "@CustName", SqlDbType = SqlDbType.NVarChar, Value = Session["ProspectRSN"].ToString() },
                                                     new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                     new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue },

                                                     new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                     new SqlParameter() { ParameterName = "@AssignedOn", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                                     new SqlParameter() { ParameterName = "@Followupdate", SqlDbType = SqlDbType.DateTime, Value = dtpchangestatusfollowupdate.SelectedDate },
                                                     new SqlParameter() { ParameterName = "@AssignedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                     new SqlParameter() { ParameterName = "@TargetDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                                     new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = "Status changed  " + txtComments.Text },
                                                     new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] });



                    LoadPagingProspectDetails();
                    CClearScr();
                    WebMsgBox.Show("'Prospect Status changed successfully. When you press OK you will return back to an empty profile page.");
                    statusclear();
                }
                else
                {
                    WebMsgBox.Show("OOPS! Changing a prospect as a customer is NOT allowed for your job Type. Contact your System Administrator.");
                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void statusclear()
    {
        txtComments.Text = "";
        dtpchangestatusfollowupdate.SelectedDate = null;
        rwChangeStatus.Visible = false;
    }

    protected void btnChangeStatusClose_Click(object sender, EventArgs e)
    {
        rwChangeStatus.Visible = false;
    }

    // Chanage status in Manage Leads End
    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvProspectDetails.Rows)
        {
            if (row.RowIndex == gvProspectDetails.SelectedIndex)
            {
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                row.ToolTip = string.Empty;
            }
            else
            {
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                row.ToolTip = "Click to select this row.";
            }
        }
    }
   
    protected void btnTagCheck_Click(object sender, EventArgs e)
    {
        Session["PagingMode"] = "TagCheck";
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        for (int i = 0; i < gvProspectDetails.Rows.Count; i++)
        {
            Int32 RSN = Convert.ToInt32(gvProspectDetails.DataKeys[i].Value.ToString());

            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_Check#Tag", new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {

                gvProspectDetails.Rows[i].Cells[8].Text = dsCCustStatus.Tables[0].Rows[0]["TrackOn"].ToString();
            }

        }
    }
    protected void btnNewBiz_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewBiz.aspx");
    }
    protected void btnAdmin_Click(object sender, EventArgs e)
    {
        strUserLevel = Session["UserLevel"].ToString();

        if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
        {
            Response.Redirect("Admin.aspx");
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void btnContacts_Click(object sender, EventArgs e)
    {
        try
        {
            lblhcontacts.Text = "Names and addresses of contact persons for the profile of :" + txtCustName.Text;
            rwAddCustomer.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnAddContacts_Click(object sender, EventArgs e)
    {

        try
        {

            // Add Contacts

            sqlobj.ExecuteSQLNonQuery("SP_Insertprcontacts",
                                            new SqlParameter() { ParameterName = "@ContactName", SqlDbType = SqlDbType.NChar, Value = txtcontactname.Text },
                                            new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtcontDesignation.Text },
                                            new SqlParameter() { ParameterName = "@EMAILID", SqlDbType = SqlDbType.NVarChar, Value = txtcontemailid.Text },
                                            new SqlParameter() { ParameterName = "@PhoneNo", SqlDbType = SqlDbType.NVarChar, Value = txtPhoneNo.Text },
                                            new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtcontmobileno.Text },
                                            new SqlParameter() { ParameterName = "@Department", SqlDbType = SqlDbType.NVarChar, Value = txtcontdepartment.Text },
                                            new SqlParameter() { ParameterName = "@Location", SqlDbType = SqlDbType.NVarChar, Value = txtcontlocation.Text },
                                            new SqlParameter() { ParameterName = "@SMS", SqlDbType = SqlDbType.NVarChar, Value = ddlcontsms.SelectedValue },
                                            new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = ddlcontemail.Text },
                                            new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtcontremarks.Text },
                                            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                            new SqlParameter()
                                            {
                                                ParameterName = "@prospects_RSN",
                                                SqlDbType = SqlDbType.BigInt,
                                                Value = Session["ProspectRSN"].ToString()
                                            }

                                            );

            LoadContacts();

            ClearContacts();

            rwAddCustomer.Visible = true;


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadContacts()
    {
        DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
            new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ProspectRSN"].ToString() });

        if (dsContacts.Tables[0].Rows.Count > 0)
        {
            gvContacts.DataSource = dsContacts;
            gvContacts.DataBind();
        }
    }

    private void ClearContacts()
    {
        txtcontactname.Text = "";
        txtcontdepartment.Text = "";
        txtcontDesignation.Text = "";
        txtPhoneNo.Text = "";
        txtcontmobileno.Text = "";
        ddlcontemail.SelectedIndex = 0;
        ddlcontsms.SelectedIndex = 0;
        txtcontmobileno.Text = "";
        txtcontremarks.Text = "";
        txtcontemailid.Text = "";
        txtcontlocation.Text = "";

    }

    protected void UpdateCustomer(object sender, GridViewUpdateEventArgs e)
    {
        string strName = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtName")).Text;
        string strDesignation = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtDesignation")).Text;
        string strEmailID = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtEmailID")).Text;
        string strPhoneNo = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtPhoneNo")).Text;
        string strMobileNo = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtMobileNo")).Text;
        string strDepartment = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtDepartment")).Text;
        string strLocation = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtLocation")).Text;
        string strRemarks = ((TextBox)gvContacts.Rows[e.RowIndex].FindControl("txtRemarks")).Text;
        string strSMS = ((DropDownList)gvContacts.Rows[e.RowIndex].FindControl("ddlsms")).SelectedValue;
        string strEmail = ((DropDownList)gvContacts.Rows[e.RowIndex].FindControl("ddlemail")).SelectedValue;
        string strRSN = gvContacts.DataKeys[e.RowIndex].Value.ToString();

        sqlobj.ExecuteSQLNonQuery("SP_Updateprcontacts",
                                           new SqlParameter() { ParameterName = "@ContactName", SqlDbType = SqlDbType.NChar, Value = strName.ToString() },
                                           new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = strDesignation.ToString() },
                                           new SqlParameter() { ParameterName = "@EMAILID", SqlDbType = SqlDbType.NVarChar, Value = strEmailID.ToString() },
                                           new SqlParameter() { ParameterName = "@PhoneNo", SqlDbType = SqlDbType.NVarChar, Value = strPhoneNo.ToString() },
                                           new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = strMobileNo.ToString() },
                                           new SqlParameter() { ParameterName = "@Department", SqlDbType = SqlDbType.NVarChar, Value = strDepartment.ToString() },
                                           new SqlParameter() { ParameterName = "@Location", SqlDbType = SqlDbType.NVarChar, Value = strLocation.ToString() },
                                           new SqlParameter() { ParameterName = "@SMS", SqlDbType = SqlDbType.NVarChar, Value = strSMS.ToString() },
                                           new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = strEmail.ToString() },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = strRemarks.ToString() },
                                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = strRSN.ToString() },
                                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                           new SqlParameter() { ParameterName = "@Prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ProspectRSN"].ToString() }

                                           );
        gvContacts.EditIndex = -1;
        LoadContacts();
        rwAddCustomer.Visible = true;
    }

    protected void EditCustomer(object sender, GridViewEditEventArgs e)
    {
        gvContacts.EditIndex = e.NewEditIndex;
        LoadContacts();
        rwAddCustomer.Visible = true;
    }

    protected void OnsmsemailBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                string sms = (e.Row.FindControl("lbleSMS") as Label).Text;
                string email = (e.Row.FindControl("lbleEmail") as Label).Text;

                DropDownList ddlsms = (e.Row.FindControl("ddlsms") as DropDownList);
                DropDownList ddlemail = (e.Row.FindControl("ddlemail") as DropDownList);

                ddlsms.Items.FindByValue(sms).Selected = true;
                ddlemail.Items.FindByValue(email).Selected = true;

            }

        }
    }

    protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvContacts.EditIndex = -1;
        LoadContacts();
        rwAddCustomer.Visible = true;
    }

    protected void ToggleSelectedState(object sender, EventArgs e)
    {
        CheckBox headerCheckBox = (sender as CheckBox);
        foreach (GridDataItem dataItem in RdGrd_TaskDetDir1.MasterTableView.Items)
        {
            (dataItem.FindControl("chkJSel") as CheckBox).Checked = headerCheckBox.Checked;
            dataItem.Selected = headerCheckBox.Checked;
        }
    }

    protected void ToggleByMeSelectedState(object sender, EventArgs e)
    {
        CheckBox headerCheckBox = (sender as CheckBox);
        foreach (GridDataItem dataItem in RdGrd_TaskDetDir2.MasterTableView.Items)
        {
            (dataItem.FindControl("chkJSel") as CheckBox).Checked = headerCheckBox.Checked;
            dataItem.Selected = headerCheckBox.Checked;
        }
    }   

    protected void btnNewPing1_Click(object sender, EventArgs e)
    {
        try
        {
            Session["TaskID"] = null;
            int CNT = 0;
            foreach (GridDataItem itm in RdGrd_TaskDetDir1.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnktaskid");
                    CNT++;
                    string STaskID = lb.Text;
                    Session["TaskID"] = Session["TaskID"] + STaskID + ",";
                }
            }
            if (CNT > 0)
            {
                Session["TaskID"] = Session["TaskID"].ToString().Remove(Session["TaskID"].ToString().Length - 1);
                Label21.Text = Session["TaskID"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);

            }
            else
            {
                WebMsgBox.Show("Select one or more tasks first.");
            }          
         
        }
        catch (Exception qr)
        {
            throw qr;
        }
    }
    protected void btnNewPing2_Click(object sender, EventArgs e)
    {
        try
        {
            Session["TaskID"] = null;
            int CNT = 0;
            foreach (GridDataItem itm in RdGrd_TaskDetDir2.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnktaskid");
                    CNT++;
                    string STaskID = lb.Text;
                    Session["TaskID"] = Session["TaskID"] + STaskID + ",";
                }
            }
            if (CNT > 0)
            {
                Session["TaskID"] = Session["TaskID"].ToString().Remove(Session["TaskID"].ToString().Length - 1);
                Label21.Text = Session["TaskID"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);

            }
            else
            {
                WebMsgBox.Show("Select one or more tasks");
            }
            //LblEodSum.Visible = false;
            //LblEodSum1.Visible = false;
            
        }
        catch (Exception qr)
        {
            throw qr;
        }
    }
    protected void btnSSaveTime_Click(object sender, EventArgs e)
    {
        rwSSavetime.Visible = true;
    }
    protected void gvSSaveTime_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string st = mygrid.Rows[index].Cells[1].Text;

                if (txtComments.Text != "")
                {
                    txtComments.Text = txtComments.Text + " " + st.ToString();
                }
                else
                {
                    txtComments.Text = txtComments.Text + st.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void SSTClear()
    {
        txtComments.Text = "";
        dtpchangestatusfollowupdate.SelectedDate = null;
    }
    protected void btnSSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                           new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                           );

            LoadSSaveTime();
            SSTClear();
            //WebMsgBox.Show("Your details are saved");
            rwSSavetime.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSSTClear_Click(object sender, EventArgs e)
    {
        SSTClear();
    }
    protected void btnSSTClose_Click(object sender, EventArgs e)
    {
        rwSSavetime.Visible = false;
    }
    protected void RdGrd_TaskDetDir1_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "CustomerName")
            {

                int iCustomerRSN = Convert.ToInt32(e.CommandArgument);

                LoadCustomerProfile(iCustomerRSN);

            }

            else if (e.CommandName == "Activities")
            {

                string strProspectRSN = Convert.ToString(e.CommandArgument);

                LinkButton lnktaskid = (LinkButton)e.Item.FindControl("lnktaskid");

                string strtaskid = lnktaskid.Text;

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                Session["DiaryFrom"] = "FromMyTasks";

                LoadProspectDiary(strProspectRSN, strtaskid.ToString());

                rwDiary.Visible = true;
            }

            else if (e.CommandName == "Pink")
            {
                int iTaskID = Convert.ToInt32(e.CommandArgument);

                DataSet dscheck = sqlobj.SQLExecuteDataset("sp_GetTaskdetail",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = iTaskID.ToString() });

                if (dscheck.Tables[0].Rows.Count > 0)
                {
                    string strstaffid = dscheck.Tables[0].Rows[0]["StaffID"].ToString();
                    string assignedby = dscheck.Tables[0].Rows[0]["AssignedBy"].ToString();
                    string strcustomer = dscheck.Tables[0].Rows[0]["Name"].ToString();
                    string stractivity = dscheck.Tables[0].Rows[0]["ActivityAssigned"].ToString();
                    string strreference = dscheck.Tables[0].Rows[0]["AssigneeCommnts"].ToString();
                    string strtargetdate = dscheck.Tables[0].Rows[0]["TargetDate"].ToString();

                    sqlobj.ExecuteSQLNonQuery("sp_insertping",
                                      new SqlParameter() { ParameterName = "@fromid", SqlDbType = SqlDbType.NVarChar, Value = assignedby.ToString() },
                                      new SqlParameter() { ParameterName = "@toid", SqlDbType = SqlDbType.NVarChar, Value = strstaffid.ToString() },
                                      new SqlParameter() { ParameterName = "@name", SqlDbType = SqlDbType.NVarChar, Value = strcustomer.ToString() },
                                      new SqlParameter() { ParameterName = "@reference", SqlDbType = SqlDbType.NVarChar, Value = strreference.ToString() },
                                      new SqlParameter() { ParameterName = "@activity", SqlDbType = SqlDbType.NVarChar, Value = stractivity.ToString() },
                                      new SqlParameter() { ParameterName = "@targetdate", SqlDbType = SqlDbType.DateTime, Value = strtargetdate.ToString() },
                                       new SqlParameter() { ParameterName = "@Createdby", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                      );
                    RadWindowManager1.Title = "Ping for Status request and Content";
                    RadWindowManager1.RadAlert("Progress update request mailed to " + strstaffid, null, null, null, null, null);
                }
            }

            else
            {
                string StaffID = QSUserName;
                LoadTaskDetDir1(StaffID);
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadProspectDiary(string prospectrsn, string taskid)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectDiary = new DataSet();
        dsProspectDiary = sqlobj.SQLExecuteDataset("SP_GetTaskIDProspectDiary",
            new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = prospectrsn.ToString() },
             new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = taskid.ToString() }
            );


        if (dsProspectDiary.Tables[0].Rows.Count > 0)
        {


            lbldiaryheadName.Text = dsProspectDiary.Tables[0].Rows[0]["name"].ToString();



            lbldiarycount.Visible = false;


            // lbldiaryheadStatus.Text = " Status:" + dsProspectDiary.Tables[0].Rows[0]["Status"].ToString();


            // lbldiaryheadType.Text = " Type:" + dsProspectDiary.Tables[0].Rows[0]["Type"].ToString();

            gvDiary.DataSource = dsProspectDiary;
            gvDiary.DataBind();
        }
        else
        {
            gvDiary.DataSource = null;
            gvDiary.DataBind();

            rwDiary.Visible = false;
            WebMsgBox.Show("Sorry, there are no activity entries present.");
        }

    }
    protected void RdGrd_TaskDetDir2_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "CustomerName")
            {

                int iCustomerRSN = Convert.ToInt32(e.CommandArgument);

                LoadCustomerProfile(iCustomerRSN);


            }
            else if (e.CommandName == "Activities")
            {

                string strProspectRSN = Convert.ToString(e.CommandArgument);

                LinkButton lnktaskid = (LinkButton)e.Item.FindControl("lnktaskid");

                string strtaskid = lnktaskid.Text;

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                Session["DiaryFrom"] = "FromByMe";

                LoadProspectDiary(strProspectRSN, strtaskid.ToString());

                rwDiary.Visible = true;
            }
            else if (e.CommandName == "Pink")
            {
                int iTaskID = Convert.ToInt32(e.CommandArgument);

                DataSet dscheck = sqlobj.SQLExecuteDataset("sp_GetTaskdetail",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = iTaskID.ToString() });

                if (dscheck.Tables[0].Rows.Count > 0)
                {
                    string strstaffid = dscheck.Tables[0].Rows[0]["StaffID"].ToString();
                    string assignedby = dscheck.Tables[0].Rows[0]["AssignedBy"].ToString();
                    string strcustomer = dscheck.Tables[0].Rows[0]["Name"].ToString();
                    string stractivity = dscheck.Tables[0].Rows[0]["Comments"].ToString();
                    string strreference = dscheck.Tables[0].Rows[0]["AssigneeCommnts"].ToString();
                    string strtargetdate = dscheck.Tables[0].Rows[0]["TargetDate"].ToString();


                    sqlobj.ExecuteSQLNonQuery("sp_insertping",
                                      new SqlParameter() { ParameterName = "@fromid", SqlDbType = SqlDbType.NVarChar, Value = assignedby.ToString() },
                                      new SqlParameter() { ParameterName = "@toid", SqlDbType = SqlDbType.NVarChar, Value = strstaffid.ToString() },
                                      new SqlParameter() { ParameterName = "@name", SqlDbType = SqlDbType.NVarChar, Value = strcustomer.ToString() },
                                      new SqlParameter() { ParameterName = "@reference", SqlDbType = SqlDbType.NVarChar, Value = strreference.ToString() },
                                      new SqlParameter() { ParameterName = "@activity", SqlDbType = SqlDbType.NVarChar, Value = stractivity.ToString() },
                                      new SqlParameter() { ParameterName = "@targetdate", SqlDbType = SqlDbType.DateTime, Value = strtargetdate.ToString() },
                                       new SqlParameter() { ParameterName = "@Createdby", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                      );

                    RadWindowManager1.Title = "Ping for Status request and Content";
                    RadWindowManager1.RadAlert("Progress update request mailed to " + strstaffid, null, null, null, null, null);
                }
            }

            else
            {
                string StaffID = QSUserName;
                LoadTaskDetDir2(StaffID);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadCustomerProfile(int customerrsn)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();

            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn.ToString() });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                lblscpcompanyname.Text = dsCCustStatus.Tables[0].Rows[0]["CompanyName"].ToString();
                lblscpdoorno.Text = dsCCustStatus.Tables[0].Rows[0]["DoorNo"].ToString();
                lblscpcity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
                lblscppinzip.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();
                lblscpstate.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
                lblscpcountry.Text = dsCCustStatus.Tables[0].Rows[0]["Country"].ToString();
                lblscpphone.Text = dsCCustStatus.Tables[0].Rows[0]["Phone"].ToString();
                lblscpmobile.Text = dsCCustStatus.Tables[0].Rows[0]["Mobile"].ToString();
                lblscpemail.Text = dsCCustStatus.Tables[0].Rows[0]["Email"].ToString();
                lblscpemail2.Text = dsCCustStatus.Tables[0].Rows[0]["Email2"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();
                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(customerrsn.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities inprogress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities inprogress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn.ToString() });

                if (dsContacts.Tables[0].Rows.Count > 0)
                {
                    gvrwcontacts.DataSource = dsContacts;
                    gvrwcontacts.DataBind();
                }
                else
                {
                    gvrwcontacts.DataSource = null;
                    gvrwcontacts.DataBind();
                }

                dsContacts.Dispose();
                rwCustomerProfile.Visible = true;
            }

            dsCCustStatus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void wsgetLatestbtn_Click(object sender, EventArgs e)
    {
        string StaffID = QSUserName;
        Session["StaffID"] = QSUserName;
        LoadTaskDetDir1(StaffID);
        LoadTaskDetDir2(StaffID);
    }

    protected void btnstatushelp_Click(object sender, EventArgs e)
    {
        DataSet dsstatuhelp = sqlobj.SQLExecuteDataset("SP_GetStatusHelp");
        if (dsstatuhelp.Tables[0].Rows.Count > 0)
        {
            gvStatuHelp.DataSource = dsstatuhelp;
            gvStatuHelp.DataBind();
            rwStatusHelp.Visible = true;
        }
        dsstatuhelp.Dispose();
    }
    protected void btnimgaddsavetime_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlsavetime.SelectedValue != "")
        {
            string st = ddlsavetime.SelectedValue;

            if (txtNotes.Text != "")
            {
                txtNotes.Text = txtNotes.Text + " " + st.ToString();
            }
            else
            {
                txtNotes.Text = txtNotes.Text + st.ToString();
            }
        }
    }


    private void LoadStaffManager()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
        ddlbdstaff.Items.Clear();
        if (dsMasters.Tables[4].Rows.Count > 0)
        {
            ddlbdstaff.DataSource = dsMasters.Tables[4];
            ddlbdstaff.DataValueField = "UserName";
            ddlbdstaff.DataTextField = "StaffName";
            ddlbdstaff.DataBind();
        }
        ddlbdstaff.Items.Insert(0, "All");
        dsMasters.Dispose();
    }
    protected void btnBusinessDashboard_Click(object sender, EventArgs e)
    {
        string url = "BusinessDashboard.aspx";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }
    protected void btnbdshow_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsbizdb = sqlobj.SQLExecuteDataset("SP_NewBusinessDashboard",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpbdfrom.SelectedDate },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpbdto.SelectedDate },
              new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = ddlbdstaff.SelectedValue == "All" ? null : ddlbdstaff.SelectedValue }
              );

            if (dsbizdb.Tables[0].Rows.Count > 0)
            {
                lblhlcount.Text = dsbizdb.Tables[0].Rows[0]["HotLeadsCount"].ToString();
            }

            if (dsbizdb.Tables[1].Rows.Count > 0)
            {
                lblwcount.Text = dsbizdb.Tables[1].Rows[0]["WarmCount"].ToString();
            }
            if (dsbizdb.Tables[2].Rows.Count > 0)
            {
                lblqcount.Text = dsbizdb.Tables[2].Rows[0]["QuotaionCount"].ToString();
                lblqvalue.Text = dsbizdb.Tables[2].Rows[0]["Value"].ToString();
            }
            if (dsbizdb.Tables[3].Rows.Count > 0)
            {
                lblecount.Text = dsbizdb.Tables[3].Rows[0]["enquiriesCount"].ToString();
            }
            if (dsbizdb.Tables[4].Rows.Count > 0)
            {
                lblnocount.Text = dsbizdb.Tables[4].Rows[0]["newordersCount"].ToString();
                lblnovalue.Text = dsbizdb.Tables[4].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[5].Rows.Count > 0)
            {
                lbleccount.Text = dsbizdb.Tables[5].Rows[0]["existingcustomerCount"].ToString();
                lblecvalue.Text = dsbizdb.Tables[5].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[6].Rows.Count > 0)
            {

                lblnccount.Text = dsbizdb.Tables[6].Rows[0]["newcustomerCount"].ToString();
                lblncvalue.Text = dsbizdb.Tables[6].Rows[0]["value"].ToString();
            }
            if (dsbizdb.Tables[7].Rows.Count > 0)
            {

                gvOrderBook.DataSource = dsbizdb.Tables[7];
                gvOrderBook.DataBind();
            }
            if (dsbizdb.Tables[8].Rows.Count > 0)
            {

                gvCategorySummary.DataSource = dsbizdb.Tables[8];
                gvCategorySummary.DataBind();
            }

            dsbizdb.Dispose();

            rwBusinessDashboard.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnServiceDashboard_Click(object sender, EventArgs e)
    {

        string url = "ServcieDashboard.aspx";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());


    }
    protected void LoadROL()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsROL = new DataSet();

        dsROL = sqlobj.SQLExecuteDataset("SP_LoadROL");

        if (dsROL.Tables[0].Rows.Count > 0)
        {
            gvROL.DataSource = dsROL;
            gvROL.DataBind();
        }

        dsROL.Dispose();
    }
    protected void LoadStaffID()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaffID = new DataSet();

        dsStaffID = sqlobj.SQLExecuteDataset("sp_fetchdropdown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = "3" }
            );

        if (dsStaffID.Tables[0].Rows.Count > 0)
        {
            ddlStaffID.DataSource = dsStaffID;
            ddlStaffID.DataValueField = "StaffID";
            ddlStaffID.DataTextField = "StaffName";
            ddlStaffID.DataBind();
        }

        dsStaffID.Dispose();
    }
    protected void LoadTotalROL()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTotalROL = new DataSet();

        dsTotalROL = sqlobj.SQLExecuteDataset("SP_getTodayROL");

        if (dsTotalROL.Tables[0].Rows.Count > 0)
        {
            lbltotalRecognition.Text = "Recognitions recorded today : " + dsTotalROL.Tables[0].Rows[0]["Count"].ToString();
        }

        dsTotalROL.Dispose();
    }
    protected void btnROL_Click(object sender, EventArgs e)
    {
        btnROLUpdate.Visible = false;
        LoadStaffID();
        LoadTotalROL();
        LoadROL();
        //rwROL.VisibleOnPageLoad = true;
        rwROL.Visible = true;
    }
    protected void btnROLUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            strUserLevel = Session["UserLevel"].ToString();
            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_UpdatetblROL",
                    new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NChar, Value = ddlStaffID.SelectedValue },
                    new SqlParameter() { ParameterName = "@ROLTYPE", SqlDbType = SqlDbType.NChar, Value = ddlROLTYPE.SelectedValue },
                    new SqlParameter() { ParameterName = "@ROLMessage", SqlDbType = SqlDbType.NChar, Value = ROLMessage.Text },
                    new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ROLRSN"].ToString() }
                    );

                ddlROLTYPE.SelectedIndex = 0;
                ddlStaffID.SelectedIndex = 0;
                ROLMessage.Text = "";

                btnROLUpdate.Visible = false;
                btnROLSave.Visible = true;
                LoadROL();
                WebMsgBox.Show("Thank you for your feedback. It shall be conveyed to the concerned via Email.");
                rwROL.Visible = true;
            }
            else
            {
                WebMsgBox.Show("Access denied");
                rwROL.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
            rwROL.Visible = true;
        }
    }
    protected void btnROLClear_Click(object sender, EventArgs e)
    {
        ddlROLTYPE.SelectedIndex = 0;
        ddlStaffID.SelectedIndex = 0;
        ROLMessage.Text = "";

        btnROLUpdate.Visible = false;
        btnROLSave.Visible = true;

        LoadROL();
        rwROL.Visible = true;
    }
    protected void btnROLExit_Click(object sender, EventArgs e)
    {
        rwROL.Visible = false;
    }
    protected void gvROL_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvROL.PageIndex = e.NewPageIndex;
        LoadROL();
        rwROL.Visible = true;
    }

    protected void btnROLSave_Click(object sender, EventArgs e)
    {
        try
        {
            strUserLevel = Session["UserLevel"].ToString();
            if (ROLMessage.Text != "")
            {
                if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
                {
                    SQLProcs sqlobj = new SQLProcs();
                    sqlobj.ExecuteSQLNonQuery("SP_InserttblROL",
                        new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NChar, Value = ddlStaffID.SelectedValue },
                        new SqlParameter() { ParameterName = "@ROLTYPE", SqlDbType = SqlDbType.NChar, Value = ddlROLTYPE.SelectedValue },
                        new SqlParameter() { ParameterName = "@ROLMessage", SqlDbType = SqlDbType.NChar, Value = ROLMessage.Text },
                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() }
                        );

                    ddlROLTYPE.SelectedIndex = 0;
                    ddlStaffID.SelectedIndex = 0;
                    ROLMessage.Text = "";
                    LoadTotalROL();
                    LoadROL();
                    WebMsgBox.Show("Thank you for your feedback. It shall be conveyed to the concerned via Email.");
                }
                else
                {
                    WebMsgBox.Show("Access denied");
                }
            }
            else
            {
                WebMsgBox.Show("Please enter your comments.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
        rwROL.Visible = true;
    }
    protected void btnAssesPerform_Click(object sender, EventArgs e)
    {
        //Response.Redirect("AssesPerform.aspx");
        Response.Redirect("Mytasks.aspx");
    }
    protected void btnCharts_Click(object sender, EventArgs e)
    {
        Response.Redirect("Charts.aspx");
    }
    protected void btnReports_Click(object sender, EventArgs e)
    {
        Response.Redirect("SMReports.aspx");
    }

    protected void btnGeneralDashboard_Click(object sender, EventArgs e)
    {
        string url = "GeneralDashBoard.aspx";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }

    protected void btnSSTSave_Click1(object sender, EventArgs e)
    {

    }

    protected void btnservice_Click(object sender, EventArgs e)
    {
        try
        {
            lblserviceName.Text = "Services provided for :" + txtCustName.Text;           
            ServiceActivityReference();
            LoadServiceDetails();
            rwServicedetails.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvServiceDetails_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvServiceDetails.EditIndex = e.NewEditIndex;
        LoadServiceDetails();
        rwServicedetails.Visible = true;
    }
    private void ServiceActivityReference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackonSer = new DataSet();
        dsTrackonSer = sqlobj.SQLExecuteDataset("Proc_GetServiceActReference");

        if (dsTrackonSer.Tables[0].Rows.Count != 0)
        {
            ddlrwservice.DataSource = dsTrackonSer.Tables[0];
            ddlrwservice.DataValueField = "trackondesc";
            ddlrwservice.DataTextField = "trackondesc";
            ddlrwservice.DataBind();

        }
        //ddlrwservice.Items.Insert(0, "All");
        dsTrackonSer.Dispose();

    }
    protected void gvServiceDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int RSN = Convert.ToInt32(gvServiceDetails.DataKeys[e.RowIndex].Value.ToString());

            DropDownList gvddlreference = (DropDownList)gvServiceDetails.Rows[e.RowIndex].FindControl("gvddlserreference");
            RadDatePicker gvraddateserfrom = (RadDatePicker)gvServiceDetails.Rows[e.RowIndex].FindControl("gvraddateserfrom");
            RadDatePicker gvraddateserto = (RadDatePicker)gvServiceDetails.Rows[e.RowIndex].FindControl("gvraddateserto");
            TextBox txtValue = (TextBox)gvServiceDetails.Rows[e.RowIndex].FindControl("txtValue");

            SQLProcs sqlobj = new SQLProcs();
            sqlobj.ExecuteSQLNonQuery("proc_updateservice",
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NChar, Value = RSN.ToString() },
                       new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NChar, Value = gvddlreference.SelectedValue },
                       new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = gvraddateserfrom.SelectedDate == null ? null : gvraddateserfrom.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = gvraddateserto.SelectedDate == null ? null : gvraddateserto.SelectedDate },
                       new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = txtValue.Text }
                       );
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Service details updated successfully.');", true);
            gvServiceDetails.EditIndex = -1;
            LoadServiceDetails();
            rwServicedetails.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvServiceDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvServiceDetails.EditIndex = -1;
        LoadServiceDetails();
        rwServicedetails.Visible = true;
    }
    private void LoadServiceDetails()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsService = new DataSet();
            dsService = sqlobj.SQLExecuteDataset("proc_SeleclService",
                 new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NChar, Value = Session["ProspectRSN"].ToString() }
                );
            if (dsService.Tables[0].Rows.Count > 0)
            {
                gvServiceDetails.DataSource = dsService.Tables[0];
                gvServiceDetails.DataBind();
            }
            else
            {
                gvServiceDetails.DataSource = null;
                gvServiceDetails.DataBind();
            }
            dsService = null;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAddService_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("proc_InsertService",
                           new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NChar, Value = Session["ProspectRSN"].ToString() },
                           new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NChar, Value = ddlrwservice.SelectedValue },
                           new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = RadDateserfrom.SelectedDate == null ? null : RadDateserfrom.SelectedDate },
                           new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = RadDateserto.SelectedDate == null ? null : RadDateserto.SelectedDate },
                           new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = txtservicevalue.Text == "" ? "0.00" : txtservicevalue.Text }
                           );
                // WebMsgBox.Show("Service details added successfully.");
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Service details added successfully.');", true);
                LoadServiceDetails();
                rwServicedetails.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvServiceDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList gvddlreference = (e.Row.FindControl("gvddlserreference") as DropDownList);
            if (gvddlreference != null)
            {
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsTrackonSer = new DataSet();
                dsTrackonSer = sqlobj.SQLExecuteDataset("Proc_GetServiceActReference");
                if (dsTrackonSer.Tables[0].Rows.Count != 0)
                {
                    gvddlreference.DataSource = dsTrackonSer.Tables[0];
                    gvddlreference.DataValueField = "trackondesc";
                    gvddlreference.DataTextField = "trackondesc";
                    gvddlreference.DataBind();
                }
                //ddlrwservice.Items.Insert(0, "All");
                dsTrackonSer.Dispose();
                string country = (e.Row.FindControl("lbltempReference") as Label).Text;
                gvddlreference.Items.FindByValue(country).Selected = true;
            }

        }
    }
    protected void Button3_Click1(object sender, EventArgs e)
    {
        rwServicedetails.Visible = false;
    }
    protected void btnnewenquiry_Click(object sender, EventArgs e)
    {
        Session["TaskType"] = "FromDirect";
    }
    protected void btnbymenewenquiry_Click(object sender, EventArgs e)
    {
        Session["TaskType"] = "FromDirect";
    }


    protected Boolean IsDiaryFrom()
    {
        string DiaryFrom = "";

        if (DiaryFrom == Session["CustomerGrid"].ToString())
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    protected void btnCloseContacts_Click(object sender, EventArgs e)
    {
        rwAddCustomer.Visible = false;
    }
    protected void btnTaskDetDir2_Click(object sender, EventArgs e)
    {
        if ((RdGrd_TaskDetDir2.Visible == true))
        {
            if (ViewState["ByMe"] != null)
            {
                DataTable dt = (DataTable)ViewState["ByMe"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("Staffid") && dt.Columns.Contains("DelegatedOn") && dt.Columns.Contains("DelegateSTask") && dt.Columns.Contains("Task") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("customerrsn") && dt.Columns.Contains("Tracker") && dt.Columns.Contains("Priority"))
                    {
                        //dt.Columns.Remove("Staffid");
                        dt.Columns["Staffid"].ColumnName = "AssignedTo";
                        dt.Columns["CustomerStatus"].ColumnName = "LeadStatus";
                        dt.Columns["Comments"].ColumnName = "Most recent work progress";
                        dt.Columns["Status"].ColumnName = "TaskStatus";
                        dt.Columns["Tracker"].ColumnName = "Ct.";
                        dt.Columns["Followupdate"].ColumnName = "Fwup?";
                        dt.Columns["Priority"].ColumnName = "Priority";
                        dt.Columns["AssignedBy"].ColumnName = "AsgndBy";
                        dt.Columns["DelegateBy"].ColumnName = "DlgtBy";

                        //dt.Columns.Remove("Reference");
                        dt.Columns.Remove("TaskID");
                        dt.Columns.Remove("CustomerRSN");
                        //dt.Columns.Remove("Tracker");
                        dt.Columns.Remove("Priority");
                        dt.Columns.Remove("Task");
                        dt.Columns.Remove("TaskType");
                        dt.Columns.Remove("DelegatedOn");
                        dt.Columns.Remove("DelegateSTask");
                        dt.AcceptChanges();
                    }
                    dt.DefaultView.Sort = "Name asc";
                    GridView gv = new GridView();
                    gv.DataSource = dt;
                    gv.DataBind();
                    GridView[] gvlist = new GridView[] { gv };
                    Export("ManageTask_AtTaskDetailLevel.xls", gvlist);
                }
            }          
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }
    protected void btnTaskDetDir1_Click(object sender, EventArgs e)
    {
        if ((RdGrd_TaskDetDir1.Visible == true))
        {
            if (ViewState["MyTasks"] != null)
            {
                DataTable dt = (DataTable)ViewState["MyTasks"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("Staffid") && dt.Columns.Contains("DelegatedOn") && dt.Columns.Contains("DelegateSTask") && dt.Columns.Contains("Task") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("customerrsn") && dt.Columns.Contains("Tracker") && dt.Columns.Contains("Priority"))
                    {
                        //dt.Columns.Remove("Staffid");
                        dt.Columns["Staffid"].ColumnName = "AssignedTo";
                        dt.Columns["CustomerStatus"].ColumnName = "LeadStatus";
                        dt.Columns["Comments"].ColumnName = "Most recent work progress";
                        dt.Columns["Status"].ColumnName = "TaskStatus";
                        dt.Columns["Tracker"].ColumnName = "Ct.";
                        dt.Columns["Followupdate"].ColumnName = "Fwup?";
                        dt.Columns["PriorityDesc"].ColumnName = "PriorityDesc";
                        dt.Columns["AssignedBy"].ColumnName = "AsgndBy";
                        dt.Columns["DelegateBy"].ColumnName = "DlgtBy";

                        //dt.Columns.Remove("Reference");
                        dt.Columns.Remove("TaskID");
                        dt.Columns.Remove("CustomerRSN");
                        //dt.Columns.Remove("Tracker");
                        dt.Columns.Remove("Priority");
                        dt.Columns.Remove("Task");
                        dt.Columns.Remove("TaskType");
                        dt.Columns.Remove("DelegatedOn");
                        dt.Columns.Remove("DelegateSTask");
                        dt.AcceptChanges();
                    }
                    dt.DefaultView.Sort = "Name asc";
                    GridView gv = new GridView();
                    gv.DataSource = dt;
                    gv.DataBind();
                    GridView[] gvlist = new GridView[] { gv };
                    Export("ManageTask_AtTaskDetailLevel.xls", gvlist);
                }
                else
                {
                    WebMsgBox.Show("There are no records to Export");
                }
            }
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }
    protected void btnView2_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlTaskList2.SelectedItem.Text != "Please Select")
            {
                HDUserID.Value = QSUserName;
                SQLProcs sqlobj = new SQLProcs();

                string StaffID = QSUserName;
                Session["StaffID"] = QSUserName;
                string StaffName = QSUserName;

                RdGrd_TaskDetDir2.Visible = true;
                btnTaskDetDir2.Visible = true;

                if (ddlTaskList2.SelectedIndex == 2 || ddlTaskList2.SelectedIndex == 3)
                {
                    btnNewPing2.Visible = true;
                }
                else
                {
                    btnNewPing1.Visible = false;
                    btnNewPing2.Visible = true;
                }
                LoadTaskDetDir2(StaffID);
                lblHelp11.Visible = false;
                lblHelp44.Visible = true;
            }
            else
            {
                WebMsgBox.Show("Please select the task status.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
            return;
        }
    }
    protected void btnView1_Click(object sender, EventArgs e)
    {
        try
        {
            HDUserID.Value = QSUserName;
            SQLProcs sqlobj = new SQLProcs();
            try
            {
                if (ddlTaskList1.SelectedItem.Text != "Please Select")
                {
                    string StaffID = QSUserName;
                    Session["StaffID"] = QSUserName;
                    string StaffName = QSUserName;
                    RdGrd_TaskDetDir1.Visible = true;
                    btnTaskDetDir1.Visible = true;

                    if (ddlTaskList1.SelectedIndex == 2 || ddlTaskList1.SelectedIndex == 3)
                    {
                        btnNewPing1.Visible = true;
                        btnNewPing2.Visible = false;
                    }
                    else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
                    {
                        btnNewPing1.Visible = true;
                        btnNewPing2.Visible = false;
                        dtpTaskDate1.Visible = false;
                    }
                    LoadTaskDetDir1(StaffID);
                    lblHelp11.Visible = true;
                    lblHelp44.Visible = false;
                }
                else
                {
                    WebMsgBox.Show("Please select the task status");
                }

            }
            catch (Exception qr)
            {
                WebMsgBox.Show("Please select an option from the drop down list");
                return;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
            return;
        }
    }
    protected void btnMyTasks_Click(object sender, EventArgs e)
    {
        try
        {
            HDUserID.Value = QSUserName;
            SQLProcs sqlobj = new SQLProcs();
            try
            {
                if (ddlTaskList1.SelectedItem.Text != "Please Select")
                {
                    string StaffID = QSUserName;
                    Session["StaffID"] = QSUserName;
                    string StaffName = QSUserName;
                    RdGrd_TaskDetDir1.Visible = true;
                    btnTaskDetDir1.Visible = true;

                    if (ddlTaskList1.SelectedIndex == 2 || ddlTaskList1.SelectedIndex == 3)
                    {
                        btnNewPing1.Visible = true;
                        btnNewPing2.Visible = false;
                    }
                    else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
                    {
                        btnNewPing1.Visible = true;
                        btnNewPing2.Visible = false;
                        dtpTaskDate1.Visible = false;
                    }
                    LoadTaskDetDir1(StaffID);
                    lblHelp11.Visible = true;
                    lblHelp44.Visible = false;
                }
                else
                {
                    WebMsgBox.Show("Please select the task status");
                }

            }
            catch (Exception qr)
            {
                WebMsgBox.Show("Please select an option from the drop down list");
                return;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
            return;
        }
    }
}