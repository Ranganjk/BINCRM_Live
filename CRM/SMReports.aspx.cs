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
using System.Data.OleDb;
using System.Web.UI.DataVisualization.Charting;
using System.Web.Script.Serialization;

public partial class SMReports : System.Web.UI.Page
{
    SQLProcs sqlobj = new SQLProcs();

    static string strUserLevel;
    protected static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
    static String StaffID;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserID"] == null)
            {
                Session.Abandon();

                Response.Redirect("Login.aspx");
            }            

            DataSet dsDT = null;

            rwCustomerProfile.VisibleOnPageLoad = true;
            rwCustomerProfile.Visible = false;

            //rwStatusHelp.VisibleOnPageLoad = true;
            rwStatusHelp.Visible = false;

            rwDiary.VisibleOnPageLoad = true;
            rwDiary.Visible = false;
          

            if (!Page.IsPostBack)
            {
                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }

                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Reports", DateTime.Now);


                dsDT = sqlobj.SQLExecuteDataset("GetServerDateTime");
                //lblDate1.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dddd") + " , " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy | hh:mm tt");

                GetUserDet();
                LoadCompanyDetails();
                //LoadProspectCount();
                //Comment by Prakash 29-08-2015
                //LoadfilterProspectStatus();

                // Load function in SMR1

                // LoadMRReference();
                LoadMRCategory();
                LoadMRLeadSource();
                LoadMRCampaign();


                //--- sm reports ---//

                //dtpsmr1fromdate.SelectedDate = DateTime.Now.AddDays(1 - DateTime.Now.Day);
                //dtpsmr1todate.SelectedDate = DateTime.Now.Date;


                dvMainSMReports.Visible = true;
                divMR1.Visible = false;
                //divLeadSummary.Visible = false;
                divMR3.Visible = false;
                divMR4.Visible = false;
                //divMR5.Visible = false;
                //divMR6.Visible = false;
                dvMarkettingAct.Visible = false;
                dvGeneralActivity.Visible = false;
                dvServiceActivity.Visible = false;


                //WM Reports
                //divwfr1.Visible = false;
                divwfr2.Visible = false;
                divwfr3.Visible = false;
                divwfr4.Visible = false;

                ddlwfr2Customer.Items.Insert(0, "All");
                ddlwfr4Customer.Items.Insert(0, "All");

                dtpwfr2StartDate.SelectedDate = DateTime.Now.AddDays(-1);
                dtpwfr2ToDate.SelectedDate = DateTime.Now.Date;

                dtpwfr4from.SelectedDate = DateTime.Now.AddDays(-1);
                dtpwfr4to.SelectedDate = DateTime.Now.Date;

                //SMX Reports//
                LoadDDL3();

                //---smx report---//
                divsmx1.Visible = false;
                ddlSMXReport1.SelectedIndex = 0;
                divsmx2.Visible = false;

                divsmx5.Visible = false;


                dvROL.Visible = false;


                dvMainSMReports.Visible = false;
                dvHeaderMenu.Visible = true;

                //08-09-2015
                dvR12TimeSummary.Visible = false;
                dvR13TimeDetailed.Visible = false;
                dvR14sysnotused.Visible = false;

                //24-09-2015

                dvR4EnqRegistered.Visible = false;
                dvR4QuoateSubmitted.Visible = false;
                dvR4OrdersBooked.Visible = false;
                dvR5SServiceReport.Visible = false;

                dvEODStats.Visible = false;
                dvEODCustStats.Visible = false;
                dvCompReport.Visible = false;
                dvRefSummReport.Visible = false;
               
                dvDailyUsageBilllingReport.Visible = false;                

