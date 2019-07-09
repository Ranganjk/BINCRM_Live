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

public partial class LeaveApprove : System.Web.UI.Page
{
    string Status, AppDate, AppBy;
    string staffid;
    double cl, sl, el, lv;
    SQLProcs proc = new SQLProcs();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Leave Approve", DateTime.Now);

            if (Request.QueryString["RSN"].ToString() != "0")
            {
                //LoadStaffId();
                LoadTxnType();
                //LoadStatus();
                //LoadReportHead();
                //LoadSaveTime();
                //Clear();
                //LoadData();
                //LoadLeave(Session["StaffId"].ToString());
                LoadHolidays();
                LoadView(Convert.ToInt16(Request.QueryString["RSN"]));
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
                LblStaffname.Text = staffid;
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

        }
    }

    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>window.close();</script>");
    }

    protected void LoadTxnType()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LookUpDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "TT" }
                );
            DdlTxnType.DataSource = ds.Tables[0];
            DdlTxnType.DataTextField = "ShortDesc";
            DdlTxnType.DataValueField = "CodeValue";
            DdlTxnType.DataBind();
            DdlTxnType.Items.Insert(0, "Please Select");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.StackTrace);
        }
    }

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        string msg1;
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                new SqlParameter() { ParameterName = "@LeaveId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Request.QueryString["RSN"]) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                double lvdays = (Convert.ToDouble(ds.Tables[0].Rows[0]["ApplyLeave"])) - (Convert.ToDouble(ds.Tables[0].Rows[0]["TxnLeave"]));
                double lvtemp = Convert.ToDouble(TxtLeaveDays.Text);
                if ((lvdays - lvtemp) == 0)
                {
                    msg1 = CheckLeave();
                    if (msg1 == "OK")
                    {
                        SaveData();
                        ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave transaction has been saved successfully!'); window.opener.location.reload(); window.close();</script>");
                    }
                    else
                    {
                        WebMsgBox.Show(msg1);
                    }
                }
                else if ((lvdays - lvtemp) > 0)
                {
                    msg1 = CheckLeave();
                    if (msg1 == "OK")
                    {
                        SaveData();
                        LoadLeave(Session["SID"].ToString());
                        WebMsgBox.Show("Leave transaction has been saved successfully!");
                    }
                    else
                        WebMsgBox.Show(msg1);
                }
                else if ((lvdays - lvtemp) < 0)
                {
                    WebMsgBox.Show("You cannot apply. Please check it!");
                }
            }
            //msg1 = CheckLeave();
            //if (msg1 == "OK")
            //{
            //    SaveData();
            //    ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave transaction has been saved successfully!'); window.opener.location.reload(); window.close();</script>");
            //}
            //else
            //{
            //    WebMsgBox.Show(msg1);
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on save the leave transaction!");
        }
    }
    protected void BtnAddMore_Click(object sender, EventArgs e)
    {
        string msg1 = null;
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                new SqlParameter() { ParameterName = "@LeaveId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Request.QueryString["RSN"]) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                double lvdays = (Convert.ToDouble(ds.Tables[0].Rows[0]["ApplyLeave"])) - (Convert.ToDouble(ds.Tables[0].Rows[0]["ApplyLeave"]));
                double lvtemp = Convert.ToDouble(TxtLeaveDays.Text);
                if ((lvdays - lvtemp) == 0)
                {
                    msg1 = CheckLeave();
                    if (msg1 == "OK")
                    {
                        SaveData();
                        LoadLeave(Session["SID"].ToString());
                        ClientScript.RegisterStartupScript(typeof(Page), "close", "<script type='text/javascript'>alert('Leave transaction has been saved successfully!'); window.opener.location.reload(); window.close();</script>");
                    }
                    else
                        WebMsgBox.Show(msg1);
                }
                else if ((lvdays - lvtemp) > 0)
                {
                    msg1 = CheckLeave();
                    if (msg1 == "OK")
                    {
                        SaveData();
                        LoadLeave(Session["SID"].ToString());
                        WebMsgBox.Show("Leave transaction has been saved successfully!");
                    }
                    else
                        WebMsgBox.Show(msg1);
                }
                else if ((lvdays - lvtemp) < 0)
                {
                    WebMsgBox.Show("You cannot apply. Please check it!");
                }
            }
            //msg1 = CheckLeave();
            //if (msg1 == "OK")
            //{
            //    SaveData();
            //    LoadLeave(Session["SID"].ToString());
            //    WebMsgBox.Show("Leave transaction has been saved successfully!");
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on save the leave transaction!");
        }
    }
    protected void SaveData()
    {
        try
        {
            proc.ExecuteSQLNonQuery("SP_LeaveTxns",
                           new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                           new SqlParameter() { ParameterName = "@LeaveId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Request.QueryString["RSN"]) },
                           new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtFromDate.Text) },
                           new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtToDate.Text) },
                           new SqlParameter() { ParameterName = "@TxnsType", SqlDbType = SqlDbType.Char, Value = DdlTxnType.SelectedValue },
                           new SqlParameter() { ParameterName = "@LeaveDays", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtLeaveDays.Text) },
                           new SqlParameter() { ParameterName = "@C_Id", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["StaffId"]) },
                           new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["StaffId"]) }
                           );
            proc.ExecuteSQLNonQuery("SP_LeaveAllow",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["SID"]) },
                       new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = cl },
                       new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = sl },
                       new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = el },
                       new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["StaffId"]) }
                );

        }
        catch (Exception ex)
        {

        }
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
                TxtFromDate.Text = ds.Tables[0].Rows[0]["LeaveStart"].ToString();
                LblRetDate.Text = ds.Tables[0].Rows[0]["ReturnDate"].ToString();
                TxtToDate.Text = ds.Tables[0].Rows[0]["ReturnDate"].ToString();
                LblLeaveDays.Text = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                TxtLeaveDays.Text = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                LblReason.Text = ds.Tables[0].Rows[0]["Reason"].ToString();
                LblStatus.Text = ds.Tables[0].Rows[0]["Status"].ToString();
                LblApplyOn.Text = ds.Tables[0].Rows[0]["C_Date"].ToString();
                LblAppliedBy.Text = ds.Tables[0].Rows[0]["C_Id"].ToString();
                LblApprovedBy.Text = ds.Tables[0].Rows[0]["ApprovedBy"].ToString();
                LblApprovedOn.Text = ds.Tables[0].Rows[0]["ApprovedDate"].ToString();
                LblRemarks.Text = ds.Tables[0].Rows[0]["Remarks"].ToString();
                //staffid = ds.Tables[0].Rows[0]["StaffId"].ToString();
                Session["SID"] = ds.Tables[0].Rows[0]["StaffId"].ToString();
                LoadLeave(Session["SID"].ToString());
                DdlTxnType.SelectedValue = "CD";
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load view!");
        }
    }
    protected string CheckLeave()
    {
        string msg = null;
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["SID"]) }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                cl = Convert.ToDouble(ds.Tables[0].Rows[0]["Casual"]);
                el = Convert.ToDouble(ds.Tables[0].Rows[0]["Earn"]);
                sl = Convert.ToDouble(ds.Tables[0].Rows[0]["Sick"]);
                lv = Convert.ToDouble(TxtLeaveDays.Text);
                if (DdlTxnType.SelectedValue == "CD")
                {
                    if (lv <= cl)
                    {
                        cl = cl - lv;
                        msg = "OK";
                    }
                    else
                    {
                        msg = "Casual leave is lessthan total no.of leave(s).So, you cannot debit from causal leave!";
                    }
                }
                else if (DdlTxnType.SelectedValue == "SD")
                {
                    if (lv <= sl)
                    {
                        sl = sl - lv;
                        msg = "OK";
                    }
                    else
                    {
                        msg = "Sick leave is lessthan total no.of leave(s).So, you cannot debit from causal leave!";
                    }
                }
                else if ((DdlTxnType.SelectedValue == "ED") || (DdlTxnType.SelectedValue == "OD") || (DdlTxnType.SelectedValue == "UD"))
                {
                    if (lv <= el)
                    {
                        el = el - lv;
                        msg = "OK";
                    }
                    else
                    {
                        msg = "Earn leave is lessthan total no.of leave(s).So, you cannot debit from causal leave!";
                    }
                }
                else if (DdlTxnType.SelectedValue == "CC")
                {
                    cl = cl + lv;
                    msg = "OK";
                }
                else if ((DdlTxnType.SelectedValue == "EC") || (DdlTxnType.SelectedValue == "OC"))
                {
                    el = el + lv;
                    msg = "OK";
                }
                else if (DdlTxnType.SelectedValue == "SC")
                {
                    sl = sl + lv;
                    msg = "OK";
                }
                else
                {
                    msg = "OK";
                }
                return msg;
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on check leave!");
            return null;
        }
    }
    protected void TxtFromDate_TextChanged(object sender, EventArgs e)
    {
        TxtToDate.Text = "";
        TxtLeaveDays.Text = "";
    }
    protected void TxtToDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            String msg = null;
            int flag = 0;
            if ((TxtFromDate.Text != "") && (TxtToDate.Text != ""))
            {
                DateTime retdate = Convert.ToDateTime(TxtToDate.Text);
                do
                {
                    ds = proc.SQLExecuteDataset("SP_HolidayDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName = "@HolidayDate", SqlDbType = SqlDbType.Date, Value = retdate }
                    );
                    if ((ds.Tables[0].Rows.Count == 0) && (retdate.DayOfWeek.ToString() != "Sunday"))
                    {
                        TxtToDate.Text = retdate.ToString("dd-MMM-yyyy");
                        flag = 0;
                    }
                    else
                    {
                        retdate = retdate.AddDays(1);
                        flag = 1;
                        //retdate = Convert.ToDateTime(ds.Tables[0].Rows[0]["HolidayDate"]).AddDays(1);
                        msg = "you select return date is holiday. The system change return date when office next working day!";
                    }
                }
                while (flag == 1);
                DataSet ds1 = new DataSet();
                ds1 = proc.SQLExecuteDataset("SP_HolidayDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                    new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtFromDate.Text) },
                    new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtToDate.Text) }
                    );
                int leave = Convert.ToInt16(ds1.Tables[0].Rows[0]["Leave"]);
                for (DateTime i = Convert.ToDateTime(TxtFromDate.Text); i < Convert.ToDateTime(TxtToDate.Text); i = i.AddDays(1))
                {
                    if (i.DayOfWeek.ToString() == "Sunday")
                    {
                        leave = leave + 1;
                    }


                }
                DateTime dstart = Convert.ToDateTime(TxtFromDate.Text);
                DateTime dreturn = Convert.ToDateTime(TxtToDate.Text);
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

}