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
//using Microsoft.Practices.EnterpriseLibrary.Data; 

public partial class Admin : System.Web.UI.Page
{
    SQLProcs sqlobj = new SQLProcs();
    string strUserLevel;

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
            rwLoginAudit.VisibleOnPageLoad = true;
            rwLoginAudit.Visible = false;
            rwHelp.VisibleOnPageLoad = true;
            rwHelp.Visible = false;
            string statusflag = CnfResult.ClientID;
            if (!Page.IsPostBack)
            {

                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Admin", DateTime.Now);


                if (Session["SUPASSWORD"] != null)
                {
                    string strsupassword = Session["SUPASSWORD"].ToString();
                    if (strsupassword.ToString() == "a#m$n~")
                    {
                        DataSet dscount = sqlobj.SQLExecuteDataset("sp_checkadminexist");
                        int icount = Convert.ToInt32(dscount.Tables[0].Rows[0]["count"].ToString());
                        if (icount > 0)
                        {
                            btnAdminUpdate.Visible = true;
                            btnAdminSave.Visible = false;
                        }
                        else
                        {
                            btnAdminUpdate.Visible = false;
                            btnAdminSave.Visible = true;
                        }
                        btnAdminUpdate.Visible = true;
                        CompanyName.Enabled = true;
                        UserContact.Enabled = true;
                        txtdefaultconta.Enabled = true;
                        ContactMobile.Enabled = true;
                        FromEmailId.Enabled = true;
                        Remarks.Enabled = true;
                        ProductName.Enabled = true;
                        ProductByLine.Enabled = true;
                        VersionNumber.Enabled = true;
                        txtLastEnqNo.Enabled = true;
                        txtLastQuoteNo.Enabled = true;
                        txtLastOrderNo.Enabled = true;
                    }
                    else
                    {
                        if (!this.Page.User.Identity.IsAuthenticated)
                        {
                            FormsAuthentication.RedirectToLoginPage();
                            return;
                        }

                        btnAdminUpdate.Visible = false;
                        btnAdminUpdate.Visible = false;
                        CompanyName.Enabled = false;
                        UserContact.Enabled = false;
                        txtdefaultconta.Enabled = false;
                        ContactMobile.Enabled = false;
                        FromEmailId.Enabled = false;
                        Remarks.Enabled = false;
                        ProductName.Enabled = false;
                        ProductByLine.Enabled = false;
                        VersionNumber.Enabled = false;
                        txtLastEnqNo.Enabled = false;
                        txtLastQuoteNo.Enabled = false;
                        txtLastOrderNo.Enabled = false;
                        GetUserDet();
                    }
                }
                else
                {
                    if (!this.Page.User.Identity.IsAuthenticated)
                    {
                        FormsAuthentication.RedirectToLoginPage();

                        return;
                    }

                    btnAdminSave.Visible = false;
                    btnAdminUpdate.Visible = false;
                    CompanyName.Enabled = false;
                    UserContact.Enabled = false;
                    txtdefaultconta.Enabled = false;
                    ContactMobile.Enabled = false;
                    FromEmailId.Enabled = false;
                    Remarks.Enabled = false;
                    ProductName.Enabled = false;
                    ProductByLine.Enabled = false;
                    VersionNumber.Enabled = false;
                    txtLastEnqNo.Enabled = false;
                    txtLastQuoteNo.Enabled = false;
                    txtLastOrderNo.Enabled = false;
                    GetUserDet();
                }
                //string password = "";
                string password = txtPassword.Text;
                txtPassword.Attributes.Add("Value", password);
                //txtPassword.Visible = false;
                InformAllMessage.Attributes.Add("maxlength", InformAllMessage.MaxLength.ToString());
                Broadcastmessage.Attributes.Add("maxlength", Broadcastmessage.MaxLength.ToString());
                txtemailbody.Attributes.Add("maxlength", txtemailbody.MaxLength.ToString());
                txtRefHelp.Attributes.Add("maxlength", txtRefHelp.MaxLength.ToString());
                txthelptext.Attributes.Add("maxlength", txthelptext.MaxLength.ToString());


                dsDT = sqlobj.SQLExecuteDataset("GetServerDateTime");
                // lblDate1.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dddd") + " , " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy | hh:mm tt");

                LoadCompanyDetails();
                LoadCompanyInformation();

                dtpAssignOnDate.MaxDate = DateTime.Today;
                dtpBirthday.MaxDate = DateTime.Today;
                dtpWeddingday.MaxDate = DateTime.Today;

                strUserLevel = Session["UserLevel"].ToString();
                if (!(strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator"))
                {
                    btnCamSave.Enabled = false;
                    btnCamUpdate.Enabled = false;
                    btnRefSave.Enabled = false;
                    btnRefUpdate.Enabled = false;
                    btnRefDelete.Enabled = false;
                    btnBcmSave.Enabled = false;
                    btnIASave.Enabled = false;
                    btnIAUpdate.Enabled = false;
                    btnLCSave.Enabled = false;
                    btnLCUpdate.Enabled = false;
                    btnSSave.Enabled = false;
                    btnSUpdate.Enabled = false;
                    btnHUpdate.Enabled = false;

                    btnCamSave.ForeColor = Color.Gray;
                    btnCamUpdate.ForeColor = Color.Gray;
                    btnRefSave.ForeColor = Color.Gray;
                    btnRefUpdate.ForeColor = Color.Gray;
                    btnRefDelete.ForeColor = Color.Gray;
                    btnBcmSave.ForeColor = Color.Gray;
                    btnIASave.ForeColor = Color.Gray;
                    btnIAUpdate.ForeColor = Color.Gray;
                    btnLCSave.ForeColor = Color.Gray;
                    btnLCUpdate.ForeColor = Color.Gray;
                    btnSSave.ForeColor = Color.Gray;
                    btnSUpdate.ForeColor = Color.Gray;
                    btnHUpdate.ForeColor = Color.Gray;
                }
            }

            string did = btnRefDelete.ClientID.ToString();
            string ctrlName = Request.Params[postEventSourceID];
            string args = Request.Params[postEventArgumentID];

            if (ctrlName == SearchBox.UniqueID && args == "OnKeyUp")
            {
                SearchBox_OnKeyPress(ctrlName, args, SearchBox.Text);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void SearchBox_OnKeyPress(string ctrlName, string args, string Value)
    {
        if (SearchBox.Text != "")
        {
            var dt = (DataTable)ViewState["myDatatable"];
            var dv = new DataView();
            dv = dt.DefaultView;
            dv.Sort = "TrackonGroup,TrackonDesc,TrackonRemarks";
            dv.RowFilter = "TrackonGroup like '%" + Value + "%' or TrackonDesc like '%" + Value + "%' or TrackonRemarks like '%" + Value + "%'";
            gvMReference.DataSource = dv;
            gvMReference.DataBind();
        }
        //SearchBox.Focus();
    }


    public DataTable GetSearchFilteredData(string StoreProcedureName, string SQLTableVariableName, DataTable SearchFilterValues, string SortExpression, string SortDirection, int PageIndex, int PageSize)
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsReference = sqlobj.SQLExecuteDataset(StoreProcedureName,
       new SqlParameter() { ParameterName = SQLTableVariableName, SqlDbType = SqlDbType.Structured, Value = SearchFilterValues },
       new SqlParameter() { ParameterName = "@PageIndex", SqlDbType = SqlDbType.Int, Value = PageIndex },
       new SqlParameter() { ParameterName = "@PageSize", SqlDbType = SqlDbType.Int, Value = PageSize },
       new SqlParameter() { ParameterName = "@SortExpression", SqlDbType = SqlDbType.VarChar, Value = SortExpression },
       new SqlParameter() { ParameterName = "@SortDirection", SqlDbType = SqlDbType.VarChar, Value = SortDirection }
       );

        return dsReference.Tables[0];
    }



    // -- Menu Item start -- //
    protected void rmAdminMenu_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "About")
        {
            mvAdmin.SetActiveView(vwCompanyName);
        }
        else if (e.Item.Text == "Scrolling Banner")
        {
            mvAdmin.SetActiveView(vwBroadcastMessage);

            LoadBroadCastMessage();
        }
        else if (e.Item.Text == "Campaign")
        {
            mvAdmin.SetActiveView(vwCampaign);

            btnCamUpdate.Visible = false;

            rdtpcamstartson.SelectedDate = DateTime.Today;
            rdtpcamstartdate.SelectedDate = DateTime.Today;
            rdtpcamenddate.SelectedDate = DateTime.Today;
            rdtpcamendson.SelectedDate = DateTime.Today;

            LoadCampaignDetails();
            LoadACManager();
        }
        else if (e.Item.Text == "Inform All")
        {
            mvAdmin.SetActiveView(vwInformall);

            btnIAUpdate.Visible = false;

            LoadInformAll();
        }

        else if (e.Item.Text == "ROL")
        {
            //mvAdmin.SetActiveView(vwROL);

            //btnROLUpdate.Visible = false;

            //LoadStaffID();

            //LoadTotalROL();

            //LoadROL();
        }

        else if (e.Item.Text == "Login Audit")
        {
            mvAdmin.SetActiveView(vwLoginAudit);

            LoadLoginAudit();
        }

        else if (e.Item.Text == "User Management")
        {
            // User Management


            btnSUpdate.Visible = false;

            //StaffClear();

            LoadUserLevel();
            LoadUserStatus();
            LoadReportingHead();
            LoadStaffDetails();

            DateTime bd = DateTime.Now;

            var vbd = new DateTime(bd.Year, bd.Month, 1);



            dtpBirthday.SelectedDate = Convert.ToDateTime("01/01/1950");
            //dtpAssignOnDate.SelectedDate = Convert.ToDateTime(vbd);
            dtpAssignOnDate.SelectedDate = DateTime.Today;
            dtpWeddingday.SelectedDate = Convert.ToDateTime("01/01/1950");

            ddlUserStatus.Items.Insert(0, "Please Select");
            ddlReportinghead.Items.Insert(0, "Please Select");
            ddlUserLevel.Items.Insert(0, "Please Select");
            ddlUserStatus.SelectedIndex = 1;

            txtStaffID.Text = GetMaxStaffID();

            mvAdmin.SetActiveView(vwUserManagement);

        }
        else if (e.Item.Text == "Upload")
        {
            mvAdmin.SetActiveView(vwUpload);
        }
        else if (e.Item.Text == "Return")
        {

            Response.Redirect("ManageNTaskList.aspx");
            //string jScript = "<script>window.close();</script>";
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "keyClientBlock", jScript);
        }

