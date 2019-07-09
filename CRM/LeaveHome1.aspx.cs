using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMS;
using System.Web.Security;
using System.Net;
public partial class LeaveHome1 : System.Web.UI.Page
{
    Boolean IsPageRefresh;
    SQLProcs proc = new SQLProcs();
    int flag = 0;
    public static DataSet dsLKUP = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        rwView.VisibleOnPageLoad = true;
        rwView.Visible = false;

        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;

        CalLeaveStart.StartDate = DateTime.Now.AddDays(-7);
        CalRetDate.StartDate = DateTime.Now.AddDays(-7);


        string strUserLevel = Session["UserLevel"].ToString();


        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            LoadLKUP();
            if (!IsPostBack)
            {
                
                LoadUserDet();
                LoadSaveTime();
                LoadGrid();
                rwSaveTime.OpenerElementID = BtnSaveTime.ClientID;
                ViewState["postids"] = System.Guid.NewGuid().ToString();
                Session["postid"] = ViewState["postids"].ToString();
                hfUserId.Value = Session["StaffID"].ToString();
                
            }
            else
            {
                if (ViewState["postids"].ToString() != Session["postid"].ToString())
                {
                    IsPageRefresh = true;
                }
                Session["postid"] = System.Guid.NewGuid().ToString();
                ViewState["postids"] = Session["postid"].ToString();
            }

