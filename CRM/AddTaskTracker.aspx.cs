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
using System.Net.Mail;

public partial class AddTaskTracker : System.Web.UI.Page
{
    public static int i;
    public static int j = 1;
    public static int TaskCnt;
    public static string TID;
    public static string StaffID;
    public static int custrsn;
    public static string[] strRSN;
    SQLProcs sqlobj = new SQLProcs();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {          

            rwHelp.VisibleOnPageLoad = true;
            rwHelp.Visible = false;

            rwSaveTime.VisibleOnPageLoad = true;
            rwSaveTime.Visible = false;

            rwReferenceHelp.VisibleOnPageLoad = true;
            rwReferenceHelp.Visible = false;

            rwMobileApp.VisibleOnPageLoad = true;
            rwMobileApp.Visible = false;

            rwCustomerProfile.VisibleOnPageLoad = true;
            rwCustomerProfile.Visible = false;

            dtpFollowupDate.MinDate = DateTime.Today;

            if (!IsPostBack)
            {
                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }


                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Task Tracker", DateTime.Now);

                if(Request.QueryString["RSN"] != "")
                {
                    strRSN = null;
                    strRSN = Request.QueryString["RSN"].ToString().Split(',');
                    custrsn = Convert.ToInt32(strRSN[0]);                    
                }

                int count = 1;
                i = 0;
              
                string TaskID = Session["TaskID"].ToString();
                string[] STaskID = TaskID.Split(',');
                TID = STaskID[i];
                TaskCnt = STaskID.Count();
                ViewState["TaskCount"] = count;
                if (TaskCnt > 1)
                {
                    Button1.Visible = true;

                }
                else
                {
                    Button1.Visible = false;
                }

                LoadStaffID(TID);
                HFTrackID.Value = TID;
                LoadPriority();

                LoadTrackOn();

                LoadAssignedTo();

                LoadDesc();
                ENCustStatus();

                LoadSaveTime();
                LoadStatus();
                LoadProjectStatus();
                LoadHrs();
                LoadMins();

                HDTaskID.Value = HFTrackID.Value;


                ddlCustStatus.SelectedValue = HDCustStatus.Value.ToString();

                if (HDCustStatus.Value == "OREG" || HDCustStatus.Value == "1ENQ" || HDCustStatus.Value == "3ASE" ||
                    HDCustStatus.Value == "5QLD" || HDCustStatus.Value == "XCLD" || HDCustStatus.Value == "ZDRD")
                {
                    lblalert.Visible = true;
                }
                else
                {
                    lblalert.Visible = false;
                }


                if (ddlCustStatus.SelectedValue == "7CUS" || ddlCustStatus.SelectedValue == "OTHR" || ddlCustStatus.SelectedValue == "VNDR")
                {
                    chkEditStatus.Visible = false;
                    chkEditCustomer.Visible = false;
                }
                else
                {
                    chkEditStatus.Visible = true;
                    chkEditCustomer.Visible = true;
                }
                string strUserLevel = Session["UserLevel"].ToString();
                if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
                {
                    ddlpriority.Enabled = true;
                    ddlCustStatus.Enabled = false;
                    btnSTSave.Visible = true;                   
                }
                else
                {
                    ddlpriority.Enabled = false;
                    ddlCustStatus.Enabled = false;
                    btnSTSave.Visible = false;
                    ddlAssignedTo.Visible = false;
                    Label15.Visible = false; //Assigned To
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnCPClose_Click(object sender, EventArgs e)
    {
        rwCustomerProfile.Visible = false;
    }
    private void LoadCustomerProfile(int customerrsn)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn });

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
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(customerrsn) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities in progress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
           new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn });

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


                DataSet dsServices = sqlobj.SQLExecuteDataset("SP_LoadServices",
           new SqlParameter() { ParameterName = "@Prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn });

                if (dsServices.Tables[0].Rows.Count > 0)
                {
                    gvrwservices.DataSource = dsServices;
                    gvrwservices.DataBind();
                }
                else
                {
                    gvrwservices.DataSource = null;
                    gvrwservices.DataBind();
                }

                dsServices.Dispose();

                rwCustomerProfile.Visible = true;

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void LoadAssignedTo()
    {

        DataSet dsAssignedTo = new DataSet();
        dsAssignedTo = sqlobj.SQLExecuteDataset("SP_FetchStaffDetails",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

        ddlAssignedTo.Items.Clear();

        ddlAssignedTo.DataSource = dsAssignedTo.Tables[0];
        ddlAssignedTo.DataValueField = "UserID";
        ddlAssignedTo.DataTextField = "UserName";
        ddlAssignedTo.DataBind();
        //ddlAssignedTo.SelectedValue = UserID;
        //ddlAssignedTo.Items.Insert(0, "");
        dsAssignedTo.Dispose();
    }

    protected void LoadStaffID(string TID)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();
        dsStaus = sqlobj.SQLExecuteDataset("SP_ActivityDesc",
            new SqlParameter() { ParameterName = "@ActivityID", SqlDbType = SqlDbType.Decimal, Value = TID });
        if (dsStaus != null && dsStaus.Tables[0].Rows.Count != 0)
        {
            StaffID = dsStaus.Tables[0].Rows[0]["UserID"].ToString();
            // Session["UserID"] = dsStaus.Tables[0].Rows[0]["UserID"].ToString();
        }
    }

    protected void ENCustStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustStatus = new DataSet();
        //string CustFID = HDUserId.Value;
        string CustFID = StaffID;
        string RCustStatus;
        dsCustStatus = sqlobj.SQLExecuteDataset("SP_FetchCustStatus",
            new SqlParameter() { ParameterName = "@EmpCode", SqlDbType = SqlDbType.NVarChar, Value = CustFID.Trim() });
        if (dsCustStatus != null && dsCustStatus.Tables[0].Rows.Count != 0)
        {
            RCustStatus = dsCustStatus.Tables[0].Rows[0]["StatusFlag"].ToString();
        }
        else
        {
            RCustStatus = "";
        }
        if (RCustStatus == "Y")
        {
            ddlCustStatus.Enabled = true;
        }
        else
        {
            ddlCustStatus.Enabled = false;
        }
        dsCustStatus.Dispose();
    }

    protected void LoadPriority()
    {
        DataSet dsPriority = new DataSet();
        dsPriority = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 10 });
        ddlpriority.DataSource = dsPriority.Tables[0];
        ddlpriority.DataValueField = "CodeValue";
        ddlpriority.DataTextField = "CodeDesc";
        ddlpriority.DataBind();
        ddlpriority.SelectedIndex = 3;
        dsPriority.Dispose();
    }
    //protected void loadActivityDesc(Decimal ActivityID)
    //{
    //    SQLProcs sqlobj = new SQLProcs();
    //    DataSet dsStaus = new DataSet();
    //    dsStaus = sqlobj.SQLExecuteDataset("SP_ActivityDesc",
    //        new SqlParameter() { ParameterName = "@ActivityID", SqlDbType = SqlDbType.Decimal, Value = ActivityID });
    //     string RDesc =  dsStaus.Tables[0].Rows[0]["ADesc"].ToString();
    //     return RDesc;

    //}

    protected void LoadDesc()
    {
        string CustomerName;
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();


        ddlFromHrs.SelectedIndex = 0;
        ddlToHrs.SelectedIndex = 0;
        ddlFromMin.SelectedIndex = 0;
        ddlToMin.SelectedIndex = 0;

        dsStaus = sqlobj.SQLExecuteDataset("SP_ActivityDesc",
            new SqlParameter() { ParameterName = "@ActivityID", SqlDbType = SqlDbType.Decimal, Value = HFTrackID.Value });
        if (dsStaus != null && dsStaus.Tables[0].Rows.Count != 0)
        {
            string ActivityDesc = dsStaus.Tables[0].Rows[0]["ADesc"].ToString();
            //lblTaskID.Text = Request.QueryString["TTID"].ToString() + " - " + ActivityDesc;
            //lblTaskID.Text = dsStaus.Tables[0].Rows[0]["UserID"].ToString() + " - " + ActivityDesc;
            //lblTaskID.Text = ActivityDesc;

            HDAssignTo.Value = dsStaus.Tables[0].Rows[0]["UserID"].ToString();
            HDAssignBy.Value = dsStaus.Tables[0].Rows[0]["AssignedBy"].ToString();

            ddlAssignedTo.SelectedValue = HDAssignTo.Value;

            ViewState["ATo"] = ddlAssignedTo.SelectedValue; 


            string straby = dsStaus.Tables[0].Rows[0]["ABy"].ToString(); ;
            string userid = Session["UserID"].ToString();

            if (straby.ToLower()  == userid.ToLower())
            {
                ddlAssignedTo.Enabled = true;
            }
            else
            {
                ddlAssignedTo.Enabled = false; 
            }

        }

        if (dsStaus == null && dsStaus.Tables[0].Rows.Count == 0 && dsStaus.Tables[0].Rows[0]["Customer"].ToString() == string.Empty)
        {
            CustomerName = "-";
        }
        else
        {
            CustomerName = dsStaus.Tables[0].Rows[0]["Customer"].ToString();
            Session["CustomerID"] = dsStaus.Tables[0].Rows[0]["Customer"].ToString();

        }


        //lblCustomer.Text = CustomerName;

        LoadCustomerName();

        DataSet dstrackon = sqlobj.SQLExecuteDataset("SP_GetCurrentReferenceGroupwise",
            new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = dsStaus.Tables[0].Rows[0]["AssigneeCommnts"].ToString() });



        if (dstrackon.Tables[0].Rows.Count > 0)
        {
            ddlTrackOn.DataSource = dstrackon;
            ddlTrackOn.DataTextField = "TrackOnDesc";
            ddlTrackOn.DataValueField = "TrackOnDesc";
            ddlTrackOn.DataBind();
        }

        dstrackon.Dispose();


        ddlTrackOn.SelectedValue = dsStaus.Tables[0].Rows[0]["AssigneeCommnts"].ToString();

        DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
            new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue });

        if (dsremarks.Tables[0].Rows.Count > 0)
        {
            if (dsremarks.Tables[0].Rows[0]["Trackonremarks"].ToString() != null)
            {
                lblcrefremarks.Text = dsremarks.Tables[0].Rows[0]["Trackongroup"].ToString() + "-" + dsremarks.Tables[0].Rows[0]["Trackonremarks"].ToString();
                lblcrefremarks.Visible = true;
            }
            else
            {
                lblcrefremarks.Visible = false;
            }
        }

        dsremarks.Dispose();




        DataSet dscustomercount = sqlobj.SQLExecuteDataset("SP_GetCustomerCount",
           new SqlParameter() { ParameterName = "@CustomerRSN", SqlDbType = SqlDbType.BigInt, Value = Session["CustomerID"].ToString() });


        if (dscustomercount.Tables[0].Rows.Count > 1)
        {
            lblcustomercount.Text = "Caution: No.of other activities in progress for this Customer are : " + dscustomercount.Tables[0].Rows.Count;
            lblcustomercount.Visible = true;
            lblcaution.Visible = true;
        }
        else
        {
            lblcustomercount.Visible = false;
            lblcaution.Visible = false;
        }

        lblSTaskID.Text = HFTrackID.Value.ToString();
        HDCustStatus.Value = dsStaus.Tables[0].Rows[0]["CustStatus"].ToString();
        lblAssignedOn.Text = dsStaus.Tables[0].Rows[0]["AssignedOn"].ToString();
        lblAssignedBy.Text = dsStaus.Tables[0].Rows[0]["AssignedBy"].ToString();
      
        //lblOtherAssignees.Text = dsStaus.Tables[0].Rows[0]["OtherAssignees"].ToString();
        lblStatus2.Text = dsStaus.Tables[0].Rows[0]["Status"].ToString();
        lblPriority.Text = dsStaus.Tables[0].Rows[0]["Priority"].ToString();
        ddlpriority.SelectedItem.Text = dsStaus.Tables[0].Rows[0]["Priority"].ToString();
        //lblComplexity.Text = dsStaus.Tables[0].Rows[0]["Complexity"].ToString();
        lblTargetDate.Text = dsStaus.Tables[0].Rows[0]["TargetDate"].ToString();
        //lblOtherRemarks.Text = dsStaus.Tables[0].Rows[0]["OtherRemarks"].ToString();
        HDStatusCode.Value = string.Empty;
        HDStatusCode.Value = dsStaus.Tables[0].Rows[0]["StatusCode"].ToString();


        //ddlStatus.SelectedIndex = Convert.ToInt16(dsStaus.Tables[0].Rows[0]["StatusCode"].ToString());

        //LoadTaskTrackDet(Request.QueryString["TTID"].ToString());


        DataSet dsfollowupdate = sqlobj.SQLExecuteDataset("sp_getfollowupdate",
         new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value });


        if (dsfollowupdate.Tables[0].Rows.Count > 0)
        {

            lblAssignedTo.Text = dsfollowupdate.Tables[0].Rows[0]["Followupdate"].ToString();

        }
        
        
        LoadTaskTrackDet(HFTrackID.Value.ToString());



        if (ddlTrackOn.SelectedValue == "#MobileApp")
        {

            lblcurrentcustomer.Text = CustomerName.ToString();

            
           

            LoadCurrentCustomer(Session["CustomerID"].ToString());

            LoadReference();

            rwMobileApp.Visible = true;
        }

    }

    protected void LoadStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();
        dsStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 });
        ddlStatus.DataSource = dsStaus.Tables[0];
        ddlStatus.DataValueField = "StatusCode";
        ddlStatus.DataTextField = "StatusName";
        ddlStatus.DataBind();
        if (HDStatusCode.Value == "00")
        {
            ddlStatus.SelectedValue = "01";
        }
        else
        {
            ddlStatus.SelectedValue = HDStatusCode.Value;
        }
        if (ddlStatus.SelectedValue == "98" || ddlStatus.SelectedValue == "99")
        {
            ddlStatus.Enabled = false;
        }
        else
        {
            ddlStatus.Enabled = true;
        }
        dsStaus.Dispose();
    }

    protected void LoadTrackOn()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();
        dsStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 });
        ddlTrackOn.DataSource = dsStaus.Tables[0];
        ddlTrackOn.DataTextField = "TrackGroup";
        ddlTrackOn.DataValueField = "TrackOnDesc";
        ddlTrackOn.DataBind();
        ddlTrackOn.Dispose();
    }

    protected void LoadProjectStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustStaus = new DataSet();
        dsCustStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 });
        ddlCustStatus.Items.Clear();
        ddlCustStatus.DataSource = dsCustStaus.Tables[0];
        ddlCustStatus.DataValueField = "StatusCode";
        ddlCustStatus.DataTextField = "StatusName";
        ddlCustStatus.DataBind();
        if (HDCustStatus.Value != null)
        {

            ddlCustStatus.SelectedValue = HDCustStatus.Value;
        }
        else
        {
            ddlCustStatus.SelectedValue = "01";
        }

        dsCustStaus.Dispose();
    }

    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true;
    }

    protected void LoadCurrentCustomer(string CustomerID)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCustStaus = new DataSet();
            dsCustStaus = sqlobj.SQLExecuteDataset("SP_GetCustomerName",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["CustomerID"].ToString()) });

            if (dsCustStaus.Tables[0].Rows.Count > 0)
            {
                lblcurrentcustomer.Text = dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
                ddlType.SelectedValue = dsCustStaus.Tables[0].Rows[0]["Type"].ToString();

                LoadCustomer();

                ddlCustName.SelectedValue = CustomerID.ToString(); 
            }

            dsCustStaus.Dispose();
        
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);  
        }
    }


    protected void LoadNewCustomerName(string rsn)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustStaus = new DataSet();
        dsCustStaus = sqlobj.SQLExecuteDataset("SP_GetCustomerName",
            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(rsn.ToString()) });

        if (dsCustStaus.Tables[0].Rows.Count > 0)
        {

            lblMobile.Text = dsCustStaus.Tables[0].Rows[0]["Mobile"].ToString();
            lblEmail.Text = dsCustStaus.Tables[0].Rows[0]["Email"].ToString();

            string strType = dsCustStaus.Tables[0].Rows[0]["Type"].ToString();

            ViewState["CName"] = dsCustStaus.Tables[0].Rows[0]["Name"].ToString();

            if (strType == "CUSTOMER")
            {
                lblCustomer.ForeColor = Color.Green;

                lblCustomer.Text = "CUSTOMER: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "PROSPECT")
            {
                lblCustomer.ForeColor = Color.Maroon;

                lblCustomer.Text = "PROSPECT: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "VENDOR")
            {
                lblCustomer.ForeColor = Color.Blue;

                lblCustomer.Text = "VENDOR: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "OTHER")
            {
                lblCustomer.ForeColor = Color.Blue;

                lblCustomer.Text = "OTHER: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }

            Session["CustomerID"] = dsCustStaus.Tables[0].Rows[0]["RSN"].ToString();
            ddlCustStatus.SelectedValue = dsCustStaus.Tables[0].Rows[0]["Status"].ToString();
            Session["Status"] = dsCustStaus.Tables[0].Rows[0]["Status"].ToString();
        }
        else
        {
            Session["CustomerName"] = "*******";

        }


    }

    protected void LoadCustomerName()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCustStaus = new DataSet();
        dsCustStaus = sqlobj.SQLExecuteDataset("SP_GetCustomerName",
            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["CustomerID"].ToString()) });

        if (dsCustStaus.Tables[0].Rows.Count > 0)
        {

            lblMobile.Text = dsCustStaus.Tables[0].Rows[0]["Mobile"].ToString();
            lblEmail.Text = dsCustStaus.Tables[0].Rows[0]["Email"].ToString();

            string strType = dsCustStaus.Tables[0].Rows[0]["Type"].ToString();

            ViewState["CName"] = dsCustStaus.Tables[0].Rows[0]["Name"].ToString();

            if (strType == "CUSTOMER")
            {
                lblCustomer.ForeColor = Color.Green;

                lblCustomer.Text = "CUSTOMER: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "PROSPECT")
            {
                lblCustomer.ForeColor = Color.Maroon;

                lblCustomer.Text = "PROSPECT: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "VENDOR")
            {
                lblCustomer.ForeColor = Color.Blue;

                lblCustomer.Text = "VENDOR: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }
            else if (strType == "OTHER")
            {
                lblCustomer.ForeColor = Color.Blue;

                lblCustomer.Text = "OTHER: " + dsCustStaus.Tables[0].Rows[0]["Name"].ToString();
            }

            Session["CustomerID"] = dsCustStaus.Tables[0].Rows[0]["RSN"].ToString();
            ddlCustStatus.SelectedValue = dsCustStaus.Tables[0].Rows[0]["Status"].ToString();
            Session["Status"] = dsCustStaus.Tables[0].Rows[0]["Status"].ToString();
        }
        else
        {
            Session["CustomerName"] = "*******";

        }


    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();
        String WBTimespent;
        if (CnfResult.Value == "true")
        {
            if (txtTrackerComments.Text != String.Empty && HDAssignTo.Value != string.Empty)
            {

                string Value;
                string TimeSpent;
                if (txtValue.Text == string.Empty)
                {
                    Value = "0";
                }
                else
                {
                    Value = txtValue.Text;
                }

                if (txtTimeSpent.Text == string.Empty)
                {
                    TimeSpent = "0";
                }
                else
                {
                    TimeSpent = txtTimeSpent.Text;
                }
                try
                {
                    DateTime? ScheduleDate;

                    if (HFTimeSpent.Value.ToString() == string.Empty || HFTimeSpent.Value.ToString() == " ")
                    {
                        WBTimespent = " ";

                    }
                    else
                    {
                        WBTimespent = " (" + HFTimeSpent.Value.ToString() + ")";
                    }


                    //Existing followup checking

                    string strfollowupdate = "";

                    DataSet dsfollowupdate = new DataSet();

                    dsfollowupdate = sqlobj.SQLExecuteDataset("sp_getfollowupdate",
                       new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value });

                    if (dsfollowupdate.Tables[0].Rows.Count > 0)
                    {
                        Session["Followupdate"] = dsfollowupdate.Tables[0].Rows[0]["Followupdate"].ToString();
                    }


                    string fsflag = "";

                    DataSet dsflag = sqlobj.SQLExecuteDataset("SP_GetStatusFlag",
        new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue });


                    if (dsflag.Tables[0].Rows.Count > 0)
                    {
                        fsflag = dsflag.Tables[0].Rows[0]["FinalStatusflag"].ToString();
                    }

                    dsflag.Dispose();


                    string strsessionid = Session["UserID"].ToString();
                    string strcusid = Session["CustomerID"].ToString();

                    sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrackWD",
                                   new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = HFTrackID.Value },
                                   new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = txtTrackerComments.Text + WBTimespent },
                        //new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = HDAssignBy.Value },
                                   new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                   new SqlParameter() { ParameterName = "@FollowupDate", SqlDbType = SqlDbType.DateTime, Value = dtpFollowupDate.SelectedDate == null ? null : dtpFollowupDate.SelectedDate },
                                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = fsflag.ToString() == "True" ? "98" : ddlStatus.SelectedValue },
                                   new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = Value },
                                   new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue },
                                   new SqlParameter() { ParameterName = "@TimeSpent", SqlDbType = SqlDbType.Decimal, Value = TimeSpent },
                                   new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = HDAssignTo.Value },
                                   new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(Session["CustomerID"].ToString()) },
                                   new SqlParameter() { ParameterName = "@ProjectStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                                   new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue },
                                   new SqlParameter() { ParameterName = "@CMail", SqlDbType = SqlDbType.NVarChar, Value = ddlcmail.SelectedValue  }

                                   );


                    if (ViewState["ATo"].ToString() != ddlAssignedTo.SelectedValue)
                    {

                        sqlobj.ExecuteSQLNonQuery("SP_UpdateAssignedTo",
                                   new SqlParameter() { ParameterName = "@ATo", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedTo.SelectedValue },
                                   new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value }
                                   );
                    }


                   


                    if (dtpFollowupDate.SelectedDate != null)
                    {

                        SendmailWithIcsAttachment(HDAssignTo.Value, ViewState["CName"].ToString(), ddlTrackOn.SelectedValue, txtTrackerComments.Text, Convert.ToDateTime(dtpFollowupDate.SelectedDate));

                    }



                    string strPreviousStatus = Session["Status"].ToString();
                    string strCurrentStatus = ddlCustStatus.SelectedValue.ToString();

                    if (strCurrentStatus != strPreviousStatus)
                    {

                        RadWindowManager1.RadConfirm("You have changed the status of the Lead. Are you sure? ", "confirmStatusCallbackFn", 400, 200, null, "Confirm");

                    }
                    else
                    {

                        if (dtpFollowupDate.SelectedDate == null)
                        {

                            if (Session["Followupdate"] != "")
                            {
                                Session["updatefollowupdate"] = Session["Followupdate"].ToString();

                                RadWindowManager1.RadConfirm("There was a followupdate. Press OK, if you wish to carry over the followup date to the recent entry?", "confirmCallbackFn", 400, 200, null, "Confirm");


                            }
                        }

                        //else
                        //{
                        //    ScheduleDate = dtpFollowupDate.SelectedDate;
                        //    sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrack",
                        //                   new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = HFTrackID.Value },
                        //                   new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = txtTrackerComments.Text + WBTimespent },
                        //                   //new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = HDAssignBy.Value },
                        //                   new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                        //                   new SqlParameter() { ParameterName = "@FollowupDate", SqlDbType = SqlDbType.DateTime, Value = ScheduleDate },
                        //        //.. string.IsNullOrEmpty(txtTrackerComments.Text)? " " : txtTrackerComments.Text},
                        //                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                        //                   new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = Value },
                        //                   new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue },
                        //                   new SqlParameter() { ParameterName = "@TimeSpent", SqlDbType = SqlDbType.Decimal, Value = TimeSpent },
                        //                   new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = HDAssignTo.Value },
                        //                   //new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = lblCustomer.Text },
                        //                   new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = Session["CustomerID"].ToString()},
                        //                   new SqlParameter() { ParameterName = "@ProjectStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                        //                   new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue }
                        //                   );

                        //    string strPreviousStatus = Session["Status"].ToString();
                        //    string strCurrentStatus = ddlCustStatus.SelectedValue.ToString();

                        //    if (strCurrentStatus != strPreviousStatus)
                        //    {
                        //        string strtype;
                        //        if (ddlCustStatus.SelectedValue == "7CUS")
                        //        {
                        //            strtype = "CUSTOMER";
                        //        }
                        //        else if (ddlCustStatus.SelectedValue == "OTHR")
                        //        {
                        //            strtype = "OTHER";

                        //        }
                        //        else if (ddlCustStatus.SelectedValue == "VEND")
                        //        {
                        //            strtype = "VENDOR";
                        //        }
                        //        else
                        //        {
                        //            strtype = "PROSPECT";
                        //        }

                        //        sqlobj.ExecuteSQLNonQuery("SP_UpdateStatus",

                        //                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["CustomerID"].ToString()) },
                        //                       new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.NVarChar, Value = StaffID.ToString()  },
                        //                       new SqlParameter() { ParameterName = "@M_Date", SqlDbType = SqlDbType.DateTime, Value = System.DateTime.Now  }, 
                        //                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                        //                       new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strtype.ToString()   }
                        //                       );
                        //    }




                        //}                      

                        WebMsgBox.Show("Work progress recorded. Your calendar may also be updated.");
                        ClearScr();
                        LoadTaskTrackDet(HFTrackID.Value);
                        if(Button1.Visible == true)
                        {                            
                            btnSaveNext_Click(sender, e);                           
                        }
                    }


                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }
            }
            else
            {
                WebMsgBox.Show("You have not updated the Progress of Work, Please write it in detail before pressing SAVE.");
            }
        }
    }

    public void SendmailWithIcsAttachment(string touser, string customer, string reference, string comments, DateTime followupdate)
    {

        try
        {

            //public string Location { get; set; }


            string Location = "";
            MailMessage msg = new MailMessage();
            //Now we have to set the value to Mail message properties


            string tomail = "";

            DataSet dsemail = sqlobj.SQLExecuteDataset("SP_GetMailId",
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = touser.ToString() });


            if (dsemail.Tables[0].Rows.Count > 0)
            {
                tomail = dsemail.Tables[0].Rows[0]["StaffEmail"].ToString();
            }

            dsemail.Dispose();


            if (tomail.ToString() != "")
            {

                string strmcusername = "";
                string strmcpassword = "";
                string strmcfromname = "";


                DataSet dsmc = sqlobj.SQLExecuteDataset("SP_GetMailCredential");

                if (dsmc.Tables[0].Rows.Count > 0)
                {
                    strmcusername = dsmc.Tables[0].Rows[0]["username"].ToString();
                    strmcpassword = dsmc.Tables[0].Rows[0]["password"].ToString();
                    strmcfromname = dsmc.Tables[0].Rows[0]["sentbyuser"].ToString();
                }

                dsmc.Dispose();

                MailClass M = new MailClass();

                M.SendMail(strmcusername, strmcfromname, tomail.ToString(), touser.ToString(), customer, reference, comments,
                    followupdate, strmcusername.ToString(), strmcpassword.ToString());


                // var smtpclient = new SmtpClient("smtp.gmail.com", 587)
                // {
                //     Credentials = new NetworkCredential("is@innovatussystems.com", "admin123#"),
                //     EnableSsl = true,
                //     Timeout = 100000
                // };

                // //Note Please change it to correct mail-id to use this in your application
                // msg.From = new MailAddress("is@innovatussystems.com", "Admin");
                // msg.To.Add(new MailAddress(tomail.ToString(), touser.ToString()));
                // //msg.CC.Add(new MailAddress("sridhar@innovatussystems.com", "Sridhar"));// it is optional, only if required
                // msg.Subject = "You have an activity scheduled for " + followupdate.ToString("dd-MM-yyyy", CultureInfo.InvariantCulture);

                // StreamReader reader = new StreamReader(Server.MapPath("~/Followup.html"));
                // string readFile = reader.ReadToEnd();
                // string myString = "";
                // myString = readFile;
                // myString = myString.Replace("$$Customer$$", customer);
                // myString = myString.Replace("$$Reference$$", reference);
                // myString = myString.Replace("$$Activity$$", comments);

                // ///string strbody ="Customer:" + customer + "<br/> Reference:" + reference + "<br/>  Comments:" + comments;



                // //msg.Body = "Customer:" + customer + "  Reference:" + reference + "  Comments:" + comments ;


                // msg.Body = myString.ToString();


                // // Now Contruct the ICS file using string builder
                //// StringBuilder str = new StringBuilder();
                //// str.AppendLine("BEGIN:VCALENDAR");
                //// str.AppendLine("PRODID:-//Schedule a Meeting");
                //// str.AppendLine("VERSION:2.0");
                //// str.AppendLine("METHOD:REQUEST");
                //// str.AppendLine("BEGIN:VEVENT");
                ////// str.AppendLine(string.Format("DTSTART:{0:yyyyMMddTHHmmssZ}", followupdate.ToShortDateString()  ));
                //// //str.AppendLine(string.Format("DTSTART:{0:yyyyMMddTHHmmssZ}", DateTime.Now.AddMinutes(+330)));
                //// str.AppendLine(string.Format("DTSTAMP:{0:yyyyMMddTHHmmssZ}", DateTime.UtcNow));
                //// //str.AppendLine(string.Format("DTEND:{0:yyyyMMddTHHmmssZ}", followupdate.ToShortDateString()));
                //// str.AppendLine("LOCATION:CGI " );
                //// str.AppendLine(string.Format("UID:{0}", Guid.NewGuid()));
                //// str.AppendLine(string.Format("DESCRIPTION:{0}", msg.Body));
                //// str.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", msg.Body));
                //// str.AppendLine(string.Format("SUMMARY:{0}", msg.Subject));
                //// str.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", msg.From.Address));

                //// str.AppendLine(string.Format("ATTENDEE;CN=\"{0}\";RSVP=TRUE:mailto:{1}", msg.To[0].DisplayName, msg.To[0].Address));

                //// str.AppendLine("BEGIN:VALARM");
                //// str.AppendLine("TRIGGER:-PT15M");
                //// str.AppendLine("ACTION:DISPLAY");
                //// str.AppendLine("DESCRIPTION:Reminder");
                //// str.AppendLine("END:VALARM");
                //// str.AppendLine("END:VEVENT");
                //// str.AppendLine("END:VCALENDAR");



                // String[] contents = { "BEGIN:VCALENDAR",
                //               "PRODID:-//Flo Inc.//FloSoft//EN",
                //               "BEGIN:VEVENT",
                //               "DTSTART:" + followupdate.ToString("yyyyMMdd\\THHmmss\\Z"), 
                //              "LOCATION:CGI", 
                //          "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" ,
                //               "SUMMARY:" + msg.Subject, "PRIORITY:3", 
                //          "END:VEVENT", "END:VCALENDAR" };





                // //Now sending a mail with attachment ICS file.                     
                // //System.Net.Mail.SmtpClient smtpclient = new System.Net.Mail.SmtpClient();
                // //smtpclient.Host = "localhost"; //-------this has to given the Mailserver IP

                // //smtpclient.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;

                //// smtpclient.Host = "smtp.gmail.com";
                // //smtpclient.Port = 587;

                //// smtpclient.EnableSsl = true;
                //// smtpclient.Timeout = 100000;
                //// smtpclient.Credentials = new System.Net.NetworkCredential("is@innovatussystems.com", "admin123#");

                // System.IO.File.WriteAllLines(Server.MapPath("Sample.ics"), contents);

                // Attachment mailAttachment = new Attachment(Server.MapPath("Sample.ics"));

                // msg.Attachments.Add(mailAttachment);

                // //System.Net.Mime.ContentType contype = new System.Net.Mime.ContentType("text/calendar");
                // //contype.Parameters.Add("method", "REQUEST");
                // //contype.Parameters.Add("name", "Meeting.ics");
                // //AlternateView avCal = AlternateView.CreateAlternateViewFromString(str.ToString(), contype);
                // //msg.AlternateViews.Add(avCal);

                // msg.IsBodyHtml = true;
                // smtpclient.Send(msg);

                // mailAttachment.Dispose(); 
            }

        }
        catch (Exception ex)
        {
            // CreateLogFiles Err = new CreateLogFiles();
            String[] contents = { ex.Message.ToString() };
            System.IO.File.WriteAllLines(Server.MapPath("error.txt"), contents);


        }

    }

    protected void HiddenStatusButton_Click(object sender, EventArgs e)
    {

        string strtype;
        string strType = "";
        string IsAllow = "";

        if (ddlCustStatus.SelectedValue == "7CUS")
        {
            strtype = "CUSTOMER";



        }
        else if (ddlCustStatus.SelectedValue == "OTHR")
        {
            strtype = "OTHER";

        }
        else if (ddlCustStatus.SelectedValue == "VNDR")
        {
            strtype = "VENDOR";
        }
        else
        {
            strtype = "PROSPECT";
        }

        sqlobj.ExecuteSQLNonQuery("SP_UpdateStatus",

                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["CustomerID"].ToString()) },
                       new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.NVarChar, Value = StaffID.ToString() },
                       new SqlParameter() { ParameterName = "@M_Date", SqlDbType = SqlDbType.DateTime, Value = System.DateTime.Now },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strtype.ToString() });


        if (Session["Followupdate"] != "")
        {
            Session["updatefollowupdate"] = Session["Followupdate"].ToString();

            RadWindowManager1.RadConfirm("There was a followupdate. Press OK, if you wish to carry over the followup date to the recent entry?", "confirmCallbackFn", 400, 200, null, "Confirm");


        }
       
        if (ViewState["ATo"].ToString() != ddlAssignedTo.SelectedValue)
        {

            sqlobj.ExecuteSQLNonQuery("SP_UpdateAssignedTo",
                       new SqlParameter() { ParameterName = "@ATo", SqlDbType = SqlDbType.NVarChar, Value = ViewState["ATo"].ToString() },
                       new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value }
                       );
        }

        LoadTaskTrackDet(HFTrackID.Value);
        ClearScr();

        RadWindowManager1.RadConfirm("Work progress recorded.", null, null, null, null, null);





    }

    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        sqlobj.ExecuteSQLNonQuery("sp_updatefollowupdate",
                                      new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = HFTrackID.Value },
                                      new SqlParameter() { ParameterName = "Followupdate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(Session["updatefollowupdate"].ToString()) }
                                      );

        if (ViewState["ATo"].ToString() != ddlAssignedTo.SelectedValue)
        {

            sqlobj.ExecuteSQLNonQuery("SP_UpdateAssignedTo",
                       new SqlParameter() { ParameterName = "@ATo", SqlDbType = SqlDbType.NVarChar, Value = ViewState["ATo"].ToString() },
                       new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value }
                       );
        }

        LoadTaskTrackDet(HFTrackID.Value);
        ClearScr();

        RadWindowManager1.RadConfirm("Work progress recorded. Your calendar may also be updated.", null, null, null, null, null);

        // WebMsgBox.Show("Track Detail Updated.");

    }



    protected void btnSaveNext_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            int acount = 0;

            i = i + 1;

            if (i < TaskCnt && Session["TaskID"].ToString() != string.Empty && Session["TaskID"].ToString() != null)
            {
                //Session["TaskID"] = Session["TaskID"].ToString().Remove(Session["TaskID"].ToString().Length - 1);
                string TaskID = Session["TaskID"].ToString();
                string[] STaskID = TaskID.Split(',');
                TID = STaskID[i];

                LoadStaffID(TID);
                HFTrackID.Value = TID;
                LoadDesc();
                LoadStatus();
                ENCustStatus();
                HDTaskID.Value = string.Empty;
                HDTaskID.Value = HFTrackID.Value;
               
                acount = Convert.ToInt16(ViewState["TaskCount"]) + 1;
                ViewState["TaskCount"] = acount;

                custrsn = Convert.ToInt32(strRSN[i]);
            }
            else
            {
                //Button1.Visible = false; 

                Session["TaskID"] = null;
                WebMsgBox.Show("All selected tasks have been reviewed / progress recorded");

            }

            if (acount < TaskCnt)
            {
                Button1.Visible = true;
            }
            else
            {
                Button1.Visible = false;
            }
        }


    }

    protected void ClearScr()
    {
        txtTrackerComments.Text = string.Empty;
        //HDAssignTo.Value = string.Empty;
        HDAssignBy.Value = string.Empty;
        dtpFollowupDate.SelectedDate = null;
        LoadStatus();
        //LoadTrackOn();
        this.txtTrackerComments.Focus();

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }

    protected void LoadTaskTrackDet(String TaskID)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTargetTrackDet = null;
            dsTargetTrackDet = sqlobj.SQLExecuteDataset("SP_FetchTaskTrackDet",
                new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = TaskID });
            if (dsTargetTrackDet != null && dsTargetTrackDet.Tables[0].Rows.Count != 0)
            {
                RdGrd_TaskTrack.DataSource = dsTargetTrackDet.Tables[0];
                int TypeRCount = dsTargetTrackDet.Tables[0].Rows.Count;
                RdGrd_TaskTrack.DataBind();
                dsTargetTrackDet.Dispose();
            }
            else
            {
                WebMsgBox.Show("There are no records to display");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }



    protected void btnTimeSpent_Click(object sender, EventArgs e)
    {

    }



    protected void LoadHrs()
    {
        //for (int i = 1; i <= 12; i++)
        //{
        //    string j = i.ToString();
        //    ddlFromHrs.Items.Insert(0, new ListItem(j, j));
        //    ddlToHrs.Items.Insert(0, new ListItem(j, j));
        //}

        List<string> THrs = new List<string>() { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24" };
        foreach (string Hrs in THrs)
        {
            ddlFromHrs.Items.Add(Hrs);
            ddlToHrs.Items.Add(Hrs);
        }

    }

    protected void LoadMins()
    {
        List<string> TMins = new List<string>() { "0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55" };
        foreach (string Mins in TMins)
        {
            ddlFromMin.Items.Add(Mins);
            ddlToMin.Items.Add(Mins);
        }
    }
    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        int FHrs = Convert.ToInt16(ddlFromHrs.SelectedValue.ToString());
        int FMins = Convert.ToInt16(ddlFromMin.SelectedValue.ToString());
        int THrs = Convert.ToInt16(ddlToHrs.SelectedValue.ToString());
        int TMins = Convert.ToInt16(ddlToMin.SelectedValue.ToString());

        int TFrom = (FHrs * 60) + FMins;
        int TTo = (THrs * 60) + TMins;
        int CAmt;
        if (TFrom < TTo)
        {
            CAmt = TTo - TFrom;
            txtTimeSpent.Text = CAmt.ToString();
        }
        else if (TFrom == TTo)
        {

            txtTimeSpent.Text = "0";
        }
        else
        {
            WebMsgBox.Show("Please enter a valid Time");
            txtTimeSpent.Text = string.Empty;
        }

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(GetType(), "CloseScript", " window.close();", true);
    }

    protected void btnDelegate_Click(object sender, EventArgs e)
    {
        //ClientScript.RegisterStartupScript(GetType(), "CloseScript"," window.close();", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir('" + TaskID + "','" + staffID + "');", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateNewTask();", true);
    }

    protected void LoadSaveTime()
    {
        DataSet dsSaveTime = new DataSet();
        dsSaveTime = sqlobj.SQLExecuteDataset("SP_GetSaveTimeEntry");

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


        //ddlTrackon.SelectedIndex = 4;
        dsSaveTime.Dispose();
    }

    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }

    private void STClear()
    {
        txtInfo.Text = "";
        //txtstremarks.Text = "";
    }

    protected void btnSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                           new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                           );

            LoadSaveTime();
            STClear();
            WebMsgBox.Show("Your details are saved");
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

                if (txtTrackerComments.Text != "")
                {
                    txtTrackerComments.Text = txtTrackerComments.Text + " " + st.ToString();
                }
                else
                {
                    txtTrackerComments.Text = txtTrackerComments.Text + st.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
    }

    protected void chkEditStatus_CheckedChanged(object sender, EventArgs e)
    {

        if (chkEditStatus.Checked == true)
        {
            DataSet dsCustStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 27 });

            ddlCustStatus.Items.Clear();

            ddlCustStatus.DataSource = dsCustStaus.Tables[0];
            ddlCustStatus.DataValueField = "StatusCode";
            ddlCustStatus.DataTextField = "StatusName";
            ddlCustStatus.DataBind();


            ddlCustStatus.Enabled = true;
        }
        else
        {
            ddlCustStatus.Enabled = false;
        }
    }
    protected void chkEditCustomer_CheckedChanged(object sender, EventArgs e)
    {
        if (chkEditCustomer.Checked == true)
        {
            string strType = "";
            string IsAllow = "";

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


            if (IsAllow == "Yes")
            {
                DataSet dsCustStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 });

                ddlCustStatus.Items.Clear();

                ddlCustStatus.DataSource = dsCustStaus.Tables[0];
                ddlCustStatus.DataValueField = "StatusCode";
                ddlCustStatus.DataTextField = "StatusName";
                ddlCustStatus.DataBind();

                ddlCustStatus.SelectedValue = "7CUS";

                ddlCustStatus.Enabled = false;


            }
            else
            {
                DataSet dsCustStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 27 });

                ddlCustStatus.Items.Clear();

                ddlCustStatus.DataSource = dsCustStaus.Tables[0];
                ddlCustStatus.DataValueField = "StatusCode";
                ddlCustStatus.DataTextField = "StatusName";
                ddlCustStatus.DataBind();

                if (chkEditStatus.Checked == true)
                {
                    ddlCustStatus.Enabled = true;
                }
            }

        }

    }

    protected void btnimgaddsavetime_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlsavetime.SelectedValue != "")
        {
            string st = ddlsavetime.SelectedValue;

            if (txtTrackerComments.Text != "")
            {
                txtTrackerComments.Text = txtTrackerComments.Text + " " + st.ToString();
            }
            else
            {
                txtTrackerComments.Text = txtTrackerComments.Text + st.ToString();
            }
        }
    }
    protected void ddlTrackOn_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
               new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue });

            if (dsremarks.Tables[0].Rows.Count > 0)
            {
                if (dsremarks.Tables[0].Rows[0]["Trackonremarks"].ToString() != null)
                {
                    lblcrefremarks.Text = dsremarks.Tables[0].Rows[0]["Trackongroup"].ToString() + "-" + dsremarks.Tables[0].Rows[0]["Trackonremarks"].ToString();
                    lblcrefremarks.Visible = true;
                }
                else
                {
                    lblcrefremarks.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReferenceHelp_Click(object sender, EventArgs e)
    {

        DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
           new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackOn.SelectedValue });

        if (dsremarks.Tables[0].Rows.Count > 0)
        {
            if (dsremarks.Tables[0].Rows[0]["HelpText"].ToString() != null)
            {
                lblrefhelp.Text = dsremarks.Tables[0].Rows[0]["Trackongroup"].ToString() + "-" + dsremarks.Tables[0].Rows[0]["HelpText"].ToString();

            }
            else
            {
                lblrefhelp.Text = "";
            }
        }

        rwReferenceHelp.Visible = true;
    }
    private void LoadMobileAppReference(string strGroup)
    {
        try
        {
            DataSet dstrackon = sqlobj.SQLExecuteDataset("SP_GetGroupwiseReference",
         new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = strGroup.ToString() });


            if (dstrackon.Tables[0].Rows.Count > 0)
            {
                ddlTrackOn.DataSource = dstrackon;
                ddlTrackOn.DataTextField = "TrackOnDesc";
                ddlTrackOn.DataValueField = "TrackOnDesc";
                ddlTrackOn.DataBind();
            }

            dstrackon.Dispose();


            ddlTrackOn.SelectedValue = ddlReference.SelectedValue;  
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void UpdateName(string rsn)
    {
        
        sqlobj.ExecuteSQLNonQuery("SP_UpdateTrackerEntryRSN",
                                           new SqlParameter() { ParameterName = "@CustomerRSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(rsn.ToString()) },
                                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = HFTrackID.Value.ToString() }
                                           );

        //Session["CustomerID"].ToString();

        LoadNewCustomerName(rsn.ToString());  

    }
    protected void btnMarketing_Click(object sender, EventArgs e)
    {
        if (ddlReference.SelectedItem.Text != "")
        {
            LoadMobileAppReference(ddlReferenceGroup.SelectedValue);
            UpdateName(ddlCustName.SelectedValue.ToString());

            rwMobileApp.Visible = false;
        }
        else
        {
            rwMobileApp.Visible = true;
            WebMsgBox.Show("Please select your appropriate reference code");
        }
    }
    protected void btnProjects_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(GetType(), "CloseScript", " window.close();", true);

        //LoadMobileAppReference("Projects");
       // rwMobileApp.Visible = false;
    }
    protected void btnGeneral_Click(object sender, EventArgs e)
    {
        LoadMobileAppReference("General");
        rwMobileApp.Visible = false;
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadCustomer();
            rwMobileApp.Visible = true; 
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadCustomer()
    {
        DataSet dsCustName = new DataSet();
        dsCustName = sqlobj.SQLExecuteDataset("SP_GetNames",
          new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue });

        ddlCustName.Items.Clear();

        ddlCustName.DataSource = dsCustName.Tables[0];
        ddlCustName.DataValueField = "CustRSN";
        ddlCustName.DataTextField = "Name";
        ddlCustName.DataBind();
        //ddlCustName.Items.Insert(0, "Please Select");
        //ddlCustName.Items.Add(new ListItem("Please Select", "0", true));
        //ddlCustName.Items.Insert(0,"Cov"   
        //ddlCustName.Items.FindByValue("0").Selected = true;
        //ddlCustName.SelectedIndex = 0;

        ddlCustName.Items.Insert(0, "");
        dsCustName.Dispose();
        //ddlTrackon.Items.Clear();
        //ddlTrackon.Items.Add(new ListItem("General", "0", true));
    }

    protected void ddlReferenceGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadReference();
            rwMobileApp.Visible = true; 

        }
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadReference()
    {

        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("SP_FetchCustDet",
            new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlReferenceGroup.SelectedValue });


        ddlReference.Items.Clear();

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {
            ddlReference.DataSource = dsTrackon.Tables[0];
            ddlReference.DataValueField = "TrackonDesc";
            ddlReference.DataTextField = "TrackonDesc";
            ddlReference.DataBind();
        }

        ddlReference.Items.Insert(0, "");

        //ddlTrackon.SelectedIndex = 4;
        dsTrackon.Dispose();
    }
    protected void btnCusProfile_Click(object sender, EventArgs e)
    {
        LoadCustomerProfile(custrsn);
    }
    protected void ddlsavetime_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsavetime.SelectedItem.ToString() != "")
        {
            string strAppend = ddlsavetime.SelectedItem.ToString();
            txtTrackerComments.Text = txtTrackerComments.Text + " " + strAppend + " ";
        }
    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                