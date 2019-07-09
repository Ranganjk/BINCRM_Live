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

public partial class Customers : System.Web.UI.Page
{
    DataTable dtTemp = new DataTable();
    SQLProcs sqlobj = new SQLProcs();

    public static DataTable dtTargets;
    public static DataSet dsTarget;
    public static DataSet dsEmpDet;
    public static DataSet dsTargetDet;
    string QSUserName;
    string strUserLevel;
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

        

        if (Session["UserID"] == null)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
      
        rwLeadSource.VisibleOnPageLoad = true;
        rwLeadSource.Visible = false;

        rwDiary.VisibleOnPageLoad = true;
        rwDiary.Visible = false;    

        rwAddCustomer.VisibleOnPageLoad = true;
        rwAddCustomer.Visible = false;

        rwStatusHelp.VisibleOnPageLoad = true;
        rwStatusHelp.Visible = false;
      

        rwSSavetime.VisibleOnPageLoad = true;
        rwSSavetime.Visible = false;

        rwReferenceHelp.VisibleOnPageLoad = true;
        rwReferenceHelp.Visible = false;

        rwChangeStatus.VisibleOnPageLoad = true;
        rwChangeStatus.Visible = false;     

        rwServicedetails.VisibleOnPageLoad = true;
        rwServicedetails.Visible = false;
        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;


        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;

        QSUserName = Session["UserID"].ToString();
        HDLoginUser.Value = Session["UserID"].ToString();

       string strResult = CnfResult.Value; 

        if (!IsPostBack)
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Customer", DateTime.Now);

            lblnrf.Visible = false;
            btnCUpate.Visible = false;
            btnContacts.Visible = false;
            btnservice.Visible = false;
            ddlCountry.SelectedValue = RegionInfo.CurrentRegion.DisplayName;
            dtpchangestatusfollowupdate.MinDate = DateTime.Today;
            btnChangeStatus.Enabled = false;

            lblnotesentry.Text = "Note:Whatever you write in the box above will be recorded as a diary entry for the prospect. Please write atleast 6 characters.";

            LoadCCustStatus();
            LoadLeadSource();
            LoadCampaign();
            LoadProspectDetails();
            LoadLeadCategory();
            LoadSaveTime();
            LoadTrackOn();
            AddAttributes();
            LoadMasters();

