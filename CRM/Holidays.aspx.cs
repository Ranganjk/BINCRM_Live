using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMS;
using System.Web.Security;
using System.Net;

public partial class Holidays : System.Web.UI.Page
{
    SQLProcs proc = new SQLProcs();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Holidays", DateTime.Now);

            LoadHType();
            LoadHStatus();
            LoadGrid();
        }
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //if (TxtHName.Text == "")
            //    TxtHName.Text = null;
            //if (TxtRemarks.Text == "")
            //    TxtRemarks.Text = null;
            
            proc.ExecuteSQLNonQuery("SP_HolidayDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@HolidayDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtHDate.Text).Date },
                new SqlParameter() { ParameterName = "@HolidayType", SqlDbType = SqlDbType.Char, Value = DdlHType.SelectedValue },
                new SqlParameter() { ParameterName = "@HolidayName", SqlDbType = SqlDbType.VarChar, Value = string.IsNullOrEmpty(TxtHName.Text) ? null : TxtHName.Text },
                new SqlParameter() { ParameterName = "@HolidayStatus", SqlDbType = SqlDbType.Char, Value = DdlHStatus.SelectedValue },
                new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.VarChar, Value = TxtRemarks.Text },
                new SqlParameter() { ParameterName = "@C_Id", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["StaffId"]) },
                new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.VarChar, Value = Convert.ToInt32(Session["StaffId"]) }
                );
            WebMsgBox.Show("Holiday details has been inserted successfully!");
            LoadGrid();
            Clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on save holiday!");
        }
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Clear();
        Response.Redirect("LeaveHome1.aspx");
    }
    protected void RGHolidays_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }
    protected void RGHolidays_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void RGHolidays_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void LnkDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDel = (LinkButton)sender;
            int rsn = Convert.ToInt32(lnkDel.CommandName);
            proc.ExecuteSQLNonQuery("SP_HolidayDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn }
                );
            WebMsgBox.Show("Deleted succesfully!");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on delete holiday!");
        }
    }
    protected void LoadHType()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LookUpDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "HT" }
                );
            DdlHType.DataSource = ds.Tables[0];
            DdlHType.DataTextField = "ShortDesc";
            DdlHType.DataValueField = "CodeValue";
            DdlHType.DataBind();
            DdlHType.Items.Insert(0, "Please Select");
            DdlHType.SelectedValue = "00";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load holiday type");
        }
    }
    protected void LoadHStatus()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LookUpDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@CodeId", SqlDbType = SqlDbType.Char, Value = "HS" }
                );
            DdlHStatus.DataSource = ds.Tables[0];
            DdlHStatus.DataTextField = "ShortDesc";
            DdlHStatus.DataValueField = "CodeValue";
            DdlHStatus.DataBind();
            DdlHStatus.Items.Insert(0, "Please Select");
            DdlHStatus.SelectedValue = "HA";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load holiday status");
        }
    }
    protected void LoadGrid()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_HolidayDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 }
                );
                RGHolidays.DataSource = ds.Tables[0];
                RGHolidays.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load holiday status");
        }
    }
    protected void Clear()
    {
        TxtHDate.Text = "";
        TxtHName.Text = "";
        TxtRemarks.Text = "";
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
}