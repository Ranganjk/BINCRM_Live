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

public partial class LeaveAllow : System.Web.UI.Page
{
    SQLProcs proc = new SQLProcs();
    public static DataSet dsLeaveReports = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Leave Allow", DateTime.Now);

                LoadStaff();
                LoadForMonth();
                LoadGrid();
            }
        }
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (TxtCasual.Text == "")
                TxtCasual.Text = "0";
            if (TxtSick.Text == "")
                TxtSick.Text = "0";
            if (TxtEarn.Text == "")
                TxtEarn.Text = "0";
            //if (BtnSave.Text == "Save")
            //{
            //    Double cl = 0, el = 0, sl = 0;
            //    DataSet ds = new DataSet();
            //    ds = proc.SQLExecuteDataset("SP_LeaveAllow",
            //        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
            //        new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(DdlStaffId.SelectedValue) }
            //        );
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        cl = Convert.ToDouble(ds.Tables[0].Rows[0]["Casual"]);
            //        el = Convert.ToDouble(ds.Tables[0].Rows[0]["Earn"]);
            //        sl = Convert.ToDouble(ds.Tables[0].Rows[0]["Sick"]);
            //    }
            //    cl = cl + Convert.ToDouble(TxtCasual.Text);
            //    el = el + Convert.ToDouble(TxtEarn.Text);
            //    sl = sl + Convert.ToDouble(TxtSick.Text);
            //    proc.SQLExecuteDataset("SP_LeaveAllow",
            //        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
            //        new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(DdlStaffId.SelectedValue) },
            //        new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = cl },
            //        new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = el },
            //        new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = sl },
            //        new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
            //        );
            //}
            //else
            //{
            //    proc.SQLExecuteDataset("SP_LeaveAllow",
            //       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
            //       new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(DdlStaffId.SelectedValue) },
            //       new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtCasual.Text) },
            //       new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtEarn.Text) },
            //       new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = Convert.ToDouble(TxtSick.Text) },
            //       new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
            //       );
            //}
            DataSet ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                   new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                   new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt64(DdlStaffId.SelectedValue) },
                   new SqlParameter() { ParameterName = "@ForMonth", SqlDbType = SqlDbType.VarChar, Value = DdlMonthDet.SelectedValue }
                   );
            //DataView dv = new DataView(dsLeaveReports.Tables[0]);
            //dv.RowFilter = "StaffID=" + DdlStaffId.SelectedValue;
            //dv.RowFilter = "month=" + DdlMonth.SelectedValue;
            DataTable dt = new DataTable();
            dt = ds.Tables[0];
            double el=0, cl=0, sl=0;
            int rsn = 0;
            if(dt.Rows.Count>0)
            {
                el =  Convert.ToDouble(TxtEarn.Text);
                cl =  Convert.ToDouble(TxtCasual.Text);
                sl =  Convert.ToDouble(TxtSick.Text);
                rsn = Convert.ToInt32(dt.Rows[0]["RSN"]);
                if(rblLeaveCorD.SelectedValue=="CT")
                {
                    el = el + Convert.ToDouble(dt.Rows[0]["LC_EL"]);
                    cl = cl + Convert.ToDouble(dt.Rows[0]["LC_CL"]);
                    sl = sl + Convert.ToDouble(dt.Rows[0]["LC_SL"]);
                    proc.SQLExecuteDataset("SP_LeaveAllow",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn },
                    new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = cl },
                    new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = el },
                    new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = sl },
                    new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }
                    );
                }
                else if(rblLeaveCorD.SelectedValue=="DT")
                {

                   

                    el = el + Convert.ToDouble(dt.Rows[0]["LD_EL"]);
                    cl = cl + Convert.ToDouble(dt.Rows[0]["LD_CL"]);
                    sl = sl + Convert.ToDouble(dt.Rows[0]["LD_SL"]);
                    proc.SQLExecuteDataset("SP_LeaveAllow",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = rsn },

                    new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Float, Value = cl },
                    new SqlParameter() { ParameterName = "@Earn", SqlDbType = SqlDbType.Float, Value = el },

                    new SqlParameter() { ParameterName = "@Sick", SqlDbType = SqlDbType.Float, Value = sl },
                    new SqlParameter() { ParameterName = "@C_Id", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString()  },
                    new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.BigInt, Value = Session["StaffId"].ToString() }

                   

                    );
                }
               
            }

           

            LoadGrid();
            Clear();
            WebMsgBox.Show("Leave credit details have been updated successfully!");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on update leave cerdit!");
        }
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Clear();
        Response.Redirect("LeaveHome1.aspx");
    }

    protected void RGLeaveCredit_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }
    protected void RGLeaveCredit_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void RGLeaveCredit_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void LoadStaff()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_FetchStaffDet",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 }
                );
            DdlStaffId.DataSource = ds.Tables[0];
            DdlStaffId.DataTextField = "StaffName";
            DdlStaffId.DataValueField = "StaffId";
            DdlStaffId.DataBind();
            DdlStaffId.Items.Insert(0, "Please Select");
            DdlStaffId.SelectedIndex = 1;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load staff name!");
        }
    }
    protected void LoadGrid()
    {
        try
        {
            //DataSet ds = new DataSet();
            //ds = proc.SQLExecuteDataset("SP_LeaveAllow",
            //    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 }
            //    );

            //for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //{
            //    ds.Tables[0].Rows[i]["Total"] = (Convert.ToDouble(ds.Tables[0].Rows[i]["Casual"]) + Convert.ToDouble(ds.Tables[0].Rows[i]["Sick"]) + Convert.ToDouble(ds.Tables[0].Rows[i]["Earn"])).ToString();
            //}

            //    RGLeaveCredit.DataSource = ds.Tables[0];
            //    RGLeaveCredit.DataBind();
                DataSet ds = new DataSet();
                ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName="@ForMonth",SqlDbType=SqlDbType.VarChar, Value=DdlMonthDet.SelectedValue }
                    );
                dsLeaveReports = ds;

                //for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                //{
                //    ds.Tables[0].Rows[i]["Total"] = (Convert.ToDouble(ds.Tables[0].Rows[i]["Casual"]) + Convert.ToDouble(ds.Tables[0].Rows[i]["Sick"]) + Convert.ToDouble(ds.Tables[0].Rows[i]["Earn"])).ToString();
                //}

                RGLeaveCredit.DataSource = ds.Tables[0];
                RGLeaveCredit.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Error on load leave credit details!");
        }
    }
    protected void LoadForMonth()
    {
        try
        {
            DdlMonth.Items.Clear();
            DdlMonthDet.Items.Clear();
            DateTime now = new DateTime();
            now = DateTime.Today;
            for(int i=-11;i<2;i++)
            {
                DateTime date = now.AddMonths(i);
                DdlMonth.Items.Add(
                    new ListItem(date.ToString("MMM yyyy"),date.ToString("MMM yyyy")));
                DdlMonthDet.Items.Add(
                    new ListItem(date.ToString("MMM yyyy"), date.ToString("MMM yyyy")));
            }
            DdlMonth.DataBind();
            DdlMonthDet.DataBind();
            DdlMonth.Items.Insert(0, "Please Select");
            DdlMonthDet.Items.Insert(0, "Please Select");
            DdlMonth.SelectedValue=now.ToString("MMM yyyy");
            DdlMonthDet.SelectedValue = now.ToString("MMM yyyy");
        }
        catch(Exception ex)
        {

        }
    }
    protected void Clear()
    {
        TxtCasual.Text = "";
        TxtEarn.Text = "";
        TxtSick.Text = "";
        BtnSave.Text = "Save";
    }

    protected void LnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdit = (LinkButton)sender;
            int staffid = Convert.ToInt32(lnkEdit.CommandName);
            DataSet ds = new DataSet();
            ds = proc.SQLExecuteDataset("SP_LeaveAllow",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@StaffId", SqlDbType = SqlDbType.Int, Value = staffid }
                );
            DdlStaffId.SelectedValue = ds.Tables[0].Rows[0]["StaffId"].ToString();
            TxtCasual.Text = ds.Tables[0].Rows[0]["Casual"].ToString();
            TxtSick.Text = ds.Tables[0].Rows[0]["Sick"].ToString();
            TxtEarn.Text = ds.Tables[0].Rows[0]["Earn"].ToString();
            BtnSave.Text = "Update";
        }
        catch (Exception ex)
        {

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
        LoadGrid();

    }
}