            ddlCountry.SelectedValue = Session["DefaultCountry"].ToString();
        }
    }
    protected void wsgetLatestbtn_Click(object sender, EventArgs e)
    {
        string StaffID = QSUserName;
        Session["StaffID"] = QSUserName;     
    }
    protected void LoadMasters()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster1",
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = QSUserName });
            if (dsMasters.Tables[1].Rows.Count > 0)
            {
                strUserLevel = dsMasters.Tables[1].Rows[0]["UserLevel"].ToString();
                Session["UserLevel"] = strUserLevel.ToString();
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
        }
        catch (SqlException ex)
        {
            WebMsgBox.Show("Please check your internet connection");
            return;
        }
    }
    private void AddAttributes()
    {       
        //Button1.Attributes.Add("onclick", "javascript:return NavigateNewTask('" + wsgetLatestbtn.ClientID + "');");   
        //btnAddContacts.Attributes.Add("click", "javascript:return Validate();");

        btnSTSave.Attributes.Add("onclick", "javascript: return ConfirmSave();");       
        btnLSSave.Attributes.Add("onclick", "javascript: return ConfirmMsg();");
        btnCSave.Attributes.Add("onclick", "javascript: return ConfirmMsg();");
        btnAddService.Attributes.Add("onclick", "javascript: return ConfirmServiceMsg();");
        btnChangeStatusUpdate.Attributes.Add("onclick", "javascript: return ConfirmStatusUpdateMsg();");       
        btnCUpate.Attributes.Add("onclick", "javascript: return ConfirmUpdateMsg();");
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
        }
        dsTrackon.Dispose();
        ddlTrackon.Items.Insert(0, "");
    }
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

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        CClearScr();
    }
    protected void btnCClear_Click(object sender, EventArgs e)
    {
        CClearScr();
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
        btnChangeStatus.Enabled = false;
        LoadCCustStatus();
        gvContacts.DataSource = null;
        gvContacts.DataBind();
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


        if (ddlType.SelectedItem.Text == "CUSTOMER")
        {
            ddlCCustStatus.SelectedIndex = 1;
        }
    }
    protected void btnGoogleMap_Click(object sender, EventArgs e)
    {
        string strlocation = txtDoorNo.Text + ",+" + txtStreet.Text + ",+" + txtCity.Text + ",+" + txtState.Text + ",+" + ddlCountry.Text;
        //string strlocation = "innovatus systems kovai pudur coimbatore";
        //strlocation = strlocation.Replace(" ", "");
        ////string url = "https://maps.google.co.in/maps/place/" + strlocation.ToString() + "";
        //string url = "https://maps.google.co.in/maps/place/" + strlocation.ToString() + "";
        //string s = "window.open('" + url + "', 'popup_window', 'width=800,height=600,left=250,top=100,resizable=yes');";
        //ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

        string url = "http://maps.google.com/maps/api/geocode/xml?address=" + strlocation + "&sensor=false";
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


                string TestLat = dtCoordinates.Rows[0][2].ToString();
                string TestLon = dtCoordinates.Rows[0][3].ToString();

                string urlloc = "GoogleMap.aspx?lat=" + TestLat.ToString() + "&lon=" + TestLon.ToString() + "&cus=" + txtCustName.Text.ToString();
                string s = "window.open('" + urlloc + "', 'popup_window', 'width=800,height=600,left=250,top=100,resizable=yes');";
                ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
            }
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

    protected void EditCustomer(object sender, GridViewEditEventArgs e)
    {
        gvContacts.EditIndex = e.NewEditIndex;
        LoadContacts();
        rwAddCustomer.Visible = true;
    }
    protected void btnNewLeadSource_Click(object sender, EventArgs e)
    {
        rwLeadSource.Enabled = true;
        rwLeadSource.Visible = true;
    }
    protected void imgAddLeadSource_Click(object sender, EventArgs e)
    {
        rwLeadSource.Enabled = true;
        rwLeadSource.Visible = true;
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
    protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvContacts.EditIndex = -1;
        LoadContacts();
        rwAddCustomer.Visible = true;
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
    protected void OnDiaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvDiary.PageIndex = e.NewPageIndex;
        LoadProspectDiary(Session["ProspectRSN"].ToString());
        rwDiary.Visible = true;
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
    protected void gvServiceDetails_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvServiceDetails.EditIndex = e.NewEditIndex;
        LoadServiceDetails();
        rwServicedetails.Visible = true;
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
            TextBox txtsRemarks = (TextBox)gvServiceDetails.Rows[e.RowIndex].FindControl("txtRemarks");

            SQLProcs sqlobj = new SQLProcs();
            sqlobj.ExecuteSQLNonQuery("proc_updateservice",
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NChar, Value = RSN.ToString() },
                       new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NChar, Value = gvddlreference.SelectedValue },
                       new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = gvraddateserfrom.SelectedDate == null ? null : gvraddateserfrom.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = gvraddateserto.SelectedDate == null ? null : gvraddateserto.SelectedDate },
                       new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = txtValue.Text },
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtsRemarks.Text  }

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
    protected void onLeadSourcePaging(object sender, GridViewPageEventArgs e)
    {
        gvMLeadSource.PageIndex = e.NewPageIndex;
        LoadLeadSource();
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

                //ImageButton imgbtn = (ImageButton)e.CommandSource;
                LinkButton imgbtn = (LinkButton)e.CommandSource;
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
    protected void gvProspectDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void gvProspectDetails_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='highlight'");

            e.Row.Attributes.Add("onmouseout", "this.className='normal'");

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
                           new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = txtservicevalue.Text == "" ? "0.00" : txtservicevalue.Text },
                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtServiceRemarks.Text   }
                           );
                // WebMsgBox.Show("Service details added successfully.");
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Service details added successfully.');", true);
                LoadServiceDetails();
                txtServiceRemarks.Text = ""; 
                rwServicedetails.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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
    protected void Button3_Click1(object sender, EventArgs e)
    {
        rwServicedetails.Visible = false;
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
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
    private void STClear()
    {
        txtInfo.Text = "";
        //txtstremarks.Text = "";
    }
    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        STClear();
        rwSaveTime.Visible = true;
    }
    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
    }
    protected void btnSearchClear_Click(object sender, EventArgs e)
    {
        LoadProspectDetails();
        lblnrf.Visible = false;
        txtSearchMobile.Text = "";
        txtSearchProspect.Text = "";
        ddlSearchType.SelectedIndex = 0;
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

        LoadRemarks();

    }
    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }
    protected void btnLSClose_Click(object sender, EventArgs e)
    {
        rwLeadSource.Visible = false;
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
    protected void btnDiaryClose_Click(object sender, EventArgs e)
    {
        rwDiary.Visible = false;
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


                        string strcustomer = txtCustName.Text;

                        //LoadProspectCount();
                        LoadPagingProspectDetails();
                        WebMsgBox.Show("The profile is now created for " + strcustomer + ". If present, the contact name is also added to the Contacts List. Update the Contacts List. Update the Contacts list later.");
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
    protected void btnCloseContacts_Click(object sender, EventArgs e)
    {
        rwAddCustomer.Visible = false;
    }
    protected void btnContacts_Click(object sender, EventArgs e)
    {
        try
        {
            lblhcontacts.Text = "Names and addresses of contact persons for the profile of :" + txtCustName.Text;
            rwAddCustomer.Visible = true;
            txtcontlocation.Text = txtCity.Text;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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

                   // LoadProspectCount();
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
    private void ClearLeadSource()
    {
        txtAddLeadKey.Text = "";
    }
    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true; 
    }
    protected void ddlrwservice_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadRemarks();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadRemarks()
    {
        DataSet dsremarks = sqlobj.SQLExecuteDataset("SP_GetReferenceRemarks",
              new SqlParameter() { ParameterName = "@Reference", SqlDbType = SqlDbType.NVarChar, Value = ddlrwservice.SelectedValue });

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

        rwServicedetails.Visible = true; 
    }
}