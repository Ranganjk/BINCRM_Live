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

public partial class Mytasks : System.Web.UI.Page
{
    DataTable dtTemp = new DataTable();
    SQLProcs sqlobj = new SQLProcs();
    string QSUserName;
    string strUserLevel;
    public static DataTable dtTargets;
    public static DataSet dsTarget;
    public static DataSet dsEmpDet;
    public static DataSet dsTargetDet;

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
        string strcnfresultid = CnfResult.ClientID.ToString();
        QSUserName = Session["UserID"].ToString();
        HDLoginUser.Value = Session["UserID"].ToString();

        rwDiary.VisibleOnPageLoad = true;
        rwDiary.Visible = false;
        rwCustomerProfile.VisibleOnPageLoad = true;
        rwCustomerProfile.Visible = false;
        rwBulkUpdate.VisibleOnPageLoad = true;
        rwBulkUpdate.Visible = false;
        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;
        

        if (!IsPostBack)
        {
            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "My Tasks", DateTime.Now);

            lnkmytasks.ForeColor = Color.DarkBlue;
            lnkbyme.ForeColor = Color.LightGray;
            lnknewactiviy.ForeColor = Color.DarkGray; 

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
           
            LoadDDL1();
            LoadTrackOn();
            LoadMasters();
            AddAttributes();
            ddlTaskList1.SelectedIndex = 1;
            btnMyTasks_Click(sender, e);          
        }
    }
    protected void LoadDDL1()
    {
        ListItem[] items = new ListItem[5];
        items[0] = new ListItem("Please Select", "0");
        items[1] = new ListItem("In Progress", "1");
        items[2] = new ListItem("Priority Tasks", "7");
        items[3] = new ListItem("Done last 7 days", "2");
        items[4] = new ListItem("Completed (30Days Range)", "3");

        ddlTaskList1.Items.AddRange(items);
        ddlTaskList1.DataBind();

    }
    protected void LoadTrackOn()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTrackon = new DataSet();
        dsTrackon = sqlobj.SQLExecuteDataset("sp_trackonlkup_new");

        if (dsTrackon.Tables[0].Rows.Count != 0)
        {

            ddlMyTasksReference.DataSource = dsTrackon.Tables[0];
            ddlMyTasksReference.DataValueField = "TrackonDesc";
            ddlMyTasksReference.DataTextField = "TrackonDesc";
            ddlMyTasksReference.DataBind();
            ddlMyTasksReference.Items.Insert(0, "All");
        }
        dsTrackon.Dispose();
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

    private void AddAttributes()
    {
        Button2.Attributes.Add("onclick", "javascript:return NavigateNewTask('" + wsgetLatestbtn.ClientID + "');");
        btnnewenquiry.Attributes.Add("onclick", "javascript:return NavigateNewEnquiry('" + wsgetLatestbtn.ClientID + "');");
        lnknewactiviy.Attributes.Add("onclick", "javascript:return NavigateNewActivity('" + wsgetLatestbtn.ClientID + "');");
        btnbulksubmit.Attributes.Add("onclick", "javascript:return BulkValidate();");
        btnbulkclose.Attributes.Add("onclick", "javascript:ConfirmClick();");
    }
    protected void wsgetLatestbtn_Click(object sender, EventArgs e)
    {
        string StaffID = QSUserName;
        Session["StaffID"] = QSUserName;
        LoadTaskDetDir1(StaffID);
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
        }
        catch (SqlException ex)
        {
            WebMsgBox.Show("Please check your internet connection");
            return;
        }
    }
    protected void ddlTaskList1_Change(object sender, EventArgs e)
    {
        if (ddlTaskList1.SelectedIndex == 3 && RdGrd_TaskDetDir1.Visible == true)
        {
            dtpTaskDate1.Visible = true;
            btnNewPing1.Visible = true;
            btnMyTasks_Click(sender, e);
        }
        else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
        {
            dtpTaskDate1.Visible = false;
            btnNewPing1.Visible = true;
            btnMyTasks_Click(sender, e);
        }
        else if (RdGrd_TaskDetDir1.Visible == true)
        {
            dtpTaskDate1.Visible = false;
            btnNewPing1.Visible = true;
            btnTaskDetDir1.Visible = false;
            btnMyTasks_Click(sender, e);
        }
    }
    protected void btnNewPing1_Click(object sender, EventArgs e)
    {
        try
        {
            Session["TaskID"] = null;
            int CNT = 0;
            string strCustRSN = "";

            foreach (GridDataItem itm in RdGrd_TaskDetDir1.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnktaskid");
                    CNT++;
                    string STaskID = lb.Text;
                    Session["TaskID"] = Session["TaskID"] + STaskID + ",";

                    LinkButton lbcustrsn = (LinkButton)itm.FindControl("lnkname");
                    strCustRSN = strCustRSN + lbcustrsn.CommandArgument.ToString() + ',';

                }
            }
            if (CNT > 0)
            {
                Session["TaskID"] = Session["TaskID"].ToString().Remove(Session["TaskID"].ToString().Length - 1);
                Label21.Text = Session["TaskID"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2('" + strCustRSN + "');", true);

            }
            else
            {
                WebMsgBox.Show("Select one or more tasks first.");
            }

        }
        catch (Exception qr)
        {
            throw qr;
        }
    }
    protected void btnMyTasks_Click(object sender, EventArgs e)
    {
        try
        {
            HDUserID.Value = QSUserName;
            SQLProcs sqlobj = new SQLProcs();
            try
            {
                if (ddlTaskList1.SelectedItem.Text != "Please Select")
                {
                    string StaffID = QSUserName;
                    Session["StaffID"] = QSUserName;
                    string StaffName = QSUserName;
                    RdGrd_TaskDetDir1.Visible = true;
                    btnTaskDetDir1.Visible = true;

                    if (ddlTaskList1.SelectedIndex == 2 || ddlTaskList1.SelectedIndex == 3)
                    {
                        btnNewPing1.Visible = true;
                    }
                    else if (ddlTaskList1.SelectedIndex == 1 || ddlTaskList1.SelectedIndex == 7)
                    {
                        btnNewPing1.Visible = true;
                        dtpTaskDate1.Visible = false;
                    }
                    LoadTaskDetDir1(StaffID);
                    lblHelp11.Visible = true;
                }
                else
                {
                    WebMsgBox.Show("Please select the task status");
                }

            }
            catch (Exception qr)
            {
                WebMsgBox.Show("Please select an option from the drop down list");
                return;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
            return;
        }
    }
    protected void btnTaskDetDir1_Click(object sender, EventArgs e)
    {
        if ((RdGrd_TaskDetDir1.Visible == true))
        {
            if (ViewState["MyTasks"] != null)
            {
                DataTable dt = (DataTable)ViewState["MyTasks"];
                if (dt.Rows.Count > 0)
                {
                    if (dt.Columns.Contains("Staffid") && dt.Columns.Contains("DelegatedOn") && dt.Columns.Contains("DelegateSTask") && dt.Columns.Contains("Task") && dt.Columns.Contains("Taskid") && dt.Columns.Contains("customerrsn") && dt.Columns.Contains("Tracker") && dt.Columns.Contains("Priority"))
                    {
                        //dt.Columns.Remove("Staffid");
                        dt.Columns["Staffid"].ColumnName = "AssignedTo";
                        dt.Columns["CustomerStatus"].ColumnName = "LeadStatus";
                        dt.Columns["Comments"].ColumnName = "Most recent work progress";
                        dt.Columns["Status"].ColumnName = "TaskStatus";
                        dt.Columns["Tracker"].ColumnName = "Ct.";
                        dt.Columns["Followupdate"].ColumnName = "Fwup?";
                        dt.Columns["PriorityDesc"].ColumnName = "PriorityDesc";
                        dt.Columns["AssignedBy"].ColumnName = "AsgndBy";
                        dt.Columns["DelegateBy"].ColumnName = "DlgtBy";

                        //dt.Columns.Remove("Reference");
                        dt.Columns.Remove("TaskID");
                        dt.Columns.Remove("CustomerRSN");
                        //dt.Columns.Remove("Tracker");
                        dt.Columns.Remove("Priority");
                        dt.Columns.Remove("Task");
                        dt.Columns.Remove("TaskType");
                        dt.Columns.Remove("DelegatedOn");
                        dt.Columns.Remove("DelegateSTask");
                        dt.AcceptChanges();
                    }
                    dt.DefaultView.Sort = "Name asc";
                    GridView gv = new GridView();
                    gv.DataSource = dt;
                    gv.DataBind();
                    GridView[] gvlist = new GridView[] { gv };
                    Export("ManageTask_AtTaskDetailLevel.xls", gvlist);
                }
                else
                {
                    WebMsgBox.Show("There are no records to Export");
                }
            }
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }
    public void Export(string fileName, GridView[] gvs)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        HttpContext.Current.Response.ContentType = "application/ms-excel";

        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);

        foreach (GridView gv in gvs)
        {
            //   Create a form to contain the grid
            Table table = new Table();
            table.GridLines = gv.GridLines;
            //   add the header row to the table
            if (!(gv.HeaderRow == null))
            {
                PrepareControlForExport(gv.HeaderRow);
                table.Rows.Add(gv.HeaderRow);
            }
            foreach (GridViewRow row in gv.Rows)
            {
                PrepareControlForExport(row);
                table.Rows.Add(row);
            }
            //   add the footer row to the table
            if (!(gv.FooterRow == null))
            {
                PrepareControlForExport(gv.FooterRow);
                table.Rows.Add(gv.FooterRow);
            }
            //   render the table into the htmlwriter
            table.RenderControl(htw);
        }
        //   render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString());
        HttpContext.Current.Response.End();
    }
    private static void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {
            Control current = control.Controls[i];
            if (current is LinkButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
            }
            else if (current is ImageButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
            }
            else if (current is HyperLink)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
            }
            else if (current is DropDownList)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
            }
            else if (current is CheckBox)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
            }


            if (current.HasControls())
            {
                PrepareControlForExport(current);
            }
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Session["TaskType"] = "FromDirect";
        //Button2.Attributes.Add("onclick", "javascript:return NavigateNewTask('" + wsgetLatestbtn.ClientID + "');");
        //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "NavigateNewTask('"+wsgetLatestbtn.ClientID+"'');", true);
    }
    protected void btnnewenquiry_Click(object sender, EventArgs e)
    {
        Session["TaskType"] = "FromDirect";
    }
    protected void LoadTaskDetDir1(string StaffID)
    {
        RdGrd_TaskDetDir1.DataSource = null;
        RdGrd_TaskDetDir1.DataBind();
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsTargetDet = null;
        dsTargetDet = sqlobj.SQLExecuteDataset("SP_FetchTaskDetDir3",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = ddlTaskList1.SelectedValue },
            new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NVarChar, Value = StaffID },
            new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpTaskDate1.SelectedDate },
            new SqlParameter() { ParameterName = "@FilterReference", SqlDbType = SqlDbType.NVarChar, Value = ddlMyTasksReference.SelectedValue == "All" ? null : ddlMyTasksReference.SelectedValue }
            );
        if (dsTargetDet.Tables[0].Rows.Count > 0)
        {
            dtTemp.Dispose();
            RdGrd_TaskDetDir1.DataSource = dsTargetDet.Tables[0];
            int TypeRCount = dsTargetDet.Tables[0].Rows.Count;
            lblmytaskscount.Text = "  Count:" + TypeRCount;
            RdGrd_TaskDetDir1.DataBind();
            ViewState["MyTasks"] = dsTargetDet.Tables[0];
            dsTargetDet.Dispose();
        }
        else
        {
            RdGrd_TaskDetDir1.DataSource = null;
            RdGrd_TaskDetDir1.DataBind();
            //RdGrd_TaskDetDir1.Visible = false;
            lblmytaskscount.Text = "  Count:0";
            ViewState["MyTasks"] = null;
        }
        RdGrd_TaskDetDir1.Visible = true;
    }
    protected void RdGrd_ProjectSel_ItemDataBound1(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {
            Telerik.Web.UI.GridDataItem item = e.Item as Telerik.Web.UI.GridDataItem;
            GridDataItem griditem = e.Item as GridDataItem;
            if (item != null)
            {
                CheckBox chkTest = (CheckBox)griditem.FindControl("chkJSel");
                string strRef = item["Reference"].Text.ToString();
                if (strRef == "#Aptmnt")
                {
                    //item.BackColor = Color.LightGray;
                    item.Cells[7].ForeColor = Color.Blue;
                    chkTest.Enabled = false;
                    chkTest.ToolTip = "Appointments can not able to edit";
                }               
                if (!item.Cells[10].Text.Equals("&nbsp;"))
                {
                    if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("04"))
                    {
                        item.Cells[9].ForeColor = Color.Red;
                        item.Cells[10].ForeColor = Color.Red;
                        item.Cells[9].Font.Bold = true;
                        item.Cells[10].Font.Bold = true;
                    }
                    else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("03"))
                    {
                        item.Cells[9].ForeColor = Color.Red;
                        item.Cells[10].ForeColor = Color.Red;
                        item.Cells[9].Font.Bold = true;
                        item.Cells[10].Font.Bold = true;
                    }
                    else if (!item.Cells[8].Text.Equals("&nbsp;") && item.Cells[8].Text.Equals("02"))
                    {
                        item.Cells[9].ForeColor = Color.Brown;
                        item.Cells[10].ForeColor = Color.Brown;
                    }
                }

                if (item.Cells[14].Text.Equals("Hot") || item.Cells[14].Text.Equals("Very Hot"))
                {
                    item.Cells[14].ForeColor = Color.Red;
                }
                string GetDate = item.Cells[6].Text;
                string CurrDate = DateTime.Now.ToString("dd/MM/yyyy");

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void RdGrd_TaskDetDir1_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "CustomerName")
            {
                int iCustomerRSN = Convert.ToInt32(e.CommandArgument);
                LoadCustomerProfile(iCustomerRSN);
            }
            else if (e.CommandName == "Activities")
            {
                string strProspectRSN = Convert.ToString(e.CommandArgument);
                LinkButton lnktaskid = (LinkButton)e.Item.FindControl("lnktaskid");
                string strtaskid = lnktaskid.Text;
                Int64 istaffid = Convert.ToInt64(strProspectRSN);
                Session["ProspectRSN"] = istaffid.ToString();
                Session["DiaryFrom"] = "FromMyTasks";
                LoadProspectDiary(strProspectRSN, strtaskid.ToString());
                rwDiary.Visible = true;
            }

            else if (e.CommandName == "Pink")
            {
                int iTaskID = Convert.ToInt32(e.CommandArgument);
                DataSet dscheck = sqlobj.SQLExecuteDataset("sp_GetTaskdetail",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = iTaskID.ToString() });

                if (dscheck.Tables[0].Rows.Count > 0)
                {
                    string strstaffid = dscheck.Tables[0].Rows[0]["StaffID"].ToString();
                    string assignedby = dscheck.Tables[0].Rows[0]["AssignedBy"].ToString();
                    string strcustomer = dscheck.Tables[0].Rows[0]["Name"].ToString();
                    string stractivity = dscheck.Tables[0].Rows[0]["ActivityAssigned"].ToString();
                    string strreference = dscheck.Tables[0].Rows[0]["AssigneeCommnts"].ToString();
                    string strtargetdate = dscheck.Tables[0].Rows[0]["TargetDate"].ToString();

                    sqlobj.ExecuteSQLNonQuery("sp_insertping",
                                      new SqlParameter() { ParameterName = "@fromid", SqlDbType = SqlDbType.NVarChar, Value = assignedby.ToString() },
                                      new SqlParameter() { ParameterName = "@toid", SqlDbType = SqlDbType.NVarChar, Value = strstaffid.ToString() },
                                      new SqlParameter() { ParameterName = "@name", SqlDbType = SqlDbType.NVarChar, Value = strcustomer.ToString() },
                                      new SqlParameter() { ParameterName = "@reference", SqlDbType = SqlDbType.NVarChar, Value = strreference.ToString() },
                                      new SqlParameter() { ParameterName = "@activity", SqlDbType = SqlDbType.NVarChar, Value = stractivity.ToString() },
                                      new SqlParameter() { ParameterName = "@targetdate", SqlDbType = SqlDbType.DateTime, Value = strtargetdate.ToString() },
                                       new SqlParameter() { ParameterName = "@Createdby", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                      );
                    RadWindowManager1.Title = "Ping for Status request and Content";
                    RadWindowManager1.RadAlert("Progress update request mailed to " + strstaffid, null, null, null, null, null);
                }
            }
            else if (e.CommandName.ToString() == "StaffUpdate")
            {
                GridDataItem griditem = e.Item as GridDataItem;
                string strRef = griditem["Reference"].Text.ToString();
                if(strRef == "#Aptmnt")
                {
                   // Response.Redirect("~/Calendar.aspx");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Calendar", "NavigateCalendar();", true);
                }
                else
                {
                    string args = e.CommandArgument.ToString();
                    string[] spargs = args.Split(';');
                    Session["TaskID"] = spargs[0].ToString();
                    //Session["TaskID"] = e.CommandArgument.ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2('" + spargs[1].ToString() + "');", true);
                }               
            }
            else
            {
                string StaffID = QSUserName;
                LoadTaskDetDir1(StaffID);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadProspectDiary(string prospectrsn, string taskid)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectDiary = new DataSet();
        dsProspectDiary = sqlobj.SQLExecuteDataset("SP_GetTaskIDProspectDiary",
            new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = prospectrsn.ToString() },
             new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = taskid.ToString() }
            );

        if (dsProspectDiary.Tables[0].Rows.Count > 0)
        {
            lbldiaryheadName.Text = dsProspectDiary.Tables[0].Rows[0]["name"].ToString();
            lbldiarycount.Visible = false;

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

    private void LoadCustomerProfile(int customerrsn)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();
            DataSet dsInprogress = new DataSet();

            dsCCustStatus = sqlobj.SQLExecuteDataset("SP_GetProspectDetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn.ToString() });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblscptitle.Text = dsCCustStatus.Tables[0].Rows[0]["Title"].ToString();
                lblscpname.Text = dsCCustStatus.Tables[0].Rows[0]["Name"].ToString();
                lblscpcompanyname.Text = dsCCustStatus.Tables[0].Rows[0]["CompanyName"].ToString();
                lblscpdoorno.Text = dsCCustStatus.Tables[0].Rows[0]["DoorNo"].ToString();
                lblscpcity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
                lblscppinzip.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();
                lblscpstate.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
                lblscpcountry.Text = dsCCustStatus.Tables[0].Rows[0]["Country"].ToString();
                lblscpphone.Text = dsCCustStatus.Tables[0].Rows[0]["Phone"].ToString();
                lblscpmobile.Text = dsCCustStatus.Tables[0].Rows[0]["Mobile"].ToString();
                lblscpemail.Text = dsCCustStatus.Tables[0].Rows[0]["Email"].ToString();
                lblscpemail2.Text = dsCCustStatus.Tables[0].Rows[0]["Email2"].ToString();
                lblscpcategory.Text = dsCCustStatus.Tables[0].Rows[0]["VIP_Imp"].ToString();
                lblscptype.Text = dsCCustStatus.Tables[0].Rows[0]["Types"].ToString();

                dsInprogress = sqlobj.SQLExecuteDataset("proc_GetCustomerInProgActivity",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(customerrsn.ToString()) });

                if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities inprogress now : " + Convert.ToInt32(dsInprogress.Tables[0].Rows[0][0].ToString());
                }
                else if (dsInprogress.Tables[0].Rows.Count > 0)
                {
                    lblcpinprogress.Text = "No.of activities inprogress now : " + 0;
                }

                DataSet dsContacts = sqlobj.SQLExecuteDataset("Sp_Loadprcontacts",
                new SqlParameter() { ParameterName = "@prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn.ToString() });

                if (dsContacts.Tables[0].Rows.Count > 0)
                {
                    gvrwcontacts.DataSource = dsContacts;
                    gvrwcontacts.DataBind();
                }
                else
                {
                    gvrwcontacts.DataSource = null;
                    gvrwcontacts.DataBind();
                }

                dsContacts.Dispose();
                rwCustomerProfile.Visible = true;
            }

            dsCCustStatus.Dispose();


            DataSet dsServices = sqlobj.SQLExecuteDataset("SP_LoadServices",
          new SqlParameter() { ParameterName = "@Prospect_RSN", SqlDbType = SqlDbType.BigInt, Value = customerrsn.ToString() });

            if (dsServices.Tables[0].Rows.Count > 0)
            {
                gvrwservices.DataSource = dsServices;
                gvrwservices.DataBind();
            }
            else
            {
                gvrwservices.DataSource = null;
                gvrwservices.DataBind();
            }

            dsServices.Dispose();

            rwCustomerProfile.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void ToggleSelectedState(object sender, EventArgs e)
    {
        CheckBox headerCheckBox = (sender as CheckBox);
        foreach (GridDataItem dataItem in RdGrd_TaskDetDir1.MasterTableView.Items)
        {
            string strRef = dataItem["Reference"].Text.ToString();
            if(strRef != "#Aptmnt")
            {
                 (dataItem.FindControl("chkJSel") as CheckBox).Checked = headerCheckBox.Checked;
                dataItem.Selected = headerCheckBox.Checked;
            }           
        }
    }
    protected void OnDiaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvDiary.PageIndex = e.NewPageIndex;
        LoadProspectDiary(Session["ProspectRSN"].ToString());
        rwDiary.Visible = true;
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
    protected void btnDiaryClose_Click(object sender, EventArgs e)
    {
        rwDiary.Visible = false;
    }
    protected void btnCPClose_Click(object sender, EventArgs e)
    {
        rwCustomerProfile.Visible = false;
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

    protected void btnMainbulkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            ViewState["Bulk"] = null;
            int CNT = 0;
            foreach (GridDataItem itm in RdGrd_TaskDetDir1.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnktaskid");
                    CNT++;
                    string STaskID = lb.Text;
                    ViewState["Bulk"] = ViewState["Bulk"] + STaskID + ",";
                }
            }
            if (CNT > 1)
            {
                ViewState["Bulk"] = ViewState["Bulk"].ToString().Remove(ViewState["Bulk"].ToString().Length - 1);
                Label21.Text = ViewState["Bulk"].ToString();
                LoadStatus();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsg();", true);
                //if (CnfResult.Value == "true")
                //{
                //    rwBulkUpdate.Visible = true;
                //}

            }
            else
            {
                //WebMsgBox.Show("Select one or more tasks first.");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsg1();", true);
            }

        }
        catch (Exception qr)
        {
            throw qr;
        }

    }
    protected void LoadStatus()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsStaus = new DataSet();
        dsStaus = sqlobj.SQLExecuteDataset("SP_FetchDropDown",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 });
        ddlbulkstatus.DataSource = dsStaus.Tables[0];
        ddlbulkstatus.DataValueField = "StatusCode";
        ddlbulkstatus.DataTextField = "StatusName";
        ddlbulkstatus.DataBind();
        dsStaus.Dispose();
    }
    protected void btnbulksubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        try
        {
            if (ViewState["Bulk"] != null)
            {
                string strtaskid = ViewState["Bulk"].ToString();
                string[] taskid = strtaskid.Split(',');
                int len = Convert.ToInt16(taskid.Length);
                int ucount = 0;
                foreach (string id in taskid)
                {
                    //string test = id;
                    //int cmd = sqlobj.ExecuteSQLNonQuery("proc_BulkUpdate",
                    //     new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.NVarChar, Value = id },
                    //     new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = txtbulktext.Text },
                    //     new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = HDLoginUser.Value },
                    //     new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlbulkstatus.SelectedValue }
                    //     );                  

                    SqlCommand cmd = new SqlCommand("proc_BulkUpdate", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TaskID", id);
                    cmd.Parameters.AddWithValue("@TrkComments", txtbulktext.Text);
                    cmd.Parameters.AddWithValue("@UserID", HDLoginUser.Value);
                    cmd.Parameters.AddWithValue("@Status", ddlbulkstatus.SelectedValue);
                    cmd.Parameters.Add("@Count", SqlDbType.Int);
                    cmd.Parameters["@Count"].Direction = ParameterDirection.Output;
                    if (con.State == ConnectionState.Closed )
                    {
                        con.Open();
                    }
                    //con.Open();
                    cmd.ExecuteNonQuery();
                    int count = Convert.ToInt16(cmd.Parameters["@Count"].Value.ToString());
                    if (count != 0)
                    {
                        ucount += 1;
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "confirmbulk('" + len.ToString() + "','"+ucount+"');", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "ConfirmClick();", true);
                txtbulktext.Text = string.Empty;
            }
            rwBulkUpdate.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
        finally
        {
            con.Close();
        }
    }
    protected void btnbulkclose_Click(object sender, EventArgs e)
    {
        rwBulkUpdate.Visible = false;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "ConfirmClick();", true);
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        rwBulkUpdate.Visible = true;
    }
    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true;
    }
    protected void btnNewActivity_Click(object sender, EventArgs e)
    {

    }
    protected void lnkmytasks_Click(object sender, EventArgs e)
    {

    }
    protected void lnkbyme_Click(object sender, EventArgs e)
    {
        Response.Redirect("ByMe.aspx");
    }
}