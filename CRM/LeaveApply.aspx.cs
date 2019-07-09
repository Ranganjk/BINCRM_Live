using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMS;

public partial class LeaveApply : System.Web.UI.Page
{
    string Status, AppDate, AppBy;
    SQLProcs proc = new SQLProcs();
    public static DataSet dsLKUP = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            LoadLKUP();
            if (!IsPostBack)
            {

                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Leave Apply", DateTime.Now);

                if (Request.QueryString["RSN"].ToString() != "0")
                {
                    LoadStaffId();
                    
                    LoadReportHead();
                    LoadSaveTime();
                    Clear();
                    LoadData();
                    LoadStatus();
                    LoadLeaveType();
                    //LoadLeave(Session["StaffId"].ToString());
                    LoadHolidays();
                    LoadLeaveApply();

                }
            }
        }
    }
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
            WebMsgBox.Show("Error on Load Leaves!");
        }
    }
    protected void LoadHolidays()
    {
        try
        {
            DateTime today, lastdate;
            String holidays = "No record found!";
            today = DateTime.Now.AddDays(-7);
            lastdate = new DateTime(DateTime.Now.Year + 1, 1, 1);
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
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load Holidays");
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
        TxtReason.Text = "";
        TxtReturnDate.Text = "";
        BtnApply.Text = "Apply";
    }

    protected void BtnApply_Click(object sender, EventArgs e)
    {
        try
        {
            if (BtnApply.Text == "Save")
            {
                proc.ExecuteSQLNonQuery("SP_LeaveDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Request.QueryString["RSN"]) },
                    new SqlParameter() { ParameterName = "@Staffid", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(DdlStaffid.SelectedValue) },
                    new SqlParameter() { ParameterName = "@LeaveType", SqlDbType = SqlDbType.Char, Value = DdlLeaveType.SelectedValue },
                    new SqlParameter() { ParameterName = "@LeaveStart", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveStart.Text) },
                    new SqlParameter() { ParameterName = "@ReturnDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtReturnDate.Text) },
                    //new SqlParameter() { ParameterName = "@LeaveDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveEndDate.Text) },
                    new SqlParameter() { ParameterName = "@LeaveDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtLeaveDays.Text) },
                    // new SqlParameter() { ParameterName = "@TotalDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtTotDays.Text) },
                    new SqlParameter() { ParameterName = "@Reason", SqlDbType = SqlDbType.VarChar, Value = TxtReason.Text },
                    new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Char, Value = DdlStatus.SelectedValue },
                    new SqlParameter() { ParameterName = "@ReportTo", SqlDbType = SqlDbType.NVarChar, Value = DdlReportTo.SelectedValue },
                    new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.VarChar, Value = Session["Staffid"].ToString() }
                    );
            }
            else
            {
                if (Status != DdlStatus.SelectedValue)
                {
                    AppBy = Session["StaffId"].ToString();

                    AppDate = DateTime.Now.ToString();
                }
                proc.ExecuteSQLNonQuery("SP_LeaveDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Request.QueryString["RSN"]) },
                    new SqlParameter() { ParameterName = "@Staffid", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(DdlStaffid.SelectedValue) },
                    new SqlParameter() { ParameterName = "@LeaveType", SqlDbType = SqlDbType.Char, Value = DdlLeaveType.SelectedValue },
                    new SqlParameter() { ParameterName = "@LeaveStart", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveStart.Text) },
                    new SqlParameter() { ParameterName = "@ReturnDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtReturnDate.Text) },
                    //new SqlParameter() { ParameterName = "@LeaveDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtLeaveEndDate.Text) },
                    new SqlParameter() { ParameterName = "@LeaveDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtLeaveDays.Text) },
                    // new SqlParameter() { ParameterName = "@TotalDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtTotDays.Text) },
                    new SqlParameter() { ParameterName = "@Reason", SqlDbType = SqlDbType.VarChar, Value = TxtReason.Text },
                    new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Char, Value = DdlStatus.SelectedValue },
                    new SqlParameter() { ParameterName = "@ReportTo", SqlDbType = SqlDbType.NVarChar, Value = DdlReportTo.SelectedValue },
                    new SqlParameter() { ParameterName = "@ApprovedBy", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(AppBy) },
                    new SqlParameter() { ParameterName = "@ApprovedDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(AppDate) },
                    new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.VarChar, Value = Session["Staffid"] }
                    );
                if ((Status != DdlStatus.SelectedValue) && (DdlStatus.SelectedValue != "AP"))
                {
                    CheckLeave(Convert.ToInt32(Request.QueryString["RSN"]));
                }
            }
            Clear();
            ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave has been saved successfully!'); window.opener.location.reload(); window.close();</script>");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on apply leave!");
        }
    }
    protected void CheckLeave(int rsn)
    {
        double cl = 0, el = 0, sl = 0;
        try
        {
            DataSet ds1 = new DataSet();
            int staffid = Convert.ToInt16(DdlStaffid.SelectedValue);
            ds1 = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn }
                );

            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = staffid }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                cl = Convert.ToDouble(ds.Tables[0].Rows[0]["Casual"]);
                el = Convert.ToDouble(ds.Tables[0].Rows[0]["Earn"]);
                sl = Convert.ToDouble(ds.Tables[0].Rows[0]["Sick"]);
            }
            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                if (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Casual Debit")
                    cl = cl + Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
                else if (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Casual Credit")
                    cl = cl - Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
                else if (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Sick Debit")
                    sl = sl + Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
                else if (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Sick Credit")
                    sl = sl - Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
                else if ((ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Earn Debit") || (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Other Debit") || (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Unauthorized Debit"))
                    el = el + Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
                else if ((ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Earn Credit") || (ds1.Tables[0].Rows[i]["TxnType"].ToString() == "Other Credit"))
                    el = el - Convert.ToDouble(ds1.Tables[0].Rows[i]["LeaveDays"]);
            }
            proc.ExecuteSQLNonQuery("SP_LeaveAllow",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = staffid },
                new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = cl },
                new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = el },
                new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = sl },
                new SqlParameter() { ParameterName = "@M_ID", SqlDbType = SqlDbType.Int, Value = staffid }
                );
            proc.ExecuteSQLNonQuery("SP_LeaveTxns",
                   new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@LeaveId", SqlDbType = SqlDbType.Int, Value = rsn }
                   );

        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on check leave!");
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
            //DdlLeaveType.SelectedValue = "CL";
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
                    DdlStatus.SelectedValue = "AL";
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
                    DdlStatus.SelectedValue = "AP";
                    DdlStatus.Items.Remove(DdlStatus.Items.FindByValue("AL"));
                }
            }
            DdlStatus.Items.Insert(0, "Please Select");
            
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
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load report head!");
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
    protected void TxtLeaveStart_TextChanged(object sender, EventArgs e)
    {
        TxtReturnDate.Text = "";
        TxtLeaveDays.Text = "";
        TxtLeaveDays.Text = "";
        CalRetDate.StartDate = Convert.ToDateTime(TxtLeaveStart.Text);
    }
    protected void TxtReturnDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            String msg = null;
            int flag = 0;
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
                        TxtReturnDate.Text = retdate.ToString("dd-MMM-yyyy");
                        flag = 0;
                    }
                    else
                    {
                        retdate = retdate.AddDays(1);
                        flag = 1;
                        //retdate = Convert.ToDateTime(ds.Tables[0].Rows[0]["HolidayDate"]).AddDays(1);
                        msg = "you select return date is holiday. The system change return when office next working day!";
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
                }
                else
                    WebMsgBox.Show("The return date must be greaterthan or equal to start date!");
            }
            if (msg != null)
                WebMsgBox.Show(msg);
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
            if ((Session["UserLevel"].ToString() == "1Manager") || (Session["UserLevel"].ToString() == "2CoOrdinator"))
            {
                //DataSet ds1 = new DataSet();
                //ds1 = proc.SQLExecuteDataset("SP_LookUpDet",
                //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                //    new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "TT" }
                //    );
                //DdlTxnType.DataSource = ds1.Tables[0];
                //DdlTxnType.DataTextField = "ShortDesc";
                //DdlTxnType.DataValueField = "CodeValue";
                //DdlTxnType.DataBind();
                //DdlTxnType.Items.Insert(0, "Please Select");
                //DdlTxnType.SelectedValue = "00";

                BtnApply.Text = "Update";
                //BtnAdd.Visible = true;
            }
            else
            {
                BtnApply.Text = "Save";
                //  BtnAdd.Visible = false;
            }
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(Request.QueryString["RSN"]) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                DdlStaffid.SelectedValue = ds.Tables[0].Rows[0]["StaffId"].ToString();
                DdlLeaveType.SelectedValue = ds.Tables[0].Rows[0]["LT"].ToString();
                TxtLeaveStart.Text = ds.Tables[0].Rows[0]["LeaveStart"].ToString();
                TxtReturnDate.Text = ds.Tables[0].Rows[0]["ReturnDate"].ToString();
                //TxtLeaveEndDate.Text = ds.Tables[0].Rows[0]["LeaveEndDate"].ToString();
                //TxtTotDays.Text = ds.Tables[0].Rows[0]["TotalDays"].ToString();
                TxtLeaveDays.Text = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                TxtReason.Text = ds.Tables[0].Rows[0]["Reason"].ToString();

                //DdlStatus.SelectedValue = ds.Tables[0].Rows[0]["Status1"].ToString();
                DdlReportTo.SelectedValue = ds.Tables[0].Rows[0]["ReportTo"].ToString();
                LoadLeave(DdlStaffid.SelectedValue);
                Status = ds.Tables[0].Rows[0]["Status1"].ToString();
                AppDate = ds.Tables[0].Rows[0]["ApprovedDate"].ToString();
                AppBy = ds.Tables[0].Rows[0]["ApprovedBy"].ToString();
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
    //        DataSet ds=new DataSet();
    //        DataSet dsUser = new DataSet();
    //        DataSet dsReportHead = new DataSet();
    //        ds=proc.SQLExecuteDataset("SP_SendMail",
    //            new SqlParameter() { ParameterName="@IMode", SqlDbType=SqlDbType.Int, Value=1}
    //            );
    //        SqlDataAdapter da = new SqlDataAdapter("Select StaffEmail,StaffName,StaffId from tblStaff where username='"+Session["username"]+"'",con);
    //        da.Fill(dsUser);
    //        SqlDataAdapter da1 = new SqlDataAdapter("Select StaffEmail,StaffId,StaffName from tblStaff where username='"+ Session["reportHead"].ToString() +"'",con);
    //        da.Fill(dsReportHead);
    //        DataSet dsleave = new DataSet();

    //        MailMessage mail = new MailMessage();
    //        mail.From = new MailAddress(ds.Tables[0].Rows[0]["username"].ToString());
    //        mail.CC.Add(new MailAddress(dsUser.Tables[0].Rows[0]["StaffEmail"].ToString()));
    //        mail.To.Add(new MailAddress(dsReportHead.Tables[0].Rows[0]["StaffEmail"].ToString()));
    //        string sname=dsUser.Tables[0].Rows[0]["StaffName"].ToString() + " " + dsUser.Tables[0].Rows[0]["StaffId"].ToString();
    //        mail.Subject = "Leave Apply - " + sname;
    //        string body = "Dear " + dsReportHead.Tables[0].Rows[0]["StaffName"].ToString() + ",<br/><br/>";
    //        body = body + "<table width=400px> <tr> <td> Staff Name</td><td> - </td><td>"+sname+"</td></tr>";
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
    //    catch(Exception ex)
    //    {

    //    }
    //}
    protected void BtnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.OpenerElementID = BtnSaveTime.ClientID;
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
    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        txtInfo.Text = "";
    }
    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        txtInfo.Text = "";
        rwSaveTime.Visible = false;
    }
    protected void BtnAdd_Click(object sender, EventArgs e)
    {

    }
    protected void DdlStaffid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DdlStaffid.SelectedIndex > 0)
        {
            LoadLeave(DdlStaffid.SelectedValue);
            LoadStatus();
            LoadLeaveType();
        }
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
}