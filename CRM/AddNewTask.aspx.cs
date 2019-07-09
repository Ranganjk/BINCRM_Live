using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using PMS;
using System.Web.Security;
using System.Net.Mail;

public partial class AddNewTask : System.Web.UI.Page
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

        rwNewLead.VisibleOnPageLoad = true;
        rwNewLead.Visible = false;


        if (!IsPostBack)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "New Task", DateTime.Now);

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
                LoadContactNames();
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
            //LoadCheckList();
            ddlNewLeadType.Enabled = false;
            txtNotes.Text = "New Lead";

            if (Request.QueryString["Group"] != null)
            {
                ddlReferenceGroup.SelectedValue = "Marketing";
                ddlTrackon.SelectedValue = "#Aptmnt";
                dtpFollowupdate.SelectedDate = Convert.ToDateTime(Request.QueryString["Date"].ToString());
                ddlReferenceGroup.Enabled = false;
                ddlTrackon.Enabled = false;
                dtpFollowupdate.Enabled = false;
            }
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

        ViewState["NewLead"] = dsCustName.Tables[0];

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
            string CustName;
            string strCustomerName = "";
            CustName = ddlCustName.SelectedValue;
            if (CnfResult.Value == "true")
            {
                if (txtTaskAssigned.Text != string.Empty)
                {
                    if (ddlTrackon.SelectedItem.Text != string.Empty)
                    {
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
                        if (ddlContactName.Visible == true || ddlContactName.SelectedIndex.ToString() != "-1")
                        {
                            txtTaskAssigned.Text = txtTaskAssigned.Text + " (" + ddlContactName.SelectedItem.Text + ")";
                        }

                        DataSet TaskID = sqlobj.SQLExecuteDataset("SP_InsertNewTask",
                                                 new SqlParameter() { ParameterName = "@CustName", SqlDbType = SqlDbType.NVarChar, Value = CustName },
                                                 new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedTo.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = ddlTrackon.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TaskType", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                 new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = string.IsNullOrEmpty(txtTaskAssigned.Text) ? " " : txtTaskAssigned.Text },
                                                 new SqlParameter() { ParameterName = "@AssignedOn", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpAssignOnDate.SelectedDate).ToString("yyyy-MM-dd HH:mm:ss") },
                                                 new SqlParameter() { ParameterName = "@AssignedBy", SqlDbType = SqlDbType.NVarChar, Value = ddlAssignedBy.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@TargetDate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDate.SelectedDate.Value },
                                                 new SqlParameter() { ParameterName = "@OtherAssignees", SqlDbType = SqlDbType.NVarChar, Value = string.IsNullOrEmpty(txtOtherAssignees.Text) ? " " : txtOtherAssignees.Text },
                                                 new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                                                 new SqlParameter() { ParameterName = "@QtyOfWork", SqlDbType = SqlDbType.NVarChar, Value = "BI" },
                                                 new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                                                 new SqlParameter() { ParameterName = "@Complexity", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                 new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                 new SqlParameter() { ParameterName = "@Docfive", SqlDbType = SqlDbType.NVarChar, Value = strdocfive.ToString() },
                                                 new SqlParameter() { ParameterName = "@CMail", SqlDbType = SqlDbType.NVarChar, Value = "N" }
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
        //LoadCheckList();
        lblCheckList.Visible = false;
        ddlCheckList.Visible = false;

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
        this.ClientScript.RegisterStartupScript(this.GetType(), "script", "CloseWindow();", true);
        //this.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "script", "CloseWindow();", true);
    }
    protected void ddlReferenceGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadTrackOn();
            //LoadCheckList();
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
    protected void ddlCustName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCustName.SelectedValue != "")
            {
                LoadContactNames();
            }
        }
        catch (Exception ex)
        {
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
                                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlCCustStatus.SelectedValue },
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

                                   new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = strNotes.ToString() + " " + txtNotes.Text },
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

                ddlType.SelectedValue = ddlNewLeadType.SelectedValue;

                LoadCustomer();
                string custname = txtCustName.Text + '-' + txtMob.Text;
                //ddlCustStatus.SelectedValue = ddlCCustStatus.SelectedValue;
                if (ViewState["NewLead"] != null)
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)ViewState["NewLead"];
                    DataRow[] rows = dt.Select("Name IN ('" + custname + "')", "", System.Data.DataViewRowState.CurrentRows);
                    ddlCustName.SelectedItem.Text = rows[0].ItemArray[0].ToString();
                    ddlCustName.SelectedValue = rows[0].ItemArray[1].ToString();
                    //ddlCustName.Refresh();
                }
                //ddlCustName.SelectedItem.Text = txtCustName.Text +'-'+ txtMob.Text;

                WebMsgBox.Show("New Profile Added.");
                txtCompanyName.Text = string.Empty;
                txtCustName.Text = string.Empty;
                txtEml.Text = string.Empty;
                txtMob.Text = string.Empty;
                txtNotes.Text = string.Empty;
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
        txtNotes.Text = string.Empty;
        rwNewLead.Visible = true;
    }

    protected void btnCUpate_Click(object sender, EventArgs e)
    {
        //rwStatusHelp.Visible = false;
        rwNewLead.Visible = false;
    }
    protected void btnNewLead_Click(object sender, EventArgs e)
    {
        LoadProspectTypes();
        rwNewLead.Visible = true;
    }

    protected void LoadProspectTypes()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();

        ddlCCustStatus.Items.Clear();

        //if (ddlType.SelectedItem.Text == "PROSPECT")
        //{
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 16 });
        //}
        //else if (ddlType.SelectedItem.Text == "VENDOR")
        //{
        //    dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
        //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 25 });
        //}
        //else if (ddlType.SelectedItem.Text == "OTHER")
        //{
        //    dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
        //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 23 });
        //}
        //else if (ddlType.SelectedItem.Text == "CUSTOMER")
        //{
        //    dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
        //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 24 });
        //}

        ddlCCustStatus.DataSource = dsCCustStatus.Tables[0];
        ddlCCustStatus.DataValueField = "StatusCode";
        ddlCCustStatus.DataTextField = "StatusDesc";
        ddlCCustStatus.DataBind();
        ddlCCustStatus.Dispose();

        ddlCCustStatus.Items.Insert(0, "Please Select");
    }
    protected void ddlNewLeadType_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadProspectTypes();

        rwNewLead.Visible = true;
    }
}