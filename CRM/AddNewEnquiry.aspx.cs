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
using System.Collections;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Net.Mail;

public partial class AddNewEnquiry : System.Web.UI.Page
{
    string UserID;
    SQLProcs sqlobj = new SQLProcs();
    string TaskType;
    protected void Page_Load(object sender, EventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsDT = null;
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);

        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;

        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;

        rwReferenceHelp.VisibleOnPageLoad = true;
        rwReferenceHelp.Visible = false;

        dtpFollowupdate.MinDate = DateTime.Today;
        dtpTargetDate.MinDate = DateTime.Today;

        ddlReferenceGroup.SelectedIndex = 0;
        ddlReferenceGroup.Enabled = false;


        if (!IsPostBack)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();

                return;
            }

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "New Enquiry", DateTime.Now);

            UserID = Session["UserID"].ToString();

            //dsDT = sqlobj.SQLExecuteDataset("GetServerDateTime");
            //lblDate.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy | hh:mm tt"); ;
            dtpAssignOnDate.SelectedDate = DateTime.Now.Date;
            dtpTargetDate.SelectedDate = DateTime.Now.AddDays(3);
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
                LoadCustomer();
                LoadTrackOn();


            }
            else if (TaskType == "FromProspect")
            {
                LoadProspectCustomer();
                ddlCustName.SelectedValue = Session["ProspectRSN"].ToString();
                ddlCustName.Enabled = false;

                ddlType.Enabled = false;

                LoadTrackOn();

                ddlTrackon.SelectedValue = Session["Reference"].ToString();

                ddlTrackon.Enabled = false;

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

            ddlTrackon.SelectedIndex = 1;
            ddlTrackon.Enabled = false;

            LoadRemarks();
            LoadSaveTime();

            LoadUserLevel();

            LoadLastEnquiryNo();
           
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
        //ddlCustStatus.Items.Insert(0, "Please Select");
        //ddlCustStatus.SelectedIndex = 0;
        dsCustStatus.Dispose();
    }

    protected void LoadLastEnquiryNo()
    {
        DataSet dsLastEnquiryNo = new DataSet();
        dsLastEnquiryNo = sqlobj.SQLExecuteDataset("SP_GetLastEnquiryNo");


        if (dsLastEnquiryNo != null)
        {
            if (dsLastEnquiryNo.Tables[0].Rows.Count > 0)
            {
                int lastenqno = Convert.ToInt32(dsLastEnquiryNo.Tables[0].Rows[0]["Lastenqno"].ToString()) + 1;

                txtTaskAssigned.Text = "Enquiry No:" + lastenqno.ToString();

                Session["LastEnqNo"] = lastenqno.ToString();
            }
            else
            {
                Session["LastEnqNo"] = null;
            }
        }
        dsLastEnquiryNo.Dispose();
    }

    protected void LoadProspectCustomer()
    {
        DataSet dsCustName = new DataSet();

        dsCustName = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 15 });




        ddlCustName.DataSource = dsCustName.Tables[0];
        ddlCustName.DataValueField = "CustRSN";
        ddlCustName.DataTextField = "Name";
        ddlCustName.DataBind();

        dsCustName.Dispose();
        ddlTrackon.Items.Clear();
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

    protected void LoadRemarks()
    {
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

    //protected void LoadComplexity()
    //{
    //    DataSet dsComplexity = new DataSet();
    //    dsComplexity = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
    //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 11 });
    //    ddlComplexity.DataSource = dsComplexity.Tables[0];
    //    ddlComplexity.DataValueField = "CodeValue";
    //    ddlComplexity.DataTextField = "CodeDesc";
    //    ddlComplexity.DataBind();
    //    ddlComplexity.SelectedIndex = 2;
    //    dsComplexity.Dispose();

    //}
    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if (txtTaskAssigned.Text != string.Empty)
                {
                    if (ddlTrackon.SelectedItem.Text != string.Empty)
                    {

                        DataSet dsenqexist = sqlobj.SQLExecuteDataset("SP_CheckExistEnquiry",
                        new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlCustName.SelectedValue });

                        if (dsenqexist != null)
                        {
                            if (dsenqexist.Tables[0].Rows.Count > 0)
                            {
                                int icount = Convert.ToInt32(dsenqexist.Tables[0].Rows[0]["count"].ToString());

                                if (icount > 0)
                                {
                                    //WebMsgBox.Show("Another Enquiry or Quote is currently in progress. Do you wish to add this also?");

                                    RadWindowManager1.RadConfirm("Another Enquiry or Quote is currently in progress. Do you wish to add this also?", "confirmCallbackFn", 400, 200, null, "Confirm");
                                }
                                else
                                {
                                    SaveEnquiry();
                                }
                            }
                        }
                    }
                    else
                    {
                        WebMsgBox.Show("Please select your appropriate Reference to your task.");
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

    private void SaveEnquiry()
    {
        try
        {
            string CustName;
            string strCustomerName = "";

            CustName = ddlCustName.SelectedValue;

            string strStatus = "";
            string strdocfive = "";

            DataSet dsCuststatus = new DataSet();
            dsCuststatus = sqlobj.SQLExecuteDataset("sp_getcustomerdetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = ddlCustName.SelectedValue });

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
            if(ddlContactName.Visible == true || ddlContactName.SelectedIndex.ToString() != "-1")
            {
                txtTaskAssigned.Text ="Contact Name : " + ddlContactName.SelectedItem.Text + " - " + txtTaskAssigned.Text;
            }
            
            DataSet TaskID = sqlobj.SQLExecuteDataset("SP_InsertNewTask",
                                             new SqlParameter() { ParameterName = "@CustName", SqlDbType = SqlDbType.NVarChar, Value = CustName },
                                             new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedTo.SelectedValue },
                                             new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue },
                                             new SqlParameter() { ParameterName = "@TaskType", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                             new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = string.IsNullOrEmpty(txtTaskAssigned.Text) ? " " : txtTaskAssigned.Text },
                                             new SqlParameter() { ParameterName = "@AssignedOn", SqlDbType = SqlDbType.DateTime, Value = dtpAssignOnDate.SelectedDate.Value },
                                             new SqlParameter() { ParameterName = "@AssignedBy", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedBy.SelectedValue },
                                             new SqlParameter() { ParameterName = "@TargetDate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDate.SelectedDate.Value },
                                             new SqlParameter() { ParameterName = "@OtherAssignees", SqlDbType = SqlDbType.NVarChar, Value = string.IsNullOrEmpty(txtOtherAssignees.Text) ? " " : txtOtherAssignees.Text },
                                             new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                                             new SqlParameter() { ParameterName = "@QtyOfWork", SqlDbType = SqlDbType.NVarChar, Value = "BI" },
                                             new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                                             new SqlParameter() { ParameterName = "@Complexity", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                             new SqlParameter() { ParameterName = "@Docfive", SqlDbType = SqlDbType.NVarChar, Value = strdocfive.ToString() },
                                             new SqlParameter() { ParameterName = "@CMail", SqlDbType = SqlDbType.NVarChar, Value = "Y" }
                                             );

            if (ddlTrackon.SelectedValue == "#Enquiry")
            {

                DataSet LastEnquiryNo = sqlobj.SQLExecuteDataset("SP_UpdateEnquiryNo",
                                        new SqlParameter() { ParameterName = "@LastEnquiryNo", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(Session["LastEnqNo"].ToString()) });
            }

            if (dtpFollowupdate.SelectedDate != null)
            {
                sqlobj.ExecuteSQLNonQuery("SP_UpdateFollowupdate",
                    new SqlParameter() { ParameterName = "@Followupdate", SqlDbType = SqlDbType.DateTime, Value = dtpFollowupdate.SelectedDate },
                    new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = TaskID.Tables[3].Rows[0]["RSN"].ToString() }
                    );




                SendmailWithIcsAttachment(Session["UserID"].ToString(), strCustomerName.ToString(), ddlTrackon.SelectedValue, txtTaskAssigned.Text, Convert.ToDateTime(dtpFollowupdate.SelectedDate));

            }
            WebMsgBox.Show(" The activity will now appear in the Tasks list of the concerned person.");
            ClearScr();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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
            LoadCustomer();
            LoadTrackOn();

            ddlTrackon.SelectedIndex = 1;
            ddlTrackon.Enabled = false;
        }
        else if (TaskType == "FromProspect")
        {
            LoadProspectCustomer();
            ddlCustName.SelectedValue = Session["ProspectRSN"].ToString();
            ddlCustName.Enabled = false;
            LoadTrackOn();
            ddlTrackon.SelectedValue = Session["Reference"].ToString();
            ddlTrackon.Enabled = false;
        }

        LoadAssignedTo();
        // LoadTaskType();
        LoadAssignedBy();
        // LoadStatus();
        LoadPriority();
        // LoadComplexity();

        dtpAssignOnDate.SelectedDate = DateTime.Now.Date;
        dtpTargetDate.SelectedDate = DateTime.Now.Date;
        txtOtherAssignees.Text = string.Empty;

        txtTaskAssigned.Text = string.Empty;

        UPLDocUpl1.Dispose();
        UPLDocUpl2.Dispose();
        UPLDocUpl3.Dispose();
        UPLDocUpl4.Dispose();
        UPLDocUpl5.Dispose();

        lblcontactname.Visible = false;
        ddlContactName.Visible = false;
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

    protected void btnNCSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                //if (txtNCustName.Text != string.Empty)
                //{
                //    sqlobj.ExecuteSQLNonQuery("SP_InsertNewProspect",
                //                           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtNCustName.Text },
                //                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCustStatus.SelectedValue },
                //                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                //    WebMsgBox.Show("New Prospects Saved");
                //    ClearNCScr();
                //}
                //else
                //{
                //    WebMsgBox.Show("Please enter customer name");
                //}
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    protected void btnNCClear_Click(object sender, EventArgs e)
    {
        ClearNCScr();

    }

    protected void ClearNCScr()
    {
        //txtNCustName.Text = string.Empty;
        //ddlCustStatus.SelectedIndex = 0;
        //this.txtNCustName.Focus();
        //LoadCustomer();
    }

    protected void chkcust_CheckedChanged(object sender, EventArgs e)
    {
        LoadCustomer();
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
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            LoadCustomer();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
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
        ClientScript.RegisterStartupScript(GetType(), "CloseScript", " window.close();", false);


    }
    protected void ddlReferenceGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadTrackOn();

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


            if (ddlTrackon.SelectedValue == "#Enquiry")
            {

            }




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        try
        {
            SaveEnquiry();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlCustName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadLastEnquiryNo();
            LoadContactNames();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void LoadContactNames()
    {
        DataSet dscontacts = sqlobj.SQLExecuteDataset("GetContactName",
              new SqlParameter() { ParameterName = "@CustRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlCustName.SelectedValue });
        if (dscontacts.Tables[0].Rows.Count > 0)
        {
            ddlContactName.DataSource = dscontacts.Tables[0];
            ddlContactName.DataTextField = "ContactName";
            ddlContactName.DataValueField = "ContactName";
            ddlContactName.DataBind();
            lblcontactname.Visible = true;
            ddlContactName.Visible = true;
            //txtTaskAssigned.Text = dscontacts.Tables[0].Rows[0]["ContactName"].ToString();
        }
        else
        {
            lblcontactname.Visible = false;
            ddlContactName.Visible = false;
            txtTaskAssigned.Text = "";
        }
    }
}