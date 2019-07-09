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

public partial class Home : System.Web.UI.Page
{
    SQLProcs sqlobj = new SQLProcs();
    protected void Page_Load(object sender, EventArgs e)
    {

        rwROL.VisibleOnPageLoad = true;
        rwROL.Visible = false;

        rwNewLead.VisibleOnPageLoad = true;
        rwNewLead.Visible = false;

        rwStatusHelp.VisibleOnPageLoad = true;
        rwStatusHelp.Visible = false;

        rwReferenceHelp.VisibleOnPageLoad = true;
        rwReferenceHelp.Visible = false;


        if (Session["UserID"] == null)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }


        rwReference.VisibleOnPageLoad = true;
        rwReference.Visible = false;

        if (!Page.IsPostBack)
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Home", DateTime.Now);


            string currPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            Session["HomePage"] = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath +"/"+ currPage;

            LoadDashBoard();
            ChkLeaveSystem();
            LoadUserLevel();            
            btnCSave.Attributes.Add("onclick", "javascript:return Validate();");
            btnROLSave.Attributes.Add("onclick", "javascript:return ROlmsg();");
            //ContentPage.Attributes.Add("onkeypress", "javascript:return clickButton(event,'" + ibtnSearch.ClientID + "');");
            dvRadWindow.Visible = false;

            LoadProspectTypes();
            LoadMsg();
            LoadCampaignMsg();
            GetApptCounts();
            LoadComplaintsDetails();
            txtSearch.Focus();