            //if (Request.QueryString["RSN"].ToString() != "0")
            //{
            //    LoadData();
            //}

        }
    }
    protected void LoadUserDet()
    {
        try
        {
            SQLProcs proc = new SQLProcs();
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["StaffID"] = ds.Tables[0].Rows[0]["StaffId"].ToString();
                Session["UserLevel"] = ds.Tables[0].Rows[0]["UserLevel"].ToString();
                Session["ReportingHead"] = ds.Tables[0].Rows[0]["ReportingHead"].ToString();
                Session["StaffName"] = ds.Tables[0].Rows[0]["StaffName"].ToString();
            }
            if (Session["UserLevel"].ToString() == "4User")
                Tab1.Focus();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load user details!");
        }
    }

    protected void LoadGrid()
    {
        string userlevel = Session["Userlevel"].ToString();
        if (userlevel == "4User")
        {
            LoadByMeUser();

        }
        else if (userlevel == "1Manager")
        {

            LoadAsToMe();
            LoadByMe();

        }
        else if (userlevel == "2CoOrdinator")
        {

            string strnormal = "";
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_ChkNormal",

                new SqlParameter() { ParameterName = "@staffid", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
                );

            if (ds.Tables[0].Rows.Count > 0)
            {
                strnormal = ds.Tables[0].Rows[0]["IsNormal"].ToString();
            }


            if (strnormal.ToString() == "True")
            {
                LoadByMeUser();
            }
            else
            {

                LoadAsToMe();
                LoadByMe();
            }

        }
    }

    public void CheckExp()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@UserId", SqlDbType = SqlDbType.NVarChar, Value = Session["UserId"].ToString() }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataSet ds1 = new DataSet();
                ds1 = proc.SQLExecuteDataset("GetServerDate",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
                    );
                double days = (Convert.ToDateTime(ds1.Tables[0].Rows[0]["Today"].ToString()) - Convert.ToDateTime(ds.Tables[0].Rows[0]["JoiningDate"].ToString())).Days;
                if ((days / 365.00) >= 1.0)
                    flag = 1;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on Check experience!");
        }
    }
    protected void LoadByMeUser()
    {

        try
        {
            //Button btnViewAll = (Button)Master.FindControl("BtnViewAll");
            BtnAppliedByMe.Visible = true;
            LoadStaffId();
            
            LoadStatus();
            LoadReportHead();
            LoadLeave(Session["StaffId"].ToString());
            LoadHolidays();
            LoadLeaveType();
            LoadLeaveApply();

            //DataSet ds = new DataSet();

            divCeo.Visible = false;
            divAdmin.Visible = false;
            //btnViewAll.Visible = false;
            //DivByMeUser.Visible = true;
            //ds = proc.SQLExecuteDataset("SP_LeaveDet",
            //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
            //    new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(Session["StaffId"]) }
            //    );
            //RGByMeLeave.DataSource = ds.Tables[0];
            //RGByMeLeave.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load by me");
        }
    }
    protected void LoadAll()
    {
        try
        {
            DataSet ds = new DataSet();
            divCeo.Visible = true;
            divAdmin.Visible = false;

            DivByMeUser.Visible = false;
            //ds = proc.SQLExecuteDataset("SP_LeaveDet",
            //   new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 }
            //  );
            ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 }
                );
            RGAll.DataSource = ds.Tables[0];
            RGAll.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load all");
        }
    }
    protected void LoadByMe()
    {
        try
        {

            LoadStaffId();
            
            LoadStatus();
            LoadReportHead();
            LoadLeave(Session["StaffId"].ToString());
            LoadHolidays();
            LoadLeaveType();
            LoadLeaveApply();

            //DataSet ds = new DataSet();
            divCeo.Visible = false;
            divAdmin.Visible = true;

            //DivByMeUser.Visible = true;
            //ds = proc.SQLExecuteDataset("SP_LeaveDet",
            //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
            //    new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(Session["StaffId"]) }
            //    );
            //RGByMe.DataSource = ds.Tables[0];
            //RGByMe.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load byme");
        }
    }
    protected void LoadAsToMe()
    {
        try
        {
            string status = "AL";


            DataSet dsaccounts = proc.SQLExecuteDataset("sp_chkaccounts",
                 new SqlParameter() { ParameterName = "@staffid", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }

               );


            if (dsaccounts.Tables[0].Rows.Count > 0)
            {
                string strisaccounts = dsaccounts.Tables[0].Rows[0]["isaccounts"].ToString();

                if (strisaccounts == "True")
                {
                    status = "AP";

                    BtnLvCredit.Visible = true;
                    BtnHolidays.Visible = true;
                }
            }


            DataSet ds = new DataSet();
            divCeo.Visible = false;
            divAdmin.Visible = true;
            BtnAppliedByMe.Visible = true;
            BtnViewAll.Visible = true;
            // DivByMeUser.Visible = true;
            ds = proc.SQLExecuteDataset("SP_LeaveDet",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                  new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Char, Value = status }
                );
            RGAssignMe.DataSource = ds.Tables[0];
            RGAssignMe.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load Assigned to me");
        }
    }
    protected void RGAssignMe_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadAsToMe();
    }
    protected void RGAssignMe_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadAsToMe();
    }
    protected void RGAssignMe_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadAsToMe();
    }
    protected void RGByMe_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadByMe();
    }
    protected void RGByMe_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadByMe();
    }
    protected void RGByMe_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadByMe();
    }
    protected void RGByMeLeave_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadByMeUser();
    }
    protected void RGByMeLeave_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadByMeUser();
    }
    protected void RGByMeLeave_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadByMeUser();
    }
    protected void RGAll_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadAll();
    }
    protected void RGAll_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadAll();
    }
    protected void RGAll_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadAll();
    }
    protected void LnkEdit_Click(object sender, EventArgs e)
    {
        if (!IsPageRefresh)
        {
            LinkButton lnk = (LinkButton)sender;
            int rsn = Convert.ToInt16(lnk.CommandName);
            string url = "LeaveApply.aspx?RSN=" + rsn;
            string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        }
    }
    protected void LnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkdel = (LinkButton)sender;
            proc.ExecuteSQLNonQuery("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(lnkdel.CommandName) }
                );

            ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave has been deleted successfully!'); window.opener.location.reload();</script>");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on delete the leave!");
        }
    }

    protected void LnkUpdate_Click(object sender, EventArgs e)
    {
        if (!IsPageRefresh)
        {
            string url = "";
            LinkButton lnk = (LinkButton)sender;
            int rsn = Convert.ToInt16(lnk.CommandName);


            DataSet dsaccounts = proc.SQLExecuteDataset("sp_chkaccounts",
               new SqlParameter() { ParameterName = "@staffid", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }

             );


            if (dsaccounts.Tables[0].Rows.Count > 0)
            {
                string strisaccounts = dsaccounts.Tables[0].Rows[0]["isaccounts"].ToString();

                if (strisaccounts == "True")
                {
                    url = "LeaveApprove.aspx?RSN=" + rsn;
                }
                else
                {
                    url = "LeaveApply.aspx?RSN=" + rsn;
                }
            }


            string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        }
    }
    //protected void BtnTxns_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("LeaveTxns.aspx");
    //}
    protected void LoadLeave(string staffid)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(staffid) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                LblStaffname.Text = ds.Tables[0].Rows[0]["StaffName"].ToString();
                LblCasualLeave.Text = ds.Tables[0].Rows[0]["Casual"].ToString();
                LblEarnLeave.Text = ds.Tables[0].Rows[0]["Earn"].ToString();
                LblSickLeave.Text = ds.Tables[0].Rows[0]["Sick"].ToString();

                //LblStaffName1.Text = ds.Tables[0].Rows[0]["StaffName"].ToString();
                //LblCasualLeave1.Text = ds.Tables[0].Rows[0]["Casual"].ToString();
                //LblEarnLeave1.Text = ds.Tables[0].Rows[0]["Earn"].ToString();
                //LblSickLeave1.Text = ds.Tables[0].Rows[0]["Sick"].ToString();
            }
            else
            {
                LblStaffname.Text = DdlStaffid.Text;
                LblCasualLeave.Text = "0";
                LblEarnLeave.Text = "0";
                LblSickLeave.Text = "0";
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadHolidays()
    {
        try
        {
            DateTime today, lastdate;
            String holidays = "No record found!";
            //today = DateTime.Now.AddDays(-7);
            today = new DateTime(DateTime.Now.Year,DateTime.Now.Month, 1);
            lastdate = new DateTime(DateTime.Now.Year,DateTime.Now.Month + 2, 1);
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_HolidayDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = today },
                new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = lastdate }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                holidays = "<table style=width:80%;margin-top:-10px;><tr align=left><th>Date</th><th>Name</th></tr>";
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    holidays = holidays + "<tr><td>" + ds.Tables[0].Rows[i]["HolidayDate"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["HolidayName"].ToString() + "</td></tr>";
                }
                holidays = holidays + "</table>";
            }
            LblHolidays.Text = holidays;
            //LblHolidays1.Text = holidays;
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadLeaveApply()
    {
        try
        {
            String LvApp = "";
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                new SqlParameter() { ParameterName = "@LeaveStart", SqlDbType = SqlDbType.Date, Value = DateTime.Now.Date }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                LvApp = LvApp + "<table style=width:80%;margin-top:-10px;><tr align=left><th>Date</th><th>Staff Name</th></tr>";
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    LvApp = LvApp + "<tr><td>" + ds.Tables[0].Rows[i]["LeaveStart"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["StaffName"].ToString() + "</td></tr>";
                }
                LvApp = LvApp + "</table>";
            }
            else
                LvApp = "No Record Found!";
            LblLvApp.Text = LvApp;
            //LblHolidays1.Text = holidays;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load leave applied!");
        }
    }
    protected void Clear()
    {
        TxtLeaveStart.Text = "";
        TxtLeaveDays.Text = "";
        //TxtTotDays.Text = "";
        TxtReason.Text = "";
        TxtReturnDate.Text = "";
        //TxtLeaveEndDate.Text = "";
        BtnApply.Text = "Apply";
    }

    protected void BtnApply_Click(object sender, EventArgs e)
    {
        //string msg = null;
        try
        {
            //if((DdlLeaveType.SelectedValue!="CO") && (DdlLeaveType.SelectedValue!="OD") && (DdlLeaveType.SelectedValue!="WH"))
            //{
            //    if(DdlLeaveType.SelectedValue == "CL")
            //    {
            //        if(Convert.ToDouble(TxtLeaveDays.Text)>Convert.ToDouble(LblCasualLeave.Text))
            //        {
            //            msg = "You cannot take leave as casual leave type!";
            //        }
            //    }
            //    else if (DdlLeaveType.SelectedValue == "EL")
            //    {
            //        if (Convert.ToDouble(TxtLeaveDays.Text) > Convert.ToDouble(LblEarnLeave.Text))
            //        {
            //            msg = "You cannot take leave as earn leave type!";
            //        }
            //    }
            //    else if (DdlLeaveType.SelectedValue == "SL")
            //    {
            //        if (Convert.ToDouble(TxtLeaveDays.Text) > Convert.ToDouble(LblEarnLeave.Text))
            //        {
            //            msg = "You cannot take leave as sick leave type!";
            //        }
            //    }
            //}
            //if (msg == null)
            //{



            DataSet ds = new DataSet();
            proc.ExecuteSQLNonQuery("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@Staffid", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(DdlStaffid.SelectedValue) },
                new SqlParameter() { ParameterName = "@LeaveType", SqlDbType = SqlDbType.Char, Value = DdlLeaveType.SelectedValue },
                new SqlParameter() { ParameterName = "@LeaveStart", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveStart.Text) },
                new SqlParameter() { ParameterName = "@ReturnDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtReturnDate.Text) },
                new SqlParameter() { ParameterName = "@LeaveEndDate", SqlDbType = SqlDbType.Date, Value = DateTime.Now },
                new SqlParameter() { ParameterName = "@LeaveDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtLeaveDays.Text) },
                //new SqlParameter() { ParameterName = "@TotalDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtTotDays.Text) },
                new SqlParameter() { ParameterName = "@Reason", SqlDbType = SqlDbType.VarChar, Value = TxtReason.Text },
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Char, Value = DdlStatus.SelectedValue },
                new SqlParameter() { ParameterName = "@ReportTo", SqlDbType = SqlDbType.Char, Value = DdlReportTo.SelectedValue },
                new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = TxtRemarks.Text },
                new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.VarChar, Value = Session["Staffid"].ToString() },
                new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.VarChar, Value = Session["Staffid"].ToString() }
                );
            Clear();
            LoadAsToMe();
            ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave has been applied successfully!'); window.opener.location.reload();</script>");
            // }
            //else
            //{
            //    WebMsgBox.Show(msg);
            // }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on apply leave!");
        }
    }

    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>window.close();</script>");
    }

    protected void LoadLeaveType()
    {
        try
        {
            DataView dv = new DataView(dsLKUP.Tables[0]);
            DataTable dt = new DataTable();
            dv.RowFilter = "CodeId='LT'";
            dt = dv.ToTable();
            DdlLeaveType.DataSource = dt;
            DdlLeaveType.DataTextField = "ShortDesc";
            DdlLeaveType.DataValueField = "CodeValue";
            DdlLeaveType.DataBind();
            DdlLeaveType.Items.Insert(0, "Please Select");
            if (LblCasualLeave.Text == "0")
            {
                DdlLeaveType.Items.Remove(DdlLeaveType.Items.FindByValue("CL"));
            }
            if (LblSickLeave.Text == "0")
            {
                DdlLeaveType.Items.Remove(DdlLeaveType.Items.FindByValue("SL"));
            }
            if (LblEarnLeave.Text == "0")
            {
                DdlLeaveType.Items.Remove(DdlLeaveType.Items.FindByValue("EL"));
            }
            DdlLeaveType.SelectedIndex = 1;
            //DataSet ds = new DataSet();
            //ds = proc.SQLExecuteDataset("SP_LookUpDet",
            //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
            //    new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "LT" }
            //    );
            //DdlLeaveType.DataSource = ds.Tables[0];
            //DdlLeaveType.DataTextField = "ShortDesc";
            //DdlLeaveType.DataValueField = "CodeValue";
            //DdlLeaveType.DataBind();
            //DdlLeaveType.Items.Insert(0, "Please Select");
           

            //DdlLeaveType1.DataSource = ds.Tables[0];
            //DdlLeaveType1.DataTextField = "ShortDesc";
            //DdlLeaveType1.DataValueField = "CodeValue";
            //DdlLeaveType1.DataBind();
            //DdlLeaveType1.Items.Insert(0, "Please Select");
            //DdlLeaveType1.SelectedValue = "CL";

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.StackTrace);
        }
    }

    protected void LoadStatus()
    {
        try
        {
            if (Session["UserLevel"].ToString() == "4User")
            {
                DdlStatus.Items.Add(
                    new ListItem("Applied", "AL")
                    );
            }
            else
            {
                if (DdlStaffid.SelectedValue.Equals(Session["StaffId"].ToString()))
                {
                    DdlStatus.Items.Clear();
                    DdlStatus.Items.Add(
                       new ListItem("Applied", "AL")
                       );
                }
                else
                {
                    DataView dv = new DataView(dsLKUP.Tables[0]);
                    DataTable dt = new DataTable();
                    dv.RowFilter = "CodeId='LS'";
                    dt = dv.ToTable();
                    DdlStatus.DataSource = dt;
                    DdlStatus.DataTextField = "ShortDesc";
                    DdlStatus.DataValueField = "CodeValue";
                    DdlStatus.DataBind();
                }
                //DataSet ds = new DataSet();
                //ds = proc.SQLExecuteDataset("SP_LookUpDet",
                //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                //    new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "LS" }
                //    );
                //DdlStatus.DataSource = ds.Tables[0];
                //DdlStatus.DataTextField = "ShortDesc";
                //DdlStatus.DataValueField = "CodeValue";
                //DdlStatus.DataBind();

                //DdlStatus1.DataSource = ds.Tables[0];
                //DdlStatus1.DataTextField = "ShortDesc";
                //DdlStatus1.DataValueField = "CodeValue";
                //DdlStatus1.DataBind();
            }
            DdlStatus.Items.Insert(0, "Please Select");
            DdlStatus.SelectedValue = "AL";
            //DdlStatus1.Items.Insert(0, "Please Select");
            //DdlStatus1.SelectedValue = "AL";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load Leave status!");
        }
    }

    protected void LoadStaffId()
    {
        try
        {
            DataSet ds = new DataSet();

            if (Session["UserLevel"].ToString() == "4User")
            {
                ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                    );
            }
            else if ((Session["UserLevel"].ToString() == "1Manager") || (Session["UserLevel"].ToString() == "2CoOrdinator"))
            {
                ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 }
                    );
            }
            DdlStaffid.DataSource = ds.Tables[0];
            DdlStaffid.DataTextField = "StaffName";
            DdlStaffid.DataValueField = "StaffId";
            DdlStaffid.DataBind();
            DdlStaffid.Items.Insert(0, "Please Select");
            DdlStaffid.SelectedValue = Session["Staffid"].ToString();

            

            //DdlStaffid1.DataSource = ds.Tables[0];
            //DdlStaffid1.DataTextField = "StaffName";
            //DdlStaffid1.DataValueField = "StaffId";
            //DdlStaffid1.DataBind();
            //DdlStaffid1.Items.Insert(0, "Please Select");
            //DdlStaffid1.SelectedValue = Session["Staffid"].ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load Staff Name!");
        }
    }
    protected void LoadReportHead()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 }
                );
            DdlReportTo.DataSource = ds.Tables[0];
            DdlReportTo.DataTextField = "StaffName";
            DdlReportTo.DataValueField = "StaffId";
            DdlReportTo.DataBind();
            DdlReportTo.Items.Insert(0, "Please Select");
            DdlReportTo.SelectedValue = Session["ReportingHead"].ToString();

            //DdlReportTo1.DataSource = ds.Tables[0];
            //DdlReportTo1.DataTextField = "StaffName";
            //DdlReportTo1.DataValueField = "StaffId";
            //DdlReportTo1.DataBind();
            //DdlReportTo1.Items.Insert(0, "Please Select");
            //DdlReportTo1.SelectedValue = Session["ReportingHead"].ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load report head!");
        }
    }
    protected void TxtLeaveStart_TextChanged(object sender, EventArgs e)
    {
        TxtReturnDate.Text = "";
        TxtLeaveDays.Text = "";
        TxtLeaveDays.Text = "";
        CalRetDate.StartDate = Convert.ToDateTime(TxtLeaveStart.Text);
        //TxtLeaveEndDate.Text = "";
        //TxtTotDays.Text = "";
    }
    protected void TxtReturnDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            //string msg = null;
            Double totLeave = 0, remainDays = 0;
            string msg1 = "";
            if ((TxtLeaveStart.Text != "") && (TxtReturnDate.Text != ""))
            {
                DateTime retdate = Convert.ToDateTime(TxtReturnDate.Text);
                do
                {
                    ds = proc.SQLExecuteDataset("SP_HolidayDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName = "@HolidayDate", SqlDbType = SqlDbType.Date, Value = retdate }
                    );
                    if ((ds.Tables[0].Rows.Count == 0) && (retdate.DayOfWeek.ToString() != "Sunday"))
                    {
                        TxtReturnDate.Text = retdate.ToString("dd-MMM-yyyy ddd");
                        flag = 0;
                    }
                    else
                    {
                        retdate = retdate.AddDays(1);
                        flag = 1;
                        //retdate = Convert.ToDateTime(ds.Tables[0].Rows[0]["HolidayDate"]).AddDays(1);
                        //msg = "you are selected return date which is holiday. So, The system change return date as office next working day!";
                    }
                }
                while (flag == 1);
                DataSet ds1 = new DataSet();
                ds1 = proc.SQLExecuteDataset("SP_HolidayDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                    new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveStart.Text) },
                    new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtReturnDate.Text) }
                    );
                int leave = Convert.ToInt16(ds1.Tables[0].Rows[0]["Leave"]);
                for (DateTime i = Convert.ToDateTime(TxtLeaveStart.Text); i < Convert.ToDateTime(TxtReturnDate.Text); i = i.AddDays(1))
                {
                    if (i.DayOfWeek.ToString() == "Sunday")
                    {
                        leave = leave + 1;
                    }
                }
                DateTime dstart = Convert.ToDateTime(TxtLeaveStart.Text);
                DateTime dreturn = Convert.ToDateTime(TxtReturnDate.Text);
                if (dreturn >= dstart)
                {
                    if (Convert.ToDouble((dreturn - dstart).Days) == 0.0)
                        TxtLeaveDays.Text = "0.5";
                    else
                        TxtLeaveDays.Text = (Convert.ToDouble((dreturn - dstart).Days) - (leave)).ToString();
                    totLeave = (Convert.ToDouble(LblCasualLeave.Text)) + (Convert.ToDouble(LblSickLeave.Text)) + (Convert.ToDouble(LblEarnLeave.Text));
                    if (totLeave < Convert.ToDouble(TxtLeaveDays.Text))
                    {
                        remainDays = Convert.ToDouble(TxtLeaveDays.Text) - totLeave;
                        msg1 = remainDays + " day(s) is apply as Loss of Pay(LOP)!";
                    }
                }
                else
                    WebMsgBox.Show("The return date must be greaterthan or equal to start date!");
            }
            //if (msg != null)
            //    WebMsgBox.Show(msg);
            //else 
            if (msg1 != "")
                WebMsgBox.Show(msg1);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on check return date!");
        }
    }
    protected void LoadData()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(Request.QueryString["RSN"]) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                DdlStaffid.SelectedValue = ds.Tables[0].Rows[0]["StaffId"].ToString();
                DdlLeaveType.Text = ds.Tables[0].Rows[0]["LeaveType"].ToString();
                TxtLeaveStart.Text = ds.Tables[0].Rows[0]["LeaveStart"].ToString();
                TxtReturnDate.Text = ds.Tables[0].Rows[0]["ReturnDate"].ToString();
                //TxtLeaveEndDate.Text = ds.Tables[0].Rows[0]["LeaveEndDate"].ToString();
                //TxtTotDays.Text = ds.Tables[0].Rows[0]["TotalDays"].ToString();
                TxtLeaveDays.Text = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                TxtReason.Text = ds.Tables[0].Rows[0]["Reason"].ToString();
                DdlStatus.SelectedValue = ds.Tables[0].Rows[0]["Status"].ToString();
                BtnApply.Text = "Save";
                DdlReportTo.SelectedValue = ds.Tables[0].Rows[0]["ReportTo"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load leave details!");
        }
    }

    //protected void SendMail()
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        DataSet dsUser = new DataSet();
    //        DataSet dsReportHead = new DataSet();
    //        ds = proc.SQLExecuteDataset("SP_SendMail",
    //            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
    //            );
    //        SqlDataAdapter da = new SqlDataAdapter("Select StaffEmail,StaffName,StaffId from tblStaff where username='" + Session["username"] + "'", con);
    //        da.Fill(dsUser);
    //        SqlDataAdapter da1 = new SqlDataAdapter("Select StaffEmail,StaffId,StaffName from tblStaff where username='" + Session["reportHead"].ToString() + "'", con);
    //        da.Fill(dsReportHead);
    //        DataSet dsleave = new DataSet();

    //        MailMessage mail = new MailMessage();
    //        mail.From = new MailAddress(ds.Tables[0].Rows[0]["username"].ToString());
    //        mail.CC.Add(new MailAddress(dsUser.Tables[0].Rows[0]["StaffEmail"].ToString()));
    //        mail.To.Add(new MailAddress(dsReportHead.Tables[0].Rows[0]["StaffEmail"].ToString()));
    //        string sname = dsUser.Tables[0].Rows[0]["StaffName"].ToString() + " " + dsUser.Tables[0].Rows[0]["StaffId"].ToString();
    //        mail.Subject = "Leave Apply - " + sname;
    //        string body = "Dear " + dsReportHead.Tables[0].Rows[0]["StaffName"].ToString() + ",<br/><br/>";
    //        body = body + "<table width=400px> <tr> <td> Staff Name</td><td> - </td><td>" + sname + "</td></tr>";
    //        body = body + "<tr> <td> Leave Type</td><td> - </td><td>" + DdlLeaveType.Text + "</td></tr>";
    //        body = body + "<tr> <td> Leave Date</td><td> - </td><td>" + TxtLeaveStart.Text + "</td></tr>";
    //        body = body + "<tr> <td> Return Date</td><td> - </td><td>" + TxtReturnDate.Text + "</td></tr>";
    //        body = body + "<tr> <td> No.of Days</td><td> - </td><td>" + TxtLeaveDays.Text + "</td></tr>";
    //        body = body + "<tr> <td> Reason</td><td> - </td><td>" + TxtReason.Text + "</td></tr></table><br/>";
    //        body = body + "<br/><b>This is an automate message from ISEASy!</b>";
    //        SmtpClient smtp = new SmtpClient();
    //        smtp.Host = ds.Tables[0].Rows[0]["mailserver"].ToString();
    //        smtp.Port = 587;
    //        NetworkCredential net = new NetworkCredential(ds.Tables[0].Rows[0]["username"].ToString(), ds.Tables[0].Rows[0]["password"].ToString());
    //        smtp.UseDefaultCredentials = true;
    //        smtp.Credentials = new NetworkCredential();
    //        smtp.EnableSsl = true;
    //        smtp.Send(mail);
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

    protected void DdlStaffid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DdlStaffid.SelectedIndex != 0)
        {
            LoadLeave(DdlStaffid.SelectedValue);
            LoadStatus();
            LoadLeaveType();
        }
    }
    protected void BtnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }
    protected void btnSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            proc.ExecuteSQLNonQuery("SP_SaveTimeReason",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@Reason", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text }
                );
            txtInfo.Text = "";
            LoadSaveTime();
            WebMsgBox.Show("Your details are saved");
            rwSaveTime.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on Save time reason!");
        }
    }
    protected void LoadSaveTime()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_SaveTimeReason",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSaveTime.DataSource = ds.Tables[0];
                gvSaveTime.DataBind();

                DdlExistReason.DataSource = ds.Tables[0];
                DdlExistReason.DataTextField = "Reason";
                DdlExistReason.DataValueField = "Reason";
                DdlExistReason.DataBind();
                DdlExistReason.Items.Insert(0, "");
                DdlExistReason.SelectedIndex = 1;
            }
        }
        catch (Exception ex)
        { }
    }
    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        txtInfo.Text = "";
    }
    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
        rwSaveTime.VisibleOnPageLoad = false;
    }
    protected void gvSaveTime_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LoadSaveTime();
    }
    protected void BtnLeaveTxns_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveTxns.aspx");
    }
    protected void LnkView_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        int rsn = Convert.ToInt16(lnk.CommandName);
        LoadView(rsn);
        rwView.OpenerElementID = lnk.ClientID;
        rwView.Visible = true;
    }
    protected void LoadView(int rsn)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                LblStaff.Text = ds.Tables[0].Rows[0]["StaffName"].ToString();
                LblLeaveType.Text = ds.Tables[0].Rows[0]["LeaveType"].ToString();
                LblLeaveStart.Text = ds.Tables[0].Rows[0]["LeaveStart"].ToString();
                LblRetDate.Text = ds.Tables[0].Rows[0]["ReturnDate"].ToString();
                LblLeaveDays.Text = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                LblReason.Text = ds.Tables[0].Rows[0]["Reason"].ToString();
                LblStatus.Text = ds.Tables[0].Rows[0]["Status"].ToString();
                LblApplyOn.Text = ds.Tables[0].Rows[0]["C_Date"].ToString();
                LblAppliedBy.Text = ds.Tables[0].Rows[0]["C_Id"].ToString();
                LblApprovedBy.Text = ds.Tables[0].Rows[0]["ApprovedBy"].ToString();
                LblApprovedOn.Text = ds.Tables[0].Rows[0]["ApprovedDate"].ToString();
                LblRemarks.Text = ds.Tables[0].Rows[0]["Remarks"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load view!");
        }
    }
    protected void LnkCeoView_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        int rsn = Convert.ToInt16(lnk.CommandName);
        LoadView(rsn);
        rwView.OpenerElementID = lnk.ClientID;
        rwView.Visible = true;
    }
    protected void LnkCeoUpdate_Click(object sender, EventArgs e)
    {
        if (!IsPageRefresh)
        {
            string url;
            LinkButton lnk = (LinkButton)sender;
            int rsn = Convert.ToInt16(lnk.CommandName);
            url = "LeaveApply.aspx?RSN=" + rsn;
            string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
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

    protected void BtnViewAll_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveTxns.aspx?Type=View All");
    }
    protected void BtnAppliedByMe_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveTxns.aspx?Type=By Me");
    }
    protected void BtnHolidays_Click(object sender, EventArgs e)
    {
        Response.Redirect("Holidays.aspx");
    }
    protected void BtnLvCredit_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveAllow.aspx");
    }
    protected void LoadLKUP()
    {
        try
        {
            dsLKUP = proc.SQLExecuteDataset("SP_LookUpDet",
                         new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 }
                         );
        }
        catch (Exception ex)
        {

        }
    }

}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