        else if (e.Item.Text == "KeyLookUp")
        {
            btnUpdate.Visible = false;
            LoadMoreinfoLkUp();
            //LoadNextKey();

            mvAdmin.SetActiveView(vwKeyLookUP);
        }
        else if (e.Item.Text == "LeadCategory")
        {
            btnLCUpdate.Visible = false;
            LoadLeadCategory();
            mvAdmin.SetActiveView(vwLeadCategory);

        }
        else if (e.Item.Text == "Reference")
        {
            btnRefUpdate.Visible = false;
            btnRefDelete.Visible = false;
            LoadTrackOn();
            mvAdmin.SetActiveView(vwReference);
            SearchBox.Focus();
        }
        else if (e.Item.Text == "Mails")
        {
            GetMails();
            mvAdmin.SetActiveView(vwMails);
        }
        else if (e.Item.Text == "Holiday")
        {

            mvAdmin.SetActiveView(vwHoliday);
            btnHUpdate.Visible = false;
            LoadHoliday();
        }
        else if (e.Item.Text == "Check List")
        {

            mvAdmin.SetActiveView(vwCheckList);
            btnCLUpdate.Visible = false;
            LoadRefCode();
            LoadCheckList();




        }
    }


    protected void GetMails()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMails = new DataSet();

            dsMails = sqlobj.SQLExecuteDataset("proc_GetAllMailDetails");
            if (dsMails.Tables[0].Rows.Count > 0)
            {
                gvMails.DataSource = dsMails.Tables[0];
                gvMails.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    // -- Menu Item End -- //

    protected void btnSUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int Final = 0;
            string semail = "";

            if (CnfResult.Value == "true")
            {

                DateTime DtBirth = Convert.ToDateTime(dtpBirthday.SelectedDate);
                int Last = DtBirth.Year;

                DateTime DtFrom = Convert.ToDateTime(DateTime.Today);
                int From = DtFrom.Year;

                Final = From - Last;
                if (Final < 18)
                {
                    WebMsgBox.Show("Please select Valid Date of Birth");
                    return;
                }

                if (txtPassword.Text == "")
                {
                    txtPassword.Text = txtStaffUserName.Text;
                }

                SQLProcs sqlobj = new SQLProcs();

                DataSet dsCCustStatus = sqlobj.SQLExecuteDataset("sp_getstaffinfo",
               new SqlParameter() { ParameterName = "@username", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    semail = dsCCustStatus.Tables[0].Rows[0]["StaffEmail"].ToString();
                }

                dsCCustStatus.Dispose();


                sqlobj.ExecuteSQLNonQuery("SP_UpdateStaffdetails",
                                                                  new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = txtStaffID.Text },
                                                                  new SqlParameter() { ParameterName = "@StaffName", SqlDbType = SqlDbType.NVarChar, Value = txtStaffName.Text },
                                                                  new SqlParameter() { ParameterName = "@StaffEmail", SqlDbType = SqlDbType.NVarChar, Value = txtStaffEmail.Text },
                                                                  new SqlParameter() { ParameterName = "@StaffPhone", SqlDbType = SqlDbType.NVarChar, Value = txtStaffPhone.Text },
                                                                  new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = txtStaffAddLine1.Text },
                                                                  new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = txtStaffaddline2.Text },
                                                                  new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = txtStaffCity.Text },
                                                                  new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = txtStaffPostalCode.Text },
                                                                  new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = txtStaffState.Text },
                                                                  new SqlParameter() { ParameterName = "@JoiningDate", SqlDbType = SqlDbType.DateTime, Value = dtpAssignOnDate.SelectedDate },
                                                                  new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtStaffDesignation.Text },
                                                                  new SqlParameter() { ParameterName = "@ReportingHead", SqlDbType = SqlDbType.NVarChar, Value = ddlReportinghead.SelectedItem.Text },
                                                                  new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = txtStaffUserName.Text },
                                                                  new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPassword.Text },
                                                                  new SqlParameter() { ParameterName = "@UserLevel", SqlDbType = SqlDbType.Int, Value = ddlUserLevel.SelectedValue },
                                                                  new SqlParameter() { ParameterName = "@UserStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlUserStatus.SelectedValue },
                                                                  new SqlParameter() { ParameterName = "@LeadStatus", SqlDbType = SqlDbType.NVarChar, Value = ddllsuf.SelectedValue },
                                                                  new SqlParameter() { ParameterName = "@Birthday", SqlDbType = SqlDbType.Date, Value = dtpBirthday.SelectedDate },
                                                                  new SqlParameter() { ParameterName = "@WeddingDay", SqlDbType = SqlDbType.Date, Value = dtpWeddingday.SelectedDate }

                                                                  );


                LoadStaffDetails();

                StaffClear();

                WebMsgBox.Show("User details updated.  A confirmation mail has also been sent to your email id which is " + semail.ToString());



            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void gvStaffDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Int64 istaffid = Convert.ToInt64(gvStaffDetails.Rows[index].Cells[1].Text);
                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetStaffDetails",
                    new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {
                    txtStaffID.Text = dsCCustStatus.Tables[0].Rows[0]["StaffID"].ToString();
                    txtStaffName.Text = dsCCustStatus.Tables[0].Rows[0]["StaffName"].ToString();
                    txtStaffEmail.Text = dsCCustStatus.Tables[0].Rows[0]["StaffEmail"].ToString();
                    txtStaffAddLine1.Text = dsCCustStatus.Tables[0].Rows[0]["AddrLine1"].ToString();
                    txtStaffaddline2.Text = dsCCustStatus.Tables[0].Rows[0]["AddrLine2"].ToString();
                    txtStaffCity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
                    txtStaffState.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
                    txtStaffPhone.Text = dsCCustStatus.Tables[0].Rows[0]["StaffPhone"].ToString();
                    txtStaffPostalCode.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();

                    if (dsCCustStatus.Tables[0].Rows[0]["Joiningdate"].ToString() != "")
                    {
                        DateTime jdate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["Joiningdate"].ToString());
                        dtpAssignOnDate.SelectedDate = jdate;
                    }

                    if (dsCCustStatus.Tables[0].Rows[0]["Birthday"].ToString() != "")
                    {
                        DateTime bdate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["Birthday"].ToString());
                        dtpBirthday.SelectedDate = bdate;
                    }

                    if (dsCCustStatus.Tables[0].Rows[0]["WeddingDay"].ToString() != "")
                    {
                        DateTime wdate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["WeddingDay"].ToString());
                        dtpWeddingday.SelectedDate = wdate;
                    }
                    txtStaffDesignation.Text = dsCCustStatus.Tables[0].Rows[0]["Designation"].ToString();
                    ddlReportinghead.SelectedItem.Text = dsCCustStatus.Tables[0].Rows[0]["ReportingHead"].ToString();
                    txtStaffUserName.Text = dsCCustStatus.Tables[0].Rows[0]["UserName"].ToString();


                    ddlUserLevel.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["UserLevel"].ToString();
                    ddlUserStatus.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["User_Status"].ToString();
                    ddllsuf.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["LS_UF"].ToString();

                    //txtPassword.Visible = true;
                    txtPassword.Enabled = false;
                    //txtPassword.Text = dsCCustStatus.Tables[0].Rows[0]["Password"].ToString();
                    txtPassword.Attributes["value"] = dsCCustStatus.Tables[0].Rows[0]["Password"].ToString();
                    //txtPassword.Attributes.Add("value", txtPassword.Text);
                    btnSUpdate.Visible = true;
                    btnSSave.Visible = false;
                }
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
        // lblproductbyline1.Text = Session["ProductByLine"].ToString();
        // lblcompanyName1.Text = Session["CompanyName"].ToString();
        // lblVersion.Text = Session["Version"].ToString();
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






    protected void LoadNextKey()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsNextKey = new DataSet();

        dsNextKey = sqlobj.SQLExecuteDataset("SP_LoadNextKey",
            new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NChar, Value = ddlmoreinfolkupgroup.SelectedValue }
            );

        if (dsNextKey.Tables[0].Rows.Count > 0)
        {
            //ddlnextkey.DataSource = dsNextKey;
            //ddlnextkey.DataValueField = "Moreinfokey";
            //ddlnextkey.DataTextField = "Moreinfokey";
            //ddlnextkey.DataBind();  
        }

        dsNextKey.Dispose();

    }

    // -- Start Company Infomation -- //

    protected void LoadCompanyInformation()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dscount = sqlobj.SQLExecuteDataset("sp_checkadminexist");

            int icount = Convert.ToInt32(dscount.Tables[0].Rows[0]["count"].ToString());

            if (icount > 0)
            {
                //btnAdminUpdate.Visible = true;
                // btnAdminSave.Visible = false;
            }
            else
            {
                //btnAdminUpdate.Visible = false;
                //sbtnAdminSave.Visible = true;
            }


            DataSet dsCompanyInformation = new DataSet();

            dsCompanyInformation = sqlobj.SQLExecuteDataset("sp_LoadCompanyInformation");

            if (dsCompanyInformation.Tables[0].Rows.Count > 0)
            {
                CompanyName.Text = dsCompanyInformation.Tables[0].Rows[0]["CompanyName"].ToString();
                UserContact.Text = dsCompanyInformation.Tables[0].Rows[0]["UserContact"].ToString();
                txtdefaultconta.Text = dsCompanyInformation.Tables[0].Rows[0]["DefaultContact"].ToString();
                ContactMobile.Text = dsCompanyInformation.Tables[0].Rows[0]["ContactMobile"].ToString();
                FromEmailId.Text = dsCompanyInformation.Tables[0].Rows[0]["FromEmailId"].ToString();
                Remarks.Text = dsCompanyInformation.Tables[0].Rows[0]["Remarks"].ToString();
                ProductName.Text = dsCompanyInformation.Tables[0].Rows[0]["ProductName"].ToString();
                ProductByLine.Text = dsCompanyInformation.Tables[0].Rows[0]["ProductByLine"].ToString();
                VersionNumber.Text = dsCompanyInformation.Tables[0].Rows[0]["VersionNumber"].ToString();
                txtLastEnqNo.Text = dsCompanyInformation.Tables[0].Rows[0]["EnqNo"].ToString();
                txtLastQuoteNo.Text = dsCompanyInformation.Tables[0].Rows[0]["QuoteNo"].ToString();
                txtLastOrderNo.Text = dsCompanyInformation.Tables[0].Rows[0]["OrderNo"].ToString();

                string strISCM = dsCompanyInformation.Tables[0].Rows[0]["ISCM"].ToString();

                if (strISCM == "True")
                {
                    // lblISCM.Text = "CM Present";
                }
                else
                {
                    // lblISCM.Text = ""; 
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnAdminSave_Click(object sender, EventArgs e)
    {
        SQLProcs sqlobj = new SQLProcs();

        sqlobj.ExecuteSQLNonQuery("SP_savetblwmadmin",
            new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NChar, Value = CompanyName.Text },
            new SqlParameter() { ParameterName = "@UserContact", SqlDbType = SqlDbType.NVarChar, Value = UserContact.Text },
            new SqlParameter() { ParameterName = "@DefaultContact", SqlDbType = SqlDbType.NVarChar, Value = txtdefaultconta.Text },
            new SqlParameter() { ParameterName = "@ContactMobile", SqlDbType = SqlDbType.NVarChar, Value = ContactMobile.Text },
            new SqlParameter() { ParameterName = "@FromEmailId", SqlDbType = SqlDbType.NVarChar, Value = FromEmailId.Text },
            new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = Remarks.Text },
            new SqlParameter() { ParameterName = "@ProductName", SqlDbType = SqlDbType.NVarChar, Value = ProductName.Text },
            new SqlParameter() { ParameterName = "@ProductByLine", SqlDbType = SqlDbType.NVarChar, Value = ProductByLine.Text },
            new SqlParameter() { ParameterName = "@VersionNumber", SqlDbType = SqlDbType.NVarChar, Value = VersionNumber.Text },
            new SqlParameter() { ParameterName = "@LastEnqNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastEnqNo.Text },
            new SqlParameter() { ParameterName = "@LastQuoteNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastQuoteNo.Text },
            new SqlParameter() { ParameterName = "@LastOrderNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastOrderNo.Text },
            new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
            );


        sqlobj.ExecuteSQLNonQuery("SP_insertprospects",
                                          new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = "BIZ" },
                                          new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = UserContact.Text },
                                          new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "OTHR" },
                                          new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = "OTHER" },
                                          new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = ContactMobile.Text },
                                          new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = FromEmailId.Text },
                                          new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                                          new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = null },

                                          new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = null },

                                          new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                          new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = CompanyName.Text },
                                          new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = null }

                                          );


        sqlobj.ExecuteSQLNonQuery("SP_insertstaff",
                                                                             new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = 1001 },
                                                                             new SqlParameter() { ParameterName = "@StaffName", SqlDbType = SqlDbType.NVarChar, Value = UserContact.Text },
                                                                             new SqlParameter() { ParameterName = "@StaffEmail", SqlDbType = SqlDbType.NVarChar, Value = FromEmailId.Text },
                                                                             new SqlParameter() { ParameterName = "@StaffPhone", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                                             new SqlParameter() { ParameterName = "@JoiningDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                                                             new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = "Manager" },
                                                                             new SqlParameter() { ParameterName = "@ReportingHead", SqlDbType = SqlDbType.NVarChar, Value = "Manager" },
                                                                             new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = txtdefaultconta.Text },
                                                                             new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtdefaultconta.Text },
                                                                             new SqlParameter() { ParameterName = "@UserLevel", SqlDbType = SqlDbType.Int, Value = 1 },
                                                                             new SqlParameter() { ParameterName = "@UserStatus", SqlDbType = SqlDbType.NVarChar, Value = "AC" },
                                                                             new SqlParameter() { ParameterName = "@LeadStatus", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                                                                             new SqlParameter() { ParameterName = "@Birthday", SqlDbType = SqlDbType.Date, Value = DateTime.Now },
                                                                             new SqlParameter() { ParameterName = "@WeddingDay", SqlDbType = SqlDbType.Date, Value = DateTime.Now }
                                                                             );


        LoadCompanyInformation();

        WebMsgBox.Show("Company Information saved");
    }

    protected void btnAdminUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            SQLProcs sqlobj = new SQLProcs();

            sqlobj.ExecuteSQLNonQuery("SP_Updatetblwmadmin",
                new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NChar, Value = CompanyName.Text },
                new SqlParameter() { ParameterName = "@UserContact", SqlDbType = SqlDbType.NVarChar, Value = UserContact.Text },
                new SqlParameter() { ParameterName = "@DefaultContact", SqlDbType = SqlDbType.NVarChar, Value = txtdefaultconta.Text },
                new SqlParameter() { ParameterName = "@ContactMobile", SqlDbType = SqlDbType.NVarChar, Value = ContactMobile.Text },
                new SqlParameter() { ParameterName = "@FromEmailId", SqlDbType = SqlDbType.NVarChar, Value = FromEmailId.Text },
                new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = Remarks.Text },
                new SqlParameter() { ParameterName = "@ProductName", SqlDbType = SqlDbType.NVarChar, Value = ProductName.Text },
                new SqlParameter() { ParameterName = "@ProductByLine", SqlDbType = SqlDbType.NVarChar, Value = ProductByLine.Text },
                new SqlParameter() { ParameterName = "@VersionNumber", SqlDbType = SqlDbType.NVarChar, Value = VersionNumber.Text },
                new SqlParameter() { ParameterName = "@LastEnqNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastEnqNo.Text },
                new SqlParameter() { ParameterName = "@LastQuoteNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastQuoteNo.Text },
                new SqlParameter() { ParameterName = "@LastOrderNo", SqlDbType = SqlDbType.NVarChar, Value = txtLastOrderNo.Text },
                new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                );

            LoadCompanyInformation();

            WebMsgBox.Show("Company Information Updated");




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    protected void btnAdminExit_Click(object sender, EventArgs e)
    {
        Server.Transfer("ManageNTaskList.aspx");

        //string jScript = "<script>window.close();</script>";
        //ClientScript.RegisterClientScriptBlock(this.GetType(), "keyClientBlock", jScript);
    }

    // -- End Company Information -- //

    // -- Start Broadcast Message --//

    protected void LoadBroadCastMessage()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsBroadCastMessage = new DataSet();

        dsBroadCastMessage = sqlobj.SQLExecuteDataset("SP_LoadBroadCastMessage");

        if (dsBroadCastMessage.Tables[0].Rows.Count > 0)
        {
            gvbroadcastmsg.DataSource = dsBroadCastMessage;
            gvbroadcastmsg.DataBind();
        }

        dsBroadCastMessage.Dispose();

    }

    protected void btnBcmSave_Click(object sender, EventArgs e)
    {
        try
        {
            strUserLevel = Session["UserLevel"].ToString();


            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {

                if (Broadcastmessage.Text != "")
                {

                    SQLProcs sqlobj = new SQLProcs();

                    sqlobj.ExecuteSQLNonQuery("SP_Inserttblbroadcastmsg",
                        new SqlParameter() { ParameterName = "@Broadcastmessage", SqlDbType = SqlDbType.NChar, Value = Broadcastmessage.Text },
                        new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() }
                        );

                    Broadcastmessage.Text = "";

                    LoadBroadCastMessage();

                    WebMsgBox.Show("Now this message will appear as a Scrolling Banner in the Sign-In screen.");
                }
                else
                {
                    WebMsgBox.Show("Please enter the Broadcast message.");
                }

            }
            else
            {
                WebMsgBox.Show("Access denied");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnBcmClear_Click(object sender, EventArgs e)
    {
        Broadcastmessage.Text = "";
    }
    protected void btnBcmExit_Click(object sender, EventArgs e)
    {
        mvAdmin.SetActiveView(vwCompanyName);
    }
    protected void gvbroadcastmsg_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvbroadcastmsg.PageIndex = e.NewPageIndex;
        LoadBroadCastMessage();
    }
    protected void gvbroadcastmsg_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        //ImageButton imgbtn = (ImageButton)e.CommandSource;
        //GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
        //GridView mygrid = (GridView)sender;
        //string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();


        //Session["BroadCastMsgRSN"] = strRSN.ToString();

        //SQLProcs sqlobj = new SQLProcs();
        //DataSet dsBroadCastMessage = new DataSet();

        //dsBroadCastMessage = sqlobj.SQLExecuteDataset("SP_GetBroadCastMessage",
        //     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["BroadCastMsgRSN"].ToString() }
        //    );

        //if (dsBroadCastMessage.Tables[0].Rows.Count > 0)
        //{
        //    Broadcastmessage.Text = dsBroadCastMessage.Tables[0].Rows[0]["BroadcastMessage"].ToString();      
        //}

        //dsBroadCastMessage.Dispose();  



    }

    // -- End Broadcast Message -- //

    // -- Start Inform All -- //

    protected void LoadInformAll()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsInformAll = new DataSet();

        dsInformAll = sqlobj.SQLExecuteDataset("SP_LoadInformAll");

        if (dsInformAll.Tables[0].Rows.Count > 0)
        {
            gvinformall.DataSource = dsInformAll;
            gvinformall.DataBind();
        }

        dsInformAll.Dispose();
    }

    protected void btnIASave_Click(object sender, EventArgs e)
    {
        try
        {

            strUserLevel = Session["UserLevel"].ToString();


            if (InformAllMessage.Text != "")
            {

                if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
                {

                    SQLProcs sqlobj = new SQLProcs();

                    sqlobj.ExecuteSQLNonQuery("SP_Inserttblinformall",
                        new SqlParameter() { ParameterName = "@InformAllMessage", SqlDbType = SqlDbType.NChar, Value = InformAllMessage.Text },
                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() }
                        );

                    InformAllMessage.Text = "";

                    LoadInformAll();

                    WebMsgBox.Show("Now this message will be broadcast to all active users.Use this option often to communicate with the users.");
                }
                else
                {
                    WebMsgBox.Show("Access denied");
                }
            }
            else
            {
                WebMsgBox.Show("Please enter the Message.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void btnIAUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            strUserLevel = Session["UserLevel"].ToString();


            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {

                SQLProcs sqlobj = new SQLProcs();

                sqlobj.ExecuteSQLNonQuery("SP_Updatetblinformall",
                    new SqlParameter() { ParameterName = "@InformAllMessage", SqlDbType = SqlDbType.NChar, Value = InformAllMessage.Text },
                    new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NChar, Value = Session["InformAllRSN"].ToString() }
                    );

                InformAllMessage.Text = "";

                LoadInformAll();

                btnIASave.Visible = true;
                btnIAUpdate.Visible = false;

                WebMsgBox.Show("InformAll messages updated.");
            }
            else
            {
                WebMsgBox.Show("Access denied");
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnIAClear_Click(object sender, EventArgs e)
    {
        InformAllMessage.Text = "";
        btnIASave.Visible = true;
        btnIAUpdate.Visible = false;
        LoadInformAll();
    }
    protected void btnIAExit_Click(object sender, EventArgs e)
    {
        mvAdmin.SetActiveView(vwCompanyName);
    }
    protected void gvinformall_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvinformall.PageIndex = e.NewPageIndex;
        LoadInformAll();
    }
    protected void gvinformall_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Commented by Prakash.M
        //ImageButton imgbtn = (ImageButton)e.CommandSource;
        //GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
        //GridView mygrid = (GridView)sender;
        //string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();


        //Session["InformAllRSN"] = strRSN.ToString();

        //SQLProcs sqlobj = new SQLProcs();
        //DataSet dsInformAll = new DataSet();

        //dsInformAll = sqlobj.SQLExecuteDataset("SP_GetInformAll",
        //     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["InformAllRSN"].ToString() }
        //    );

        //if (dsInformAll.Tables[0].Rows.Count > 0)
        //{
        //    InformAllMessage.Text = dsInformAll.Tables[0].Rows[0]["InformAllMessage"].ToString();
        //    btnIAUpdate.Visible = true;
        //    btnIASave.Visible = false; 
        //}

        //dsInformAll.Dispose();  
    }

    // -- End inform All -- //
    // -- Start ROL -- //

    //protected void LoadStaffID()
    //{
    //    SQLProcs sqlobj = new SQLProcs();
    //    DataSet dsStaffID = new DataSet();

    //    dsStaffID = sqlobj.SQLExecuteDataset("sp_fetchdropdown",
    //        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = "3" }
    //        );

    //    if (dsStaffID.Tables[0].Rows.Count > 0)
    //    {
    //        ddlStaffID.DataSource = dsStaffID;
    //        ddlStaffID.DataValueField = "StaffID";
    //        ddlStaffID.DataTextField = "StaffName"; 
    //        ddlStaffID.DataBind();
    //    }

    //    dsStaffID.Dispose();  
    //}

    //protected void LoadTotalROL()
    //{
    //    SQLProcs sqlobj = new SQLProcs();
    //    DataSet dsTotalROL = new DataSet();

    //    dsTotalROL = sqlobj.SQLExecuteDataset("SP_getTodayROL");

    //    if (dsTotalROL.Tables[0].Rows.Count > 0)
    //    {
    //        lbltotalRecognition.Text = "Recognition(s) recorded given today : " + dsTotalROL.Tables[0].Rows[0]["Count"].ToString(); 
    //    }

    //    dsTotalROL.Dispose();  
    //}

    //protected void LoadROL()
    //{
    //    SQLProcs sqlobj = new SQLProcs();
    //    DataSet dsROL = new DataSet();

    //    dsROL = sqlobj.SQLExecuteDataset("SP_LoadROL");

    //    if (dsROL.Tables[0].Rows.Count > 0)
    //    {
    //        gvROL.DataSource = dsROL;
    //        gvROL.DataBind();
    //    }

    //    dsROL.Dispose();  
    //}

    //protected void btnROLSave_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //         strUserLevel = Session["UserLevel"].ToString();

    //         if (ROLMessage.Text != "")
    //         {
    //             if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
    //             {

    //                 SQLProcs sqlobj = new SQLProcs();

    //                 sqlobj.ExecuteSQLNonQuery("SP_InserttblROL",
    //                     new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NChar, Value = ddlStaffID.SelectedValue },
    //                     new SqlParameter() { ParameterName = "@ROLTYPE", SqlDbType = SqlDbType.NChar, Value = ddlROLTYPE.SelectedValue },
    //                     new SqlParameter() { ParameterName = "@ROLMessage", SqlDbType = SqlDbType.NChar, Value = ROLMessage.Text },
    //                     new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() }
    //                     );

    //                 ddlROLTYPE.SelectedIndex = 0;
    //                 ddlStaffID.SelectedIndex = 0;
    //                 ROLMessage.Text = "";

    //                 LoadTotalROL();

    //                 LoadROL();

    //                 WebMsgBox.Show("Information saved.");
    //             }
    //             else
    //             {
    //                 WebMsgBox.Show("Access denied");
    //             }
    //         }
    //         else
    //         {
    //             WebMsgBox.Show("Please enter a message");  
    //         }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);   
    //    }
    //}
    //protected void btnROLUpdate_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //         strUserLevel = Session["UserLevel"].ToString();


    //         if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
    //         {

    //             SQLProcs sqlobj = new SQLProcs();

    //             sqlobj.ExecuteSQLNonQuery("SP_UpdatetblROL",
    //                 new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NChar, Value = ddlStaffID.SelectedValue },
    //                 new SqlParameter() { ParameterName = "@ROLTYPE", SqlDbType = SqlDbType.NChar, Value = ddlROLTYPE.SelectedValue },
    //                 new SqlParameter() { ParameterName = "@ROLMessage", SqlDbType = SqlDbType.NChar, Value = ROLMessage.Text },
    //                 new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NChar, Value = Session["UserID"].ToString() },
    //                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ROLRSN"].ToString() }
    //                 );

    //             ddlROLTYPE.SelectedIndex = 0;
    //             ddlStaffID.SelectedIndex = 0;
    //             ROLMessage.Text = "";

    //             btnROLUpdate.Visible = false;
    //             btnROLSave.Visible = true;

    //             LoadROL();

    //             WebMsgBox.Show("Information Updated.");
    //         }
    //         else
    //         {
    //             WebMsgBox.Show("Access denied");  
    //         }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);   
    //    }
    //}
    //protected void btnROLClear_Click(object sender, EventArgs e)
    //{
    //    ddlROLTYPE.SelectedIndex = 0;
    //    ddlStaffID.SelectedIndex = 0;
    //    ROLMessage.Text = "";

    //    btnROLUpdate.Visible = false;
    //    btnROLSave.Visible = true;

    //    LoadROL();
    //}
    //protected void btnROLExit_Click(object sender, EventArgs e)
    //{
    //    mvAdmin.SetActiveView(vwCompanyName);  
    //}
    //protected void gvROL_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gvROL.PageIndex = e.NewPageIndex;

    //    LoadROL(); 
    //}
    //protected void gvROL_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    strUserLevel = Session["UserLevel"].ToString();


    //    if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
    //    {


    //        ImageButton imgbtn = (ImageButton)e.CommandSource;
    //        GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
    //        GridView mygrid = (GridView)sender;
    //        string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();


    //        Session["ROLRSN"] = strRSN.ToString();

    //        SQLProcs sqlobj = new SQLProcs();
    //        DataSet dsROL = new DataSet();

    //        dsROL = sqlobj.SQLExecuteDataset("SP_GetROL",
    //             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ROLRSN"].ToString() }
    //            );

    //        if (dsROL.Tables[0].Rows.Count > 0)
    //        {
    //            ddlStaffID.SelectedValue = dsROL.Tables[0].Rows[0]["StaffID"].ToString();
    //            ddlROLTYPE.SelectedValue = dsROL.Tables[0].Rows[0]["ROLType"].ToString();
    //            ROLMessage.Text = dsROL.Tables[0].Rows[0]["ROLMessage"].ToString();
    //            btnROLUpdate.Visible = true;
    //            btnROLSave.Visible = false;
    //        }

    //        dsROL.Dispose();
    //    }
    //    else
    //    {
    //        WebMsgBox.Show("Access denied");  
    //    }
    //}

    // -- End ROL -- //

    // -- Start Login Audit -- //

    protected void LoadLoginAudit()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLoginAudit = new DataSet();

        dsLoginAudit = sqlobj.SQLExecuteDataset("SP_LoadLoginAudit");

        if (dsLoginAudit.Tables[0].Rows.Count > 0)
        {
            gvLoginAudit.DataSource = dsLoginAudit;
            gvLoginAudit.DataBind();
        }

        dsLoginAudit.Dispose();
    }

    protected void gvLoginAudit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLoginAudit.PageIndex = e.NewPageIndex;
        LoadLoginAudit();
    }

    protected void gvLoginAudit_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "View")
        {
            strUserLevel = Session["UserLevel"].ToString();


            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;
                string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();


                Session["LoginAuditRSN"] = strRSN.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsLoginAudit = new DataSet();

                dsLoginAudit = sqlobj.SQLExecuteDataset("SP_GetLoginAudit",
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["LoginAuditRSN"].ToString() }
                    );

                if (dsLoginAudit.Tables[0].Rows.Count > 0)
                {
                    lblstaff.Text = dsLoginAudit.Tables[0].Rows[0]["StaffID"].ToString();
                    lblAction.Text = dsLoginAudit.Tables[0].Rows[0]["Action"].ToString();
                    lblDate.Text = dsLoginAudit.Tables[0].Rows[0]["Date"].ToString();
                    lblBrowser.Text = dsLoginAudit.Tables[0].Rows[0]["Browser"].ToString();
                    lblDevice.Text = dsLoginAudit.Tables[0].Rows[0]["Device"].ToString();
                    lblipaddress.Text = dsLoginAudit.Tables[0].Rows[0]["ipaddress"].ToString();
                }

                dsLoginAudit.Dispose();

                rwLoginAudit.Visible = true;
            }
            else
            {
                WebMsgBox.Show("Access denied");
            }
        }
    }

    // -- End Login Audit -- //


    // -- Users Management Starts Here.

    protected void LoadUserLevel()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 20 });
        ddlUserLevel.DataSource = dsCCustStatus.Tables[0];
        ddlUserLevel.DataValueField = "UserLevelID";
        ddlUserLevel.DataTextField = "UserLevelName";
        ddlUserLevel.DataBind();
        ddlUserLevel.Dispose();
    }

    protected void LoadUserStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 22 });
        ddlUserStatus.DataSource = dsCCustStatus.Tables[0];
        ddlUserStatus.DataValueField = "CodeValue";
        ddlUserStatus.DataTextField = "CodeDesc";
        ddlUserStatus.DataBind();
        ddlUserStatus.Dispose();
    }

    protected void LoadReportingHead()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 21 });

        ddlReportinghead.DataSource = dsCCustStatus.Tables[0];
        ddlReportinghead.DataValueField = "StaffID";
        ddlReportinghead.DataTextField = "UserName";
        ddlReportinghead.DataBind();
        ddlReportinghead.Dispose();
    }

    protected void LoadStaffDetails()
    {

        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_StaffDetails");

        gvStaffDetails.DataSource = dsCCustStatus;
        gvStaffDetails.DataBind();
    }

    public string GetMaxStaffID()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaffID = new DataSet();
        string StaffID = "";
        try
        {
            dsStaffID = sqlobj.SQLExecuteDataset("proc_MaxStaffID");
            if (dsStaffID.Tables[0].Rows.Count > 0)
            {
                int CStaffID = Convert.ToInt32(dsStaffID.Tables[0].Rows[0][0].ToString());
                CStaffID += 1;
                return StaffID = CStaffID.ToString();
            }
            else
            {
                return StaffID = "1001";
            }

        }
        catch (Exception ex)
        {
            return StaffID;
        }
    }


    protected void btnSSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {
                int Final = 0;

                if (txtStaffID.Text == "" || txtStaffName.Text == "" || txtStaffEmail.Text == "" || txtStaffPhone.Text == "" ||
                    dtpAssignOnDate.SelectedDate == null || ddlReportinghead.SelectedIndex == 0 ||
                    txtStaffUserName.Text == "" || ddlUserLevel.SelectedIndex == 0 || ddlUserStatus.SelectedIndex == 0)
                {
                    WebMsgBox.Show("Please enter or select the mandatory fields");
                }
                else
                {

                    DateTime DtBirth = Convert.ToDateTime(dtpBirthday.SelectedDate);
                    int Last = DtBirth.Year;

                    DateTime DtFrom = Convert.ToDateTime(DateTime.Today);
                    int From = DtFrom.Year;

                    Final = From - Last;
                    if (Final < 18)
                    {
                        WebMsgBox.Show("Please select Valid Date of Birth");
                        return;
                    }

                    if (IsStaffIDExisting(Convert.ToDouble(txtStaffID.Text)))
                    {
                        txtStaffID.Text = "";
                        txtStaffID.Focus();
                        WebMsgBox.Show("This staff id already existing");
                    }
                    else
                    {
                        if (IsUserNameExisting(txtStaffUserName.Text))
                        {
                            txtStaffUserName.Text = "";
                            txtStaffUserName.Focus();
                            WebMsgBox.Show("This user name already existing");

                        }

                        else
                        {
                            txtPassword.Text = txtStaffUserName.Text;

                            SQLProcs sqlobj = new SQLProcs();
                            sqlobj.ExecuteSQLNonQuery("SP_insertstaff",
                                                                              new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = txtStaffID.Text },
                                                                              new SqlParameter() { ParameterName = "@StaffName", SqlDbType = SqlDbType.NVarChar, Value = txtStaffName.Text },
                                                                              new SqlParameter() { ParameterName = "@StaffEmail", SqlDbType = SqlDbType.NVarChar, Value = txtStaffEmail.Text },
                                                                              new SqlParameter() { ParameterName = "@StaffPhone", SqlDbType = SqlDbType.NVarChar, Value = txtStaffPhone.Text },
                                                                              new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = txtStaffAddLine1.Text },
                                                                              new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = txtStaffaddline2.Text },
                                                                              new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = txtStaffCity.Text },
                                                                              new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = txtStaffPostalCode.Text },
                                                                              new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = txtStaffState.Text },
                                                                              new SqlParameter() { ParameterName = "@JoiningDate", SqlDbType = SqlDbType.DateTime, Value = dtpAssignOnDate.SelectedDate },
                                                                              new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtStaffDesignation.Text },
                                                                              new SqlParameter() { ParameterName = "@ReportingHead", SqlDbType = SqlDbType.NVarChar, Value = ddlReportinghead.SelectedItem.Text },
                                                                              new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = txtStaffUserName.Text },
                                                                              new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPassword.Text },
                                                                              new SqlParameter() { ParameterName = "@UserLevel", SqlDbType = SqlDbType.Int, Value = ddlUserLevel.SelectedValue },
                                                                              new SqlParameter() { ParameterName = "@UserStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlUserStatus.SelectedValue },
                                                                              new SqlParameter() { ParameterName = "@LeadStatus", SqlDbType = SqlDbType.NVarChar, Value = ddllsuf.SelectedValue },
                                                                              new SqlParameter() { ParameterName = "@Birthday", SqlDbType = SqlDbType.Date, Value = dtpBirthday.SelectedDate },
                                                                              new SqlParameter() { ParameterName = "@WeddingDay", SqlDbType = SqlDbType.Date, Value = dtpWeddingday.SelectedDate }
                                                                              );





                            LoadStaffDetails();

                            StaffClear();

                            WebMsgBox.Show("Staff Details Saved.");
                        }
                    }

                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private bool IsStaffIDExisting(double staffid)
    {
        bool IsExisting;

        SQLProcs sqlobj = new SQLProcs();
        DataSet dspe = new DataSet();
        dspe = sqlobj.SQLExecuteDataset("SP_CheckExistingStaffID",
            new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = staffid });

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

    private bool IsUserNameExisting(string username)
    {
        bool IsExisting;

        SQLProcs sqlobj = new SQLProcs();
        DataSet dspe = new DataSet();
        dspe = sqlobj.SQLExecuteDataset("SP_CheckExistingUserName",
            new SqlParameter() { ParameterName = "@StaffUserName", SqlDbType = SqlDbType.NVarChar, Value = username });

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

    protected void btnSClear_Click(object sender, EventArgs e)
    {
        StaffClear();
    }

    protected void StaffClear()
    {
        txtStaffID.Text = GetMaxStaffID();
        txtStaffEmail.Text = "";
        txtStaffName.Text = "";
        txtStaffPhone.Text = "";
        txtStaffState.Text = "";
        txtStaffAddLine1.Text = "";
        txtStaffaddline2.Text = "";
        txtStaffCity.Text = "";
        txtStaffPostalCode.Text = "";
        txtStaffDesignation.Text = "";
        dtpAssignOnDate.Clear();
        dtpWeddingday.Clear();
        dtpBirthday.Clear();
        ddlReportinghead.SelectedIndex = 0;
        txtStaffUserName.Text = "";
        txtPassword.Text = string.Empty;
        txtPassword.Attributes.Add("value", txtPassword.Text);
        ddlUserLevel.SelectedIndex = 0;
        ddlUserStatus.SelectedIndex = 1;

        ddlReportinghead.SelectedIndex = 0;


        txtPassword.Enabled = false;

        DateTime bd = DateTime.Now;

        var vbd = new DateTime(bd.Year, bd.Month, 1);



        dtpBirthday.SelectedDate = Convert.ToDateTime("01/01/1950");
        dtpAssignOnDate.SelectedDate = DateTime.Today;
        dtpWeddingday.SelectedDate = Convert.ToDateTime("01/01/1950");

        btnSSave.Visible = true;
        btnSUpdate.Visible = false;


        //LoadProspectDetails();

    }



    // -- Users Management Ends Here.


    // -- KeyLookUP Starts Here

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_InsertmoreinfoLkUp",
                                              new SqlParameter() { ParameterName = "@MoreInfoGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlmoreinfolkupgroup.SelectedValue },
                                              new SqlParameter() { ParameterName = "@MoreInfoKey", SqlDbType = SqlDbType.NVarChar, Value = txtMoreInfoKey.Text },
                                              new SqlParameter() { ParameterName = "@MoreInfoSequence", SqlDbType = SqlDbType.Int, Value = txtMoreInfoSequence.Text },
                                              new SqlParameter() { ParameterName = "@MoreInfoDesc", SqlDbType = SqlDbType.NVarChar, Value = txtMoreInfoDesc.Text },
                                              new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                              new SqlParameter() { ParameterName = "@Dropdownvalues", SqlDbType = SqlDbType.NVarChar, Value = txtdropdownvalues.Text },
                                              new SqlParameter() { ParameterName = "@HelpText", SqlDbType = SqlDbType.NVarChar, Value = txthelptext.Text }

                                              );
                LoadMoreinfoLkUp();
                LkupClear();

                WebMsgBox.Show("More information lookup saved");

            }
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
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_UdpatemoreinfoLkUp",
                                              new SqlParameter() { ParameterName = "@MoreInfoGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlmoreinfolkupgroup.SelectedValue },
                                              new SqlParameter() { ParameterName = "@MoreInfoKey", SqlDbType = SqlDbType.NVarChar, Value = txtMoreInfoKey.Text },
                                              new SqlParameter() { ParameterName = "@MoreInfoSequence", SqlDbType = SqlDbType.Int, Value = txtMoreInfoSequence.Text },
                                              new SqlParameter() { ParameterName = "@MoreInfoDesc", SqlDbType = SqlDbType.NVarChar, Value = txtMoreInfoDesc.Text },
                                              new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() },
                                              new SqlParameter() { ParameterName = "@Dropdownvalues", SqlDbType = SqlDbType.NVarChar, Value = txtdropdownvalues.Text },
                                              new SqlParameter() { ParameterName = "@HelpText", SqlDbType = SqlDbType.NVarChar, Value = txthelptext.Text }
                                              );
                LoadMoreinfoLkUp();
                LkupClear();

                WebMsgBox.Show("More information lookup updated");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            LkupClear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LkupClear()
    {
        txtMoreInfoKey.Text = "";
        txtMoreInfoDesc.Text = "";
        txtMoreInfoSequence.Text = "";
        txtdropdownvalues.Text = "";
        txthelptext.Text = "";
        //ddlireq.SelectedIndex = 0;
        //ddlvreq.SelectedIndex = 0;
        //ddldreq.SelectedIndex = 0; 

        btnSave.Visible = true;
        btnUpdate.Visible = false;

    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            mvAdmin.SetActiveView(vwCompanyName);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void LoadMoreinfoLkUp()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMoreinfolkup = new DataSet();
            dsMoreinfolkup = sqlobj.SQLExecuteDataset("SP_LoadMoreinfoLkUp");

            if (dsMoreinfolkup.Tables[0].Rows.Count > 0)
            {
                gvmoreinfoLkUp.DataSource = dsMoreinfolkup;
                gvmoreinfoLkUp.DataBind();
            }

            dsMoreinfolkup.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvmoreinfoLkUp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvmoreinfoLkUp.PageIndex = e.NewPageIndex;
            LoadMoreinfoLkUp();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvmoreinfoLkUp_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int index = Convert.ToInt32(e.CommandArgument);

            //LoadCCustStatus();

            ImageButton imgbtn = (ImageButton)e.CommandSource;
            GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
            GridView mygrid = (GridView)sender;
            string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();
            Session["RSN"] = strRSN.ToString();

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMoreinfoLkUp = new DataSet();
            dsMoreinfoLkUp = sqlobj.SQLExecuteDataset("SP_GetMoreinfoLkUp",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = strRSN.ToString() });

            if (dsMoreinfoLkUp.Tables[0].Rows.Count > 0)
            {
                ddlmoreinfolkupgroup.SelectedValue = dsMoreinfoLkUp.Tables[0].Rows[0]["MoreinfoGroup"].ToString();
                txtMoreInfoKey.Text = dsMoreinfoLkUp.Tables[0].Rows[0]["Moreinfokey"].ToString();
                txtMoreInfoSequence.Text = dsMoreinfoLkUp.Tables[0].Rows[0]["MoreinfoSequence"].ToString();
                txtMoreInfoDesc.Text = dsMoreinfoLkUp.Tables[0].Rows[0]["MoreinfoDesc"].ToString();
                txtdropdownvalues.Text = dsMoreinfoLkUp.Tables[0].Rows[0]["DValues"].ToString();
                txthelptext.Text = dsMoreinfoLkUp.Tables[0].Rows[0]["HelpText"].ToString();

                btnSave.Visible = false;
                btnUpdate.Visible = true;
            }


            dsMoreinfoLkUp.Dispose();

        }
    }



    // -- KeyLookUP Ends Here


    // -- Customers bulk upload starts here -- //


    protected void btnUploadProspect_Click(object sender, EventArgs e)
    {
        try
        {
            FileInfo uploadedFile;
            Int64 count = 0;
            string fileName = string.Empty;
            int res = 0;
            if (FLuploadProspect.HasFile == true)
            {
                string[] strFormat = FLuploadProspect.FileName.Split('.');
                if (strFormat[strFormat.Length - 1] != "xls")
                {
                    WebMsgBox.Show("Kindly select correct excel sheet format(.xls) to upload data");
                    return;
                }
                fileName = Server.MapPath(@"~/UploadExl/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + FLuploadProspect.FileName;
                FLuploadProspect.SaveAs(fileName);
                uploadedFile = new FileInfo(fileName);
                string fileLocation = Server.MapPath(@"~/UploadExl/") + uploadedFile.Name;
                DataTable dt = new DataTable();

                dt = exceldata(fileLocation);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sqlobj.ExecuteSQLNonQuery("SP_BulkUploadCustomers",
                    new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["Title"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["Name"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["Mobile"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["EmailID"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["Status"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = dt.Rows[i]["Type"].ToString().Trim() },
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = Session["UserID"].ToString() }
                    );
                }

                //dbTran.Commit();
                WebMsgBox.Show("Customers are successfully uploaded.");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error in uploading. Correct the data before uploading.");
        }
    }


    public static DataTable exceldata(string filelocation)
    {
        try
        {
            DataSet ds = new DataSet();
            OleDbCommand excelCommand = new OleDbCommand();
            // OleDbConnection oconn = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath(@"~/UploadExl/") + fuFileName.FileName + ";Extended Properties=Excel 8.0");
            OleDbDataAdapter excelDataAdapter = new OleDbDataAdapter();
            //string excelConnStr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + filelocation + "; Extended Properties =Excel 8.0;";
            string excelConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filelocation + ";Extended Properties=Excel 8.0;";
            //string excelConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;" & "Data Source=" + filelocation + ";Extended Properties=Excel 8.0;HDR=YES;";
            OleDbConnection excelConn = new OleDbConnection(excelConnStr);
            excelConn.Open();
            DataTable dtSAP = new DataTable();
            excelCommand = new OleDbCommand("SELECT * FROM [Sheet1$]", excelConn);
            excelDataAdapter.SelectCommand = excelCommand;
            excelDataAdapter.Fill(dtSAP);
            return dtSAP;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
            return null;
        }

    }

    // -- Customers bulk upload ends here -- //



    protected void ddlmoreinfolkupgroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadNextKey();
    }


    // Lead Category Lookup

    private void LoadLeadCategory()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsleadcategory = new DataSet();
        dsleadcategory = sqlobj.SQLExecuteDataset("sp_loadcategory");

        if (dsleadcategory.Tables[0].Rows.Count > 0)
        {
            gvLeadCategory.DataSource = dsleadcategory;
            gvLeadCategory.DataBind();
        }

        dsleadcategory.Dispose();
    }

    private void ClearCategory()
    {
        btnLCUpdate.Visible = false;
        btnLCSave.Visible = true;
        txtleadcategory.Text = "";
        txtLeadCategoryCode.Text = "";
        LoadLeadCategory();
    }

    protected void btnLCSave_Click(object sender, EventArgs e)
    {
        try
        {
            //LeadCategory LC = new LeadCategory();


            if (txtleadcategory.Text == "" || txtLeadCategoryCode.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter all the Fields');", true);
                return;
            }
            if (CnfResult.Value == "true")
            {
                // LC.Save(txtLeadCategoryCode.Text, txtleadcategory.Text, Session["UserID"].ToString(), "SP_InsertCategoryLkup"); 


                sqlobj.ExecuteSQLNonQuery("SP_InsertCategoryLkup",
                        new SqlParameter() { ParameterName = "@CatCode", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = txtLeadCategoryCode.Text },
                        new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = txtleadcategory.Text },
                        new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = Session["UserID"].ToString() }

                        );
                ClearCategory();

                WebMsgBox.Show("New Caltegory lookup added.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnLCUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                sqlobj.ExecuteSQLNonQuery("sp_updateleadcategory",
                        new SqlParameter() { ParameterName = "@CatCode", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = txtLeadCategoryCode.Text },
                        new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = txtleadcategory.Text },
                        new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = Session["UserID"].ToString() },
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = Session["LeadCategoryRSN"].ToString() }

                        );

                ClearCategory();

                WebMsgBox.Show("Caltegory lookup updated.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnLCClear_Click(object sender, EventArgs e)
    {
        try
        {
            ClearCategory();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnLCExit_Click(object sender, EventArgs e)
    {
        try
        {
            mvAdmin.SetActiveView(vwCompanyName);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvLeadCategory_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Select")
        {

            btnLCUpdate.Visible = true;
            btnLCSave.Visible = false;

            int i = Convert.ToInt32(e.CommandArgument);

            ImageButton imgbtn = (ImageButton)e.CommandSource;
            GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
            GridView mygrid = (GridView)sender;
            string strRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();
            Session["LeadCategoryRSN"] = strRSN.ToString();

            txtleadcategory.Text = gvLeadCategory.Rows[i].Cells[2].Text;
            txtLeadCategoryCode.Text = gvLeadCategory.Rows[i].Cells[1].Text;

        }




    }

    // campaign start//

    private void LoadACManager()
    {
        SQLProcs sqlobj = new SQLProcs();

        DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

        if (dsMasters.Tables[4].Rows.Count > 0)
        {
            ddlCamResponsibility.DataSource = dsMasters.Tables[4];
            ddlCamResponsibility.DataValueField = "UserName";
            ddlCamResponsibility.DataTextField = "StaffName";
            ddlCamResponsibility.DataBind();
        }
    }

    private void LoadCampaignDetails()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCampaignDetails = new DataSet();

            dsCampaignDetails = sqlobj.SQLExecuteDataset("sp_getCampaignDetails");

            if (dsCampaignDetails.Tables[0].Rows.Count != 0)
            {
                gvMCampaign.DataSource = dsCampaignDetails;
                gvMCampaign.DataBind();


            }

            dsCampaignDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvMCampaign_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMCampaign.PageIndex = e.NewPageIndex;
        LoadCampaignDetails();

    }

    protected void gvMCampaign_RowCommand(object sender, GridViewCommandEventArgs e)
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
                string strCampaignRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strCampaignRSN);

                Session["CampaignRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_LoadCampaignDetails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    txtAddCampaignvalue.Text = dsCCustStatus.Tables[0].Rows[0]["CampaignValue"].ToString();
                    rdtpcamstartdate.SelectedDate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["StartDate"].ToString());
                    rdtpcamenddate.SelectedDate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["EndDate"].ToString());
                    if (dsCCustStatus.Tables[0].Rows[0]["CStartDate"].ToString() != "")
                    {
                        rdtpcamstartson.SelectedDate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["CStartDate"].ToString());
                    }
                    if (dsCCustStatus.Tables[0].Rows[0]["CfinalDate"].ToString() != "")
                    {
                        rdtpcamendson.SelectedDate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["CfinalDate"].ToString());
                    }
                    if (dsCCustStatus.Tables[0].Rows[0]["Responsibility"].ToString() != "")
                    {
                        ddlCamResponsibility.SelectedItem.Text = dsCCustStatus.Tables[0].Rows[0]["Responsibility"].ToString();
                    }

                    txtCampaigninfo.Text = dsCCustStatus.Tables[0].Rows[0]["CampaignInfo"].ToString();
                    ddlCampaignStatus.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["CampaignStatus"].ToString();
                    ddlsendanemail.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["EmailSendFlag"].ToString();
                    txtemailsubjectline.Text = dsCCustStatus.Tables[0].Rows[0]["EmailSubject"].ToString();
                    txtemailbody.Text = dsCCustStatus.Tables[0].Rows[0]["EmailBody"].ToString();
                    txtemailbody.Text.Replace(Environment.NewLine, "<br/>");


                    btnCamUpdate.Visible = true;
                    btnCamSave.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnCamSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtAddCampaignvalue.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please Enter campaign value');", true);
                return;
            }
            if (Convert.ToDateTime(rdtpcamstartson.SelectedDate) > Convert.ToDateTime(rdtpcamstartdate.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the PreWorkStartsOn and Start date');", true);
                return;
            }

            if (Convert.ToDateTime(rdtpcamstartdate.SelectedDate) > Convert.ToDateTime(rdtpcamenddate.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the Start and End date');", true);
                return;
            }
            if (Convert.ToDateTime(rdtpcamenddate.SelectedDate) > Convert.ToDateTime(rdtpcamendson.SelectedDate))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please check the PostWorkEndsOn and End date');", true);
                return;
            }


            if (CnfResult.Value == "true")
            {

                SQLProcs sqlobj = new SQLProcs();



                sqlobj.ExecuteSQLNonQuery("SP_insertcampaign",

                                         new SqlParameter() { ParameterName = "@CampaignValue", SqlDbType = SqlDbType.NVarChar, Value = txtAddCampaignvalue.Text },
                                         new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = rdtpcamstartdate.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = rdtpcamenddate.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@CStartdate", SqlDbType = SqlDbType.Date, Value = rdtpcamstartson.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@Cfinaldate", SqlDbType = SqlDbType.Date, Value = rdtpcamendson.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@CampaignInfo", SqlDbType = SqlDbType.NVarChar, Value = txtCampaigninfo.Text },
                                         new SqlParameter() { ParameterName = "@CampaignStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlCampaignStatus.SelectedValue },
                                         new SqlParameter() { ParameterName = "@EmailSendFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlsendanemail.SelectedValue },
                                         new SqlParameter() { ParameterName = "@EmailSubject", SqlDbType = SqlDbType.NVarChar, Value = txtemailsubjectline.Text },
                                         new SqlParameter() { ParameterName = "@EmailBody", SqlDbType = SqlDbType.NVarChar, Value = txtemailbody.Text.Replace(Environment.NewLine, "<br/>") },
                                         new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                         new SqlParameter() { ParameterName = "@Responsibility", SqlDbType = SqlDbType.NVarChar, Value = ddlCamResponsibility.SelectedValue },
                                         new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] }

                                         );


                LoadCampaignDetails();

                //ddlCompaign.Items.Insert(0, "");

                CamClear();



                WebMsgBox.Show("Campaign details saved.");
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnCamUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                SQLProcs sqlobj = new SQLProcs();


                string strCompaignstatus = ddlCampaignStatus.SelectedValue;
                string strSendEmail;
                if (strCompaignstatus == "Close")
                {
                    strSendEmail = "0";
                }
                else
                {
                    strSendEmail = "1";
                }

                sqlobj.ExecuteSQLNonQuery("SP_updatecampaign",

                                         new SqlParameter() { ParameterName = "@CampaignValue", SqlDbType = SqlDbType.NVarChar, Value = txtAddCampaignvalue.Text },
                                         new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = rdtpcamstartdate.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = rdtpcamenddate.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@CStartdate", SqlDbType = SqlDbType.Date, Value = rdtpcamstartson.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@Cfinaldate", SqlDbType = SqlDbType.Date, Value = rdtpcamendson.SelectedDate.Value },
                                         new SqlParameter() { ParameterName = "@CampaignInfo", SqlDbType = SqlDbType.NVarChar, Value = txtCampaigninfo.Text },
                                         new SqlParameter() { ParameterName = "@CampaignStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlCampaignStatus.SelectedValue },
                                         new SqlParameter() { ParameterName = "@EmailSendFlag", SqlDbType = SqlDbType.NVarChar, Value = strSendEmail.ToString() },
                                         new SqlParameter() { ParameterName = "@EmailSubject", SqlDbType = SqlDbType.NVarChar, Value = txtemailsubjectline.Text },
                                         new SqlParameter() { ParameterName = "@EmailBody", SqlDbType = SqlDbType.NVarChar, Value = txtemailbody.Text },
                                         new SqlParameter() { ParameterName = "@Responsibility", SqlDbType = SqlDbType.NVarChar, Value = ddlCamResponsibility.SelectedValue },
                                         new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"] },
                                         new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["CampaignRSN"] }
                                         );


                LoadCampaignDetails();



                CamClear();



                WebMsgBox.Show("Campaign details updated.");
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void CamClear()
    {
        txtAddCampaignvalue.Text = "";

        rdtpcamstartdate.SelectedDate = DateTime.Now.Date;
        rdtpcamenddate.SelectedDate = DateTime.Now.Date;
        txtCampaigninfo.Text = "";
        ddlsendanemail.SelectedIndex = 0;
        //ddlCampaignStatus.SelectedIndex = 0;
        //ddlCompaign.SelectedValue = "General";
        txtemailsubjectline.Text = "";
        txtemailbody.Text = "";
        btnCamUpdate.Visible = false;
        btnCamSave.Visible = true;



    }
    protected void btnCamClear_Click(object sender, EventArgs e)
    {
        CamClear();

    }


    protected void btnCamClose_Click(object sender, EventArgs e)
    {

    }

    //campaign end//

    // Reference start


    protected void LoadTrackOn()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup");



        if (dsTrackon.Tables[0].Rows.Count != 0)
        {

            gvMReference.DataSource = dsTrackon.Tables[0];
            gvMReference.AllowPaging = true;
            gvMReference.DataBind();

            ViewState["myDatatable"] = dsTrackon.Tables[0];
            //gvSearchReference.DataSource = dsTrackon.Tables[0];
            // gvSearchReference.DataBind(); 

        }
        else
        {
            ViewState["myDatatable"] = dsTrackon.Tables[0];
            gvMReference.DataSource = null;
            gvMReference.DataBind();
        }

        dsTrackon.Dispose();


    }

    private void ReferenceClear()
    {
        txtReference.Text = "";
        // txtRemarks.Text = "";
        btnRefUpdate.Visible = false;
        btnRefDelete.Visible = false;
        btnRefSave.Visible = true;
        ddlRefGroup.SelectedIndex = 0;
        txtRefHelp.Text = "";
        txtRefRemakrs.Text = "";
    }
    protected void btnRefSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtReference.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter all the Fields');", true);
                return;
            }

            if (CnfResult.Value == "true")
            {
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_InsertReference",
                                                                 new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = txtReference.Text },
                                                                 new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRefRemakrs.Text },
                                                                 new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlRefGroup.SelectedValue },
                                                                 new SqlParameter() { ParameterName = "@HelpText", SqlDbType = SqlDbType.NVarChar, Value = txtRefHelp.Text },
                                                                 new SqlParameter() { ParameterName = "@User", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                                 new SqlParameter() { ParameterName = "@FinalStatusFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlFinalStatusFlag.SelectedValue == "Yes" ? true : false }
                                                                 );



                LoadTrackOn();



                ReferenceClear();

                WebMsgBox.Show("New Reference Added.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvMReference_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMReference.PageIndex = e.NewPageIndex;
        LoadTrackOn();

    }

    protected void btnRefUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_UpdateReference",
                                                                 new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = txtReference.Text },
                                                                 new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRefRemakrs.Text },
                                                                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ReferenceRSN"].ToString() },
                                                                 new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlRefGroup.SelectedValue },
                                                                 new SqlParameter() { ParameterName = "@HelpText", SqlDbType = SqlDbType.NVarChar, Value = txtRefHelp.Text },
                                                                 new SqlParameter() { ParameterName = "@User", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                                 new SqlParameter() { ParameterName = "@FinalStatusFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlFinalStatusFlag.SelectedValue == "Yes" ? true : false }
                                                                 );



                LoadTrackOn();

                //ddlTrackon.Items.Insert(0, "Please Select");

                ReferenceClear();

                WebMsgBox.Show("Reference Updated.");

            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnRefDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            if (CnfResult.Value == "true")
            {






                sqlobj.ExecuteSQLNonQuery("SP_DeleteReference",
                                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ReferenceRSN"].ToString() }
                                          );
                LoadTrackOn();

                //ddlTrackon.Items.Insert(0, "Please Select");

                ReferenceClear();

                WebMsgBox.Show("Reference Deleted.");
            }

        }




        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvMReference_RowCommand(object sender, GridViewCommandEventArgs e)
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
                string strReferenceRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strReferenceRSN);

                Session["ReferenceRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_LoadReferenceDeatails",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    ddlRefGroup.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["TrackOnGroup"].ToString();
                    txtReference.Text = dsCCustStatus.Tables[0].Rows[0]["TrackOnDesc"].ToString();
                    txtRefRemakrs.Text = dsCCustStatus.Tables[0].Rows[0]["TrackOnRemarks"].ToString();
                    txtRefHelp.Text = dsCCustStatus.Tables[0].Rows[0]["HelpText"].ToString();
                    ddlFinalStatusFlag.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["StatusFlag"].ToString();


                    btnRefUpdate.Visible = true;

                    if (txtReference.Text != "#Order")
                    {
                        if (txtReference.Text != "#Enquiry")
                        {
                            if (txtReference.Text != "#Quote")
                            {

                                if (txtReference.Text != "#MobileApp")
                                {
                                    btnRefDelete.Visible = true;
                                }
                            }
                        }
                    }


                    if (txtReference.Text == "#Order" || txtReference.Text == "#Enquiry" || txtReference.Text == "#Quote" || txtReference.Text == "#MobileApp")
                    {
                        btnRefDelete.Visible = false;
                    }

                    btnRefSave.Visible = false;

                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnRefClear_Click(object sender, EventArgs e)
    {
        try
        {
            ReferenceClear();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnRefClose_Click(object sender, EventArgs e)
    {
        mvAdmin.SetActiveView(vwCompanyName);
    }

    // Reference end
    protected void gvStaffDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvStaffDetails.PageIndex = e.NewPageIndex;
        LoadStaffDetails();
    }



    protected void ExportToExcel(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Reference.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            gvMReference.AllowPaging = false;
            this.LoadTrackOn();

            gvMReference.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in gvMReference.HeaderRow.Cells)
            {
                cell.BackColor = gvMReference.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in gvMReference.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = gvMReference.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = gvMReference.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            gvMReference.AllowPaging = true;
            this.LoadTrackOn();

            gvMReference.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    //protected void gvinformall_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{

    //}
    //protected void gvinformall_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{

    //}
    protected void txtPassword_TextChanged(object sender, EventArgs e)
    {
        txtPassword.TextMode = TextBoxMode.Password;
    }
    protected void gvMails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMails.PageIndex = e.NewPageIndex;
        GetMails();
    }
    protected void gvMails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            if (e.CommandName.Equals("Mails"))
            {
                int RSN = Convert.ToInt32(e.CommandArgument.ToString());

                Session["MailRSN"] = RSN.ToString();
                string userid = Session["UserID"].ToString();

                DataSet dsCCustStatus = sqlobj.SQLExecuteDataset("sp_getstaffinfo",
                new SqlParameter() { ParameterName = "@username", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    Session["StaffEmail"] = dsCCustStatus.Tables[0].Rows[0]["StaffEmail"].ToString();

                    RadWindowManager1.RadConfirm("A sample email will be sent to your email id which is " + dsCCustStatus.Tables[0].Rows[0]["StaffEmail"].ToString(), "confirmCallbackFn", 400, 150, null, "Confirm");
                }

                dsCCustStatus.Dispose();


            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Mail formats not available')", true);
        }
    }

    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true;
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        try
        {
            sqlobj.ExecuteSQLNonQuery("proc_sendmails",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.BigInt, Value = Session["MailRSN"].ToString() },
                   new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
            // ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Mail sent successfully.');", true);

            WebMsgBox.Show("A sample mail is sent to your email id which is " + Session["StaffEmail"]);


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvMReference_Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTrackon = new DataSet();
            dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup");

            if (dsTrackon.Tables[0].Rows.Count != 0)
            {

                DataTable dtreference = new DataTable();

                dtreference = dsTrackon.Tables[0];

                dtreference.DefaultView.Sort = e.SortExpression;

                gvMReference.DataSource = dtreference;
                gvMReference.AllowPaging = true;
                gvMReference.DataBind();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    [WebMethod]
    public static ProductDetails[] GetReference(string Value)
    {
        DataTable dtreference = new DataTable();
        List<ProductDetails> details = new List<ProductDetails>();
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTrackon = new DataSet();
            dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup");
            if (dsTrackon.Tables[0].Rows.Count != 0)
            {
                dtreference = dsTrackon.Tables[0];
                string expression = "TrackonGroup ='" + Value + "' or TrackonDesc='" + Value + "' or TrackonRemarks = '" + Value + "' or Helptext='" + Value + "'";
                DataRow[] dr = dtreference.Select(expression);
                //gvMReference.DataSource = dr;
                //gvMReference.DataBind();

                foreach (DataRow dtrow in dtreference.Rows)
                {
                    ProductDetails product = new ProductDetails();
                    product.TrackonGroup = dtrow["TrackonGroup"].ToString();
                    product.TrackonDesc = dtrow["TrackonDesc"].ToString();
                    product.TrackonRemarks = dtrow["TrackonRemarks"].ToString();
                    product.Helptext = dtrow["Helptext"].ToString();
                    product.StatusFlag = dtrow["StatusFlag"].ToString();
                    details.Add(product);
                }


            }
            //return dtreference;
            return details.ToArray();
        }
        catch (Exception ex)
        {
            //return dtreference;
            return details.ToArray();
        }


    }
    public class ProductDetails
    {
        public string TrackonGroup { get; set; }
        public string TrackonDesc { get; set; }
        public string TrackonRemarks { get; set; }
        public string Helptext { get; set; }
        public string StatusFlag { get; set; }
    }
    protected void gvMReference_DataBound(object sender, EventArgs e)
    {
        try
        {

            //GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            //for (int i = 1; i < gvMReference.Columns.Count; i++)
            //{
            //    TableHeaderCell cell = new TableHeaderCell();
            //    TextBox txtSearch = new TextBox();
            //    txtSearch.Width = 50;

            //    txtSearch.Attributes["placeholder"] = gvMReference.Columns[i].HeaderText;
            //    txtSearch.CssClass = "search_textbox";

            //    cell.Controls.Add(txtSearch);
            //    row.Controls.Add(cell);

            //    //txtSearch.Attributes.Add("onkeyup", "callback();");
            //}
            //gvMReference.HeaderRow.Parent.Controls.AddAt(1, row);

            //GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            //for (int i = 0; i < gvMReference.Columns.Count - 1; i++)
            //{
            //    TableHeaderCell cell = new TableHeaderCell();
            //    TextBox txtSearch = new TextBox();
            //    txtSearch.Attributes["placeholder"] = "Search Here.";
            //    txtSearch.CssClass = "search_textbox";
            //    cell.Controls.Add(txtSearch);
            //    row.Controls.Add(cell);
            //}
            //gvMReference.HeaderRow.Parent.Controls.AddAt(1, row);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        WebMsgBox.Show("Test");
    }
    protected void txttrackongroup_TextChanged(object sender, EventArgs e)
    {
        if (sender is TextBox)
        {
            TextBox txtVal = (TextBox)sender;
            if (txtVal.ID == "txtSearch")
            {
                if (!(string.IsNullOrEmpty(txtVal.Text)))
                {
                    GetReference(txtVal.Text);
                }

            }
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


    private void LoadHoliday()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsTrackon = new DataSet();
            dsTrackon = sqlobj.SQLExecuteDataset("SP_LoadHoliday");

            if (dsTrackon.Tables[0].Rows.Count != 0)
            {

                gvHoliday.DataSource = dsTrackon.Tables[0];
                gvHoliday.AllowPaging = true;
                gvHoliday.DataBind();

            }
            else
            {

                gvHoliday.DataSource = null;
                gvHoliday.DataBind();
            }

            dsTrackon.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void HolidayClear()
    {
        dtpHdate.SelectedDate = null;
        txthdescription.Text = "";

        btnHSave.Visible = true;
        btnHUpdate.Visible = false;
    }

    protected void btnHSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                SQLProcs sqlobj = new SQLProcs();

                sqlobj.ExecuteSQLNonQuery("SP_InsertHoliday",
                                                                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpHdate.SelectedDate },
                                                                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txthdescription.Text },
                                                                 new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                                                                 );



                LoadHoliday();

                HolidayClear();

                WebMsgBox.Show("Holiday saved succefully.");
            }

        }


        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnHUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                SQLProcs sqlobj = new SQLProcs();

                sqlobj.ExecuteSQLNonQuery("SP_UpdateHoliday",
                                                                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpHdate.SelectedDate.Value },
                                                                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txthdescription.Text },
                                                                 new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["HRSN"].ToString() }
                                                                 );



                LoadHoliday();



                HolidayClear();

                WebMsgBox.Show("Holiday updated successfully.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnHClear_Click(object sender, EventArgs e)
    {
        try
        {

            HolidayClear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnHExit_Click(object sender, EventArgs e)
    {
        try
        {
            mvAdmin.SetActiveView(vwCompanyName);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void gvHoliday_RowCommand(object sender, GridViewCommandEventArgs e)
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
                string strReferenceRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strReferenceRSN);

                Session["HRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetHoliday",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    dtpHdate.SelectedDate = Convert.ToDateTime(dsCCustStatus.Tables[0].Rows[0]["Date"].ToString());
                    txthdescription.Text = dsCCustStatus.Tables[0].Rows[0]["Description"].ToString();

                    btnHUpdate.Visible = true;


                }


                btnHSave.Visible = false;

            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvHoliday_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvMReference.PageIndex = e.NewPageIndex;
            LoadHoliday();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    //****************************

    protected void LoadRefCode()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCCustStatus = new DataSet();
        dsCCustStatus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 29 });

        ddlCLRefCode.DataSource = dsCCustStatus.Tables[0];
        ddlCLRefCode.DataValueField = "RefCode";
        ddlCLRefCode.DataTextField = "RefName";
        ddlCLRefCode.DataBind();
        ddlCLRefCode.Dispose();

        ddlCLRefCode.Items.Insert(0, "Please Select");
    }




    protected void btnCLSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlCLRefCode.SelectedValue == "Please Select" || txtCLActSeq.Text == "" || txtCLActivity.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter/Select mandatory field(s)');", true);
                return;
            }

            if (CnfResult.Value == "true")
            {

                SQLProcs sqlobj2 = new SQLProcs();
                DataSet dsTrackon2 = new DataSet();
                dsTrackon2 = sqlobj2.SQLExecuteDataset("SP_InsertCheckList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlCLRefCode.SelectedValue },
                new SqlParameter() { ParameterName = "@ActSeqNo", SqlDbType = SqlDbType.NVarChar, Value = txtCLActSeq.Text });

                if (dsTrackon2.Tables[0].Rows.Count == 0)
                {
                    SQLProcs sqlobj = new SQLProcs();
                    sqlobj.ExecuteSQLNonQuery("SP_InsertCheckList",
                    new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlCLRefCode.SelectedValue },
                    new SqlParameter() { ParameterName = "@ActSeqNo", SqlDbType = SqlDbType.NVarChar, Value = txtCLActSeq.Text },
                    new SqlParameter() { ParameterName = "@Activity", SqlDbType = SqlDbType.NVarChar, Value = txtCLActivity.Text },
                    new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtCLRemarks.Text });

                    CheckListClear();

                    WebMsgBox.Show("New Check List Added.");
                }
                else
                {
                    WebMsgBox.Show("Sequence number already exists for this reference code.");
                    txtCLActSeq.Focus();
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnCLUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlCLRefCode.SelectedValue == "Please Select" || txtCLActSeq.Text == "" || txtCLActivity.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Enter/Select mandatory field(s)');", true);
                return;
            }

            if (CnfResult.Value == "true")
            {
                SQLProcs sqlobj = new SQLProcs();
                sqlobj.ExecuteSQLNonQuery("SP_InsertCheckList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ReferenceRSN"] },
                new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlCLRefCode.SelectedValue },
                new SqlParameter() { ParameterName = "@ActSeqNo", SqlDbType = SqlDbType.NVarChar, Value = txtCLActSeq.Text },
                new SqlParameter() { ParameterName = "@Activity", SqlDbType = SqlDbType.NVarChar, Value = txtCLActivity.Text },
                new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtCLRemarks.Text });


                CheckListClear();

                WebMsgBox.Show("Check List Updated.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void CheckListClear()
    {
        LoadRefCode();
        LoadCheckList();

        txtCLActSeq.Text = "";
        txtCLActivity.Text = "";
        txtCLRemarks.Text = ""; ;

        btnCLUpdate.Visible = false;
        btnCLSave.Visible = true;

    }



    protected void btnCLClear_Click(object sender, EventArgs e)
    {
        try
        {

            CheckListClear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadCheckList()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCL = new DataSet();
        dsCL = sqlobj.SQLExecuteDataset("SP_FetchCheckList");

        if (dsCL.Tables[0].Rows.Count != 0)
        {
            gvCheckList.DataSource = dsCL.Tables[0];
            gvCheckList.AllowPaging = true;
            gvCheckList.DataBind();

            ViewState["myDatatable"] = dsCL.Tables[0];
            //gvSearchReference.DataSource = dsTrackon.Tables[0];
            // gvSearchReference.DataBind(); 
        }
        else
        {
            ViewState["myDatatable"] = dsCL.Tables[0];
            gvCheckList.DataSource = null;
            gvCheckList.DataBind();
        }

        dsCL.Dispose();

    }


    protected void gvCheckList_RowCommand(object sender, GridViewCommandEventArgs e)
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
                string strReferenceRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

                Int64 istaffid = Convert.ToInt64(strReferenceRSN);

                Session["ReferenceRSN"] = istaffid.ToString();

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCCustStatus = new DataSet();
                dsCCustStatus = sqlobj.SQLExecuteDataset("SP_InsertCheckList",
                    new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = istaffid });

                if (dsCCustStatus.Tables[0].Rows.Count > 0)
                {

                    ddlCLRefCode.SelectedValue = dsCCustStatus.Tables[0].Rows[0]["ReferenceCode"].ToString();
                    txtCLActSeq.Text = dsCCustStatus.Tables[0].Rows[0]["ActivitySeqNo"].ToString();
                    txtCLActivity.Text = dsCCustStatus.Tables[0].Rows[0]["Activity"].ToString();
                    txtCLRemarks.Text = dsCCustStatus.Tables[0].Rows[0]["Remarks"].ToString();

                    btnCLSave.Visible = false;
                    btnCLUpdate.Visible = true;

                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvCheckList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCheckList.PageIndex = e.NewPageIndex;

        LoadCheckList();

    }

    protected void gvCheckList_Sorting(object sender, GridViewSortEventArgs e)
    {
        try
        {
            //    SQLProcs sqlobj = new SQLProcs();
            //    DataSet dsTrackon = new DataSet();
            //    dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup");

            //    if (dsTrackon.Tables[0].Rows.Count != 0)
            //    {

            //        //DataTable dtreference = new DataTable();

            //        //dtreference = dsTrackon.Tables[0];

            //        //dtreference.DefaultView.Sort = e.SortExpression;

            //        //gvMReference.DataSource = dtreference;
            //        //gvMReference.AllowPaging = true;
            //        //gvMReference.DataBind();

            //    }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvCheckList_DataBound(object sender, EventArgs e)
    {
        try
        {

            //GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            //for (int i = 1; i < gvMReference.Columns.Count; i++)
            //{
            //    TableHeaderCell cell = new TableHeaderCell();
            //    TextBox txtSearch = new TextBox();
            //    txtSearch.Width = 50;

            //    txtSearch.Attributes["placeholder"] = gvMReference.Columns[i].HeaderText;
            //    txtSearch.CssClass = "search_textbox";

            //    cell.Controls.Add(txtSearch);
            //    row.Controls.Add(cell);

            //    //txtSearch.Attributes.Add("onkeyup", "callback();");
            //}
            //gvMReference.HeaderRow.Parent.Controls.AddAt(1, row);

            //GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            //for (int i = 0; i < gvMReference.Columns.Count - 1; i++)
            //{
            //    TableHeaderCell cell = new TableHeaderCell();
            //    TextBox txtSearch = new TextBox();
            //    txtSearch.Attributes["placeholder"] = "Search Here.";
            //    txtSearch.CssClass = "search_textbox";
            //    cell.Controls.Add(txtSearch);
            //    row.Controls.Add(cell);
            //}
            //gvMReference.HeaderRow.Parent.Controls.AddAt(1, row);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void imgbtnExportExcel_Click(object sender, EventArgs e)
    {
        try
        {

            SQLProcs proc = new SQLProcs();
            DataSet dsGrid = new DataSet();

            DataSet dsStatement = sqlobj.SQLExecuteDataset("SP_FetchStaffDet",
                new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 6});

            if (dsStatement.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStatement.Tables[0];
                dg.DataBind();

               
                // THE EXCEL FILE.
                string sFileName = "EmployeeUserList.xls";
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


                Response.Write("<table><tr><td><b>Employee User List :</td></b></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                //WebMsgBox.Show(" From" + dtpFromDate.SelectedDate.Value + " To " + dtpTillDate.SelectedDate.Value + " Preview Summary does not exist");
                WebMsgBox.Show("There are no records to Export");
            }
        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }
}