                if (Request.QueryString["Name"] != null)
                {
                    string test = Request.QueryString["Name"].ToString();
                    btnR1CusList_Click(sender, e);
                    //divMR1.Visible = true;
                    txtmr1name.Text = test.ToString();
                    btnmr1Search_Click(sender, e);
                }
            }
            string strUserID = Session["UserID"].ToString();
            //string strUserID = "demo";     
            strUserLevel = Session["UserLevel"].ToString();
            if (!(strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator"))
            {
                btnR1CusList.Enabled = false;
                btnR2Leadsflup.Enabled = false;
                btnR3NoSales.Enabled = false;
                btnR4Enquiry.Enabled = false;
                btnR4MarkAct.Enabled = false;
                btnR4Quotation.Enabled = false;
                btnR4Orders.Enabled = false;
                btnR5ServAct.Enabled = false;
                btnR6GenAct.Enabled = false;
                btnR10cuslistloc.Enabled = false;
                btnR50ROL.Enabled = false;
                //btnR12timesummary.Enabled = false;
                //btnR13timedetailed.Enabled = false;
                btnR14sysnotused.Enabled = false;
                btnX1cusdump.Enabled = false;
                btnX2reflist.Enabled = false;
                btnR15serpro.Enabled = false;

                btnR1CusList.ForeColor = Color.Transparent;
                btnR2Leadsflup.ForeColor = Color.Transparent;
                btnR3NoSales.ForeColor = Color.Transparent;
                btnR4Enquiry.ForeColor = Color.Transparent;
                btnR4MarkAct.ForeColor = Color.Transparent;
                btnR4Quotation.ForeColor = Color.Transparent;
                btnR4Orders.ForeColor = Color.Transparent;
                btnR5ServAct.ForeColor = Color.Transparent;
                btnR6GenAct.ForeColor = Color.Transparent;
                btnR10cuslistloc.ForeColor = Color.Transparent;
                btnR50ROL.ForeColor = Color.Transparent;
                //btnR12timesummary.ForeColor = Color.Gray;
                //btnR13timedetailed.ForeColor = Color.Gray;
                btnR14sysnotused.ForeColor = Color.Transparent;
                btnX1cusdump.ForeColor = Color.Transparent;
                btnX2reflist.ForeColor = Color.Transparent;
                btnR15serpro.ForeColor = Color.Transparent;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    // -- Start User and Company details -- //


    protected void LoadCompanyDetails()
    {
        //lblHeading.Text = Session["ProductName"].ToString();
        //lblproductbyline1.Text = Session["ProductByLine"].ToString();
        //lblcompanyName1.Text = Session["CompanyName"].ToString();
        //lblVersion.Text = Session["Version"].ToString();
    }

    protected void GetUserDet()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsUserDet = new DataSet();
            dsUserDet = sqlobj.SQLExecuteDataset("SP_FetchUserDet",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

            // lblUser.Text = dsUserDet.Tables[0].Rows[0]["UserDet"].ToString();
            Session["StaffName"] = Convert.ToString(dsUserDet.Tables[0].Rows[0]["StaffName"].ToString());
            dsUserDet.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    // -- End User and Company details -- //


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




    // SMR1 PROCESS START

    private void LoadMRReference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup_new");

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {

            ddlmrReference.DataSource = dsTrackon.Tables[0];
            ddlmrReference.DataValueField = "TrackonDesc";
            ddlmrReference.DataTextField = "TrackonDesc";
            ddlmrReference.DataBind();

        }

        ddlmrReference.Items.Insert(0, "All");

        dsTrackon.Dispose();

    }

    private void LoadMRCategory()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("proc_LoadCategory");

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {

            ddlmrReference.DataSource = dsTrackon.Tables[0];
            ddlmrReference.DataValueField = "Category";
            ddlmrReference.DataTextField = "Category";
            ddlmrReference.DataBind();
        }

        ddlmrReference.Items.Insert(0, "All");

        dsTrackon.Dispose();

    }

    private void LoadMRLeadSource()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 17 });


        ddlmrLeadSource.DataSource = dsCCustStatus.Tables[0];
        ddlmrLeadSource.DataValueField = "LeadKey";
        ddlmrLeadSource.DataTextField = "LeadKey";
        ddlmrLeadSource.DataBind();
        ddlmrLeadSource.Dispose();

        ddlmrLeadSource.Items.Insert(0, "All");

    }

    private void LoadMRCampaign()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 18 });

        ddlmr1Campaign.DataSource = dsCCustStatus.Tables[0];
        ddlmr1Campaign.DataValueField = "Campaignvalue";
        ddlmr1Campaign.DataTextField = "Campaignvalue";
        ddlmr1Campaign.DataBind();


        ddlmr1Campaign.Dispose();

        ddlmr1Campaign.Items.Insert(0, "All");
    }

    protected void btnStatusHelp_Click(object sender, EventArgs e)
    {
        //rwStatusHelp.VisibleOnPageLoad = true;       
        rwStatusHelp.VisibleOnPageLoad = true;
        //rwStatusHelp.Width = 500;
        //rwStatusHelp.Height = 300;      
        rwStatusHelp.Visible = true;
    }

    protected void btnmr1Search_Click(object sender, EventArgs e)
    {
        try
        {
            LoadMR1();
            lblCount.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadMR1()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport1",
                //new SqlParameter() { ParameterName = "@Startdate", SqlDbType = SqlDbType.Date, Value = dtpsmr1fromdate.SelectedDate },
                //new SqlParameter() { ParameterName = "@Enddate", SqlDbType = SqlDbType.Date, Value = dtpsmr1todate.SelectedDate },
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.NVarChar, Value = ddlmrType.SelectedValue },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrReference.SelectedValue == "All") ? null : ddlmrReference.SelectedValue },
                    new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrLeadSource.SelectedValue == "All") ? null : ddlmrLeadSource.SelectedValue },
                    new SqlParameter() { ParameterName = "@Campaign", SqlDbType = SqlDbType.NVarChar, Value = (ddlmr1Campaign.SelectedValue == "All") ? null : ddlmr1Campaign.SelectedValue },
                    new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtmr1mobileNo.Text },
                    new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtmr1name.Text }

                    );


            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport1.DataSource = dsTargetDet.Tables[0];
                ViewState["R1"] = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblCount.Text = "Count:" + TypeRCount.ToString();
                gvMarketingReport1.DataBind();
                dsTargetDet.Dispose();
            }

            else
            {
                lblCount.Text = "Count: 0";
                WebMsgBox.Show("There are no records to display");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    protected void btnClearmr1_Click(object sender, EventArgs e)
    {
        //dtpsmr1fromdate.SelectedDate = DateTime.Now.AddDays(1 - DateTime.Now.Day);
        //dtpsmr1todate.SelectedDate = DateTime.Now.Date;

        ddlmrType.SelectedIndex = 0;
        ddlmrReference.SelectedIndex = 0;
        ddlmrLeadSource.SelectedIndex = 0;
        ddlmr1Campaign.SelectedIndex = 0;
        txtmr1mobileNo.Text = "";
        txtmr1name.Text = "";
        lblCount.Text = "";

        gvMarketingReport1.DataSource = null;
        gvMarketingReport1.DataBind();
        ViewState["R1"] = null;
    }


    protected void OnMR1Paging(object sender, GridViewPageEventArgs e)
    {
        gvMarketingReport1.PageIndex = e.NewPageIndex;
        LoadMR1();
    }


    protected void gvMarketingReport1_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataView sortedView = new DataView(BindGridView());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvMarketingReport1.DataSource = sortedView;
        gvMarketingReport1.DataBind();
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


    private DataTable BindGridView()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsTargetDet = new DataSet();

        dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport1",
            //new SqlParameter() { ParameterName = "@Startdate", SqlDbType = SqlDbType.Date, Value = dtpsmr1fromdate.SelectedDate },
            //        new SqlParameter() { ParameterName = "@Enddate", SqlDbType = SqlDbType.Date, Value = dtpsmr1todate.SelectedDate },
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.NVarChar, Value = ddlmrType.SelectedValue },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrReference.SelectedValue == "All") ? null : ddlmrReference.SelectedValue },
                    new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrLeadSource.SelectedValue == "All") ? null : ddlmrLeadSource.SelectedValue },
                    new SqlParameter() { ParameterName = "@Campaign", SqlDbType = SqlDbType.NVarChar, Value = (ddlmr1Campaign.SelectedValue == "All") ? null : ddlmr1Campaign.SelectedValue },
                    new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtmr1mobileNo.Text },
                    new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtmr1name.Text }

                );


        if (dsTargetDet != null)
        {
            //dtTemp.Dispose();
            gvMarketingReport1.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            ViewState["R1"] = dsTargetDet.Tables[0];
            gvMarketingReport1.DataBind();

        }
        return dsTargetDet.Tables[0];
    }

    private DataTable BindGridViewWFR2()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReferenceSummary = new DataSet();
        DataSet dsReferenceSummaryTotal = new DataSet();

        dsReferenceSummary = sqlobj.SQLExecuteDataset("sp_getWorkFlowReport2",
           new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = dtpwfr2StartDate.SelectedDate.Value.ToString("yyyy-MM-dd") },
           new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = dtpwfr2ToDate.SelectedDate.Value.ToString("yyyy-MM-dd") },
           new SqlParameter() { ParameterName = "@CustomerName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Customer.SelectedValue == "All" ? null : ddlwfr2Customer.SelectedValue },
           new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Reference.SelectedValue == "All" ? null : ddlwfr2Reference.SelectedValue },
           new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2By.SelectedValue == "All" ? null : ddlwfr2By.SelectedValue },
           new SqlParameter() { ParameterName = "@ReportName", SqlDbType = SqlDbType.VarChar, Value = ddlwfr2Report.SelectedValue.ToString() },
           new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Type.SelectedValue == "All" ? null : ddlwfr2Type.SelectedValue }
           );


        if (dsReferenceSummary != null)
        {
            //dtTemp.Dispose();
            gvWFR2.DataSource = dsReferenceSummary.Tables[0];
            int TypeRCount = dsReferenceSummary.Tables[0].Rows.Count;
            gvWFR2.DataBind();

        }
        return dsReferenceSummary.Tables[0];
    }
    protected void gvMarketingReport1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                //LoadCCustStatus();

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    lblscptitle.Text = dsCCustStatus.
                    Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }
                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
               new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }


            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();


                rwDiary.Visible = true;

                LoadProspectDiary(istaffid.ToString());

                if (gvDiary.Rows.Count > 0)
                {
                    rwDiary.Visible = true;
                }

                // Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow","window.open('Diary.aspx');", true);

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void LoadProspectDiary_New(string prospectrsn, string taskid)
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
            //lbldiarycount.Visible = false;
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
    protected void LoadProspectDiary(string prospectrsn)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectDiary = new DataSet();
        dsProspectDiary = sqlobj.SQLExecuteDataset("SP_GetProspectDiary", new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = prospectrsn.ToString() });




        if (dsProspectDiary.Tables[0].Rows.Count > 0)
        {


            lbldiaryheadName.Text = dsProspectDiary.Tables[0].Rows[0]["name"].ToString();


            lbldiaryheadStatus.Text = " Status:" + dsProspectDiary.Tables[0].Rows[0]["Status"].ToString();


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

    protected void onDataBound(object sender, EventArgs e)
    {
        for (int i = gvDiary.Rows.Count - 1; i > 0; i--)
        {
            GridViewRow row = gvDiary.Rows[i];
            GridViewRow previousRow = gvDiary.Rows[i - 1];
            for (int j = 0; j < 1; j++)
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





            // set to darkblue color for yet to start and inprogress

            foreach (GridViewRow rows in gvDiary.Rows)
            {
                string sTaskid = rows.Cells[0].Text;

                DataSet dsYSIP = sqlobj.SQLExecuteDataset("SP_GetActivityStatus", new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = rows.Cells[0].Text });

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



    protected void onReferenceSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        //gvReferenceSummary.PageIndex = e.NewPageIndex;
        //LoadReferenceSummary();
    }


    // SMR2 PROCESS END


    // SMR3 PROCESS START

    protected void OnMR3Paging(object sender, GridViewPageEventArgs e)
    {
        gvMarketingReport3.PageIndex = e.NewPageIndex;
        LoadMR3();
    }

    private void LoadMR3()
    {
        try
        {

            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport3");

            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport3.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblmr3count.Text = "Count:" + TypeRCount.ToString();
                gvMarketingReport3.DataBind();
                dsTargetDet.Dispose();
            }

            else
            {
                lblmr3count.Text = "0";
                WebMsgBox.Show("There are no records to display");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }


    protected void gvMarketingReport3_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataView sortedView = new DataView(BindGridViewMR3());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvMarketingReport3.DataSource = sortedView;
        gvMarketingReport3.DataBind();

    }

    private DataTable BindGridViewMR3()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsTargetDet = new DataSet();


        dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport3");


        if (dsTargetDet.Tables[0].Rows.Count > 0)
        {
            //dtTemp.Dispose();
            gvMarketingReport3.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            gvMarketingReport3.DataBind();

        }
        return dsTargetDet.Tables[0];
    }

    protected void gvMarketingReport3_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                //LoadCCustStatus();

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }
                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
               new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }

            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();


                rwDiary.Visible = true;

                LoadProspectDiary(istaffid.ToString());

                if (gvDiary.Rows.Count > 0)
                {
                    rwDiary.Visible = true;
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void OnMR4Paging(object sender, GridViewPageEventArgs e)
    {
        gvMarketingReport4.PageIndex = e.NewPageIndex;
        LoadMR4();
    }

    private void LoadMR4()
    {
        try
        {

            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport4");

            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport4.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblmr4count.Text = "Count:" + TypeRCount.ToString();
                gvMarketingReport4.DataBind();
                dsTargetDet.Dispose();
            }

            else
            {
                lblmr4count.Text = " Count: 0";
                //WebMsgBox.Show("There are no records to display");
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to display');", true);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvMarketingReport4_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataView sortedView = new DataView(BindGridViewMR4());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvMarketingReport4.DataSource = sortedView;
        gvMarketingReport4.DataBind();
    }

    private DataTable BindGridViewMR4()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsTargetDet = new DataSet();


        dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport4");


        if (dsTargetDet.Tables[0].Rows.Count > 0)
        {
            //dtTemp.Dispose();
            gvMarketingReport4.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            gvMarketingReport4.DataBind();

        }
        return dsTargetDet.Tables[0];
    }


    protected void gvMarketingReport4_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {


            //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "script", "ConfirmMessage();", true);


            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                //LoadCCustStatus();

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }
                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
               new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }

            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();


                rwDiary.Visible = true;

                LoadProspectDiary(istaffid.ToString());

                if (gvDiary.Rows.Count > 0)
                {
                    rwDiary.Visible = true;
                }


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    // SMR4 PROCESS END


    // SMR5 PROCESS START



    // SMR5 PROCESS END

    // General functions start

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
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
            gv.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
            //   Create a form to contain the grid
            Table table = new Table();
            table.GridLines = gv.GridLines;
            
            //   add the header row to the table
            if (!(gv.HeaderRow == null))
            {
                PrepareControlForExport(gv.HeaderRow);
                table.Rows.Add(gv.HeaderRow);
            }
            //   add each of the data rows to the table

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
        //HttpContext.Current.Response.End();       
        HttpContext.Current.Response.Flush();
    }


    public void ExportReport(string fileName, GridView[] gvs)
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
            //   add each of the data rows to the table


            DataSet ds = dtmrs();

            gvMarketingReport1.AllowPaging = false;
            gvMarketingReport1.DataSource = ds;

            gvMarketingReport1.DataBind();

            int check = gvMarketingReport1.Rows.Count;

            foreach (GridViewRow row in gvMarketingReport1.Rows)
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


    protected DataSet dtmrs()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsTargetDet = new DataSet();


        dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport1",
            //new SqlParameter() { ParameterName = "@Startdate", SqlDbType = SqlDbType.Date, Value = dtpsmr1fromdate.SelectedDate },
            //new SqlParameter() { ParameterName = "@Enddate", SqlDbType = SqlDbType.Date, Value = dtpsmr1todate.SelectedDate },
                     new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.NVarChar, Value = ddlmrType.SelectedValue },
                     new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrReference.SelectedValue == "All") ? null : ddlmrReference.SelectedValue },
                     new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = (ddlmrLeadSource.SelectedValue == "All") ? null : ddlmrLeadSource.SelectedValue },
                     new SqlParameter() { ParameterName = "@Campaign", SqlDbType = SqlDbType.NVarChar, Value = (ddlmr1Campaign.SelectedValue == "All") ? null : ddlmr1Campaign.SelectedValue },
                     new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtmr1mobileNo.Text },
                     new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtmr1name.Text }

                     );


        if (dsTargetDet.Tables[0].Rows.Count > 0)
        {
            //dtTemp.Dispose();
            gvMarketingReport1.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            lblCount.Text = "Count:" + TypeRCount.ToString();
            gvMarketingReport1.DataBind();
            //dsTargetDet.Dispose();
        }

        else
        {
            lblCount.Text = "Count : 0";
            WebMsgBox.Show("There are no records to display");
        }

        return dsTargetDet;
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



    protected void btnCPClose_Click(object sender, EventArgs e)
    {
        rwCustomerProfile.Visible = false;
    }

    // CUSTOMER PROFILE PROCESS END

    protected void ddlmrReference_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblCount.Text = "Count : 0";
            gvMarketingReport1.DataSource = null;
            gvMarketingReport1.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlmrLeadSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblCount.Text = "Count : 0";
            gvMarketingReport1.DataSource = null;
            gvMarketingReport1.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlmr1Campaign_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblCount.Text = "Count : 0";
            gvMarketingReport1.DataSource = null;
            gvMarketingReport1.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlmrType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblCount.Text = "Count : 0";
            gvMarketingReport1.DataSource = null;
            gvMarketingReport1.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void ddlsmr4status_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblmr4count.Text = "Count : 0";
            gvMarketingReport4.DataSource = null;
            gvMarketingReport4.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnimgmr1exporttoexcel_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport1.Rows.Count > 0)
        {
            if (ViewState["R1"] != null)
            {
                DataTable dt = (DataTable)ViewState["R1"];
                rwmMR1Export.RadConfirm("No. of profiles selected : " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmMR1ExportFn", 300, 200, null, "R1-Customer List");        
            }            
        }
        else
        {
            rwmMR1Export.RadAlert("There are no profiles to export.", 300, 130, "R1-Customer List", ""); ;
        }        
    }

    protected void HiddenButtonMR1Export_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport1.Rows.Count > 0)
        {
            if(ViewState["R1"] != null)
            {
                DataTable dt = (DataTable)ViewState["R1"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN"))
                    {
                        dt.Columns.Remove("RSN");                       
                        dt.AcceptChanges();
                    }
                    //GridView gv = new GridView();
                    //gv.DataSource = dt;
                    //gv.DataBind();
                    //GridView[] gvList = new GridView[] { gv };
                    //Export("R1-CustomerList.xls", gvList);
                    DatatabletoExcel(dt, "R1-CustomerList");
                }
                else
                {
                    WebMsgBox.Show("There are no profiles to export."); 
                }                
            }          
           
        }
        else
        {
            WebMsgBox.Show("There are no profiles to export."); 
        }
    }

    protected void btnimgRefSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        //GridView[] gvList = new GridView[] { gvReferenceSummary, gvReferenceSummaryTotal };
        //Export("ReferenceSummary.xls", gvList);
    }
    protected void btnimgMR3Excel_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport3.Rows.Count > 0)
        {
            if (ViewState["R2"] != null)
            {
                DataTable dt = (DataTable)ViewState["R2"];
                rwmMR3Export.RadConfirm("No. of profiles selected:" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmMR3ExportFn", 300, 200, null, "R2-LeadsFollowup");
            }            
        }
        else
        {
            rwmMR3Export.RadAlert("There are no profiles to export", 300, 130, "Alert","");
        }        
    }
    protected void HiddenButtonMR3Export_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport3.Rows.Count > 0)
        {
            if (ViewState["R2"] != null)
            {
                DataTable dt = (DataTable)ViewState["R2"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("ProspectRSN"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("ProspectRSN");
                        dt.AcceptChanges();
                    }
                    //GridView gv = new GridView();
                    //gv.DataSource = dt;
                    //gv.DataBind();
                    //GridView[] gvList = new GridView[] { gv };
                    //Export("R2-LeadsFollowup.xls", gvList);
                    DatatabletoExcel(dt, "R2-LeadsFollowup");
                }
                else
                {
                    WebMsgBox.Show("There are no profiles to export.");
                }
            }          
            
            
        }
        else
        {
            WebMsgBox.Show("There are no profiles to export.");
        }
    }

    protected void btnimgMR4Excel_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport4.Rows.Count == 0)
        {
            rwmMR4Export.RadAlert("There are no profiles to export", 300, 130, "R3-No Followups","");
        }
        else
        {
            if (ViewState["R3"] != null)
            {
                DataTable dt = (DataTable)ViewState["R3"];
                rwmMR4Export.RadConfirm("No. of profiles selected:" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmMR4ExportFn", 300, 200, null, "R3-No Followups");      
            }            
        }        
    }
    protected void HiddenButtonMR4Export_Click(object sender, EventArgs e)
    {
        if (gvMarketingReport4.Rows.Count > 0)
        {
            if(ViewState["R3"] != null)
            {
                DataTable dt = (DataTable)ViewState["R3"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("ProspectRSN"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("ProspectRSN");
                        dt.AcceptChanges();
                    }
                    //GridView gv = new GridView();
                    //gv.DataSource = dt;
                    //gv.DataBind();
                    //GridView[] gvList = new GridView[] { gv };
                    //Export("R3-NoFollowups.xls", gvList);
                    DatatabletoExcel(dt, "R3-NoFollowups");
                }
                else
                {
                    WebMsgBox.Show("There are no profiles to export.");
                }
            }
            //GridView[] gvList = new GridView[] { gvMarketingReport4 };
            //Export("R3-NoFollowups.xls", gvList);
        }
        else
        {
            WebMsgBox.Show("There are no profiles to export.");
        }
    }

    protected void btnimgCRefSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        //GridView[] gvList = new GridView[] { gvReferenceSummary, gvReferenceSummaryTotal };
        //Export("CustomerReferenceSummary.xls", gvList);
    }
    protected void btnTest_Click(object sender, EventArgs e)
    {
        divMR1.Visible = true;
        //divLeadSummary.Visible = false;
        divMR3.Visible = false;
        divMR4.Visible = false;
        //divMR5.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    divMR1.Visible = false;
    //    //divLeadSummary.Visible = true;
    //    divMR3.Visible = false;
    //    divMR4.Visible = false;
    //    //divMR5.Visible = false;

    //    dvMarkettingAct.Visible = false;
    //    dvGeneralActivity.Visible = false;
    //    dvServiceActivity.Visible = false;
    //    //LoadLeadSourceSummary();
    //    //LoadLeadStatusSummary();
    //    //LoadLeadCategorySummary();
    //    //LoadCampaignSummary();
    //    //LoadReferenceSummary();
    //    divwfr2.Visible = false;

    //    divwfr3.Visible = false;
    //    divwfr4.Visible = false;

    //    divsmx1.Visible = false;
    //    divsmx2.Visible = false;

    //    divsmx5.Visible = false;


    //    dvROL.Visible = false;
    //    dvR12TimeSummary.Visible = false;
    //    dvR13TimeDetailed.Visible = false;
    //    dvR14sysnotused.Visible = false;
    //}
    protected void btnchart_Click(object sender, EventArgs e)
    {
        //divMR5.Visible = true;
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        //divLeadSummary.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;

        //CLoadLeadSourceSummary();
        //CLoadCampaignSummary();
        //CLoadReferenceSummary();

        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSales_Click(object sender, EventArgs e)
    {
        try
        {
            divMR1.Visible = false;
            //divLeadSummary.Visible = false;
            divMR3.Visible = true;
            divMR4.Visible = false;
            //divMR5.Visible = false;

            dvMarkettingAct.Visible = false;
            dvGeneralActivity.Visible = false;
            dvServiceActivity.Visible = false;
            divwfr2.Visible = false;

            divwfr3.Visible = false;
            divwfr4.Visible = false;


            divsmx1.Visible = false;
            divsmx2.Visible = false;

            divsmx5.Visible = false;


            dvROL.Visible = false;
            dvR12TimeSummary.Visible = false;
            dvR13TimeDetailed.Visible = false;
            dvR14sysnotused.Visible = false;
            //ddlsmr3Status.SelectedIndex = 3;


            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport3",
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "ALL" }
                );

            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport3.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                lblmr3count.Text = "Count:" + TypeRCount.ToString();
                ViewState["R2"] = dsTargetDet.Tables[0];
                gvMarketingReport3.DataBind();
                dsTargetDet.Dispose();
                // ddlsmr3Status.Items.Insert(0, "ALL");
            }

            else
            {
                divMR3.Visible = true;
                gvMarketingReport3.DataSource = null;
                gvMarketingReport3.DataBind();
                lblmr3count.Text = "0";
                ViewState["R2"] = dsTargetDet.Tables[0];
                //WebMsgBox.Show("There are no records to display");
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnNosales_Click(object sender, EventArgs e)
    {

    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        //Response.Redirect("ManageNTaskList.aspx");
        dvHeaderMenu.Visible = true;
        dvMainSMReports.Visible = false;
        //btnRtnHome.Visible = true;
    }

    // marketting Activities

    private void MALoadMRReference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("Proc_GetMarketingActReference");

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {
            ddlmarkactref.DataSource = dsTrackon.Tables[0];
            ddlmarkactref.DataValueField = "trackondesc";
            ddlmarkactref.DataTextField = "trackondesc";
            ddlmarkactref.DataBind();
        }

        ddlmarkactref.Items.Insert(0, "All");

        dsTrackon.Dispose();

    }

    protected void btnmarkettingact_Click(object sender, EventArgs e)
    {

    }
    protected void btnMarkActSub_Click(object sender, EventArgs e)
    {
        try
        {
            lblMarkActCount.Visible = true;
            if (ddlmarkactstatus.SelectedValue == "0")
            {
                // WebMsgBox.Show("Please Select Status");
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                gvMarkActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvMarkActDetails.DataSource = string.Empty;
                gvMarkActDetails.DataBind();
                lblMarkActCount.Text = "Count : " + 0;
                return;
            }
            if (Convert.ToDateTime(RadDatemarkactfrom.SelectedDate) > Convert.ToDateTime(RadDatemarkactto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvMarkActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvMarkActDetails.DataSource = string.Empty;
                gvMarkActDetails.DataBind();
                lblMarkActCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMarActDetails = new DataSet();
            dsMarActDetails = null;


            dsMarActDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlmarkactstatus.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlmarkactref.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDatemarkactfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDatemarkactto.SelectedDate.ToString() }
                );

            if (dsMarActDetails.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                //Session["ExcelTemp"] = dsMarActDetails.Tables[0];
                gvMarkActDetails.DataSource = dsMarActDetails.Tables[0];
                int TypeRCount = dsMarActDetails.Tables[0].Rows.Count;
                lblMarkActCount.Text = "Count : " + TypeRCount.ToString();
                gvMarkActDetails.DataBind();
                ViewState["R4M"]=dsMarActDetails.Tables[0];                    
            }
            else
            {
                gvMarkActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvMarkActDetails.DataSource = dsMarActDetails.Tables[0];
                gvMarkActDetails.DataBind();
                lblMarkActCount.Text = "Count : " + 0;
                ViewState["R4M"] = dsMarActDetails.Tables[0]; 
            }
            gvMarkActDetails.Visible = true;
            dsMarActDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Check your internet connections");
        }
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

                ExcelCell header = worksheet.Cell(1, 1);


                if (rptType.ToString() == "R4Q - Quotations submitted")
                {
                    header.Value = rptType.ToString() + " From " + dtpR4Quoatesubfrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpR4Quoatesubto.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R4 - Marketing activities")
                {
                    header.Value = rptType.ToString() + " From " + RadDatemarkactfrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + RadDatemarkactto.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R4E - Enquiries Registered")
                {
                    header.Value = rptType.ToString() + " From " + dtpR4engregfrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpR4engregto.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if(rptType.ToString() == "R4O - Orders Booked")
                {
                    header.Value = rptType.ToString() + " From " + dtpR4OrderBookfrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpR4engregto.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R5 - Service activities")
                {
                    header.Value = rptType.ToString() + " From " + RadDateSerActFrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + RadDateSerActTo.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R6 - General activities")
                {
                    header.Value = rptType.ToString() + " From " + RadDateGenActFrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + RadDateGenActTo.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R7-Work Progress")
                {
                    header.Value = rptType.ToString() + " From " + dtpwfr2StartDate.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpwfr2ToDate.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R12 -Time consumed per client - Summary")
                {
                    header.Value = rptType.ToString() + " From " + dtpr12from.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpR12till.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
                else if (rptType.ToString() == "R13 -Time consumed per client - Detailed")
                {
                    header.Value = rptType.ToString() + " From " + dtpR13from.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + dtpR13to.SelectedDate.Value.ToString("dd/MM/yyyy"); 
                }
               
                
                


                
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
    protected void btnMarActExcel_Click(object sender, EventArgs e)
    {
        if (gvMarkActDetails.Items.Count == 0)
        {
            rwmMarActExport.RadAlert("There are no records to export", 300, 130, "R4-Marketing Activities", "");
        }
        else
        {
            // Its select for current grid page records.
            //rwmMarActExport.RadConfirm("No. of records selected : " + gvMarkActDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmMarActExportFn", 300, 200, null, "R4-Marketing Activities");

            // Select All Records
            if (ViewState["R4M"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4M"];
                rwmMarActExport.RadConfirm("No. of records selected : " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmMarActExportFn", 300, 200, null, "R4-Marketing Activities");
            }
        }        
    }

    protected void HiddenButtonMarActExport_Click(object sender, EventArgs e)
    {
        if ((gvMarkActDetails.Visible == true))
        {
            if (ViewState["R4M"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4M"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 18, "R4 - Marketing activities");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "alert('There is no records to export');", true);
                }
            }            
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void gvMarkActDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {

                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string RSN = commandArgs[0];
            string taskid = commandArgs[1];

            rwDiary.Visible = true;
            Session["ProspectRSN"] = RSN.ToString();
            LoadProspectDiary(RSN.ToString());

            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMarActDetails = new DataSet();
            dsMarActDetails = null;


            dsMarActDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlmarkactstatus.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlmarkactref.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDatemarkactfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDatemarkactto.SelectedDate.ToString() }
                );

            if (dsMarActDetails.Tables[0].Rows.Count > 0)
            {
                gvMarkActDetails.DataSource = dsMarActDetails.Tables[0];
                int TypeRCount = dsMarActDetails.Tables[0].Rows.Count;
                lblMarkActCount.Text = "Count : " + TypeRCount.ToString();
                gvMarkActDetails.DataBind();                        
            }
            else
            {
                gvMarkActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvMarkActDetails.DataSource = dsMarActDetails.Tables[0];
                gvMarkActDetails.DataBind();
                lblMarkActCount.Text = "Count : " + 0;              
            }
            dsMarActDetails.Dispose();
        }

    }
    protected void ddlmarkactref_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button7_Click(object sender, EventArgs e)
    {

    }
    protected void btnServiceactivities_Click(object sender, EventArgs e)
    {

    }
    private void ServiceActivityReference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackonSer = new DataSet();
        dsTrackonSer = sqlobj.SQLExecuteDataset("Proc_GetServiceActReference");

        if (dsTrackonSer.Tables[0].Rows.Count != 0)
        {
            ddlSerActReference.DataSource = dsTrackonSer.Tables[0];
            ddlSerActReference.DataValueField = "trackondesc";
            ddlSerActReference.DataTextField = "trackondesc";
            ddlSerActReference.DataBind();

            ddlR5SReference.DataSource = dsTrackonSer.Tables[0];
            ddlR5SReference.DataValueField = "trackondesc";
            ddlR5SReference.DataTextField = "trackondesc";
            ddlR5SReference.DataBind();            
        }
        ddlSerActReference.Items.Insert(0, "All");
        ddlR5SReference.Items.Insert(0, "All");
        dsTrackonSer.Dispose();
    }

    protected void btnSerActSub_Click(object sender, EventArgs e)
    {
        try
        {
            lblSerActCount.Visible = true;
            if (ddlSerActStatus.SelectedValue == "0")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                return;
            }

            if (Convert.ToDateTime(RadDateSerActFrom.SelectedDate) > Convert.ToDateTime(RadDateSerActTo.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvSerActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvSerActDetails.DataSource = string.Empty;
                gvSerActDetails.DataBind();
                lblSerActCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsSerActDetails = new DataSet();
            dsSerActDetails = null;


            dsSerActDetails = sqlobj.SQLExecuteDataset("proc_GetServiceActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlSerActStatus.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlSerActReference.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDateSerActFrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDateSerActTo.SelectedDate.ToString() }
                );

            if (dsSerActDetails.Tables[0].Rows.Count > 0)
            {
                gvSerActDetails.DataSource = dsSerActDetails.Tables[0];
                int TypeRCount = dsSerActDetails.Tables[0].Rows.Count;
                lblSerActCount.Text = "Count : " + TypeRCount.ToString();
                gvSerActDetails.DataBind();
                ViewState["R5S"]=dsSerActDetails.Tables[0];
            }
            else
            {
                gvSerActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvSerActDetails.DataSource = dsSerActDetails.Tables[0];
                gvSerActDetails.DataBind();
                lblSerActCount.Text = "Count : " + 0;
                ViewState["R5S"] = dsSerActDetails.Tables[0];
            }
            gvSerActDetails.Visible = true;
            dsSerActDetails.Dispose();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSerActExport_Click(object sender, EventArgs e)
    {
        if (gvSerActDetails.Items.Count == 0)
        {
            rwR5serAct.RadAlert("There are no records to export", 300, 130, "R5-Service Activities", "");
        }
        else
        {
            //rwR5serAct.RadConfirm("No. of records selected " + gvSerActDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmServiceSubExportFn", 300, 200, null, "R5-Service Activities.");
            if (ViewState["R5S"] != null)
            {
                DataTable dt = (DataTable)ViewState["R5S"];
                rwR5serAct.RadConfirm("No. of records selected :" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmServiceSubExportFn", 300, 200, null, "R5-Service Activities.");
            }
        }        
    }
    protected void gvSerActDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);
                Int64 istaffid = Convert.ToInt64(index);
                Session["ProspectRSN"] = istaffid.ToString();
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }

                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                    new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }
            else if (e.CommandName.Equals("Tasks"))
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string RSN = commandArgs[0];
                string taskid = commandArgs[1];

                rwDiary.Visible = true;
                Session["ProspectRSN"] = RSN.ToString();
                LoadProspectDiary(RSN.ToString());

                if (gvDiary.Rows.Count > 0)
                {
                    rwDiary.Visible = true;
                }
            }
            else
            {
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsSerActDetails = new DataSet();
                dsSerActDetails = null;


                dsSerActDetails = sqlobj.SQLExecuteDataset("proc_GetServiceActivities",
                    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlSerActStatus.SelectedValue.ToString()) },
                    new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlSerActReference.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDateSerActFrom.SelectedDate.ToString() },
                    new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDateSerActTo.SelectedDate.ToString() }
                    );

                if (dsSerActDetails.Tables[0].Rows.Count > 0)
                {
                    gvSerActDetails.DataSource = dsSerActDetails.Tables[0];
                    int TypeRCount = dsSerActDetails.Tables[0].Rows.Count;
                    lblSerActCount.Text = "Count : " + TypeRCount.ToString();
                    gvSerActDetails.DataBind();
                    //ddlsmr4status.Items.Insert(0, "ALL");                    
                }
                else
                {
                    gvSerActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                    gvSerActDetails.DataSource = dsSerActDetails.Tables[0];
                    gvSerActDetails.DataBind();
                    lblSerActCount.Text = "Count : " + 0;
                    // WebMsgBox.Show("There are no records to display");
                }
                dsSerActDetails.Dispose();
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void GeneralActivityReference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackonGen = new DataSet();
        dsTrackonGen = sqlobj.SQLExecuteDataset("Proc_GetGeneralActReference");

        if (dsTrackonGen.Tables[0].Rows.Count != 0)
        {
            ddlGenActReference.DataSource = dsTrackonGen.Tables[0];
            ddlGenActReference.DataValueField = "trackondesc";
            ddlGenActReference.DataTextField = "trackondesc";
            ddlGenActReference.DataBind();
        }
        ddlGenActReference.Items.Insert(0, "All");
        dsTrackonGen.Dispose();
    }
    protected void btnGenActSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsGenActDetails = new DataSet();
            dsGenActDetails = null;

            lblGenActCount.Visible = true;
            if (ddlGenActStatus.SelectedValue == "0")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                gvGenActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvGenActDetails.DataSource = string.Empty;
                gvGenActDetails.DataBind();
                lblGenActCount.Text = "Count : " + 0;
                return;
            }
            if (Convert.ToDateTime(RadDateGenActFrom.SelectedDate) > Convert.ToDateTime(RadDateGenActTo.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvGenActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvGenActDetails.DataSource = string.Empty;
                gvGenActDetails.DataBind();
                lblGenActCount.Text = "Count : " + 0;
                return;
            }

            dsGenActDetails = sqlobj.SQLExecuteDataset("proc_GetGeneralActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlGenActStatus.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlGenActReference.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDateGenActFrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDateGenActTo.SelectedDate.ToString() }
                );

            if (dsGenActDetails.Tables[0].Rows.Count > 0)
            {
                gvGenActDetails.DataSource = dsGenActDetails.Tables[0];
                int TypeRCount = dsGenActDetails.Tables[0].Rows.Count;
                lblGenActCount.Text = "Count : " + TypeRCount.ToString();
                gvGenActDetails.DataBind();
                ViewState["R6G"]=dsGenActDetails.Tables[0];                   
            }
            else
            {
                gvGenActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvGenActDetails.DataSource = dsGenActDetails.Tables[0];
                gvGenActDetails.DataBind();
                lblGenActCount.Text = "Count : " + 0;
                ViewState["R6G"] = dsGenActDetails.Tables[0];  
            }
            gvGenActDetails.Visible = true;
            dsGenActDetails.Dispose();
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnGenActExcel_Click(object sender, EventArgs e)
    {
        if (gvGenActDetails.Items.Count == 0)
        {
            rwR6genact.RadAlert("There are no records to export", 300, 130, "R6-General Activities", "");
        }
        else
        {
            //rwR6genact.RadConfirm("No. of records selected : " + gvGenActDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmGeneralSubExportFn", 300, 200, null, "R6-General Activities.");
            if (ViewState["R6G"] != null)
            {
                DataTable dt = (DataTable)ViewState["R6G"];
                rwR6genact.RadConfirm("No. of records selected : " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmGeneralSubExportFn", 300, 200, null, "R6-General Activities.");
            }
        }        
    }
    protected void gvGenActDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string RSN = commandArgs[0];
            string taskid = commandArgs[1];

            rwDiary.Visible = true;
            Session["ProspectRSN"] = RSN.ToString();
            LoadProspectDiary(RSN.ToString());

            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsGenActDetails = new DataSet();
            dsGenActDetails = null;


            dsGenActDetails = sqlobj.SQLExecuteDataset("proc_GetGeneralActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlGenActStatus.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlGenActReference.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = RadDateGenActFrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = RadDateGenActTo.SelectedDate.ToString() }
                );

            if (dsGenActDetails.Tables[0].Rows.Count > 0)
            {
                gvGenActDetails.DataSource = dsGenActDetails.Tables[0];
                int TypeRCount = dsGenActDetails.Tables[0].Rows.Count;
                lblGenActCount.Text = "Count : " + TypeRCount.ToString();
                gvGenActDetails.DataBind();                               
            }
            else
            {
                gvGenActDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvGenActDetails.DataSource = dsGenActDetails.Tables[0];
                gvGenActDetails.DataBind();
                lblGenActCount.Text = "Count : " + 0;                
            }
            dsGenActDetails.Dispose();
        }
    }
    protected void RadDateGenActTo_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void RadDateGenActFrom_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void RadDateSerActFrom_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void RadDateSerActTo_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void RadDatemarkactfrom_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void RadDatemarkactto_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {

    }
    protected void btnSMReports_Click(object sender, EventArgs e)
    {
        dvMainSMReports.Visible = true;
    }
    protected void btnWMReports_Click(object sender, EventArgs e)
    {
        Response.Redirect("WMReports.aspx");
    }
    protected void btnSMXReports_Click(object sender, EventArgs e)
    {
        Response.Redirect("SMXReports.aspx");
    }
    protected void btnWMXReports_Click(object sender, EventArgs e)
    {
        Response.Redirect("WMXReports.aspx");
    }
    protected void btnHomeReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageNTaskList.aspx");
    }
    //WM reports
    protected void btnWMWorkSts_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;

        divwfr2.Visible = false;
        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

    }


    private void Loadwfr2Reference()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReference = new DataSet();

        dsReference = sqlobj.SQLExecuteDataset("sp_getReference");

        if (dsReference.Tables[0].Rows.Count != 0)
        {
            ddlwfr2Reference.DataSource = dsReference;
            ddlwfr2Reference.DataValueField = "TrackonDesc";
            ddlwfr2Reference.DataTextField = "TrackonDesc";
            ddlwfr2Reference.DataBind();

            ddlwfr4Reference.DataSource = dsReference;
            ddlwfr4Reference.DataValueField = "TrackonDesc";
            ddlwfr4Reference.DataTextField = "TrackonDesc";
            ddlwfr4Reference.DataBind();

            ddlwfr2Reference.Items.Insert(0, "All");
            ddlwfr4Reference.Items.Insert(0, "All");

        }
        else
        {
            ddlwfr2Customer.DataSource = null;
            ddlwfr2Customer.DataBind();

            ddlwfr4Customer.DataSource = null;
            ddlwfr4Customer.DataBind();

            ddlwfr2Customer.Items.Insert(0, "All");
            ddlwfr4Customer.Items.Insert(0, "All");
        }

        dsReference.Dispose();
    }

    private void Loadwfr2By()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsUserName = new DataSet();

        //dsUserName = sqlobj.SQLExecuteDataset("sp_getUserName");


        dsUserName = sqlobj.SQLExecuteDataset("proc_GetStaff", new SqlParameter() { ParameterName = "@staffname", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });


        if (dsUserName.Tables[0].Rows.Count != 0)
        {

            ddlwfr2By.DataSource = dsUserName;
            ddlwfr2By.DataValueField = "UserName";
            ddlwfr2By.DataTextField = "UserName";
            ddlwfr2By.DataBind();

            ddlwfr4By.DataSource = dsUserName;
            ddlwfr4By.DataValueField = "UserName";
            ddlwfr4By.DataTextField = "UserName";
            ddlwfr4By.DataBind();

            strUserLevel = Session["UserLevel"].ToString();

            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {

                ddlwfr2By.Items.Insert(0, "All");
                ddlwfr4By.Items.Insert(0, "All");
            }
        }
        else
        {
            ddlwfr2By.DataSource = null;
            ddlwfr2By.DataBind();

            ddlwfr4By.DataSource = null;
            ddlwfr4By.DataBind();

            ddlwfr2By.Items.Insert(0, "All");

            ddlwfr4By.Items.Insert(0, "All");
        }

        dsUserName.Dispose();
    }
    
    protected void ddlwfr2Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        Loadwfr2FilterCustomer();
    }
    protected void Loadwfr2FilterCustomer()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustomers = new DataSet();

        dsCustomers = sqlobj.SQLExecuteDataset("sp_getfcustomer", new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Type.SelectedValue });

        ddlwfr2Customer.Items.Clear();

        if (dsCustomers.Tables[0].Rows.Count != 0)
        {
            ddlwfr2Customer.DataSource = dsCustomers;
            ddlwfr2Customer.DataValueField = "Name";
            ddlwfr2Customer.DataTextField = "Name";
            ddlwfr2Customer.DataBind();

            ddlwfr2Customer.Items.Insert(0, "All");

        }
        else
        {
            ddlwfr2Customer.DataSource = null;
            ddlwfr2Customer.DataBind();

            ddlwfr2Customer.Items.Insert(0, "All");
        }

        dsCustomers.Dispose();

    }
    protected void btnwfr2Search_Click(object sender, EventArgs e)
    {
        if (Convert.ToDateTime(dtpwfr2StartDate.SelectedDate) > Convert.ToDateTime(dtpwfr2ToDate.SelectedDate))
        {
            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the Start and End date');", true);
            rwR7workprog.RadAlert("Please check the Start and End date", 300, 130, "R7-Work Progress", "");
            return;
        }
        LoadWFR2();
    }
    private void LoadWFR2()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReferenceSummary = new DataSet();
        DataSet dsReferenceSummaryTotal = new DataSet();
        lblR7workprogcount.Visible = true;
        string From = null;
        string To = null;
        if (ddlwfr2Report.SelectedValue.ToString() == "Completed" || ddlwfr2Report.SelectedValue.ToString() == "InProgress")
        {
            if (Chkwfr2date.Checked)
            {
                From = dtpwfr2StartDate.SelectedDate.Value.ToString("yyyy-MM-dd");
                To = dtpwfr2ToDate.SelectedDate.Value.ToString("yyyy-MM-dd");
            }
        }
      
        dsReferenceSummary = sqlobj.SQLExecuteDataset("sp_getWorkFlowReport2",
            new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = From },
            new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = To },
            new SqlParameter() { ParameterName = "@CustomerName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Customer.SelectedValue == "All" ? null : ddlwfr2Customer.SelectedValue },
            new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Reference.SelectedValue == "All" ? null : ddlwfr2Reference.SelectedValue },
            new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2By.SelectedValue == "All" ? null : ddlwfr2By.SelectedValue },
            new SqlParameter() { ParameterName = "@ReportName", SqlDbType = SqlDbType.VarChar, Value = ddlwfr2Report.SelectedValue.ToString() },
            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr2Type.SelectedValue == "All" ? null : ddlwfr2Type.SelectedValue }
            );

        if (dsReferenceSummary.Tables[0].Rows.Count != 0)
        {
            gvWFR2.DataSource = dsReferenceSummary;
            lblR7workprogcount.Text = "Count : " + dsReferenceSummary.Tables[0].Rows.Count;
            gvWFR2.DataBind();
            Session["R7"] = dsReferenceSummary.Tables[0];
        }
        else
        {
            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to display');", true);
            rwR7workprog.RadAlert("There are no records to display", 300, 130, "R7-Work Progress", "");
            gvWFR2.DataSource = null;
            gvWFR2.DataBind();
            Session["R7"] = dsReferenceSummary.Tables[0];
            lblR7workprogcount.Text = "Count : 0";
        }
        dsReferenceSummary.Dispose();
    }
    protected void btnwfr2Clear_Click(object sender, EventArgs e)
    {
        ddlwfr2Type.SelectedIndex = 0;
        ddlwfr2Customer.SelectedIndex = 0;
        ddlwfr2Reference.SelectedIndex = 0;
        ddlwfr2By.SelectedIndex = 0;
        ddlwfr2Report.SelectedIndex = 0;

        dtpwfr2StartDate.SelectedDate = DateTime.Now.AddDays(-1);
        dtpwfr2ToDate.SelectedDate = DateTime.Now.Date;

        gvWFR2.DataSource = null;
        gvWFR2.DataBind();
        lblR7workprogcount.Visible = false;
    }
    protected void btnimgwfr2exporttoexcel_Click(object sender, EventArgs e)
    {
        if (gvWFR2.Rows.Count == 0)
        {
            rwR7workprog.RadAlert("There are no records to export", 300, 130, "R7-Work Progress", "");
        }
        else
        {
            //rwR7workprog.RadConfirm("No. of records selected : " + gvWFR2.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmWorkProgSubExportFn", 300, 200, null, "R7-Work Progress");
            if (Session["R7"] != null)
            {
                DataTable dt = (DataTable)Session["R7"];
                rwR7workprog.RadConfirm("No. of records selected : " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmWorkProgSubExportFn", 300, 200, null, "R7-Work Progress");
            }
        }
    }
    protected void gvWFR2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                //LoadCCustStatus();
                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);
                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
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
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }

                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                    new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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
            }

            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex][0].ToString();
                Int64 istaffid = Convert.ToInt64(strProspectRSN);
                Session["ProspectRSN"] = istaffid.ToString();
                string strtaskid = mygrid.DataKeys[myrow.RowIndex][1].ToString();
                LoadProspectDiary(strProspectRSN, strtaskid.ToString());
                rwDiary.Visible = true;
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
            lbldiaryheadStatus.Text = " Status:" + dsProspectDiary.Tables[0].Rows[0]["Status"].ToString();    
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
    protected void gvWFR2_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";
        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";
        }
        DataView sortedView = new DataView(BindGridViewWFR2());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvWFR2.DataSource = sortedView;
        gvWFR2.DataBind();
        gvWFR2.Visible = true;
    }
    protected void gvWFR3_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                //LoadCCustStatus();
                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();
                Int64 istaffid = Convert.ToInt64(strProspectRSN);
                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

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
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }

                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                    new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }

            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex][0].ToString();


                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();
                string strtaskid = mygrid.DataKeys[myrow.RowIndex][1].ToString();

                LoadProspectDiary(strProspectRSN, strtaskid.ToString());

                rwDiary.Visible = true;

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvWFR3_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataView sortedView = new DataView(BindGridViewWFR3());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvWFR3.DataSource = sortedView;
        gvWFR3.DataBind();
    }
    private DataTable BindGridViewWFR3()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsSearchComment = new DataSet();

        dsSearchComment = sqlobj.SQLExecuteDataset("SP_SearchComments",
            new SqlParameter()
            {
                ParameterName = "@Keyword",
                SqlDbType = SqlDbType.NVarChar,
                Value = TxtSearchValue.Text
            });




        if (dsSearchComment.Tables[0].Rows.Count != 0)
        {
            gvWFR3.DataSource = dsSearchComment;
            gvWFR3.DataBind();

        }
        else
        {
            WebMsgBox.Show("No Matches found!!.");
            gvWFR3.DataSource = null;
            gvWFR3.DataBind();
        }
        return dsSearchComment.Tables[0];
    }
    protected void btnwfr3Search_Click(object sender, EventArgs e)
    {
        TxtSearchValue.Visible = true;
        Search.Visible = true;
        if (TxtSearchValue.Text != "")
        {
            if (TxtSearchValue.Text.Length >= 4)
            {              
                int TotalRecord = 0;
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsSearchComment = new DataSet();

                dsSearchComment = sqlobj.SQLExecuteDataset("SP_SearchComments",
                    new SqlParameter()
                    {
                        ParameterName = "@Keyword",
                        SqlDbType = SqlDbType.NVarChar,
                        Value = TxtSearchValue.Text
                    });
                TotalRecord = dsSearchComment.Tables[0].Rows.Count; //This is total number of records in gridview
                lblR8QuicksrchCount.Visible = true;
                lblR8QuicksrchCount.Text = "Count : " + TotalRecord;
                if (TotalRecord >= 1)
                {
                    SearchWindowManager1.RadConfirm("No. of records selected " + TotalRecord + " <br/>Do you wish to export these as a spreadsheet file?", "confirmCallbackFn", 300, 200, null, "R8-Quick Search");
                }
                else
                {
                   //WebMsgBox.Show("No Matches Found!!");
                    SearchWindowManager1.RadAlert("There are no records to export", 300, 130, "R8-Quick Search", "");
                }
            }
            else
            {
                WebMsgBox.Show("Minimum 4 characters are required.");
            }
        }
        else
        {
            WebMsgBox.Show("Please enter some value to search");
        }
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        LoadWFR3();
    }
    private void LoadWFR3()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsSearchComment = new DataSet();
        dsSearchComment = sqlobj.SQLExecuteDataset("SP_SearchComments", new SqlParameter() { ParameterName = "@Keyword", SqlDbType = SqlDbType.NVarChar, Value = TxtSearchValue.Text });


        if (dsSearchComment.Tables[0].Rows.Count != 0)
        {
            gvWFR3.DataSource = dsSearchComment;
            gvWFR3.DataBind();
        }
        else
        {
            gvWFR3.DataSource = null;
            gvWFR3.DataBind();
        }

        dsSearchComment.Dispose();
    }
    protected void btnwfr4Search_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDateTime(dtpwfr4from.SelectedDate) > Convert.ToDateTime(dtpwfr4to.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and To date');", true);
                return;
            }
            LoadWFR4();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadWFR4()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReferenceSummary = new DataSet();
        DataSet dsReferenceSummaryTotal = new DataSet();


        dsReferenceSummary = sqlobj.SQLExecuteDataset("SP_getWorkFlowReport4",
            new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = Chkwfr4date.Checked == true ? dtpwfr4from.SelectedDate.Value.ToString("yyyy-MM-dd") : null },
            new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = Chkwfr4date.Checked == true ? dtpwfr4to.SelectedDate.Value.ToString("yyyy-MM-dd") : null },
            new SqlParameter() { ParameterName = "@CustomerName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Customer.SelectedValue == "All" ? null : ddlwfr4Customer.SelectedValue },
            new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Reference.SelectedValue == "All" ? null : ddlwfr4Reference.SelectedValue },
            new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4By.SelectedValue == "All" ? null : ddlwfr4By.SelectedValue },
            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Type.SelectedValue == "All" ? null : ddlwfr4Type.SelectedValue }
            );
        lblR9hrspentcount.Visible = true;
        lblR9hrspentcount.Text = "Count : " + dsReferenceSummary.Tables[0].Rows.Count;
        if (dsReferenceSummary.Tables[0].Rows.Count != 0)
        {
            gvwfr4.DataSource = dsReferenceSummary;
            ViewState["R9"] = dsReferenceSummary.Tables[0];
            gvwfr4.DataBind();

        }
        else
        {
            gvwfr4.DataSource = null;
            gvwfr4.DataBind();
            //WebMsgBox.Show("No Records selected.");
        }

        dsReferenceSummary.Dispose();
    }
    protected void btnwfr4Clear_Click(object sender, EventArgs e)
    {
        try
        {
            ddlwfr4Type.SelectedIndex = 0;
            ddlwfr4Customer.SelectedIndex = 0;
            ddlwfr4Reference.SelectedIndex = 0;
            ddlwfr4By.SelectedIndex = 0;


            dtpwfr4from.SelectedDate = DateTime.Now.AddDays(-1);
            dtpwfr4to.SelectedDate = DateTime.Now.Date;

            gvwfr4.DataSource = null;
            gvwfr4.DataBind();
            lblR9hrspentcount.Visible = false;
            //ddlwfr4Customer.Items.Clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnimgwfr4exporttoexcel_Click(object sender, EventArgs e)
    {
        if (gvwfr4.Rows.Count == 0)
        {
            rwR9hrsSpent.RadAlert("There are no records to export.", 300, 130, "R9-Hours Spent", "");
        }
        else
        {
            DataTable dt = (DataTable)ViewState["R9"];
            rwR9hrsSpent.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmHrsSpentSubExportFn", 300, 200, null, "R9-Hours Spent");           
        }
        
    }
    protected void gvwfr4_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                //LoadCCustStatus();

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();
                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }

                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                    new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

            }

            else if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex][0].ToString();

                Int64 istaffid = Convert.ToInt64(strProspectRSN);

                Session["ProspectRSN"] = istaffid.ToString();

                string strtaskid = mygrid.DataKeys[myrow.RowIndex][1].ToString();

                LoadProspectDiary(istaffid.ToString(), strtaskid.ToString());

                rwDiary.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvwfr4_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataView sortedView = new DataView(HourGridView());
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvwfr4.DataSource = sortedView;
        gvwfr4.DataBind();
        gvwfr4.Visible = true;
    }
    private DataTable HourGridView()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReferenceSummary = new DataSet();
        DataSet dsReferenceSummaryTotal = new DataSet();


        dsReferenceSummary = sqlobj.SQLExecuteDataset("SP_getWorkFlowReport4",
            new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = Chkwfr4date.Checked == true ? dtpwfr4from.SelectedDate.Value.ToString("yyyy-MM-dd") : null },
            new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = Chkwfr4date.Checked == true ? dtpwfr4to.SelectedDate.Value.ToString("yyyy-MM-dd") : null },
            new SqlParameter() { ParameterName = "@CustomerName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Customer.SelectedValue == "All" ? null : ddlwfr4Customer.SelectedValue },
            new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Reference.SelectedValue == "All" ? null : ddlwfr4Reference.SelectedValue },
            new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4By.SelectedValue == "All" ? null : ddlwfr4By.SelectedValue },
            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Type.SelectedValue == "All" ? null : ddlwfr4Type.SelectedValue }
            );


        if (dsReferenceSummary != null)
        {
            //dtTemp.Dispose();
            gvwfr4.DataSource = dsReferenceSummary.Tables[0];
            int TypeRCount = dsReferenceSummary.Tables[0].Rows.Count;
            gvwfr4.DataBind();

        }
        return dsReferenceSummary.Tables[0];
    }
    protected void ddlwfr4Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        Loadwfr4FilterCustomer();
    }
    protected void Loadwfr4FilterCustomer()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustomers = new DataSet();

        dsCustomers = sqlobj.SQLExecuteDataset("sp_getfcustomer", new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlwfr4Type.SelectedValue });

        ddlwfr4Customer.Items.Clear();

        if (dsCustomers.Tables[0].Rows.Count != 0)
        {
            ddlwfr4Customer.DataSource = dsCustomers;
            ddlwfr4Customer.DataValueField = "Name";
            ddlwfr4Customer.DataTextField = "Name";
            ddlwfr4Customer.DataBind();

            ddlwfr4Customer.Items.Insert(0, "All");

        }
        else
        {
            ddlwfr4Customer.DataSource = null;
            ddlwfr4Customer.DataBind();

            ddlwfr4Customer.Items.Insert(0, "All");
        }

        dsCustomers.Dispose();
    }
    //WMX Reports//
    protected void btnWMX1_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnWMX2_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnHiddenwmx1Export_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            string rptType = "UserDetails";
            int strRpt = 11;
            dsDisp = sqlp.SQLExecuteDataset("SP_WMX_Report1",
                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 });

            if (dsDisp != null && dsDisp.Tables.Count > 0 && dsDisp.Tables[0].Rows.Count > 0)
            {
                WMXExcelExport(dsDisp.Tables[0], strRpt, rptType);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }

    protected void btnwmx2export_Click(object sender, EventArgs e)
    {

    }
    protected void btnwmx1export_Click(object sender, EventArgs e)
    {

    }
    protected void rmWMXReports_ItemClick(object sender, RadMenuEventArgs e)
    {

    }
    protected void WMXExcelExport(DataTable dt, int strRpt, string rptType)
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


    protected void imgbtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            int TotalRecCount = 0;

            dsDisp = sqlp.SQLExecuteDataset("SP_WMX_Report1", new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 });


            TotalRecCount = dsDisp.Tables[0].Rows.Count;
            if (TotalRecCount >= 1)
            {
                //SearchWindowManager7.RadConfirm("No. of records selected " + TotalRecCount + " <br/>Press OK if you wish to export the records in Excel else press CANCEL.", "confirmCallbackFn11", 300, 200, null, "WMX1 Excel Export Result");

            }
            else
            {
                WebMsgBox.Show("No Matches Found!!");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }

    //SMX Reports

    protected void LoadDDL3()
    {
        ListItem[] items = new ListItem[5];
        items[0] = new ListItem("Please Select", "Please Select");
        items[1] = new ListItem("Prospect", "Prospect");
        items[2] = new ListItem("Customer", "Customer");
        items[3] = new ListItem("Vendor", "Vendor");
        items[4] = new ListItem("Other", "Other");

        ddlSMXReport1.Items.AddRange(items);
        ddlSMXReport1.DataBind();

    }

    protected void btnsmx1export_Click(object sender, EventArgs e)
    {

    }
    public void dtgridtoexcelreport(DataTable ds)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "R7-Work Progress.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView gvDetails = new GridView();
        gvDetails.AllowPaging = false;
        gvDetails.DataSource = ds;
        gvDetails.DataBind();
        //Change the Header Row back to white color
        gvDetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
        {
            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvDetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    public void gridtoexcelreport(DataSet ds,string ReportName)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", ReportName +".xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView gvDetails = new GridView();
        gvDetails.AllowPaging = false;
        gvDetails.DataSource = ds;
        gvDetails.DataBind();
        //Change the Header Row back to white color
        gvDetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
        {
            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvDetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public void DatatabletoExcel(DataTable ds, string ReportName)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", ReportName + ".xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView gvDetails = new GridView();
        gvDetails.AllowPaging = false;       
        gvDetails.DataSource = ds;
        gvDetails.DataBind();    

        //Change the Header Row back to white color
        gvDetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
        {
            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvDetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public void gridtoexcelreport(DataTable ds, string ReportName)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", ReportName + ".xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView gvDetails = new GridView();
        gvDetails.AllowPaging = false;
        gvDetails.ShowFooter = true;
        gvDetails.DataSource = ds;
        gvDetails.DataBind();       
        gvDetails.FooterRow.Cells[0].Text = "Total";
        gvDetails.FooterRow.Cells[1].Text = ds.Compute("sum(YetToStart)","").ToString();
        gvDetails.FooterRow.Cells[2].Text = ds.Compute("sum(InProgress)", "").ToString();
        gvDetails.FooterRow.Cells[3].Text = ds.Compute("sum(Completed)", "").ToString();
        gvDetails.FooterRow.Cells[4].Text = ds.Compute("sum(TotalCompleted)", "").ToString();
      
        //Change the Header Row back to white color
        gvDetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
        {
            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvDetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    protected void btnHiddensmxExport_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            int strRpt = 1;
            string rptType = ddlSMXReport1.SelectedValue.ToString();

            dsDisp = sqlp.SQLExecuteDataset("SP_SMX_Report",
                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                            new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ddlSMXReport1.SelectedValue.ToString() });

            if (dsDisp != null && dsDisp.Tables.Count > 0 && dsDisp.Tables[0].Rows.Count > 0)
            {
                //SMXExcelExport(dsDisp.Tables[0], strRpt, rptType);               
                DataSet ds = dsDisp.Clone();
                ds.Tables[0].Rows.Add("Report Name","X1-Customer Dump","Date :",DateTime.Today);
                ds.Merge(dsDisp);
                gridtoexcelreport(ds, "X1-Customer Dump");
                //ds.Tables.Remove(dsDisp);
                ds.Dispose();
                dsDisp.Dispose();                
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    //SMX1 Ends
    //SMX2 Begins



    protected void btnsmx2export_Click(object sender, EventArgs e)
    {

    }


    protected void btn2Hiddensmx2Export_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            string rptType = "Reference";
            int strRpt = 2;
            dsDisp = sqlp.SQLExecuteDataset("SP_SMX_RefReport",
                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                            new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 2 });

            if (dsDisp != null && dsDisp.Tables.Count > 0 && dsDisp.Tables[0].Rows.Count > 0)
            {
                SMXExcelExport(dsDisp.Tables[0], strRpt, rptType);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    //SMX2 Ends
    //SMX3 Begins


    protected void btn1smx3export_Click(object sender, EventArgs e)
    {


    }



    //SMX3 Ends
    //SMX4 Begins





    protected void btnsmx4export_Click(object sender, EventArgs e)
    {


    }


    //SMX5 Begins


    protected void btnsmx5export_Click(object sender, EventArgs e)
    {


    }


    protected void btnHiddensmx5Export_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            int strRpt = 5;
            string rptType = ddlArea.SelectedValue.ToString();

            dsDisp = sqlp.SQLExecuteDataset("SP_SMX_Report",
                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 3 },
                            new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ddlArea.SelectedValue.ToString() });

            if (dsDisp != null && dsDisp.Tables.Count > 0 && dsDisp.Tables[0].Rows.Count > 0)
            {
                SMXExcelExport(dsDisp.Tables[0], strRpt, rptType);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }

    protected void SMXExcelExport(DataTable dt, int strRpt, string rptType)
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
                    //System.Threading.Thread.Sleep(1000);
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


    //SMX ENDS HERE


    protected void btnimgexporttoexcel1_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (ddlSMXReport1.SelectedValue != "Please Select")
            {

                SQLProcs sqlp = new SQLProcs();
                DataSet dsDisp = new DataSet();

                int TotalRecCount = 0;

                dsDisp = sqlp.SQLExecuteDataset("SP_SMX_Report",
                                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                                new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ddlSMXReport1.SelectedValue.ToString() });
                TotalRecCount = dsDisp.Tables[0].Rows.Count;
                if (TotalRecCount >= 1)
                {
                    SearchWindowManager2.RadConfirm("No. of records selected " + TotalRecCount + " <br/>Press OK if you wish to export the records in Excel else press CANCEL.", "confirmCallbackFn1", 300, 200, null, "X1-Customer dump");

                }
                else
                {
                    WebMsgBox.Show("No Matches Found!!");
                }
            }
            else
            {
                WebMsgBox.Show("Please select customer type");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnimgexporttoexcel2_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlp = new SQLProcs();
            DataSet dsDisp = new DataSet();

            int TotalRecCount = 0;

            dsDisp = sqlp.SQLExecuteDataset("SP_SMX_RefReport",
                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                            new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Value = 2 });
            TotalRecCount = dsDisp.Tables[0].Rows.Count;
            if (TotalRecCount >= 1)
            {
                SearchWindowManager3.RadConfirm("No. of records selected :" + TotalRecCount + " <br/>Do you wish to export these as a spreadsheet file?", "confirmCallbackFn2", 300, 200, null, "X2-Reference list dump");
            }
            else
            {
                //WebMsgBox.Show("No Matches Found!!");
                SearchWindowManager3.RadAlert("There are no records to export", 300, 130, "X2-Reference list dump", "");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnimgexporttoexcel3_Click(object sender, ImageClickEventArgs e)
    {
        //if (ddlSMXReport3.SelectedValue != "Please Select")
        //{
        //    LoadSMX3();
        //}
        //else
        //{
        //    WebMsgBox.Show("Please select customer type");
        //}

    }

    protected void btnimgexporttoexcel5_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlArea.SelectedValue.ToString() != "")
            {
                SQLProcs sqlp = new SQLProcs();
                DataSet dsDisp = new DataSet();

                int TotalRecCount = 0;

                dsDisp = sqlp.SQLExecuteDataset("SP_SMX_Report",
                                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 3 },
                                new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ddlArea.SelectedValue.ToString() });
                TotalRecCount = dsDisp.Tables[0].Rows.Count;
                if (TotalRecCount >= 1)
                {
                    SearchWindowManager8.RadConfirm("No. of records selected :" + TotalRecCount + " <br/>Do you wish to export these as a spreadsheet file?", "confirmCallbackFn6", 300, 200, null, "R10-Customer List by Location");
                }
                else
                {
                    //WebMsgBox.Show("No Matches Found!!");
                    SearchWindowManager8.RadAlert("There are no records to export.", 300, 130, "R10-Customer List by Location", "");
                }

            }
            else
            {
                SearchWindowManager8.RadAlert("There are no records to export.", 300, 130, "R10-Customer List by Location", "");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnSMX1_Click(object sender, EventArgs e)
    {

    }
    protected void btnSMX2_Click(object sender, EventArgs e)
    {

    }
    protected void btnSMX3_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;


        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSMX4_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSMX5_Click(object sender, EventArgs e)
    {

    }
    protected void btnSMX6_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSMX7_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSMX8_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnSMX9_Click(object sender, EventArgs e)
    {
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
    }
    protected void btnR1CusList_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R1- Customer List", DateTime.Now);

        divMR1.Visible = true;
        //divLeadSummary.Visible = false;
        divMR3.Visible = false;
        divMR4.Visible = false;
        //divMR5.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
       // btnRtnHome.Visible = false;
        lblCount.Visible = false;
        gvMarketingReport1.DataSource = null;
        gvMarketingReport1.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnHelpscrn_Click(object sender, EventArgs e)
    {
        //rwStatusHelp.VisibleOnPageLoad = true;
        rwStatusHelp.VisibleOnPageLoad = true;
        //rwStatusHelp.Width = 300;
        //rwStatusHelp.Height = 300;
        rwStatusHelp.Visible = false;
    }
    protected void btnR2Leadsflup_Click(object sender, EventArgs e)
    {
        try
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "R2-Leads Followup", DateTime.Now);

            divMR1.Visible = false;
            //divLeadSummary.Visible = false;
            divMR3.Visible = true;
            divMR4.Visible = false;
            //divMR5.Visible = false;

            dvMarkettingAct.Visible = false;
            dvGeneralActivity.Visible = false;
            dvServiceActivity.Visible = false;
            divwfr2.Visible = false;

            divwfr3.Visible = false;
            divwfr4.Visible = false;


            divsmx1.Visible = false;
            divsmx2.Visible = false;

            divsmx5.Visible = false;

            dvROL.Visible = false;
            dvHeaderMenu.Visible = false;
            dvMainSMReports.Visible = true;
           // btnRtnHome.Visible = false;
            dvR12TimeSummary.Visible = false;
            dvR13TimeDetailed.Visible = false;
            dvR14sysnotused.Visible = false;
            dvR4EnqRegistered.Visible = false;
            dvR4OrdersBooked.Visible = false;
            dvR4QuoateSubmitted.Visible = false;

            dvR5SServiceReport.Visible = false;
            dvRefSummReport.Visible = false;
            dvDailyUsageBilllingReport.Visible = false;

            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport3",
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "ALL" }
                );

            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport3.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                ViewState["R2"] = dsTargetDet.Tables[0];
                lblmr3count.Text = "Count:" + TypeRCount.ToString();
                gvMarketingReport3.DataBind();
                dsTargetDet.Dispose();
                //ddlsmr3Status.Items.Insert(0, "ALL");
            }

            else
            {
                divMR3.Visible = true;
                gvMarketingReport3.DataSource = null;
                gvMarketingReport3.DataBind();
                lblmr3count.Text = "0";
                ViewState["R2"] = dsTargetDet.Tables[0];
                //WebMsgBox.Show("There are no records to display");
            }
            //ddlsmr3Status.SelectedIndex = 3;
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnR3NoSales_Click(object sender, EventArgs e)
    {
        try
        {
            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "R3-No Followups", DateTime.Now);

            divMR4.Visible = true;
            divMR1.Visible = false;
            divMR3.Visible = false;
            //divLeadSummary.Visible = false;
            //divMR5.Visible = false;

            dvMarkettingAct.Visible = false;
            dvGeneralActivity.Visible = false;
            dvServiceActivity.Visible = false;

            divwfr2.Visible = false;

            divwfr3.Visible = false;
            divwfr4.Visible = false;


            divsmx1.Visible = false;
            divsmx2.Visible = false;

            divsmx5.Visible = false;

            dvROL.Visible = false;
            dvR12TimeSummary.Visible = false;
            dvR13TimeDetailed.Visible = false;
            dvR14sysnotused.Visible = false;

            dvR4EnqRegistered.Visible = false;
            dvR4OrdersBooked.Visible = false;
            dvR4QuoateSubmitted.Visible = false;

            dvHeaderMenu.Visible = false;
            dvMainSMReports.Visible = true;
           // btnRtnHome.Visible = false;

            dvR5SServiceReport.Visible = false;
            dvRefSummReport.Visible = false;
            dvDailyUsageBilllingReport.Visible = false;
            //ddlsmr4status.SelectedIndex = 3;

            SQLProcs sqlobj = new SQLProcs();

            DataSet dsTargetDet = new DataSet();
            dsTargetDet = null;


            dsTargetDet = sqlobj.SQLExecuteDataset("sp_GetMarketingReport4",
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "ALL" }
                );

            if (dsTargetDet.Tables[0].Rows.Count > 0)
            {
                //dtTemp.Dispose();
                gvMarketingReport4.DataSource = dsTargetDet.Tables[0];
                int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
                ViewState["R3"] = dsTargetDet.Tables[0];
                lblmr4count.Text = "Count:" + TypeRCount.ToString();
                gvMarketingReport4.DataBind();
                //ddlsmr4status.Items.Insert(0, "ALL");                    
            }
            else
            {
                gvMarketingReport4.DataSource = null;
                gvMarketingReport4.DataBind();
                ViewState["R3"] = dsTargetDet.Tables[0];
                lblmr4count.Text = "Count : 0";
                // WebMsgBox.Show("There are no records to display");
            }
            dsTargetDet.Dispose();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnR4MarkAct_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R4-Marketing Activities", DateTime.Now);

        MALoadMRReference();
        RadDatemarkactfrom.SelectedDate = DateTime.Now;
        RadDatemarkactto.SelectedDate = DateTime.Now;
        lblMarActPrintDate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblMarActBy.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;
        //divLeadSummary.Visible = false;
        //divMR5.Visible = false;

        dvMarkettingAct.Visible = true;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;


        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        gvMarkActDetails.Visible = false;
        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        lblMarkActCount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR5ServAct_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R5-Service Activities", DateTime.Now);

        ServiceActivityReference();
        RadDateSerActFrom.SelectedDate = DateTime.Now;
        RadDateSerActTo.SelectedDate = DateTime.Now;
        lblSerActDate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH: mm") + " Hrs";
        lblSerActBy.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;
        //divLeadSummary.Visible = false;
        //divMR5.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = true;

        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        gvSerActDetails.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        lblSerActCount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR6GenAct_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R6-General Activities", DateTime.Now);

        GeneralActivityReference();
        RadDateGenActFrom.SelectedDate = DateTime.Now;
        RadDateGenActTo.SelectedDate = DateTime.Now;
        lblGenActDate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH: mm") + " Hrs";
        lblGenActBy.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = true;
        dvServiceActivity.Visible = false;

        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        gvGenActDetails.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        lblGenActCount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR7WorkProg_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R7-Work Progress", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = true;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        Loadwfr2Reference();
        Loadwfr2By();
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
       // btnRtnHome.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        lblR7workprogcount.Visible = false;
        gvWFR2.DataSource = null;
        gvWFR2.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR8QuickSrch_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R8-Quick Search", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = true;
        divwfr4.Visible = false;

        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        lblR8QuicksrchCount.Visible = false;
        TxtSearchValue.Text = "";
        gvWFR3.DataSource = null;
        gvWFR3.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR7HrsSpent_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R9-Hours Spent", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = true;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        Loadwfr2Reference();
        Loadwfr2By();

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        lblR9hrspentcount.Visible = false;
        gvwfr4.DataSource = null;
        gvwfr4.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnX1cusdump_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "X1-Customer Dump", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = true;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnX2reflist_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "X2-Reference List Dump", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx2.Visible = true;
        divsmx1.Visible = false;

        divsmx5.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        dvR5SServiceReport.Visible = false;
    }
    protected void btnR10cuslistloc_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "Home", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = true;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        LoadProsArea();   //Load street

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }

    private void LoadProsArea()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsArea = new DataSet();
        dsArea = sqlobj.SQLExecuteDataset("proc_GetAllArea");

        if (dsArea.Tables[0].Rows.Count != 0)
        {

            ddlArea.DataSource = dsArea.Tables[0];
            ddlArea.DataValueField = "Street";
            ddlArea.DataTextField = "Street";
            ddlArea.DataBind();
        }

        // ddlArea.Items.Insert(0, "All");

        dsArea.Dispose();

    }
    protected void btnRtnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageNTaskList.aspx");
    }
    protected void btnR50ROL_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R11-Recognitions&Observations", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;

        dvROL.Visible = true;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
       // btnRtnHome.Visible = false;

        StaffID = Session["UserID"].ToString();
        GetStaff(StaffID);
        strUserLevel = Session["UserLevel"].ToString();

        if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
        {
            ddlROLStaff.Items.Insert(0, "All");
        }

        rdpROLfrom.SelectedDate = DateTime.Now;
        rdpROLTo.SelectedDate = DateTime.Now;
        gvROL.Visible = false;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        lblROLCount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }

    public void GetStaff(string staffName)
    {
        SqlCommand cmd1 = new SqlCommand();
        DataSet dsStaff = new DataSet();
        cmd1.CommandText = "proc_GetStaff";
        cmd1.Connection = con;
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@staffname", staffName);
        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
        dap.Fill(dsStaff, "tblstaff");
        ddlROLStaff.DataSource = dsStaff.Tables["tblstaff"];
        ddlROLStaff.DataValueField = "Username";
        ddlROLStaff.DataTextField = "StaffName";
        ddlROLStaff.DataBind();
    }


    protected void btnROLSearch_Click(object sender, EventArgs e)
    {
        try
        {

            if (Convert.ToDateTime(rdpROLfrom.SelectedDate) > Convert.ToDateTime(rdpROLTo.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check From and Until date.');", true);
                return;
            }
            lblROLCount.Visible = true;
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsROLDetails = new DataSet();
            dsROLDetails = null;


            string Untill = rdpROLTo.SelectedDate.ToString();
            Untill = Untill.Replace("00:00:00", "23:59:00");

            //DateTime EndDate=new DateTime(rdpROLTo.SelectedDate);
            //string Test = EndDate.Date.Add(1).AddMilliseconds(-1).ToString();


            dsROLDetails = sqlobj.SQLExecuteDataset("proc_GetROLReport",
                new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.NVarChar, Value = ddlROLStaff.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(rdpROLfrom.SelectedDate.ToString()) },
                new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(Untill.ToString()) }
                );

            if (dsROLDetails.Tables[0].Rows.Count > 0)
            {
                gvROL.DataSource = dsROLDetails.Tables[0];
                int TypeRCount = dsROLDetails.Tables[0].Rows.Count;
                lblROLCount.Text = "Count : " + TypeRCount.ToString();
                gvROL.DataBind();
                //ddlsmr4status.Items.Insert(0, "ALL");                    
            }
            else
            {
                gvROL.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvROL.DataSource = dsROLDetails.Tables[0];
                gvROL.DataBind();
                lblROLCount.Text = "Count : " + 0;
                // WebMsgBox.Show("There are no records to display");
            }
            dsROLDetails.Dispose();
            gvROL.Visible = true;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }



    }
    protected void btnROLExport_Click(object sender, EventArgs e)
    {
        if (gvROL.Items.Count == 0)
        {
            rwR11ROL.RadAlert("There are no records to export", 300, 130, "R11-Recognitions and Observations", "");
        }
        else
        {
            rwR11ROL.RadConfirm("No. of records selected :" + gvROL.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmROLSubExportFn", 300, 200, null, "R11-Recognitions and Observations");
        }        
    }

    protected void gvROL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsROLDetails = new DataSet();
        dsROLDetails = null;
        string Untill = rdpROLTo.SelectedDate.ToString();
        Untill = Untill.Replace("00:00:00", "23:59:00");

        dsROLDetails = sqlobj.SQLExecuteDataset("proc_GetROLReport",
            new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.NVarChar, Value = ddlROLStaff.SelectedValue.ToString() },
            new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(rdpROLfrom.SelectedDate.ToString()) },
            new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(Untill.ToString()) }
            );

        if (dsROLDetails.Tables[0].Rows.Count > 0)
        {
            gvROL.DataSource = dsROLDetails.Tables[0];
            int TypeRCount = dsROLDetails.Tables[0].Rows.Count;
            lblROLCount.Text = "Count : " + TypeRCount.ToString();
            gvROL.DataBind();
            //ddlsmr4status.Items.Insert(0, "ALL");                    
        }
        else
        {
            gvROL.MasterTableView.ShowHeadersWhenNoRecords = true;
            gvROL.DataSource = dsROLDetails.Tables[0];
            gvROL.DataBind();
            lblROLCount.Text = "Count : " + 0;
            // WebMsgBox.Show("There are no records to display");
        }
        dsROLDetails.Dispose();
    }
    protected void btnR12timesummary_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R12-Time consumed -Summary", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        dvR12TimeSummary.Visible = true;
        dtpr12from.SelectedDate = DateTime.Today;
        dtpR12till.SelectedDate = DateTime.Today;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        lblR12Count.Visible = false;
        gvR12details.DataSource = null;
        gvR12details.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR13timedetailed_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R13-Time consumed -Detailed", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR13TimeDetailed.Visible = true;
        dtpR13from.SelectedDate = DateTime.Today;
        dtpR13to.SelectedDate = DateTime.Today;

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        lblR13count.Visible = false;
        gvR13Details.DataSource = null;
        gvR13Details.DataBind();

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR14sysnotused_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R14-System Usage Report", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR14sysnotused.Visible = true;
        GetR14ReportDetails();

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }

    protected void GetR14ReportDetails()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR14details = new DataSet();
            dsR14details = null;

            dsR14details = sqlobj.SQLExecuteDataset("proc_GetR14Report");
            if (dsR14details.Tables[0].Rows.Count > 0)
            {
                gvR14Details.DataSource = dsR14details.Tables[0];
                gvR14Details.DataBind();
            }
            else
            {
                gvR14Details.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR14Details.DataSource = dsR14details.Tables[0];
                gvR14Details.DataBind();
            }
            dsR14details.Dispose();
            gvR14Details.Visible = true;
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnR12search_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDateTime(dtpr12from.SelectedDate) > Convert.ToDateTime(dtpR12till.SelectedDate))
            {
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check From and Till date.');", true);
                rwR12TimeCons.RadAlert("Please check From and Till date", 300, 130, "R12-Time consumed per client-Summary", "");
                return;
            }
            lblR12Count.Visible = true;

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR12details = new DataSet();
            dsR12details = null;

            dsR12details = sqlobj.SQLExecuteDataset("proc_GetR12Report",
                new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpr12from.SelectedDate) },
                new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR12till.SelectedDate) }
                );

            if (dsR12details.Tables[0].Rows.Count > 0)
            {
                gvR12details.DataSource = dsR12details.Tables[0];
                int TypeRCount = dsR12details.Tables[0].Rows.Count;
                lblR12Count.Text = "Count : " + TypeRCount.ToString();
                gvR12details.DataBind();
                Session["R12"] = (DataTable)dsR12details.Tables[0];
            }
            else
            {
                gvR12details.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR12details.DataSource = dsR12details.Tables[0];
                gvR12details.DataBind();
                lblR12Count.Text = "Count : " + 0;
                Session["R12"] = (DataTable)dsR12details.Tables[0];
            }
            dsR12details.Dispose();
            gvR12details.Visible = true;
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnR12excel_Click(object sender, EventArgs e)
    {
        if (gvR12details.Items.Count == 0)
        {
            rwR12TimeCons.RadAlert("There are no records to export", 300, 130, "R12-Time consumed per client-Summary", "");
        }
        else
        {
            //rwR12TimeCons.RadConfirm("No. of records selected :" + gvR12details.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmTimeConsumeExportFn", 300, 200, null, "R12-Time consumed per client-Summary");
            if (Session["R12"] != null)
            {
                DataTable dt = (DataTable)Session["R12"];
                rwR12TimeCons.RadConfirm("No. of records selected :" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmTimeConsumeExportFn", 300, 200, null, "R12-Time consumed per client-Summary");
            }
        }        
    }
    protected void gvR12details_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Profile")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
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
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR12details = new DataSet();
            dsR12details = null;       
            dsR12details = sqlobj.SQLExecuteDataset("proc_GetR12Report",
                new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpr12from.SelectedDate) },
                new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR12till.SelectedDate) }
                );

            if (dsR12details.Tables[0].Rows.Count > 0)
            {
                gvR12details.DataSource = dsR12details.Tables[0];
                int TypeRCount = dsR12details.Tables[0].Rows.Count;
                lblR12Count.Text = "Count : " + TypeRCount.ToString();
                gvR12details.DataBind();   
            }
            else
            {
                gvR12details.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR12details.DataSource = dsR12details.Tables[0];
                gvR12details.DataBind();
                lblR12Count.Text = "Count : " + 0;            
            }
            dsR12details.Dispose();
            gvR12details.Visible = true;
        }
       

    }
    protected void btnR13search_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDateTime(dtpR13from.SelectedDate) > Convert.ToDateTime(dtpR13to.SelectedDate))
            {
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check From and Till date.');", true);
                rwR13TimeDetail.RadAlert("Please check From and Till date", 300, 130, "R13-Time consumed per client-Detailed", "");
                return;
            }

            lblR13count.Visible = true;
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR13details = new DataSet();
            dsR13details = null;

            dsR13details = sqlobj.SQLExecuteDataset("proc_GetR13Report",
                new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR13from.SelectedDate) },
                new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR13to.SelectedDate) }
                );

            if (dsR13details.Tables[0].Rows.Count > 0)
            {
                gvR13Details.DataSource = dsR13details.Tables[0];
                int TypeRCount = dsR13details.Tables[0].Rows.Count;
                lblR13count.Text = "Count : " + TypeRCount.ToString();
                gvR13Details.DataBind();
                Session["R13"] = (DataTable)dsR13details.Tables[0];
            }
            else
            {
                gvR13Details.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR13Details.DataSource = dsR13details.Tables[0];
                gvR13Details.DataBind();
                lblR13count.Text = "Count : " + 0;
                Session["R13"] = (DataTable)dsR13details.Tables[0];
            }
            dsR13details.Dispose();
            gvR13Details.Visible = true;
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnR13excel_Click(object sender, EventArgs e)
    {
        if (gvR13Details.Items.Count == 0)
        {
            rwR13TimeDetail.RadAlert("There are no records to export", 300, 130, "R13-Time consumed per client-Detailed", "");
        }
        else
        {
            //rwR13TimeDetail.RadConfirm("No. of records selected :" + gvR13Details.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmR13TimeDetailExportFn", 300, 200, null, "R13-Time consumed per client-Detailed");
            if (Session["R13"] != null)
            {
                DataTable dt = (DataTable)Session["R13"];
                rwR13TimeDetail.RadConfirm("No. of records selected :" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmR13TimeDetailExportFn", 300, 200, null, "R13-Time consumed per client-Detailed");
            }
        }        
    }
    protected void gvR13Details_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Profile")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
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
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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
        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            string strProspectRSN = Convert.ToString(arg[0]);


            string strtaskid = arg[1].ToString();

            Int64 istaffid = Convert.ToInt64(strProspectRSN);

            Session["ProspectRSN"] = istaffid.ToString();

            LoadProspectDiary(strProspectRSN, strtaskid.ToString());
            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            if (Convert.ToDateTime(dtpR13from.SelectedDate) > Convert.ToDateTime(dtpR13to.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check From and Till date.');", true);
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR13details = new DataSet();
            dsR13details = null;

            dsR13details = sqlobj.SQLExecuteDataset("proc_GetR13Report",
                new SqlParameter() { ParameterName = "@fromdate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR13from.SelectedDate) },
                new SqlParameter() { ParameterName = "@todate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpR13to.SelectedDate) }
                );

            if (dsR13details.Tables[0].Rows.Count > 0)
            {
                gvR13Details.DataSource = dsR13details.Tables[0];
                int TypeRCount = dsR13details.Tables[0].Rows.Count;
                lblR13count.Text = "Count : " + TypeRCount.ToString();
                gvR13Details.DataBind();
                //ddlsmr4status.Items.Insert(0, "ALL");                    
            }
            else
            {
                gvR13Details.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR13Details.DataSource = dsR13details.Tables[0];
                gvR13Details.DataBind();
                lblR13count.Text = "Count : " + 0;
                // WebMsgBox.Show("There are no records to display");
            }
            dsR13details.Dispose();
            gvR13Details.Visible = true;
        }
    }
    protected void gvR14Details_ItemCommand(object sender, GridCommandEventArgs e)
    {
        GetR14ReportDetails();
    }
    protected void btnR4Enquiry_Click(object sender, EventArgs e)
    {


        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R4E - Enquiries Registered", DateTime.Now);

        dtpR4engregfrom.SelectedDate = DateTime.Now;
        dtpR4engregto.SelectedDate = DateTime.Now;
        lblR4EnqRegdate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblR4enqregby.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;


        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        gvR4EnqRegDetails.Visible = false;
        dvR4EnqRegistered.Visible = true;
        dvR4QuoateSubmitted.Visible = false;

        dvR4OrdersBooked.Visible = false;
        lblR4EnqRegCount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR4Quotation_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R4Q - Quotations Submitted", DateTime.Now);

        dtpR4Quoatesubfrom.SelectedDate = DateTime.Now;
        dtpR4Quoatesubto.SelectedDate = DateTime.Now;
        lblR4Quoatesubdate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblR4QuoatesubBy.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;


        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;


        dvR4EnqRegistered.Visible = false;
        dvR4QuoateSubmitted.Visible = true;
        gvR4QuoateSubDetails.Visible = false;

        dvR4OrdersBooked.Visible = false;

        lblR4quoatesubcount.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR4Orders_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R4O - Orders Booked", DateTime.Now);

        dtpR4OrderBookfrom.SelectedDate = DateTime.Now;
        dtpR4OrderBookto.SelectedDate = DateTime.Now;
        lblR4Ordersbookdate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblR4OrdersbookBy.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;


        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;


        dvR4EnqRegistered.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
        dvR4OrdersBooked.Visible = true;
        gvR4OrdersBookDetails.Visible = false;
        lblR4Ordersbookcount.Visible = false;
        dvR5SServiceReport.Visible = false;
        dvRefSummReport.Visible = false;
            dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btnR4EnqRegSub_Click(object sender, EventArgs e)
    {
        try
        {
            lblR4EnqRegCount.Visible = true;
            if (ddlR4enqregsts.SelectedValue == "0")
            {
                // WebMsgBox.Show("Please Select Status");
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                gvR4EnqRegDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4EnqRegDetails.DataSource = string.Empty;
                gvR4EnqRegDetails.DataBind();
                lblR4EnqRegCount.Text = "Count : " + 0;
                return;
            }
            if (Convert.ToDateTime(dtpR4engregfrom.SelectedDate) > Convert.ToDateTime(dtpR4engregto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvR4EnqRegDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4EnqRegDetails.DataSource = string.Empty;
                gvR4EnqRegDetails.DataBind();
                lblR4EnqRegCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsEnqRegDetails = new DataSet();
            dsEnqRegDetails = null;


            dsEnqRegDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlR4enqregsts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Enquiry" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4engregfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4engregto.SelectedDate.ToString() }
                );

            if (dsEnqRegDetails.Tables[0].Rows.Count > 0)
            {               
                gvR4EnqRegDetails.DataSource = dsEnqRegDetails.Tables[0];
                int TypeRCount = dsEnqRegDetails.Tables[0].Rows.Count;
                lblR4EnqRegCount.Text = "Count : " + TypeRCount.ToString();
                gvR4EnqRegDetails.DataBind();
                ViewState["R4E"]=dsEnqRegDetails.Tables[0];                    
            }
            else
            {
                gvR4EnqRegDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4EnqRegDetails.DataSource = dsEnqRegDetails.Tables[0];
                gvR4EnqRegDetails.DataBind();
                lblR4EnqRegCount.Text = "Count : " + 0;
                ViewState["R4E"] = dsEnqRegDetails.Tables[0];
            }
            gvR4EnqRegDetails.Visible = true;
            dsEnqRegDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Check your internet connection");
        }
    }
    protected void btnR4EnqRegExcel_Click(object sender, EventArgs e)
    {
        if (gvR4EnqRegDetails.Items.Count == 0)
        {
            rwmEnqRegExport.RadAlert("There are no records to export", 300, 130, "R4E-Enquiries Registered", "");
        }
        else
        {
            //rwmEnqRegExport.RadConfirm("No. of records selected " + gvR4EnqRegDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmEnqRegExportFn", 300, 200, null, "R4E-Enquiries Registered");
            if (ViewState["R4E"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4E"];
                rwmEnqRegExport.RadConfirm("No. of records selected : " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmEnqRegExportFn", 300, 200, null, "R4E-Enquiries Registered");
            }
        }        
    }
    protected void HiddenButtonEnqRegExport_Click(object sender, EventArgs e)
    {
        if ((gvR4EnqRegDetails.Visible == true))
        {
            if (ViewState["R4E"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4E"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date") && dt.Columns.Contains("Reference"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.Columns.Remove("Reference");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 21, "R4E - Enquiries Registered");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "alert('There is no records to export');", true);
                }
            }           
        }
        else
        {       
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }

    protected void gvR4EnqRegDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string RSN = commandArgs[0];
            string taskid = commandArgs[1];

            rwDiary.Visible = true;
            Session["ProspectRSN"] = RSN.ToString();
            LoadProspectDiary(RSN.ToString());

            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsEnqRegDetails = new DataSet();
            dsEnqRegDetails = null;


            dsEnqRegDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlR4enqregsts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Enquiry" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4engregfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4engregto.SelectedDate.ToString() }
                );

            if (dsEnqRegDetails.Tables[0].Rows.Count > 0)
            {             
                gvR4EnqRegDetails.DataSource = dsEnqRegDetails.Tables[0];
                int TypeRCount = dsEnqRegDetails.Tables[0].Rows.Count;
                lblR4EnqRegCount.Text = "Count : " + TypeRCount.ToString();
                gvR4EnqRegDetails.DataBind();                   
            }
            else
            {
                gvR4EnqRegDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4EnqRegDetails.DataSource = dsEnqRegDetails.Tables[0];
                gvR4EnqRegDetails.DataBind();
                lblR4EnqRegCount.Text = "Count : " + 0;            
            }
            gvR4EnqRegDetails.Visible = true;
            dsEnqRegDetails.Dispose();
        }
    }
    protected void btnR4quoatesubmit_Click(object sender, EventArgs e)
    {
        try
        {
            lblR4quoatesubcount.Visible = true;
            if (ddlr4quoatesubsts.SelectedValue == "0")
            {              
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                gvR4QuoateSubDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4QuoateSubDetails.DataSource = string.Empty;
                gvR4QuoateSubDetails.DataBind();
                lblR4quoatesubcount.Text = "Count : " + 0;
                return;
            }
            if (Convert.ToDateTime(dtpR4Quoatesubfrom.SelectedDate) > Convert.ToDateTime(dtpR4Quoatesubto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvR4QuoateSubDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4QuoateSubDetails.DataSource = string.Empty;
                gvR4QuoateSubDetails.DataBind();
                lblR4quoatesubcount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsQuoateSubDetails = new DataSet();
            dsQuoateSubDetails = null;


            dsQuoateSubDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlr4quoatesubsts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Quote" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4Quoatesubfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4Quoatesubto.SelectedDate.ToString() }
                );

            if (dsQuoateSubDetails.Tables[0].Rows.Count > 0)
            {
                gvR4QuoateSubDetails.DataSource = dsQuoateSubDetails.Tables[0];
                int TypeRCount = dsQuoateSubDetails.Tables[0].Rows.Count;
                lblR4quoatesubcount.Text = "Count : " + TypeRCount.ToString();
                gvR4QuoateSubDetails.DataBind();
                ViewState["R4Q"] = dsQuoateSubDetails.Tables[0];
            }
            else
            {
                gvR4QuoateSubDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4QuoateSubDetails.DataSource = dsQuoateSubDetails.Tables[0];
                gvR4QuoateSubDetails.DataBind();
                lblR4quoatesubcount.Text = "Count : " + 0;
                ViewState["R4Q"] = dsQuoateSubDetails.Tables[0];
            }
            gvR4QuoateSubDetails.Visible = true;
            dsQuoateSubDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Check your internet connection");
        }
    }
    protected void btnr4quoatesubexcel_Click(object sender, EventArgs e)
    {
        if (gvR4QuoateSubDetails.Items.Count == 0)
        {
            rwmQuoSubExport.RadAlert("There are no records to export", 300, 130, "R4Q-Quotaions Submitted", "");
        }
        else
        {
            //rwmQuoSubExport.RadConfirm("No. of records selected " + gvR4QuoateSubDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmQuoSubExportFn", 300, 200, null, "R4Q-Quotaions Submitted.");
            if (ViewState["R4Q"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4Q"];
                rwmQuoSubExport.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmQuoSubExportFn", 300, 200, null, "R4Q-Quotaions Submitted.");
            }
        }
        
    }
    protected void HiddenButtonQuoSubExport_Click(object sender, EventArgs e)
    {
        if ((gvR4QuoateSubDetails.Visible == true))
        {
            if (ViewState["R4Q"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4Q"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date") && dt.Columns.Contains("Reference"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.Columns.Remove("Reference");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 22, "R4Q - Quotations submitted");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
                }
            }           
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void gvR4QuoateSubDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string RSN = commandArgs[0];
            string taskid = commandArgs[1];

            rwDiary.Visible = true;
            Session["ProspectRSN"] = RSN.ToString();
            LoadProspectDiary(RSN.ToString());

            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsQuoateSubDetails = new DataSet();
            dsQuoateSubDetails = null;


            dsQuoateSubDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlr4quoatesubsts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Quote" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4Quoatesubfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4Quoatesubto.SelectedDate.ToString() }
                );

            if (dsQuoateSubDetails.Tables[0].Rows.Count > 0)
            {               
                gvR4QuoateSubDetails.DataSource = dsQuoateSubDetails.Tables[0];
                int TypeRCount = dsQuoateSubDetails.Tables[0].Rows.Count;
                lblR4quoatesubcount.Text = "Count : " + TypeRCount.ToString();
                gvR4QuoateSubDetails.DataBind();                          
            }
            else
            {
                gvR4QuoateSubDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4QuoateSubDetails.DataSource = dsQuoateSubDetails.Tables[0];
                gvR4QuoateSubDetails.DataBind();
                lblR4quoatesubcount.Text = "Count : " + 0;            
            }
            gvR4QuoateSubDetails.Visible = true;
            dsQuoateSubDetails.Dispose();
        }
    }
    protected void btnR4OrdersBookSub_Click(object sender, EventArgs e)
    {
        try
        {
            lblR4Ordersbookcount.Visible = true;
            if (ddlR4OrdersBooksts.SelectedValue == "0")
            {              
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Select Status');", true);
                gvR4OrdersBookDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4OrdersBookDetails.DataSource = string.Empty;
                gvR4OrdersBookDetails.DataBind();
                lblR4Ordersbookcount.Text = "Count : " + 0;
                return;
            }
            if (Convert.ToDateTime(dtpR4OrderBookfrom.SelectedDate) > Convert.ToDateTime(dtpR4OrderBookto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvR4OrdersBookDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4OrdersBookDetails.DataSource = string.Empty;
                gvR4OrdersBookDetails.DataBind();
                lblR4Ordersbookcount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsOrdersBookDetails = new DataSet();
            dsOrdersBookDetails = null;


            dsOrdersBookDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlR4OrdersBooksts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Order" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4OrderBookfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4OrderBookto.SelectedDate.ToString() }
                );

            if (dsOrdersBookDetails.Tables[0].Rows.Count > 0)
            {
                gvR4OrdersBookDetails.DataSource = dsOrdersBookDetails.Tables[0];
                int TypeRCount = dsOrdersBookDetails.Tables[0].Rows.Count;
                lblR4Ordersbookcount.Text = "Count : " + TypeRCount.ToString();
                gvR4OrdersBookDetails.DataBind();
                ViewState["R4O"]=dsOrdersBookDetails.Tables[0];                   
            }
            else
            {
                gvR4OrdersBookDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4OrdersBookDetails.DataSource = dsOrdersBookDetails.Tables[0];
                gvR4OrdersBookDetails.DataBind();
                lblR4Ordersbookcount.Text = "Count : " + 0;
                ViewState["R4O"] = dsOrdersBookDetails.Tables[0]; 
            }
            gvR4OrdersBookDetails.Visible = true;
            dsOrdersBookDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Check your internet connection");
        }
    }
    protected void btnR4OrdersBookExcel_Click(object sender, EventArgs e)
    {
        if (gvR4OrdersBookDetails.Items.Count == 0)
        {
            rwR4orders.RadAlert("There are no records to export", 300, 130, "R4O-Orders Submitted", "");
        }
        else
        {
            //rwR4orders.RadConfirm("No. of records selected " + gvR4OrdersBookDetails.Items.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmOrdersSubExportFn", 300, 200, null, "R4O-Orders Submitted.");
            if (ViewState["R4O"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4O"];
                rwR4orders.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmOrdersSubExportFn", 300, 200, null, "R4O-Orders Submitted.");
            }
        }   
    }
    protected void gvR4OrdersBookDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Int64 istaffid = Convert.ToInt64(index);
            Session["ProspectRSN"] = istaffid.ToString();
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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

        }
        else if (e.CommandName.Equals("Tasks"))
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string RSN = commandArgs[0];
            string taskid = commandArgs[1];

            rwDiary.Visible = true;
            Session["ProspectRSN"] = RSN.ToString();
            LoadProspectDiary(RSN.ToString());

            if (gvDiary.Rows.Count > 0)
            {
                rwDiary.Visible = true;
            }
        }
        else
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsOrdersBookDetails = new DataSet();
            dsOrdersBookDetails = null;

            dsOrdersBookDetails = sqlobj.SQLExecuteDataset("proc_GetMarkettingActivities",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt64(ddlR4OrdersBooksts.SelectedValue.ToString()) },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = "#Order" },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = dtpR4OrderBookfrom.SelectedDate.ToString() },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = dtpR4OrderBookto.SelectedDate.ToString() }
                );

            if (dsOrdersBookDetails.Tables[0].Rows.Count > 0)
            {
                gvR4OrdersBookDetails.DataSource = dsOrdersBookDetails.Tables[0];
                int TypeRCount = dsOrdersBookDetails.Tables[0].Rows.Count;
                lblR4Ordersbookcount.Text = "Count : " + TypeRCount.ToString();
                gvR4OrdersBookDetails.DataBind();
                //ddlsmr4status.Items.Insert(0, "ALL");                    
            }
            else
            {
                gvR4OrdersBookDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR4OrdersBookDetails.DataSource = dsOrdersBookDetails.Tables[0];
                gvR4OrdersBookDetails.DataBind();
                lblR4Ordersbookcount.Text = "Count : " + 0;
            }
            gvR4OrdersBookDetails.Visible = true;
            dsOrdersBookDetails.Dispose();
        }
    }
    protected void hbtnR4Orders_Click(object sender, EventArgs e)
    {
        if ((gvR4OrdersBookDetails.Visible == true))
        {
            if (ViewState["R4O"] != null)
            {
                DataTable dt = (DataTable)ViewState["R4O"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date") && dt.Columns.Contains("Reference"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.Columns.Remove("Reference");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 23, "R4O - Orders Booked");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no records to export');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void hbtnR5serAct_Click(object sender, EventArgs e)
    {
        if ((gvSerActDetails.Visible == true))
        {
            if (ViewState["R5S"] != null)
            {
                DataTable dt = (DataTable)ViewState["R5S"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.AcceptChanges();
                    }
                   
                    ExcelExport(dt, 19, "R5 - Service activities");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "alert('There is no records to export');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void hbtnR6genAct_Click(object sender, EventArgs e)
    {
        if ((gvGenActDetails.Visible == true))
        {
            if (ViewState["R6G"] != null)
            {
                DataTable dt = (DataTable)ViewState["R6G"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("Date"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("Taskid");
                        dt.Columns.Remove("Date");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 20, "R6 - General activities");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "alert('There is no records to export');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void hbtnR7workprog_Click(object sender, EventArgs e)
    {
        if (Session["R7"] != null)
        {
            DataTable dt = (DataTable)Session["R7"];
            if (dt.Rows.Count > 0)
            {
                if (dt.Columns.Contains("TaskId") && dt.Columns.Contains("Customerrsn") && dt.Columns.Contains("ShowFudate"))
                {
                    dt.Columns.Remove("Taskid");
                    dt.Columns.Remove("Customerrsn");
                    //dt.Columns.Remove("AsignDate");
                    dt.Columns["ShowFudate"].ColumnName = "FollowupDate";
                    dt.AcceptChanges();
                }             
                if(dt.Rows.Count > 350)
                {                    
                    dtgridtoexcelreport(dt);
                    //ExcelExport(dt, 17, "");
                }
                else
                {
                    ExcelExport(dt, 17, "R7-Work Progress");
                }
               
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to export');", true);
            }
        }   
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to export');", true);
        }
    }
    protected void hbtnR9hrsspent_Click(object sender, EventArgs e)
    {
        try
        {
            if(gvwfr4.Rows.Count > 0)
            {
                if (ViewState["R9"] != null)
                {
                    DataTable dt = (DataTable)ViewState["R9"];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("Taskid") && dt.Columns.Contains("Customerrsn"))
                        {
                            dt.Columns.Remove("Taskid");
                            dt.Columns.Remove("Customerrsn");
                            dt.AcceptChanges();
                        }
                        //GridView gv = new GridView();
                        //gv.DataSource = dt;
                        //gv.DataBind();
                        //GridView[] gvList = new GridView[] { gv };
                        //Export("R9-HoursSpentReport.xls", gvList);
                        DatatabletoExcel(dt, "R9-HoursSpentReport");
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no records to export');", true);
                    }
                }
              
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to export');", true);
            }
            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void hbtnR11ROL_Click(object sender, EventArgs e)
    {
        if ((gvROL.Visible == true))
        {
            if(gvROL.MasterTableView.Items.Count > 0)
            {
                gvROL.ExportSettings.ExportOnlyData = true;
                gvROL.ExportSettings.FileName = "R11-RecognitionsandObservation" + "-" + DateTime.Now.ToShortDateString();
                gvROL.MasterTableView.Caption = "R11 - Recognitions and Observations " + " From " + rdpROLfrom.SelectedDate.Value.ToString("dd/MM/yyyy") + " To " + rdpROLTo.SelectedDate.Value.ToString("dd/MM/yyyy");
                gvROL.ExportSettings.IgnorePaging = true;
                gvROL.ExportSettings.OpenInNewWindow = true;
                gvROL.MasterTableView.ExportToExcel();
            }  
            else
            {
               ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void hbtnR12TimeCons_Click(object sender, EventArgs e)
    {
        if ((gvR12details.Visible == true))
        {
            if (Session["R12"] != null)
            {
                DataTable dt = (DataTable)Session["R12"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 15, "R12 -Time consumed per client - Summary");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to export');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void nbtnR13TimeDetail_Click(object sender, EventArgs e)
    {
        if ((gvR13Details.Visible == true))
        {
            if (Session["R13"] != null)
            {
                DataTable dt = (DataTable)Session["R13"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("RSN") && dt.Columns.Contains("TaskID"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.Columns.Remove("TaskID");
                        dt.AcceptChanges();
                    }
                    ExcelExport(dt, 16, "R13 -Time consumed per client - Detailed");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to export');", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There are no records to Export');", true);
        }
    }
    protected void btnimgexporttoexcel1_Click1(object sender, EventArgs e)
    {
        SQLProcs sqlp = new SQLProcs();
        DataSet dsDisp = new DataSet();

        int strRpt = 1;
        string rptType = ddlSMXReport1.SelectedValue.ToString();

        dsDisp = sqlp.SQLExecuteDataset("SP_SMX_Report",
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                        new SqlParameter() { ParameterName = "@keyword", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ddlSMXReport1.SelectedValue.ToString() });

        if (dsDisp != null && dsDisp.Tables.Count > 0 && dsDisp.Tables[0].Rows.Count > 0)
        {
            rwX1Cusdump.RadConfirm("No. of records selected " + dsDisp.Tables[0].Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmCallbackFn1", 300, 200, null, "X1-Customer Dump");
        }
        else
        {
            rwX1Cusdump.RadAlert("There are no records to export", 300, 130, "X1-Customer Dump", "");
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }

    protected void gvwfr4_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwfr4.PageIndex = e.NewPageIndex;
        LoadWFR4();
    }
    protected void gvWFR2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvWFR2.PageIndex = e.NewPageIndex;
        LoadWFR2();
    }  
    

    protected void btnR15serpro_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R5S-Services", DateTime.Now);

        raddateR5Sfromdate.SelectedDate = DateTime.Now;
        raddateR5Stodate.SelectedDate = DateTime.Now;
        lblR5Sdate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblR5Sby.Text = "By : " + Session["UserID"].ToString();
        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;
   
        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;


        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;


        divsmx1.Visible = false;
        divsmx2.Visible = false;

        divsmx5.Visible = false;


        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;
        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;

        gvMarkActDetails.Visible = false;
        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;
     
        dvR5SServiceReport.Visible = true;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
        ServiceActivityReference();
    }
    protected void gvR5SServices_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Int64 istaffid = Convert.ToInt64(index);
                Session["ProspectRSN"] = istaffid.ToString();
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                DataSet dsInprogress = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });
                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                    lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                    //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
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
                    //lblscpgender.Text = dsCCustStatus.Tables[0].Rows[0]["Gender"].ToString();
                    lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();

                    lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                    dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(istaffid.ToString()) });

                    if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                    }
                    else if (dsInprogress.Tables[0].Rows.Count > 0)
                    {
                        lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                    }

                    DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                    new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid.ToString() });

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
            }
            else
            {
                btnR5Sservices_Click(sender, e);
            }            
        }
        catch (Exception ex)
        {
          WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnR5Sservices_Click(object sender, EventArgs e)
    {
        try
        {
            lblR5SCount.Visible = true;
            if (Convert.ToDateTime(raddateR5Sfromdate.SelectedDate) > Convert.ToDateTime(raddateR5Stodate.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvR5SServices.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR5SServices.DataSource = string.Empty;
                gvR5SServices.DataBind();
                lblR5SCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsR5SServices = new DataSet();
            dsR5SServices = null;
            DateTime? From = null;
            DateTime? To = null;
            if(chkR5Service.Checked)
            {
                From = raddateR5Sfromdate.SelectedDate;
                To = raddateR5Stodate.SelectedDate;
            }

            dsR5SServices = sqlobj.SQLExecuteDataset("proc_GetR5S_ServiceReport",
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlR5SReference.SelectedValue },
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = From },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = To }
                );

            if (dsR5SServices.Tables[0].Rows.Count > 0)
            {
                gvR5SServices.DataSource = dsR5SServices.Tables[0];
                int TypeRCount = dsR5SServices.Tables[0].Rows.Count;
                lblR5SCount.Text = "Count : " + TypeRCount.ToString();
                gvR5SServices.DataBind();
                ViewState["R5SService"] = dsR5SServices.Tables[0];
            }
            else
            {
                gvR5SServices.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvR5SServices.DataSource = dsR5SServices.Tables[0];
                gvR5SServices.DataBind();
                lblR5SCount.Text = "Count : " + 0;
                ViewState["R5SService"] = dsR5SServices.Tables[0];
            }
            gvR5SServices.Visible = true;
            dsR5SServices.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
   
    protected void btnR5SExport_Click(object sender, EventArgs e)
    {
        if (gvR5SServices.Items.Count == 0)
        {
            rwmgrR5S.RadAlert("There are no records to export", 300, 130, "R5S-Services", "");
        }
        else
        {
            if (ViewState["R5SService"] != null)
            {
                DataTable dt = (DataTable)ViewState["R5SService"];
                rwmgrR5S.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmR5SExportFn", 300, 200, null, "R5S-Services.");
            }
        }
    }
    protected void hbtnR5SServices_Click(object sender, EventArgs e)
    {
        try
        {
            if(gvR5SServices.Visible == true)
            {
                if (ViewState["R5SService"] != null)
                {
                    DataTable dt = (DataTable)ViewState["R5SService"];
                    if(dt.Columns.Contains("RSN"))
                    {
                        dt.Columns.Remove("RSN");
                        dt.AcceptChanges();
                    }
                    DataSet ds = new DataSet();
                    ds.Tables.Add(dt);
                    gridtoexcelreport(ds,"R5S-Services");
                    ds.Tables.Remove(dt);                 
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btneoduserstats_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R16-Customer tasks summary", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;        
        dvR14sysnotused.Visible = false;
        GetR14ReportDetails();

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvEODStats.Visible = false;
        dvEODCustStats.Visible = true;

        lblEODCustDate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lblEODCustBy.Text = "By : " + Session["UserID"].ToString();

        raddateEODCusfrom.SelectedDate = DateTime.Today;
        raddateEODCusto.SelectedDate = DateTime.Today;
       // LoadCustomers();


        strUserLevel = Session["UserLevel"].ToString();
        //if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
        //{
        //    ddlEODCustomers.Items.Insert(0, "All");
        //}
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;
    }
    protected void btneodcusstats_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R15-User tasks summary", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;

        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;

        divwfr3.Visible = false;
        divwfr4.Visible = false;

        divsmx2.Visible = false;
        divsmx1.Visible = false;

        divsmx5.Visible = false;



        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        //btnRtnHome.Visible = false;
        dvR14sysnotused.Visible = false;
        GetR14ReportDetails();

        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvEODStats.Visible = true;


        lbleoduserdate.Text = "Date : " + DateTime.Now.ToString("dd-MMM-yyyy HH : mm") + " Hrs";
        lbleodusertby.Text = "By : " + Session["UserID"].ToString();

        StaffID = Session["UserID"].ToString();
        //ddleodusers.DataSource = GetStaffDetails(StaffID);
        //ddleodusers.DataValueField = "StaffId";
        //ddleodusers.DataTextField = "StaffName";
        //ddleodusers.DataBind();

        strUserLevel = Session["UserLevel"].ToString();
        //if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
        //{
        //    ddleodusers.Items.Insert(0, "All");
        //}

        raddateeoduserfrom.SelectedDate = DateTime.Today;
        raddateeoduserto.SelectedDate = DateTime.Today;
        dvRefSummReport.Visible = false;
        dvDailyUsageBilllingReport.Visible = false;

    }
    public DataSet GetStaffDetails(string staffName)
    {
        SqlCommand cmd1 = new SqlCommand();
        DataSet dsStaff = new DataSet();
        cmd1.CommandText = "proc_GetStaff";
        cmd1.Connection = con;
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@staffname", staffName);
        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
        dap.Fill(dsStaff, "tblstaff");
        return dsStaff;
    }
    //public void LoadCustomers()
    //{
    //    DataSet dsCustomer = new DataSet();
    //    SQLProcs SqlProc = new SQLProcs();
    //    dsCustomer = SqlProc.SQLExecuteDataset("Proc_LoadCustomers");
    //    ddlEODCustomers.DataSource = dsCustomer.Tables[0];
    //    ddlEODCustomers.DataValueField = "RSN";
    //    ddlEODCustomers.DataTextField = "Name";
    //    ddlEODCustomers.DataBind();
    //}
    protected void BindChart(DataTable dt)
    {     
        string category="";
        decimal[] values = new decimal[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            category = category + "," + dt.Rows[i]["staffname"].ToString();
            values[i] = Convert.ToDecimal(dt.Rows[i]["YettoStart"]);         
        }
        //barchartUsers.CategoriesAxis = category.Remove(0, 1);
        //barchartUsers.Series.Add(new AjaxControlToolkit.BarChartSeries { Data = values, BarColor = "#2fd1f9", Name = "Status" });       
        
    }
    private void LoadChartData(DataTable initialDataSource)
    {        
        for (int i = 0; i < initialDataSource.Columns.Count; i++)
        {
            Series series = new Series();
            Series series1 = new Series();
            Series series2 = new Series();
           
            foreach (DataRow dr in initialDataSource.Rows)
            {
                Int64 y = Convert.ToInt64(dr[0]);
                series.Points.AddXY("YTS", y);
                //Chart1.Series.Add(series);
                Int64 w = Convert.ToInt64(dr[1]);
                series1.Points.AddXY("WIP", w);
                //Chart1.Series.Add(series1);
                Int64 c = Convert.ToInt64(dr[2]);
                series2.Points.AddXY("CTD", c);
                //Chart1.Series.Add(series2);
                //Chart1.Series["Yet to start"].YValueMembers = y;
            }
            //Chart1.Series.Add(series);
            //Chart1.Series.Add(series1);
            //Chart1.Series.Add(series2);
        }
    }
    protected void btnEODUsersearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblEODUsersCount.Visible = false;
            if (Convert.ToDateTime(raddateeoduserfrom.SelectedDate) > Convert.ToDateTime(raddateeoduserto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvEODUsersList.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODUsersList.DataSource = string.Empty;
                gvEODUsersList.DataBind();
                lblEODUsersCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsEODUsers = new DataSet();
            DataSet dsEODUsersTotal = new DataSet();
            dsEODUsers = null;
            DateTime? From = null;
            DateTime? To = null;

            //if (chkEODUsers.Checked)
            //{
               
            //}
            From = raddateeoduserfrom.SelectedDate;
            To = raddateeoduserto.SelectedDate;

          
            dsEODUsers = sqlobj.SQLExecuteDataset("Proc_GetNewEODUserStatus",
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value =From },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = To }
                );
            if(dsEODUsers.Tables[0].Rows.Count > 0)
            {
              
                gvEODUsersList.DataSource = dsEODUsers.Tables[0];
                int TypeRCount = dsEODUsers.Tables[0].Rows.Count;
                lblEODUsersCount.Text = "Count : " + TypeRCount.ToString();
                gvEODUsersList.DataBind();
                ViewState["EODUsers"] = dsEODUsers.Tables[0];
                
                dvEODUser.Visible = true;
            }
            else
            {
                gvEODUsersList.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODUsersList.DataSource = dsEODUsers.Tables[0];
                gvEODUsersList.DataBind();
                lblEODUsersCount.Text = "Count : " + 0;
                ViewState["EODUsers"] = dsEODUsers.Tables[0];
                dvEODUser.Visible = true;
            }
            gvEODUsersList.Visible = true;
            //LoadChartData(dsEODUsers.Tables[0]);
            dsEODUsers.Dispose();


            // Total



            dsEODUsersTotal = sqlobj.SQLExecuteDataset("Proc_GetNewEODUserStatusTotal",
               new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = From },
               new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = To }
               );
            if (dsEODUsers.Tables[0].Rows.Count > 0)
            {

                gvEODUsersListTotal.DataSource = dsEODUsersTotal.Tables[0];
                int TypeRCount = dsEODUsersTotal.Tables[0].Rows.Count;
                gvEODUsersListTotal.DataBind();
                ViewState["EODUsersTotal"] = dsEODUsersTotal.Tables[0];

                dvEODUser.Visible = true;
            }
            else
            {
                gvEODUsersListTotal.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODUsersListTotal.DataSource = dsEODUsersTotal.Tables[0];
                gvEODUsersListTotal.DataBind();

                ViewState["EODUsersTotal"] = dsEODUsersTotal.Tables[0];
                dvEODUser.Visible = true;
            }
            gvEODUsersListTotal.Visible = true;
            //LoadChartData(dsEODUsers.Tables[0]);
            dsEODUsersTotal.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnEODUsersExport_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvEODUsersList.Items.Count == 0)
            {
                rwmgrEODusers.RadAlert("There are no records to export", 300, 130, "EOD User Stats", "");
            }
            else
            {
                if (ViewState["EODUsers"] != null)
                {
                    DataTable dt = (DataTable)ViewState["EODUsers"];
                    rwmgrEODusers.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmEODUsersExportFn", 300, 200, null, "EOD User Stats.");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvEODUsersList_ItemCommand(object sender, GridCommandEventArgs e)
    {        
        btnEODUsersearch_Click(sender, null);
    }
    protected void btnEODCustSearch_Click(object sender, EventArgs e)
    {
        try
        {

           

            lblEODCustCount.Visible = false;
            if (Convert.ToDateTime(raddateEODCusfrom.SelectedDate) > Convert.ToDateTime(raddateEODCusto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvEODUsersList.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODUsersList.DataSource = string.Empty;
                gvEODUsersList.DataBind();
                lblEODCustCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsEODCustomers = new DataSet();

            DataSet dsEODCustomersTotal = new DataSet();
            
            dsEODCustomers = null;
            DateTime? From = null;
            DateTime? To = null;

            From = raddateEODCusfrom.SelectedDate;
            To = raddateEODCusto.SelectedDate;

            dsEODCustomersTotal = sqlobj.SQLExecuteDataset("Proc_GetNewEODCustomerStatusTotal ",
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = From },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = To }
                );

            if (dsEODCustomersTotal.Tables[0].Rows.Count > 0)
            {
                gvEODCustomerListTotal.DataSource = dsEODCustomersTotal.Tables[0];
                int TypeRCount = dsEODCustomersTotal.Tables[0].Rows.Count;
                
                gvEODCustomerListTotal.ShowFooter = true;
                gvEODCustomerListTotal.DataBind();
                ViewState["EODCustomerTotal"] = dsEODCustomersTotal.Tables[0];
            }
            else
            {
                gvEODCustomerListTotal.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODCustomerListTotal.DataSource = dsEODCustomersTotal.Tables[0];
                gvEODCustomerListTotal.DataBind();

                ViewState["EODCustomerTotal"] = dsEODCustomersTotal.Tables[0];
            }
            gvEODCustomerListTotal.Visible = true;
            gvEODCustomerListTotal.Dispose();



            dsEODCustomers = sqlobj.SQLExecuteDataset("Proc_GetNewEODCustomerStatus",
                new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = From },
                new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = To }
                );

            if (dsEODCustomers.Tables[0].Rows.Count > 0)
            {
                gvEODCustomerList.DataSource = dsEODCustomers.Tables[0];
                int TypeRCount = dsEODCustomers.Tables[0].Rows.Count;
                lblEODCustCount.Text = "Count : " + TypeRCount.ToString();
                gvEODCustomerList.ShowFooter = true;
                gvEODCustomerList.DataBind();
                ViewState["EODCustomer"] = dsEODCustomers.Tables[0];
            }
            else
            {
                gvEODCustomerList.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvEODCustomerList.DataSource = dsEODCustomers.Tables[0];
                gvEODCustomerList.DataBind();
                lblEODCustCount.Text = "Count : " + 0;
                ViewState["EODCustomer"] = dsEODCustomers.Tables[0];
            }
            gvEODCustomerList.Visible = true;
            dsEODCustomers.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnEODCustExport_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvEODCustomerList.Items.Count == 0)
            {
                rwmgrEODCustomer.RadAlert("There are no records to export", 300, 130, "EOD Customer Stats", "");
            }
            else
            {
                if (ViewState["EODCustomer"] != null)
                {
                    DataTable dt = (DataTable)ViewState["EODCustomer"];
                    rwmgrEODCustomer.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmEODCustomerExportFn", 300, 200, null, "EOD Customer Stats");
                }
            }
        }
        catch (Exception ex)
        {
             WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void hbtnEODUsers_Click(object sender, EventArgs e)
    {
        try
        {            
            if (ViewState["EODUsers"] != null)
            {
                DataTable dtEODUsers = null;
                dtEODUsers = (DataTable)ViewState["EODUsers"];
                //Data(dtEODUsers, "EODUserStats");
                DatatabletoExcel(dtEODUsers, "EODUserStats");
            }
           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void hbtnEODCustomers_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["EODCustomer"] != null)
            {
                DataTable dtEODCustomers = null;
                dtEODCustomers = (DataTable)ViewState["EODCustomer"];
                DatatabletoExcel(dtEODCustomers, "EODCustomerStats");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void gvEODCustomerList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        btnEODCustSearch_Click(sender, null);
    }
    protected void btnCompRepSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblCompReportCount.Visible = false;
            if (Convert.ToDateTime(raddatecompreportfrom.SelectedDate) > Convert.ToDateTime(raddatecompreportto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvCompreport.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvCompreport.DataSource = string.Empty;
                gvCompreport.DataBind();
                lblCompReportCount.Text = "Count : " + 0;
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCompReport = new DataSet();
            dsCompReport = null;

            string From = null;
            string To = null;

          
            dsCompReport = sqlobj.SQLExecuteDataset("GetComplaintsServiceReportNew",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = raddatecompreportfrom.SelectedDate.Value },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = raddatecompreportto.SelectedDate.Value }
              );


            if (dsCompReport.Tables[0].Rows.Count > 0)
            {
                gvCompreport.AllowPaging = true;
                gvCompreport.DataSource = dsCompReport.Tables[0];
                int TypeRCount = dsCompReport.Tables[0].Rows.Count;
                lblCompReportCount.Text = "Count : " + TypeRCount.ToString();                
                gvCompreport.DataBind();
                ViewState["CompReport"] = dsCompReport.Tables[0];
            }
            else
            {
                gvCompreport.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvCompreport.DataSource = dsCompReport.Tables[0];
                gvCompreport.DataBind();
                lblCompReportCount.Text = "Count : " + 0;
                ViewState["CompReport"] = dsCompReport.Tables[0];
            }
            gvCompreport.Visible = true;
            dsCompReport.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnComReportExport_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvCompreport.Items.Count == 0)
            {
                rwmgrComReport.RadAlert("There are no records to export", 300, 130, "EOD Customer Stats", "");
            }
            else
            {
                if (ViewState["CompReport"] != null)
                {
                    DataTable dt = (DataTable)ViewState["CompReport"];
                    rwmgrComReport.RadConfirm("No. of records selected " + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmCompReportExportFn", 300, 200, null, "Service status Report");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void hbtnCompReport_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["CompReport"] != null)
            {
                DataTable CompReport = null;
                CompReport = (DataTable)ViewState["CompReport"];
                DatatabletoExcel(CompReport, "Service status Report");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnCompSerRep_Click(object sender, EventArgs e)
    {

        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "R17-Service tasks summary", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;
        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;
        divwfr3.Visible = false;
        divwfr4.Visible = false;
        divsmx2.Visible = false;
        divsmx1.Visible = false;
        divsmx5.Visible = false;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;
        dvMainSMReports.Visible = true;
        dvR14sysnotused.Visible = false;       
        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvEODStats.Visible = false;
        dvEODCustStats.Visible = false;
        dvCompReport.Visible = true;

        raddatecompreportfrom.SelectedDate = DateTime.Today;
        raddatecompreportto.SelectedDate = DateTime.Today;
        dvRefSummReport.Visible = false;
        SQLProcs sqlobj = new SQLProcs();
        dvDailyUsageBilllingReport.Visible = false;
        DataSet dsCompReport = new DataSet();
        
        dsCompReport = sqlobj.SQLExecuteDataset("GetComplaintsServiceReportNew",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = raddatecompreportfrom.SelectedDate.ToString() },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.DateTime, Value = raddatecompreportto.SelectedDate.ToString() }
              );

        if (dsCompReport != null)
        { 

        if (dsCompReport.Tables[0].Rows.Count > 0)
        {
            gvCompreport.AllowPaging = false;
            gvCompreport.DataSource = dsCompReport.Tables[0];
            int TypeRCount = dsCompReport.Tables[0].Rows.Count;
            
            gvCompreport.DataBind();
                     
        }
        else
        {
            gvCompreport.MasterTableView.ShowHeadersWhenNoRecords = true;
            gvCompreport.DataSource = dsCompReport.Tables[0];
            gvCompreport.DataBind();
            
        }
        dsCompReport.Dispose();
        }
        
        gvCompreport.Visible = true;
        
    }
    protected void gvCompreport_ItemCommand(object sender, GridCommandEventArgs e)
    {
        btnCompRepSearch_Click(sender, null);
    }
    protected void btnRefsummreport_Click(object sender, EventArgs e)
    {
        UserMenuLog uml = new UserMenuLog();
        uml.InsertUserMenuLog(Session["UserID"].ToString(), "Reference Summary Report", DateTime.Now);

        divMR4.Visible = false;
        divMR1.Visible = false;
        divMR3.Visible = false;
        dvMarkettingAct.Visible = false;
        dvGeneralActivity.Visible = false;
        dvServiceActivity.Visible = false;
        divwfr2.Visible = false;
        divwfr3.Visible = false;
        divwfr4.Visible = false;
        divsmx2.Visible = false;
        divsmx1.Visible = false;
        divsmx5.Visible = false;

        dvROL.Visible = false;
        dvR12TimeSummary.Visible = false;
        dvR13TimeDetailed.Visible = false;
        dvR14sysnotused.Visible = false;

        dvHeaderMenu.Visible = false;       
        dvR14sysnotused.Visible = false;
        dvR4EnqRegistered.Visible = false;
        dvR4OrdersBooked.Visible = false;
        dvR4QuoateSubmitted.Visible = false;

        dvR5SServiceReport.Visible = false;
        dvEODStats.Visible = false;
        dvEODCustStats.Visible = false;
        dvCompReport.Visible = false;

        dvMainSMReports.Visible = true;
        dvRefSummReport.Visible = true;
        dvDailyUsageBilllingReport.Visible = false;

        raddaterefsummfrom.SelectedDate = DateTime.Today;
        raddaterefsummto.SelectedDate = DateTime.Today;
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsRefSumm = new DataSet();
        dsRefSumm = null;
        dsRefSumm = sqlobj.SQLExecuteDataset("GetReferenceSummaryReport",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.VarChar, Value = raddaterefsummfrom.SelectedDate.ToString() },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.VarChar, Value = raddaterefsummto.SelectedDate.ToString() }
              );


        if (dsRefSumm.Tables[0].Rows.Count > 0)
        {
            gvRefSummDetails.AllowPaging = false;
            gvRefSummDetails.DataSource = dsRefSumm.Tables[0];
            gvRefSummDetails.DataBind();            
            ViewState["RefSummary"] = dsRefSumm.Tables[0];
        }
        else
        {
            gvRefSummDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
            gvRefSummDetails.DataSource = dsRefSumm.Tables[0];
            gvRefSummDetails.DataBind();
            ViewState["RefSummary"] = dsRefSumm.Tables[0];
        }
        gvRefSummDetails.Visible = true;
        dsRefSumm.Dispose();
    }
    protected void btnRefSummSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToDateTime(raddaterefsummfrom.SelectedDate) > Convert.ToDateTime(raddaterefsummto.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the From and Till date');", true);
                gvRefSummDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvRefSummDetails.DataSource = string.Empty;
                gvRefSummDetails.DataBind();
                return;
            }

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsRefSumm = new DataSet();
            dsRefSumm = null;

            string From = null;
            string To = null;

            From = raddaterefsummfrom.SelectedDate.ToString();
            To = raddaterefsummto.SelectedDate.ToString();

            if (To.Contains("00:00:00"))
            {
                To = To.Replace("00:00:00", "23:59:59");
            }

            dsRefSumm = sqlobj.SQLExecuteDataset("GetReferenceSummaryReport",
              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.VarChar, Value = From },
              new SqlParameter() { ParameterName = "@Todate", SqlDbType = SqlDbType.VarChar, Value = To }
              );

            gvRefSummDetails.AllowPaging = true;
            if (dsRefSumm.Tables[0].Rows.Count > 0)
            {
                gvRefSummDetails.DataSource = dsRefSumm.Tables[0];
                gvRefSummDetails.DataBind();
                ViewState["RefSummary"] = dsRefSumm.Tables[0];
            }
            else
            {
                gvRefSummDetails.MasterTableView.ShowHeadersWhenNoRecords = true;
                gvRefSummDetails.DataSource = dsRefSumm.Tables[0];
                gvRefSummDetails.DataBind();
                ViewState["RefSummary"] = dsRefSumm.Tables[0];
            }
            gvRefSummDetails.Visible = true;
            dsRefSumm.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnRefSummExport_Click(object sender, EventArgs e)
    {
        try
        {
            if (gvRefSummDetails.Items.Count == 0)
            {
                rwRefsumm.RadAlert("There are no records to export", 300, 130, "Reference Summary Report", "");
            }
            else
            {
                if (ViewState["RefSummary"] != null)
                {
                    DataTable dt = (DataTable)ViewState["RefSummary"];
                    rwRefsumm.RadConfirm("No. of records selected :" + dt.Rows.Count + " <br/>Do you wish to export these as a spreadsheet file?", "confirmRefReportExportFn", 300, 200, null, "Reference Summary Report");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void hbtnRefSummReport_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["RefSummary"] != null)
            {
                DataTable RefReport = null;
                RefReport = (DataTable)ViewState["RefSummary"];
                DatatabletoExcel(RefReport, "Reference Summary Report");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void gvRefSummDetails_ItemCommand(object sender, GridCommandEventArgs e)
    {
        btnRefSummSearch_Click(sender, null);
    }
    protected void btnAppointmentReport_Click(object sender, EventArgs e)
    {
        try
        {
            dvHeaderMenu.Visible = false;
            dvMainSMReports.Visible = false;
            //pnlCalender.BorderColor = Color.Blue;
            //pnlCalender.BorderStyle = BorderStyle.Solid;
            //pnlCalender.BorderWidth = 5;
            //pnlCalender.Height = 400;
            Button1.Visible = true;           
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    public class Event
    {
        public int? EventID { get; set; }
        public string EventName { get; set; }
        public string StartDate { get; set; }
        //public string EndDate { get; set; }
    }
    [WebMethod]
    public static List<Event> GetEvents()
    {
        List<Event> events;

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        SqlCommand cmd = new SqlCommand("AppointmentEventsAllDays", con);
        cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@date", DateTime.Today);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        events = new List<Event>();
        if (dr.HasRows)
        {
            int i = 0;
            while (dr.Read())
            {
                i = i + 1;
                Event _Event = new Event();
                DateTime dtStart = Convert.ToDateTime(dr["Followupdate"]);
                DateTime dtTest = DateTime.Now;

                string formattedDate = dtStart.ToString("MM/dd/yyyy");

                _Event.EventID = i;
                _Event.EventName = dr["Event"].ToString();
                _Event.StartDate = dtStart.DayOfWeek + "," + formattedDate;
                //string test = DateTime.Now.DayOfWeek + ", " + DateTime.Now.AddDays(i + 2).ToString();
                events.Add(_Event);
            }
        }
        dr.Close();
        con.Close();
        //HttpContext.Current.Session["events"] = events;
        return events;
    }

    //protected void btnShowAppointment_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        DateTime test = mnth.StartDate;
    //        SQLProcs sqlobj = new SQLProcs();
    //        DataSet dsEvents = new DataSet();
    //        dsEvents = sqlobj.SQLExecuteDataset("AppointmentEvents",
    //            new SqlParameter() { ParameterName = "@date", SqlDbType = SqlDbType.DateTime, Value = test });
    //        if (dsEvents.Tables[0].Rows.Count > 0)
    //        {
    //            MonthPicker1.DataSource = dsEvents;
    //            MonthPicker1.DataTextField = "Event";
    //            MonthPicker1.DataValueField = "Event";
    //            MonthPicker1.DataStartField = "Followupdate";
    //            MonthPicker1.DataEndField = "Followupdate";               
    //            MonthPicker1.DataBind();
    //        }
    //        else
    //        {
    //            MonthPicker1.DataSource = null;
    //            MonthPicker1.DataBind();
    //        }
    //        dsEvents.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //} 

    protected void btnDailyUsageBillingReport_Click(object sender, EventArgs e)
    {

        try
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Daily Usage Biling", DateTime.Now);

            divMR4.Visible = false;
            divMR1.Visible = false;
            divMR3.Visible = false;
            dvMarkettingAct.Visible = false;
            dvGeneralActivity.Visible = false;
            dvServiceActivity.Visible = false;
            divwfr2.Visible = false;
            divwfr3.Visible = false;
            divwfr4.Visible = false;
            divsmx2.Visible = false;
            divsmx1.Visible = false;
            divsmx5.Visible = false;

            dvROL.Visible = false;
            dvR12TimeSummary.Visible = false;
            dvR13TimeDetailed.Visible = false;
            dvR14sysnotused.Visible = false;

            dvHeaderMenu.Visible = false;
            dvR14sysnotused.Visible = false;
            dvR4EnqRegistered.Visible = false;
            dvR4OrdersBooked.Visible = false;
            dvR4QuoateSubmitted.Visible = false;

            dvR5SServiceReport.Visible = false;
            dvEODStats.Visible = false;
            dvEODCustStats.Visible = false;
            dvCompReport.Visible = false;

            dvMainSMReports.Visible = true;
            dvRefSummReport.Visible = false;
            dvDailyUsageBilllingReport.Visible = true;

            ReportList.DataSource = string.Empty;
            ReportList.DataBind();

            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);


            dtpfordate.SelectedDate = sd;
            dtpuntildate.SelectedDate = DateTime.Now;

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadUsageBilling()
    {
        try
        {

            DataSet dsStatement = sqlobj.SQLExecuteDataset("SP_UsageBilling",

                 new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                 new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                 );

            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnShow_Click(object sender, EventArgs e)
    {
        LoadUsageBilling();
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {



            DataSet dsStatement = sqlobj.SQLExecuteDataset("SP_UsageBilling",

                  new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                  new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                  );


            if (dsStatement.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStatement.Tables[0];
                dg.DataBind();

                DateTime sdate = dtpfordate.SelectedDate.Value;
                DateTime edate = dtpuntildate.SelectedDate.Value;

                // THE EXCEL FILE.
                string sFileName = "Daily Usage Billing From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
                sFileName = sFileName.Replace("/", "");

                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

                dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                Response.Write("<table><tr><td>Daily Usage Billing</td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " daily usage billing does not exist");
            }
        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }

    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadUsageBilling();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}
   