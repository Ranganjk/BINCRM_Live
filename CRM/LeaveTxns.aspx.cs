using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMS;
using System.Web.Security;
using System.Net;
using Telerik.Web.UI;

public partial class LeaveTxns : System.Web.UI.Page
{
    SQLProcs proc = new SQLProcs();
    Boolean IsPageRefresh;
    protected void Page_Load(object sender, EventArgs e)
    {
        rwView.VisibleOnPageLoad = true;
        rwView.Visible = false;
        if (!IsPostBack)
        {
            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Leave Transaction", DateTime.Now);

            DateTime date = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            TxtFrmDate.Text = date.ToString("dd-MMM-yyyy ddd");
            TxtToDate.Text = date.AddMonths(1).AddDays(-1).ToString("dd-MMM-yyyy ddd");
            LoadTxns();
            LoadBtn();
            ViewState["postids"] = System.Guid.NewGuid().ToString();
            Session["postid"] = ViewState["postids"].ToString();
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

    }

    protected void LoadBtn()
    {
        try
        {
            if (Session["UserLevel"].ToString() == "4User")
            {
                BtnAppliedByMe.Visible = true;
            }
            else if (Session["UserLevel"].ToString() == "1Manager")
            {
                BtnAppliedByMe.Visible = true;
                BtnViewAll.Visible = true;
            }
            else if (Session["UserLevel"].ToString() == "2CoOrdinator")
            {
                DataSet ds = new DataSet();
                ds = proc.SQLExecuteDataset("SP_ChkNormal",

                    new SqlParameter() { ParameterName = "@staffid", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
                    );

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["IsNormal"].ToString() == "True")
                    {
                        BtnAppliedByMe.Visible = true;
                    }
                    else
                    {
                        BtnAppliedByMe.Visible = true;
                        BtnViewAll.Visible = true;
                        DataSet dsaccounts = proc.SQLExecuteDataset("sp_chkaccounts",
                            new SqlParameter() { ParameterName = "@staffid", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
                            );
                        if (dsaccounts.Tables[0].Rows.Count > 0)
                        {
                            if (dsaccounts.Tables[0].Rows[0]["IsAccounts"].ToString() == "True")
                            {
                                BtnHolidays.Visible = true;
                                BtnLvCredit.Visible = true;
                            }
                        }
                    }
                }

            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void LoadTxns()
    {
        try
        {
            //if (Convert.ToInt32(Session["UserLevel"]) > 2)
            //{

            //    RGTxns.MasterTableView.GetColumn("LnkDelete").Display = false;
            //}
            //else
            //{
            //    RGTxns.MasterTableView.GetColumn("LnkDelete").Display = true;
            //}
            if (Request.QueryString["Type"] == "By Me")
            {
                LblHeader.Text = "Leave Transaction Details - By Me";
                DataSet ds = new DataSet();
                ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                    new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(Session["StaffId"]) },
                    new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtFrmDate.Text) },
                    new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtToDate.Text).AddDays(1) }
                    );
                RGTxns.DataSource = ds.Tables[0];
                RGTxns.DataBind();
                RGTxns.MasterTableView.GetColumn("StaffName").Display = false;
            }
            else
            {
                LblHeader.Text = "Leave Transaction Details - View All";
                DataSet ds = new DataSet();
                ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtFrmDate.Text) },
                    new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtToDate.Text) }
                    );
                RGTxns.DataSource = ds.Tables[0];
                RGTxns.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Failed on load leave transactions!");
        }
    }

    protected void RGTxns_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadTxns();
    }
    protected void RGTxns_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadTxns();
    }
    protected void RGTxns_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadTxns();
    }

    protected void LnkTxnEdit_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
         string status = lnk.CommandArgument;
        if (!IsPageRefresh)
        {
           
            if (Session["UserLevel"].ToString() == "4User")
            {
                if (status != "Applied")
                    WebMsgBox.Show("This leave has been modified by your reporting head. So you are not able to update/edit.");
                else
                {
                    string rsn = lnk.CommandName;
                    string url = "LeaveApply.aspx?RSN=" + rsn;
                    string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
                    ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
                }
            }
            else
            {
                if (lnk.ValidationGroup.Equals(Session["StaffID"].ToString()))
                {
                    if (status != "Applied")
                        WebMsgBox.Show("This leave has been modified by your reporting head. So you are not able to update/edit.");
                    else
                    {
                        string rsn = lnk.CommandName;
                        string url = "LeaveApply.aspx?RSN=" + rsn;
                        string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
                        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
                    }
                }
                else
                {
                    string rsn = lnk.CommandName;
                    string url = "LeaveApply.aspx?RSN=" + rsn;
                    string s = "window.open('" + url + "', 'popup_window', 'status=no,height=600,width=1000,resizable=yes,screenX=80,screenY=80,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no');";
                    ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
                }
            }
        }

    }
    protected void LnkTxnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(Session["UserLevel"]) < 3)
            {
                LinkButton lnkDelete = (LinkButton)sender;
                int rsn = Convert.ToInt16(lnkDelete.CommandName);
                string txntype = lnkDelete.CommandArgument;
                if (txntype == "")
                {
                    proc.ExecuteSQLNonQuery("SP_LeaveDet",
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn }
                        );
                    WebMsgBox.Show("Leave transaction has been deleted successfully!");
                }
                else
                {
                    CheckLeave(rsn);
                    WebMsgBox.Show("Leave transaction has been deleted successfully!");
                }
            }
            else
            {
                WebMsgBox.Show("You cannot delete the leave transactions!");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on delete!");
        }
    }
    protected void CheckLeave(int rsn)
    {
        string msg = null;
        double cl = 0, el = 0, sl = 0;
        try
        {
            DataSet ds2 = new DataSet();
            DataSet ds1 = new DataSet();
            ds2 = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                new SqlParameter() { ParameterName = "@Flag", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn }
                );
            int staffid = Convert.ToInt16(ds2.Tables[0].Rows[0]["StaffId"]);
            int LeaveId = Convert.ToInt16(ds2.Tables[0].Rows[0]["LeaveId"]);
            ds1 = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = LeaveId }
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
            proc.ExecuteSQLNonQuery("SP_LeaveDet",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(ds1.Tables[0].Rows[0]["LeaveId"]) }
                    );
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on check leave!");
        }
    }
    protected void LnkTxnView_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        int rsn = Convert.ToInt16(lnk.CommandName);
        string txntype = lnk.CommandArgument;
        LoadView(rsn, txntype);
        rwView.OpenerElementID = lnk.ClientID;
        rwView.Visible = true;
    }

    protected void LoadView(int rsn, string txntype)
    {
        try
        {
            int flag = 0;
            DataSet ds = new DataSet();
            if (txntype == "-")
                flag = 0;
            else
                flag = 1;
            ds = proc.SQLExecuteDataset("SP_LeaveTxns",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn },
                new SqlParameter() { ParameterName = "@Flag", SqlDbType = SqlDbType.Int, Value = flag }
                );
            if (ds.Tables[0].Rows.Count > 0)
            {
                LblStaff.Text = ds.Tables[0].Rows[0]["StaffName"].ToString();
                LblLeaveType.Text = ds.Tables[0].Rows[0]["LeaveType"].ToString();
                LblTxnType.Text = ds.Tables[0].Rows[0]["TxnType"].ToString();
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

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("LeaveHome1.aspx");
    }
    protected void BtnView_Click(object sender, EventArgs e)
    {
        LoadTxns();
    }
    protected void TxtFrmDate_TextChanged(object sender, EventArgs e)
    {
        CalLeaveToDate.StartDate=Convert.ToDateTime(TxtFrmDate.Text);
        TxtToDate.Text = TxtFrmDate.Text;
    }
}