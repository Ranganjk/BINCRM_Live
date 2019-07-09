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

public partial class Activity : System.Web.UI.Page
{
    string UserID;
    SQLProcs sqlobj = new SQLProcs();
    string TaskType;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsDT = null;
            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);

            rwSaveTime.VisibleOnPageLoad = true;
            rwSaveTime.Visible = false;

            // rwHelp.VisibleOnPageLoad = true;
            // rwHelp.Visible = false;

            rwReferenceHelp.VisibleOnPageLoad = true;
            rwReferenceHelp.Visible = false;

            dtpFollowupdate.MinDate = DateTime.Today;
            dtpTargetDate.MinDate = DateTime.Today;

            rwDiary.VisibleOnPageLoad = true;
            rwDiary.Visible = false;

            //rwNewLead.VisibleOnPageLoad = true;
            //rwNewLead.Visible = false;




            if (!IsPostBack)
            {


                dvCustomerDetails.Visible = false;
                dvNewLead.Visible = false;

                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }
                UserID = Session["UserID"].ToString();
                //dsDT = sqlobj.SQLExecuteDataset("GetServerDateTime");
                //lblDate.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy | hh:mm tt"); ;
                //dtpAssignOnDate.SelectedDate = DateTime.Now.Date;
                dtpTargetDate.SelectedDate = DateTime.Now;
                //LoadCompleInDays();
                if (Session["TaskType"] == null)
                {
                    TaskType = "FromDirect";
                }
                else
                {
                    TaskType = Session["TaskType"].ToString();
                }
                if (TaskType == "FromDirect")
                {
                    // LoadCustomer();
                    LoadTrackOn();
                }
                else if (TaskType == "FromProspect")
                {

                    Session["TaskType"] = "FromDirect";
                }
                //LoadCustomer();
                LoadAssignedTo();
                //LoadTrackOn();
                //LoadTaskType();
                LoadAssignedBy();
                //LoadStatus();
                LoadPriority();
                // LoadComplexity();
                LoadCustStatus();
                LoadSaveTime();
                LoadUserLevel();
                LoadProspectTypes();

                LoadDefaultGroupReference();
                ddlNewLeadType.Enabled = false;
                // txtNotes.Text = "New Lead";

                LoadComplaints();

                LoadRemarks();

                LoadStatus();







                ddlStatus.Visible = false;
                btnUpdate.Visible = false;
                lblshelp.Visible = false;
                lblStatus.Visible = false;


                if (Request.QueryString["Group"] != null)
                {
                    ddlReferenceGroup.SelectedValue = "Marketing";
                    ddlTrackon.SelectedValue = "#Aptmnt";
                    dtpFollowupdate.SelectedDate = Convert.ToDateTime(Request.QueryString["Date"].ToString());
                    ddlReferenceGroup.Enabled = false;
                    ddlTrackon.Enabled = false;
                    dtpFollowupdate.Enabled = false;
                }

                DataSet dsCL = sqlobj.SQLExecuteDataset("SP_FetchSCheckList",
              new SqlParameter() { ParameterName = "@RefCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });
                if (dsCL.Tables[0].Rows.Count > 0)
                {
                    lblCheckList.Visible = true;
                    ddlCheckList.Visible = true;
                    LoadCheckList();
                }
                else
                {
                    lblCheckList.Visible = false;
                    ddlCheckList.Visible = false;
                    LoadCheckList();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public void LoadComplaints()
    {
        DataSet dsComp = new DataSet();
        try
        {
            dsComp = sqlobj.SQLExecuteDataset("Proc_GetLatestTasks");
            if (dsComp.Tables[0].Rows.Count > 0)
            {
                gvNewActivity.DataSource = dsComp;
                gvNewActivity.DataBind();
            }
            else
            {
                gvNewActivity.DataSource = null;
                gvNewActivity.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadUserLevel()
    {
        try
        {
            DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster1",
                        new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });


            if (dsMasters.Tables[1].Rows.Count > 0)
            {
                string strUserLevel = dsMasters.Tables[1].Rows[0]["UserLevel"].ToString();

                Session["UserLevel"] = strUserLevel.ToString();

                if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
                {
                    btnSTSave.Visible = true;
                }
                else
                {
                    btnSTSave.Visible = false;
                    //ddlAssignedTo.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadCustStatus()
    {

        DataSet dsCustStatus = new DataSet();
        dsCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 12 });
        ddlCustStatus.DataSource = dsCustStatus.Tables[0];
        ddlCustStatus.DataValueField = "StatusCode";
        ddlCustStatus.DataTextField = "StatusDesc";
        ddlCustStatus.DataBind();

        dsCustStatus.Dispose();
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
        ddlAssignedTo.SelectedValue = Session["UserID"].ToString();
        ddlAssignedTo.Items.Insert(0, "");
        dsAssignedTo.Dispose();
    }

    protected void LoadCAssignedTo()
    {

        DataSet dsAssignedTo = new DataSet();
        dsAssignedTo = sqlobj.SQLExecuteDataset("SP_FetchStaffDetails",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
        ddlAssignedTo.DataSource = dsAssignedTo.Tables[0];
        ddlAssignedTo.DataValueField = "UserID";
        ddlAssignedTo.DataTextField = "UserName";
        ddlAssignedTo.DataBind();
        dsAssignedTo.Dispose();
    }

    protected void LoadTrackOn()
    {

        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("SP_FetchCustDet",
            new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlReferenceGroup.SelectedValue });


        ddlTrackon.Items.Clear();

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {
            ddlTrackon.DataSource = dsTrackon.Tables[0];
            ddlTrackon.DataValueField = "TrackonDesc";
            ddlTrackon.DataTextField = "TrackonDesc";
            ddlTrackon.DataBind();
        }

        ddlTrackon.Items.Insert(0, "");

        //ddlTrackon.SelectedIndex = 4;
        dsTrackon.Dispose();
    }

    private void LoadDefaultGroupReference()
    {
        try
        {
            DataSet dsGroupReference = sqlobj.SQLExecuteDataset("SP_DefaultGroupReference");

            if (dsGroupReference.Tables[0].Rows.Count > 0)
            {
                ddlReferenceGroup.SelectedValue = dsGroupReference.Tables[0].Rows[0]["DefaultGroup"].ToString();

                LoadTrackOn();

                ddlTrackon.SelectedValue = dsGroupReference.Tables[0].Rows[0]["DefaultReference"].ToString();

            }

            dsGroupReference.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadRemarks()
    {
        lblcrefremarks.Text = string.Empty;
        DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
              new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });

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

    //protected void LoadTaskType()
    //{

    //    DataSet dsTaskType = new DataSet();
    //    dsTaskType = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
    //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 8 });
    //    ddlTaskType.DataSource = dsTaskType.Tables[0];
    //    ddlTaskType.DataValueField = "CodeValue";
    //    ddlTaskType.DataTextField = "CodeDesc";
    //    ddlTaskType.DataBind();
    //    ddlTaskType.SelectedIndex = 0;
    //    dsTaskType.Dispose();
    //}

    protected void LoadAssignedBy()
    {

        DataSet dsAssignedBy = new DataSet();
        dsAssignedBy = sqlobj.SQLExecuteDataset("SP_FetchStaffDetails",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
        ddlAssignedBy.DataSource = dsAssignedBy.Tables[0];
        ddlAssignedBy.DataValueField = "UserID";
        ddlAssignedBy.DataTextField = "UserName";
        ddlAssignedBy.DataBind();
        ddlAssignedBy.SelectedValue = Session["UserID"].ToString();
        dsAssignedBy.Dispose();
    }

    protected void LoadCAssignedBy()
    {

        DataSet dsAssignedBy = new DataSet();
        dsAssignedBy = sqlobj.SQLExecuteDataset("SP_FetchStaffDetails",
            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
        ddlAssignedBy.DataSource = dsAssignedBy.Tables[0];
        ddlAssignedBy.DataValueField = "UserID";
        ddlAssignedBy.DataTextField = "UserName";
        ddlAssignedBy.DataBind();
        dsAssignedBy.Dispose();
    }
    //protected void LoadStatus()
    //{
    //    DataSet dsStatus = new DataSet();
    //    dsStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
    //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 });
    //    ddlStatus.DataSource = dsStatus.Tables[0];
    //    ddlStatus.DataValueField = "CodeValue";
    //    ddlStatus.DataTextField = "CodeDesc";
    //    ddlStatus.DataBind();
    //    dsStatus.Dispose();
    //}

    protected void LoadPriority()
    {
        DataSet dsPriority = new DataSet();
        dsPriority = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 10 });
        ddlPriority.DataSource = dsPriority.Tables[0];
        ddlPriority.DataValueField = "CodeValue";
        ddlPriority.DataTextField = "CodeDesc";
        ddlPriority.DataBind();
        ddlPriority.SelectedIndex = 3;
        dsPriority.Dispose();
    }


    protected void btnHelp_Click(object sender, EventArgs e)
    {
        // rwHelp.Visible = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            string strCustomerName = "";

            if (CnfResult.Value == "true")
            {
                if (txtTaskAssigned.Text != string.Empty)
                {
                    if (ddlTrackon.SelectedItem.Text != string.Empty)
                    {
                        string strStatus = "";
                        string strdocfive = "";



                        if (chkNew.Checked == true)
                        {

                            string strNotes = "";

                            string struid = Session["UserID"].ToString();

                            DataSet dsCustomerRSN = sqlobj.SQLExecuteDataset("SP_insertprospects",
                            new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlTitle.SelectedValue },
                            new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtCustName.Text },
                            new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = chkNew.Checked == false ? "7CUS" : "0REG" },
                            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlNewLeadType.SelectedValue },
                            new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtMob.Text },
                            new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = txtEml.Text },
                            new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = null },
                            new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                            new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = null },

                            new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = " " },
                            new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = null },
                            new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = null },
                            new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = null },
                            new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = "" },
                            new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = null },

                            new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                            new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = txtCompanyName.Text },
                            new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = null }

                            );

                            Session["CustomerRSN"] = dsCustomerRSN.Tables[0].Rows[0]["RSN"].ToString();

                        }





                        DataSet dsCuststatus = new DataSet();
                        dsCuststatus = sqlobj.SQLExecuteDataset("sp_getcustomerdetails",
                            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["CustomerRSN"].ToString() });







                        if (dsCuststatus.Tables[0].Rows.Count > 0)
                        {

                            strStatus = dsCuststatus.Tables[0].Rows[0]["custstatus"].ToString();
                            strCustomerName = dsCuststatus.Tables[0].Rows[0]["Name"].ToString();
                        }

                        dsCuststatus.Dispose();

                        if (strStatus == "7CUS" || strStatus == "OTHR" || strStatus == "VNDR")
                        {
                            strdocfive = "CUST";
                        }
                        else
                        {
                            strdocfive = "LEAD";
                        }


                        DataSet TaskID = sqlobj.SQLExecuteDataset("SP_InsertNewTask",
                                                 new SqlParameter() { ParameterName = "@CustName", SqlDbType = SqlDbType.NVarChar, Value = Session["CustomerRSN"].ToString() },
                                                 new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedTo.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TaskType", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                 new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = string.IsNullOrEmpty(txtTaskAssigned.Text) ? " " : txtTaskAssigned.Text },
                                                 new SqlParameter() { ParameterName = "@AssignedOn", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                                 new SqlParameter() { ParameterName = "@AssignedBy", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedBy.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TargetDate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDate.SelectedDate.Value },
                                                 new SqlParameter() { ParameterName = "@OtherAssignees", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                 new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                                                 new SqlParameter() { ParameterName = "@QtyOfWork", SqlDbType = SqlDbType.NVarChar, Value = "BI" },
                                                 new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@Complexity", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                 new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                 new SqlParameter() { ParameterName = "@Docfive", SqlDbType = SqlDbType.NVarChar, Value = strdocfive.ToString() },
                                                 new SqlParameter() { ParameterName = "@CMail", SqlDbType = SqlDbType.NVarChar, Value = ddlcmail.SelectedValue }
                                                 );


                        if (dtpFollowupdate.SelectedDate != null)
                        {
                            sqlobj.ExecuteSQLNonQuery("SP_UpdateFollowupdate",
                                new SqlParameter() { ParameterName = "@Followupdate", SqlDbType = SqlDbType.DateTime, Value = dtpFollowupdate.SelectedDate },
                                new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = TaskID.Tables[2].Rows[0]["RSN"].ToString() }
                                );
                            SendmailWithIcsAttachment(Session["UserID"].ToString(), strCustomerName.ToString(), ddlTrackon.SelectedValue, txtTaskAssigned.Text, Convert.ToDateTime(dtpFollowupdate.SelectedDate));

                        }
                        WebMsgBox.Show(" The activity will now appear in the Tasks list of the concerned person.");
                        LoadComplaints();
                        ClearScr();
                    }
                    else
                    {
                        WebMsgBox.Show("Please select appropriate Reference for your task.");
                    }
                }
                else
                {
                    WebMsgBox.Show("Have you written the work to be done. Have you missed out any vital information? Please re-check.");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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
            }
        }
        catch (Exception ex)
        {
            // CreateLogFiles Err = new CreateLogFiles();
            String[] contents = { ex.Message.ToString() };
            System.IO.File.WriteAllLines(Server.MapPath("error.txt"), contents);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void ClearScr()
    {

        dvCustomerDetails.Visible = false;
        dvNewLead.Visible = false;

        chkNew.Checked = false;

        if (Session["TaskType"] == null)
        {
            TaskType = "FromDirect";
        }
        else
        {
            TaskType = Session["TaskType"].ToString();
        }

        if (TaskType == "FromDirect")
        {
            // LoadCustomer();
            LoadTrackOn();
        }
        else if (TaskType == "FromProspect")
        {
            // LoadProspectCustomer();
            // ddlCustName.SelectedValue = Session["ProspectRSN"].ToString();
            // ddlCustName.Enabled = false;
            LoadTrackOn();
            ddlTrackon.SelectedValue = Session["Reference"].ToString();
            ddlTrackon.Enabled = false;
        }
        LoadAssignedTo();
        // LoadTaskType();
        LoadAssignedBy();
        // LoadStatus();
        LoadPriority();

        lblCheckList.Visible = false;
        ddlCheckList.Visible = false;

        // LoadComplexity();
        //dtpAssignOnDate.SelectedDate = DateTime.Now.Date;
        dtpTargetDate.SelectedDate = DateTime.Now.Date;
        //txtOtherAssignees.Text = string.Empty;

        txtTaskAssigned.Text = string.Empty;

        btnUpdate.Visible = false;
        btnSave.Visible = true;

        lblStatus.Visible = false;
        lblshelp.Visible = false;
        ddlStatus.Visible = false;


        DdlUhid.Entries.Clear();

        UPLDocUpl1.Dispose();
        UPLDocUpl2.Dispose();
        UPLDocUpl3.Dispose();
        UPLDocUpl4.Dispose();
        UPLDocUpl5.Dispose();

        // lblcontactname.Visible = false;
        //ddlContactName.Visible = false;
    }

    protected void lbNewCustomer_Click(object sender, EventArgs e)
    {
        //if (lbNewCustomer.Text == "Add a New Prospect\\Customer Name")
        //{
        //    lbNewCustomer.Text = "Go Back";
        //    lblNCustName.Visible = true;
        //    lblash4.Visible = true;
        //    txtNCustName.Visible = true;
        //    lblCustStatus.Visible = true;
        //    lblash5.Visible = true;
        //    ddlCustStatus.Visible = true;
        //    btnNCSave.Visible = true;
        //    btnNCClear.Visible = true;
        //}
        //else if (lbNewCustomer.Text == "Go Back")
        //{
        //    lbNewCustomer.Text = "Add a New Prospect\\Customer Name";
        //    lblNCustName.Visible=false;
        //    lblash4.Visible=false;
        //    txtNCustName.Visible=false;
        //    lblCustStatus.Visible=false;
        //    lblash5.Visible=false;
        //    ddlCustStatus.Visible=false;
        //    btnNCSave.Visible=false;
        //    btnNCClear.Visible = false;
        //}
    }


    protected void chkcust_CheckedChanged(object sender, EventArgs e)
    {

        LoadTrackOn();
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
            if (txtInfo.Text != "")
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
            else
            {
                WebMsgBox.Show("Please enter the savetime entry.");
                rwSaveTime.Visible = true;
            }

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

                if (txtTaskAssigned.Text != "")
                {
                    txtTaskAssigned.Text = txtTaskAssigned.Text + " " + st.ToString();
                }
                else
                {
                    txtTaskAssigned.Text = txtTaskAssigned.Text + st.ToString();
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


    protected void btnimgaddsavetime_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlsavetime.SelectedValue != "")
        {
            string st = ddlsavetime.SelectedValue;

            if (txtTaskAssigned.Text != "")
            {
                txtTaskAssigned.Text = txtTaskAssigned.Text + " " + st.ToString();
            }
            else
            {
                txtTaskAssigned.Text = txtTaskAssigned.Text + st.ToString();
            }
        }
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
    protected void btnClose_Click(object sender, EventArgs e)
    {
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", "CloseWindow();", true);
        //this.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "script", "CloseWindow();", true);
    }
    protected void ddlReferenceGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadTrackOn();

            txtTaskAssigned.Text = "";

            DataSet dsCL = sqlobj.SQLExecuteDataset("SP_FetchSCheckList",
           new SqlParameter() { ParameterName = "@RefCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });
            if (dsCL.Tables[0].Rows.Count > 0)
            {
                lblCheckList.Visible = true;
                ddlCheckList.Visible = true;
            }
            else
            {
                lblCheckList.Visible = false;
                ddlCheckList.Visible = false;
                LoadCheckList();
            }

        }
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlTrackon_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadRemarks();
            DataSet dsCL = sqlobj.SQLExecuteDataset("SP_FetchSCheckList",
               new SqlParameter() { ParameterName = "@RefCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });
            if (dsCL.Tables[0].Rows.Count > 0)
            {
                lblCheckList.Visible = true;
                ddlCheckList.Visible = true;
                LoadCheckList();
            }
            else
            {
                lblCheckList.Visible = false;
                ddlCheckList.Visible = false;
                LoadCheckList();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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

    protected void btnCSave_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();

            if (IsProspectExisting(txtCustName.Text, txtMob.Text))
            {
                WebMsgBox.Show("This prospect name and mobile-no combination exists.");
            }
            else
            {
                string strNotes = "";
                string struid = Session["UserID"].ToString();
                sqlobj.ExecuteSQLNonQuery("SP_insertprospects",
                                   new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlTitle.SelectedValue },
                                   new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtCustName.Text },
                                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = chkNew.Checked == false ? "7CUS" : "OREG" },
                                   new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlNewLeadType.SelectedValue },
                                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = txtMob.Text },
                                   new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = txtEml.Text },
                                   new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                                   new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = null },

                                   new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = " " },
                                   new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = null },

                                   new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                   new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = txtCompanyName.Text },
                                   new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = null }

                                   );

                //LoadProspectCount();
                //LoadPagingProspectDetails();
                LoadProspectTypes();




                string custname = txtCustName.Text + '-' + txtMob.Text;
                //ddlCustStatus.SelectedValue = ddlCCustStatus.SelectedValue;
                if (ViewState["NewLead"] != null)
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)ViewState["NewLead"];
                    DataRow[] rows = dt.Select("Name IN ('" + custname + "')", "", System.Data.DataViewRowState.CurrentRows);
                    // ddlCustName.SelectedItem.Text = rows[0].ItemArray[0].ToString();
                    // ddlCustName.SelectedValue = rows[0].ItemArray[1].ToString();
                    //ddlCustName.Refresh();
                }
                //ddlCustName.SelectedItem.Text = txtCustName.Text +'-'+ txtMob.Text;

                WebMsgBox.Show("New Profile Added.");
                txtCompanyName.Text = string.Empty;
                txtCustName.Text = string.Empty;
                txtEml.Text = string.Empty;
                txtMob.Text = string.Empty;
                //txtNotes.Text = string.Empty;
            }
        }
        catch (Exception ex)
        {
            this.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "ALert", "alert('" + ex.Message.ToString() + "');");
        }
    }

    protected void btnCClear_Click(object sender, EventArgs e)
    {
        txtCompanyName.Text = string.Empty;
        txtCustName.Text = string.Empty;
        txtEml.Text = string.Empty;
        txtMob.Text = string.Empty;
        //txtNotes.Text = string.Empty;
        //rwNewLead.Visible = true;
    }

    protected void btnCUpate_Click(object sender, EventArgs e)
    {
        //rwStatusHelp.Visible = false;
        //rwNewLead.Visible = false;
    }
    protected void btnNewLead_Click(object sender, EventArgs e)
    {
        LoadProspectTypes();
        // rwNewLead.Visible = true;
    }

    protected void LoadProspectTypes()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        //ddlCCustStatus.Items.Clear();

        if (ddlNewLeadType.SelectedItem.Text == "PROSPECT")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 16 });
        }
        else if (ddlNewLeadType.SelectedItem.Text == "VENDOR")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 25 });
        }
        else if (ddlNewLeadType.SelectedItem.Text == "OTHER")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 23 });
        }
        else if (ddlNewLeadType.SelectedItem.Text == "CUSTOMER")
        {
            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 24 });
        }

        if (dsCCustStatus != null)
        {

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {

                //ddlCCustStatus.DataSource = dsCCustStatus.Tables[0];
                //ddlCCustStatus.DataValueField = "StatusCode";
                //ddlCCustStatus.DataTextField = "StatusDesc";
                //ddlCCustStatus.DataBind();
                //ddlCCustStatus.Dispose();

            }
        }

        // ddlCCustStatus.Items.Insert(0, "Please Select");
    }
    protected void ddlNewLeadType_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadProspectTypes();

        //rwNewLead.Visible = true;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {

            SQLProcs sqlobj = new SQLProcs();


            string strrsnfilter = DdlUhid.Text;

            string[] custrsn = strrsnfilter.Split(',');

            strrsnfilter = custrsn[3].ToString();

            custrsn = strrsnfilter.Split(';');

            Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            DataSet dscustomerdetails = sqlobj.SQLExecuteDataset("SP_GetCustomerSearchDetails",
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn }
                     );


            if (dscustomerdetails.Tables[0].Rows.Count > 0)
            {
                dvCustomerDetails.Visible = true;

                Session["CustomerRSN"] = dscustomerdetails.Tables[0].Rows[0]["RSN"].ToString();

                lblname.Text = dscustomerdetails.Tables[0].Rows[0]["Name"].ToString();
                lblDoorNo.Text = dscustomerdetails.Tables[0].Rows[0]["DoorNo"].ToString() + " " + dscustomerdetails.Tables[0].Rows[0]["City"].ToString() + " " + dscustomerdetails.Tables[0].Rows[0]["PostCode"].ToString() + " " + dscustomerdetails.Tables[0].Rows[0]["State"].ToString() + " " + dscustomerdetails.Tables[0].Rows[0]["Country"].ToString();
                lblMobileNo.Text = dscustomerdetails.Tables[0].Rows[0]["Mobile"].ToString();
                lblEmail.Text = dscustomerdetails.Tables[0].Rows[0]["Email"].ToString();


                ddlNewLeadType.SelectedValue = "CUSTOMER";


                dvNewLead.Visible = false;
                chkNew.Checked = false;
            }


            dscustomerdetails.Dispose();
        }



        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkNew_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkNew.Checked == true)
            {
                dvCustomerDetails.Visible = false;
                dvNewLead.Visible = true;

                DdlUhid.Entries.Clear();

                ddlNewLeadType.SelectedValue = "PROSPECT";
            }
            else
            {

                dvNewLead.Visible = false;
                ddlNewLeadType.SelectedValue = "CUSTOMER";

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvcomplist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int i = 0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            foreach (TableCell cell in e.Row.Cells)
            {
                i++;
                string s = cell.Text;
                if (cell.Text.Length > 20 && (i == 5))
                {
                    cell.Text = cell.Text.Substring(0, 20) + "...";
                    cell.ToolTip = s;
                }
            }
        }
    }

    protected void gvNewActivity_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            Telerik.Web.UI.GridDataItem item = e.Item as Telerik.Web.UI.GridDataItem;
            GridDataItem griditem = e.Item as GridDataItem;
            if (item != null)
            {
                LinkButton lnkRSN = (LinkButton)griditem.FindControl("lnkRSN");
                LinkButton lnkStatus = (LinkButton)griditem.FindControl("lnkStatus");

                if (lnkStatus.Text == "Completed")
                {
                    lnkRSN.Enabled = false;
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvNewActivity_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Task")
            {
                string strProspectRSN = Convert.ToString(e.CommandArgument);
                LinkButton lnktaskid = (LinkButton)e.Item.FindControl("lnkRSN");


                DataSet dsactivitydetails = sqlobj.SQLExecuteDataset("SP_GetActivityDetails",
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = strProspectRSN.ToString() }
                       );


                if (dsactivitydetails.Tables[0].Rows.Count > 0)
                {
                    dvCustomerDetails.Visible = true;

                    Session["CustomerRSN"] = dsactivitydetails.Tables[0].Rows[0]["projectname"].ToString();
                    Session["ActivityTaskID"] = dsactivitydetails.Tables[0].Rows[0]["RSN"].ToString();


                    lblname.Text = dsactivitydetails.Tables[0].Rows[0]["Name"].ToString();
                    lblDoorNo.Text = dsactivitydetails.Tables[0].Rows[0]["DoorNo"].ToString() + " " + dsactivitydetails.Tables[0].Rows[0]["City"].ToString() + " " + dsactivitydetails.Tables[0].Rows[0]["PostCode"].ToString() + " " + dsactivitydetails.Tables[0].Rows[0]["State"].ToString() + " " + dsactivitydetails.Tables[0].Rows[0]["Country"].ToString();
                    lblMobileNo.Text = dsactivitydetails.Tables[0].Rows[0]["Mobile"].ToString();
                    lblEmail.Text = dsactivitydetails.Tables[0].Rows[0]["Email"].ToString();

                    txtTaskAssigned.Text = dsactivitydetails.Tables[0].Rows[0]["Comments"].ToString();

                    ddlReferenceGroup.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["Group"].ToString();

                    ddlTrackon.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["Reference"].ToString();

                    ddlAssignedBy.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["AssignedBy"].ToString();

                    ddlAssignedTo.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["AssignedTo"].ToString();

                    ddlPriority.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["Priority"].ToString();

                    ddlStatus.SelectedValue = dsactivitydetails.Tables[0].Rows[0]["TasksStatus"].ToString();





                    dvNewLead.Visible = false;
                    chkNew.Checked = false;


                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                    lblshelp.Visible = true;
                    lblStatus.Visible = true;
                    ddlStatus.Visible = true;

                }

            }
            else
            {
                LoadComplaints();
            }

            DataSet dsCL = sqlobj.SQLExecuteDataset("SP_FetchSCheckList",
            new SqlParameter() { ParameterName = "@RefCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });
            if (dsCL.Tables[0].Rows.Count > 0)
            {
                lblCheckList.Visible = true;
                ddlCheckList.Visible = true;
                LoadCheckList();

                DataSet dsCL2 = sqlobj.SQLExecuteDataset("SP_TaskAssigned",
                new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = txtTaskAssigned.Text });
                if (dsCL2.Tables[0].Rows.Count > 0)
                {
                    ddlCheckList.SelectedValue = dsCL2.Tables[0].Rows[0]["Activity"].ToString();
                }


            }
            else
            {
                lblCheckList.Visible = false;
                ddlCheckList.Visible = false;
                LoadCheckList();
            }


        }
        catch (Exception ex)
        {

        }
    }

    protected void gvcomplist_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {

            if (e.CommandName == "Diary")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                LinkButton lnkbtn = (LinkButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;


                string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();







                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2('" + strProspectRSN.ToString() + "');", true);

                //Int64 istaffid = Convert.ToInt64(strProspectRSN);

                //Session["ProspectRSN"] = istaffid.ToString();

                //Session["DiaryFrom"] = "CustomerGrid";

                //LoadProspectDiary(istaffid.ToString());

                //if (gvDiary.Rows.Count > 0)
                //{
                //    rwDiary.Visible = true;
                //}
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();
        dsStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 28 });
        ddlStatus.DataSource = dsStaus.Tables[0];
        ddlStatus.DataValueField = "StatusCode";
        ddlStatus.DataTextField = "StatusName";
        ddlStatus.DataBind();

        dsStaus.Dispose();
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

    protected void btnDiaryClose_Click(object sender, EventArgs e)
    {
        rwDiary.Visible = false;
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
    protected void ddlsavetime_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsavetime.SelectedItem.ToString() != "")
        {
            string strAppend = ddlsavetime.SelectedItem.ToString();
            txtTaskAssigned.Text = txtTaskAssigned.Text + " " + strAppend + " ";
        }
    }
    protected void DdlUhid_EntryAdded(object sender, AutoCompleteEntryEventArgs e)
    {
        try
        {
            string strrsn = e.Entry.Value;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDateAdd_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime date = dtpTargetDate.SelectedDate.Value;

            dtpTargetDate.SelectedDate = date.AddDays(1);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void btnDateMinus_Click(object sender, EventArgs e)
    {
        try
        {

            DateTime date = dtpTargetDate.SelectedDate.Value;

            dtpTargetDate.SelectedDate = date.AddDays(-1);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrackWD",
                                  new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = Session["ActivityTaskID"].ToString() },
                                  new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = txtTaskAssigned.Text },
                                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                  new SqlParameter() { ParameterName = "@FollowupDate", SqlDbType = SqlDbType.DateTime, Value = dtpFollowupdate.SelectedDate == null ? null : dtpFollowupdate.SelectedDate },
                                  new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                                  new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = 0 },
                                  new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue },
                                  new SqlParameter() { ParameterName = "@TimeSpent", SqlDbType = SqlDbType.Decimal, Value = 0 },
                                  new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedTo.SelectedValue },
                                  new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(Session["CustomerRSN"].ToString()) },
                                  new SqlParameter() { ParameterName = "@ProjectStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                                  new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                                  new SqlParameter() { ParameterName = "@CMail", SqlDbType = SqlDbType.NVarChar, Value = ddlcmail.SelectedValue }

                                  );


                WebMsgBox.Show(" The activity is updated will now appear in the Tasks list of the concerned person.");
                LoadComplaints();
                ClearScr();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void LoadCheckList()
    {
        DataSet dsCL = sqlobj.SQLExecuteDataset("SP_FetchSCheckList",
              new SqlParameter() { ParameterName = "@RefCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue });
        if (dsCL.Tables[0].Rows.Count > 0)
        {
            ddlCheckList.DataSource = dsCL.Tables[0];
            ddlCheckList.DataTextField = "Activity";
            ddlCheckList.DataValueField = "Activity";
            ddlCheckList.DataBind();

            ddlCheckList.Items.Insert(0, "Please Select");

            //txtTaskAssigned.Text = dscontacts.Tables[0].Rows[0]["ContactName"].ToString();
        }
        else
        {
            ddlCheckList.DataSource = dsCL.Tables[0];
            ddlCheckList.DataBind();
            ddlCheckList.Items.Insert(0, "Please Select");

            txtTaskAssigned.Text = "";


        }

    }

    protected void ddlCheckList_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCheckList.SelectedValue != "")
            {

                if (ddlCheckList.SelectedValue != "Please Select")
                {
                    txtTaskAssigned.Text = ddlCheckList.SelectedValue;
                }
                else
                {
                    txtTaskAssigned.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
        }
    }





}