            if (Session["AlertMsg"] != null)
            {
                Session["AlertMsg"] = null;
                WebMsgBox.Show("Please recharge quickly to avoid disconnecting.");
            }

        }
    }

    private void LoadComplaintsDetails()
    {
        DataSet dsComplaints = new DataSet();
        dsComplaints = sqlobj.SQLExecuteDataset("Proc_GetComplaints_Home");
        if(dsComplaints.Tables[0].Rows.Count > 0)
        {
            lblCompBT.Text = dsComplaints.Tables[0].Rows[0]["BookedToday"].ToString();
            lblCompCT.Text = dsComplaints.Tables[0].Rows[0]["CompletedToday"].ToString();
            lblCompPG.Text = dsComplaints.Tables[0].Rows[0]["Waiting"].ToString();
        }
        dsComplaints.Dispose();
    }

    protected void LoadMsg()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsFetchMsg = new DataSet();

        //dsFetchMsg = sqlobj.SQLExecuteDataset("SP_FetchMsg");                            
        dsFetchMsg = sqlobj.SQLExecuteDataset("SP_BCMsg");
        if (dsFetchMsg.Tables[0].Rows.Count != 0)
        {
            lblmsg.Text = dsFetchMsg.Tables[0].Rows[0]["BroadcastMessage"].ToString();
        }
    }
    public void GetApptCounts()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        //DateTime DT = new DateTime(System.DateTime.Today());
        try
        {
            using (SqlCommand cmd = new SqlCommand("GetAppointmentsCount"))
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@i", 1);
                cmd.Parameters.AddWithValue("@Date", DateTime.Today.ToString("yyyy-MM-dd HH:mm"));
                con.Open();
                int Done;
                int due;
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if(dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            Done = Convert.ToInt16(dr["Done"].ToString());
                            due = Convert.ToInt16(dr["Scheduled"].ToString());
                            lblAppTotal.Text = Done.ToString();
                            //App.Done = Convert.ToInt64(dr["Done"].ToString());
                            lblAppDue.Text = due.ToString();
                        }
                    }
                    else
                    {
                        lblAppTotal.Text = "0";
                        lblAppDue.Text = "0";
                    }
                    
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
        }       
    }
    protected void LoadCampaignMsg()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsFetchCampaignMsg = new DataSet();

        string strShowCampaign = "";

        //dsFetchMsg = sqlobj.SQLExecuteDataset("SP_FetchMsg");                            
        dsFetchCampaignMsg = sqlobj.SQLExecuteDataset("SP_ShowCampaign");
        if (dsFetchCampaignMsg.Tables[0].Rows.Count != 0)
        {
            for (int i = 0; i < dsFetchCampaignMsg.Tables[0].Rows.Count; i++)
            {
                DateTime cstartdate = Convert.ToDateTime(dsFetchCampaignMsg.Tables[0].Rows[i]["StartDate"].ToString());
                DateTime cenddate = Convert.ToDateTime(dsFetchCampaignMsg.Tables[0].Rows[i]["EndDate"].ToString());

                if (strShowCampaign == "")
                {
                    strShowCampaign = dsFetchCampaignMsg.Tables[0].Rows[i]["Campaignvalue"].ToString() + " From :" + cstartdate.ToString("dd/MM/yyyy") + " To :" + cenddate.ToString("dd/MM/yyyy");
                }
                else
                {
                    strShowCampaign = strShowCampaign + " , " + dsFetchCampaignMsg.Tables[0].Rows[i]["Campaignvalue"].ToString() + " From :" + cstartdate.ToString("dd/MM/yyyy") + " To :" + cenddate.ToString("dd/MM/yyyy");
                }
            }
            lblcampaignmsg.Text = strShowCampaign;
        }
    }
    protected void ChkLeaveSystem()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_chkleavesystem");
           
            
            if (dsMasters.Tables[0].Rows.Count > 0)
            {
                string strleavesystem = dsMasters.Tables[0].Rows[0]["isleavesystem"].ToString();
                string strAssessPerf = dsMasters.Tables[0].Rows[0]["ISAssessPerf"].ToString();
                if(strAssessPerf == "1")
                {
                    btnAssessPerf.Visible = true;
                }
                else
                {
                    btnAssessPerf.Visible = false;
                }
               if (strleavesystem  == "True")
               {
                   btnApplyLeave.Visible = true;
               }
               else
               {
                   btnApplyLeave.Visible = false;
               }
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadUserLevel()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMasters = sqlobj.SQLExecuteDataset("SP_GetHomePageMaster1",
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
            if (dsMasters.Tables[1].Rows.Count > 0)
            {
                string strUserLevel = dsMasters.Tables[1].Rows[0]["UserLevel"].ToString();
                Session["UserLevel"] = strUserLevel.ToString();
            }
        }
        catch (SqlException ex)
        {
            WebMsgBox.Show("Please check your internet connection");
            return;
        }
    }

    private void LoadDashBoard()
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsHomeDashboard = sqlobj.SQLExecuteDataset("Get_NewHomeDashboard");
            DataSet dsDashboard = sqlobj.SQLExecuteDataset("SP_HomeDashboard",
                    new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
            if (dsHomeDashboard != null)
            {
                //lblMyTasks.Text = "MyTasks(" + dsHomeDashboard.Tables[0].Rows[0]["MyTasks"].ToString() + ")";
                
                lblMyTasks.Text = "Sales Pipeline(" + dsHomeDashboard.Tables[0].Rows[0]["SalesPipeline"].ToString() + ")";

                //lbltilemytaskscount.Text = "Complaints(" + dsHomeDashboard.Tables[1].Rows[0]["Complaint"].ToString() + ")";

                lblByMe.Text = "Complaints(" + dsHomeDashboard.Tables[1].Rows[0]["Complaint"].ToString() + ")";

                //lbltilebymecount.Text = "(" + dsHomeDashboard.Tables[1].Rows[0]["ByMe"].ToString() + ")";
                
                //lblhipriority.Text = "HiPriority(" + dsHomeDashboard.Tables[2].Rows[0]["HiPriority"].ToString() + ")";
                
                lbltodyasfollowups.Text = "Today's Followups(" + dsHomeDashboard.Tables[2].Rows[0]["TodaysFollowups"].ToString() + ")";
                lbloverduefollowups.Text = "Overdue Followups(" + dsHomeDashboard.Tables[3].Rows[0]["OverdueFollowups"].ToString() + ")";
                lbloncomingFollowups.Text = "OnComing Followups(" + dsHomeDashboard.Tables[4].Rows[0]["OncomingFollowups"].ToString() + ")";

            }
            if(dsDashboard != null)
            {
                lbltilemytaskscount.Text = "(" + dsDashboard.Tables[0].Rows[0]["MyTasks"].ToString() + ")";
                lbltilebymecount.Text = "(" + dsDashboard.Tables[1].Rows[0]["ByMe"].ToString() + ")";
            }
            dsDashboard.Dispose();
            dsHomeDashboard.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

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

    protected void TileMyTasks_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Mytasks.aspx");
    }
    protected void TileByMe_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ByMe.aspx");
    }
    protected void TileCustomers_Click(object sender, EventArgs e)
    {
        
    }
    protected void TileInfoGraphics_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BusinessDashboard.aspx");
    }
    protected void TileNewTask_Click(object sender, EventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "NavigateNewTask();", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadProspectTypes();
            rwNewLead.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
            rwNewLead.Visible = true;
        }
    }
    protected void OnClientClose(object sender, EventArgs args)
    {
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "ReloadRepSessions", "SetArgumentValue(" + "'ThisIsMyArgument'" + ");", true);
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
    protected void btnstatushelp_Click(object sender, EventArgs e)
    {
        DataSet dsstatuhelp = sqlobj.SQLExecuteDataset("SP_GetStatusHelp");
        if (dsstatuhelp.Tables[0].Rows.Count > 0)
        {
            gvStatuHelp.DataSource = dsstatuhelp;
            gvStatuHelp.DataBind();
            rwNewLead.Visible = true;
            rwStatusHelp.Visible = true;
        }
        dsstatuhelp.Dispose();
    }
    protected void TileNewEnquiry_Click(object sender, EventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "NavigateNewEnquiry();", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void TileReports_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/SMReports.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void TileSettings_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Admin.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnROLUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            string strUserLevel = Session["UserLevel"].ToString();
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
                dvRadWindow.Visible = true;
                rwROL.Visible = true;
            }
            else
            {
                WebMsgBox.Show("Access denied");
                dvRadWindow.Visible = true;
                rwROL.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
            dvRadWindow.Visible = true;
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
        dvRadWindow.Visible = false;
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
            string strUserLevel = Session["UserLevel"].ToString();
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
                rwROL.Visible = true;
                WebMsgBox.Show("Thank you for your feedback. It shall be conveyed to the concerned via Email.");
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
        }

    }
    protected void TileROL_Click(object sender, EventArgs e)
    {
        try
        {
            btnROLUpdate.Visible = false;
            LoadStaffID();
            LoadTotalROL();
            LoadROL();

            dvRadWindow.Visible = true;
            rwROL.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
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
    protected void TileNewLead_Click(object sender, EventArgs e)
    {
        LoadProspectTypes();
        dvRadWindow.Visible = true;
        rwNewLead.Visible = true;
    }
    protected void btnCUpate_Click(object sender, EventArgs e)
    {
        dvRadWindow.Visible = false;
        rwStatusHelp.Visible = false;
        rwNewLead.Visible = false;
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
    public void CloseRadWindows()
    {
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
                                   new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue },
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

    protected void TileReference_Click(object sender, EventArgs e)
    {
        try
        {
            LoadTrackOn();
            dvRadWindow.Visible = true;
            rwReference.Visible = true;
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

        rwReference.Visible = true;
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

            rwReference.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnRefClose_Click(object sender, EventArgs e)
    {
        try
        {
            dvRadWindow.Visible = false;
            rwReference.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void Label3_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Customers.aspx");
    }
    protected void ibtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string strUserLevel = Session["UserLevel"].ToString();
            if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
            {
                Response.Redirect("SMReports.aspx?Name=" + txtSearch.Text);
            }
            else
            {
                WebMsgBox.Show("Access Denied");
                txtSearch.Text = string.Empty;
            }           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnReferenceHelp_Click(object sender, EventArgs e)
    {
        rwReference.Visible = true;
        rwReferenceHelp.Visible = true; 
    }
    protected void TileComplaints_Click(object sender, EventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "NavigateNewComplaints();", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void TileLeave_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveHome1.aspx");
    }
    protected void btnAssessPerf_Click(object sender, EventArgs e)
    {
        Response.Redirect("AssesPerform.aspx");
    }
    protected void btnAppoint_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Calendar.aspx");
    }
    protected void appointment_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Calendar.aspx");
    }
    protected void btnRecongnitions_Click(object sender, EventArgs e)
    {
        try
        {
            btnROLUpdate.Visible = false;
            LoadStaffID();
            LoadTotalROL();
            LoadROL();

            dvRadWindow.Visible = true;
            rwROL.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}