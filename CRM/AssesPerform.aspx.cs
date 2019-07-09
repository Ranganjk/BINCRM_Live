using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using AjaxControlToolkit;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Drawing;
using System.Web.Security;
using PMS;
using Telerik.Web.UI;
using System.Web.Script.Serialization;
using System.Web.Services;

public partial class AssesPerform : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(@"Data Source=111.118.188.128\SQLEXPRESS;Initial Catalog=ISTASKS_NEW;Persist Security Info=True;User ID=is;Password=!nn0v@tU$");
    protected static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
    SqlCommand cmd = new SqlCommand();
    DataSet dsUserDet = new DataSet();
    DataSet dsFilter = new DataSet();
    int level = 0;
    HiddenField hiddenrsn = new HiddenField();
    static String StaffID;
    static string URSN;
    static string UserLevel;
    static string Reporting;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Asses Perform", DateTime.Now);
            
            Session["Dataset"] = null;
            DataTable dtStaff = new DataTable();
            dtStaff.Columns.Add("StaffName", typeof(string));
            //dsUserDet = null;
            dsUserDet.Clear();
            dsFilter.Clear();
            GetGridData();
            StaffID = Session["UserID"].ToString();          
               
            Clear();

            dtStaff.Rows.Add(StaffID);
            dtStaff.AcceptChanges();
            //ddlStaffName.DataSource = dtStaff;
            //ddlStaffName.DataValueField = "StaffName";   dropdown for staff name
            //ddlStaffName.DataTextField = "StaffName";
            //ddlStaffName.DataBind();

            LblStaffName.Text = StaffID.ToString();

            hiddenrsn.Value = "";           
            dvTest.Visible = false;
            dvAdd.Visible = false;
            dvEdit.Visible = false;
            dvpreview.Visible = false;
            dvUnSubmitted.Visible = false;
            dvMenu.Visible = false;

            GetReporting();

            btnSubmit.Attributes.Add("click", "return chkconfirm();");
            Button1.Attributes.Add("click", "return validate();");
            btnTestSubmit.Attributes.Add("click", "return submitconfirm();");
        }
        
    }    
    private void GetReporting()
    {
        SqlCommand sqlRep = new SqlCommand("GetReportingHead", con);
        sqlRep.CommandType = CommandType.StoredProcedure;
        sqlRep.Parameters.AddWithValue("@staffid", StaffID);
        
        if (con.State.Equals(ConnectionState.Open))
        {
           con.Close();
        }
        con.Open();
        SqlDataReader dr = sqlRep.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                hbtnReporting.Value = dr["ReportingHead"].ToString();
            }
        }
        dr.Close();
        con.Close();
    }
    private void CheckYear(string Staffid)
    {
        try
        {
            SqlCommand getdate = new SqlCommand("proc_GetAssesMonth", con);
            getdate.CommandType = CommandType.StoredProcedure;
            getdate.Parameters.AddWithValue("@Staffid", Staffid);        
            con.Open();           
            int Serverdate = Convert.ToInt16(getdate.ExecuteScalar());
            //con.Close();
            SqlCommand GetDateTime = new SqlCommand("GetServerDateTime", con);
            DateTime date = Convert.ToDateTime(GetDateTime.ExecuteScalar());
            if (Serverdate != 0)
            {
                DateTime dt = Convert.ToDateTime(date);
                string curYear = dt.Year.ToString().Substring(2, 2).ToString();
                string CurMon = dt.Month.ToString();
                string curmon = Convert.ToInt64(curYear)+ "" + Convert.ToInt64(CurMon);
                DataTable dt1 = new DataTable();
                dt1.Columns.AddRange(new DataColumn[1] { new DataColumn("Year", typeof(int)) });
                string chk = Serverdate.ToString().Substring(2,2);
                if(chk == "12")
                {
                    int newyear =Convert.ToInt16(Serverdate.ToString().Substring(0, 2));
                    newyear += 1;
                    dt1.Rows.Add(newyear+"01".ToString());
                    lblMonth.Text = newyear + "01".ToString();
                }
                else
                {
                    Serverdate += 1;
                    if (Serverdate < Convert.ToInt64(curmon))
                    {
                        WebMsgBox.Show("Last month appraisal was not submitted");
                    }
                    dt1.Rows.Add(Serverdate);
                    lblMonth.Text = Serverdate.ToString();
                }
                GetMonthYear(lblMonth.Text.ToString());
            }
            else
            {            
               
                DateTime dt = Convert.ToDateTime(date);
                string curYear = dt.Year.ToString().Substring(2, 2).ToString();
                string CurMon = dt.Month.ToString();
                if(CurMon.Length == 1)
                {
                    CurMon = "0" + CurMon;
                }
                if (!curYear.Contains("14"))
                {
                    DataTable dt1 = new DataTable();
                    dt1.Columns.AddRange(new DataColumn[1] { new DataColumn("Year", typeof(int)) });
                    dt1.Rows.Add(curYear + CurMon);                   
                    lblMonth.Text = (curYear + CurMon).ToString();
                }
            }            
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }    

    public void GetMonthYear(string data)
    {
        try
        {
            int Month =Convert.ToInt16(data.Substring(2, 2));
            int Year = Convert.ToInt16(data.Substring(0, 2));
            switch(Month)
            {
                case 01:
                    lblMonthYear.Text = "(Jan" + " - 20" + Year + ")";
                    break;
                case 02:
                    lblMonthYear.Text = "(Feb" + " - 20" + Year + ")";
                    break;
                case 03:
                    lblMonthYear.Text = "(Mar" + " - 20" + Year + ")";
                    break;
                case 04:
                    lblMonthYear.Text = "(Apr" + " - 20" + Year + ")";
                    break;
                case 05:
                    lblMonthYear.Text = "(May" + " - 20" + Year + ")";
                    break;
                case 06:
                    lblMonthYear.Text = "(Jun" + " - 20" + Year + ")";
                    break;
                case 07:
                    lblMonthYear.Text = "(Jul" + " - 20" + Year + ")";
                    break;
                case 08:
                    lblMonthYear.Text = "(Aug" + " - 20" + Year + ")";
                    break;
                case 09:
                    lblMonthYear.Text = "(Sep" + " - 20" + Year + ")";
                    break;
                case 10:
                    lblMonthYear.Text = "(Oct" + " - 20" + Year + ")";
                    break;
                case 11:
                    lblMonthYear.Text = "(Nov" + " - 20" + Year + ")";
                    break;
                case 12:
                    lblMonthYear.Text = "(Dec" + " - 20" + Year + ")";
                    break;

                default:
                    break;
            }
        }
        catch (Exception ex)
        {          
        }
    }

    public string GetMonthYearfromgrid(string data)
    {
        string value = "";
        try
        {
            int Month = Convert.ToInt16(data.Substring(2, 2));
            int Year = Convert.ToInt16(data.Substring(0, 2));           
            switch (Month)
            {
                case 01:
                    value = "Jan" + " - 20" + Year;
                    break;
                case 02:
                    value = "Feb" + " - 20" + Year;
                    break;
                case 03:
                    value = "Mar" + " - 20" + Year;
                    break;
                case 04:
                    value = "Apr" + " - 20" + Year;
                    break;
                case 05:
                    value = "May" + " - 20" + Year;
                    break;
                case 06:
                    value = "Jun" + " - 20" + Year;
                    break;
                case 07:
                    value = "Jul" + " - 20" + Year;
                    break;
                case 08:
                    value = "Aug" + " - 20" + Year;
                    break;
                case 09:
                    value = "Sep" + " - 20" + Year;
                    break;
                case 10:
                    value = "Oct" + " - 20" + Year;
                    break;
                case 11:
                    value = "Nov" + " - 20" + Year;
                    break;
                case 12:
                    value = "Dec" + " - 20" + Year;
                    break;

                default:
                    break;
            }
            return value;
        }
        catch (Exception ex)
        {
            return value;
        }
    }

    public void GetStaff(string staffName)
    {
        SqlCommand cmd1 = new SqlCommand();
        DataSet dsStaff = new DataSet();
        cmd1.CommandText = "proc_GetStaff";
        cmd1.Connection = con;
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@staffname", staffName);
        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
        dap.Fill(dsStaff, "tblstaff");     

        LblStaffName.Text = dsStaff.Tables["tblstaff"].ToString();
    }

    public void GetGridData()
    {
        try
        {
            //dsUserDet = null;
            cmd.CommandText = "proc_GetAssesPerform";
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@staffName", Session["UserID"].ToString());
            cmd.Parameters.Add("@userlevel", SqlDbType.Int);

            cmd.Parameters["@userlevel"].Direction = ParameterDirection.Output;
            //dsUserDet = sqlobj.SQLExecuteDataset("proc_GetAssesPerform",
            //    new SqlParameter() { ParameterName = "@staffName", SqlDbType = SqlDbType.NVarChar, Value = "prakashm" });         
           SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dsUserDet = new DataSet();
            //dsUserDet = null;
            dap.Fill(dsUserDet, "tblperfmon");
            Session["Dataset"] = (DataSet)dsUserDet;
            level = Convert.ToInt16(cmd.Parameters["@userlevel"].Value);
            UserLevel = level.ToString();
            if(!(level == 1 || level == 2))
            {
                lblunStaff.Visible = false;
                radstaff.Visible = false;
                btnUnSearch.Visible = false;               
            }           
            //lbtnsubappraisal.Visible = true;
            lbtnunsubmit.Visible = true;
            if (dsUserDet.Tables[0].Rows.Count > 0)
            {
                gvAssesPerform.ShowHeader = true;
                gvAssesPerform.DataSource = dsUserDet.Tables[0];
                gvAssesPerform.DataBind();
            }
            else
            {
                dsUserDet.Tables[0].Rows.Add(dsUserDet.Tables[0].NewRow());
                gvAssesPerform.DataSource = dsUserDet;
                gvAssesPerform.DataBind();
                int columncount = gvAssesPerform.Rows[0].Cells.Count;
                gvAssesPerform.Rows[0].Cells.Clear();
                gvAssesPerform.Rows[0].Cells.Add(new TableCell());
                gvAssesPerform.Rows[0].Cells[0].ColumnSpan = columncount;
                gvAssesPerform.Rows[0].Cells[0].Text = "No Appraisal Found";
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "AlertMsg();", true);
            return;
        }
    }

    public void BindDetailsView(string RSN)
    {
        DataSet dsDetailsView = new DataSet();
        dsDetailsView = null;
        try
        {
            string strQuery = "RSN = '" + RSN + "'";
            dsUserDet = (DataSet)Session["Dataset"];
            DataRow[] dsUserDetRows = dsUserDet.Tables["tblperfmon"].Select(strQuery);
            dsDetailsView = dsUserDet.Clone();
            foreach (DataRow dr in dsUserDetRows) dsDetailsView.Tables["tblperfmon"].ImportRow(dr);       
            DetailsView1.DataSource = dsDetailsView;
            DetailsView1.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    //converting columns to rows
    public void FilterByRSN(string RSN, bool rotate,DataSet ds)
    {
        try
        {
            string strQuery = "RSN = '" + RSN + "'";
            dsUserDet = (DataSet)Session["Dataset"];
            DataRow[] drFilterRows = dsUserDet.Tables["tblperfmon"].Select(strQuery);
            dsFilter = dsUserDet.Clone();
            foreach (DataRow dr in drFilterRows) dsFilter.Tables["tblperfmon"].ImportRow(dr);
            if (drFilterRows.Length > 0)
            {
                dsFilter.AcceptChanges();
                DataTable dt2 = new DataTable();
                if (!(level == 1))
                {
                    if (dsFilter.Tables["tblperfmon"].Rows[0]["FLAG"].ToString() == "N")
                    {
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Attendance_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Attitude_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("CustomerCentric_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("MeetingDeadlines_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Communication_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Qualityofwork_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Learning_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Participation_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("Average_A");
                        dsFilter.Tables["tblperfmon"].Columns.Remove("AdminRemarks_A");
                    }
                }               
               
                dsFilter.Tables["tblperfmon"].Columns.Remove("RSN");
                dsFilter.Tables["tblperfmon"].Columns.Remove("StaffName");
                dsFilter.Tables["tblperfmon"].Columns.Remove("Flag");
                for (int i = 0; i <= dsFilter.Tables["tblperfmon"].Rows.Count; i++)
                {
                    dt2.Columns.Add();
                }
                for (int i = 0; i < dsFilter.Tables["tblperfmon"].Columns.Count; i++)
                {
                    dt2.Rows.Add();
                    dt2.Rows[i][0] = dsFilter.Tables["tblperfmon"].Columns[i].ColumnName;
                }
                for (int i = 0; i < dsFilter.Tables["tblperfmon"].Columns.Count; i++)
                {
                    for (int j = 0; j < dsFilter.Tables["tblperfmon"].Rows.Count; j++)
                    {
                        dt2.Rows[i][j + 1] = dsFilter.Tables["tblperfmon"].Rows[j][i];
                    }
                }
                gvAssesView.ShowHeader = !rotate;
                gvAssesView.DataSource = dt2;
                gvAssesView.DataBind();

                if (rotate)
                {
                    foreach (GridViewRow row in gvAssesView.Rows)
                    {
                        row.Cells[0].CssClass = "header";
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void gvAssesPerform_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAssesPerform.PageIndex = e.NewPageIndex;
        GetGridData();
    }

    protected void gvAssesPerform_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string RSN = "";
        try
        {
            if (e.CommandName.Equals("View"))
            {
                RSN = e.CommandArgument.ToString();
                dvContent.Visible = false;
                dvMenu.Visible = false;
                dvTest.Visible = true;
                FilterByRSN(RSN, true, (DataSet)Session["Dataset"]);
            }
            else if (e.CommandName.Equals("SEdit"))
            {
                dvTest.Visible = false;
                dvAdd.Visible = false;
                dvContent.Visible = false;
                dvMenu.Visible = false;
                dvEdit.Visible = true;
                BindDetailsView(e.CommandArgument.ToString());
                ViewState["RSN"] = e.CommandArgument.ToString();
            }
            else if (e.CommandName.Equals("AddNew"))
            {
                dvTest.Visible = false;
                dvContent.Visible = false;
                dvMenu.Visible = false;
                dvAdd.Visible = true;
                btnSubmit.Text = "Save";
                Clear();
            }
            else if(e.CommandName.Equals("UpdateS"))
            {
                dvContent.Visible = false;
                dvTest.Visible = false;
                dvMenu.Visible = false;
                btnSubmit.Text = "Save";
                Button1.Visible = true;
                SqlCommand sqlucmd = new SqlCommand();
                DataSet dsUpdate = new DataSet();
                SqlDataAdapter adpUpdate = new SqlDataAdapter();
                sqlucmd.Connection = con;
                sqlucmd.CommandText = "proc_selectAssesPerformance";
                sqlucmd.CommandType = CommandType.StoredProcedure;
                sqlucmd.Parameters.AddWithValue("@RSN",e.CommandArgument.ToString());
                URSN = e.CommandArgument.ToString();
                adpUpdate = new SqlDataAdapter(sqlucmd);
                adpUpdate.Fill(dsUpdate, "tblperfmon");
                if (dsUpdate.Tables["tblperfmon"].Rows.Count > 0)
                {
                    LblStaffName.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["StaffName"].ToString();
                    LblStaffName.Enabled = false;
                    //LblStaffName.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["StaffName"].ToString();                    
                    lblMonth.Text = dsUpdate.Tables["tblperfmon"].Rows[0][2].ToString();
                    txtMonth.Enabled = false;
                    ddlAttendance.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["Attendance"].ToString();
                    ddlAttitude.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["Attitude"].ToString();                
                                     
                    //ddlcustomercentric.DataSource = dsUpdate.Tables["tblperfmon"];
                    ddlcustomercentric.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["CustomerCentric"].ToString();
                    //ddlcustomercentric.DataBind();

                    ddlMeeting.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["MeetingDeadlines"].ToString();
                    ddlCommunication.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["Communication"].ToString();
                    ddlQuality.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["QualityofWork"].ToString();

                    ddlLearning.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["Learning"].ToString();
                    ddlparticipation.SelectedText = dsUpdate.Tables["tblperfmon"].Rows[0]["Participation"].ToString();                                    
                                      
                    txtStaffSugg.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["StaffSuggestion"].ToString();
                    txtStaffRemarks.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["StaffRemarks"].ToString();
                    txtGoodWorkDone.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["GoodWorkDone"].ToString();

                    txtGoodbyAnother.Text = dsUpdate.Tables["tblperfmon"].Rows[0]["GoodWorkDonebyAnother"].ToString();
                    dvAdd.Visible = true;
                    btnSubmit.CommandArgument = "Save";
                    GetMonthYear(lblMonth.Text.ToString());
                    CalculateAvg();
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Error');", true);
        }
    }
    public double CalculateAvg()
    {
        double total = Convert.ToDouble(ddlAttendance.SelectedText) + Convert.ToDouble(ddlAttitude.SelectedText) + Convert.ToDouble(ddlcustomercentric.SelectedText) + Convert.ToDouble(ddlMeeting.SelectedText) + Convert.ToDouble(ddlCommunication.SelectedText) + Convert.ToDouble(ddlQuality.SelectedText) + Convert.ToDouble(ddlLearning.SelectedText) + Convert.ToDouble(ddlparticipation.SelectedText);
        double average = total / 8;
        return average;
    }
    [WebMethod]
    public static string Average()
    {
        string avg="";
        return new JavaScriptSerializer().Serialize(avg);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlCommand sqlcmd = new SqlCommand();
        try
        {
            if (btnSubmit.CommandArgument == "Add")
            {
                sqlcmd.Connection = con;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "proc_UserInsertAssesPerformance";
                if (con.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
                double total = Convert.ToDouble(ddlAttendance.SelectedText) + Convert.ToDouble(ddlAttitude.SelectedText) + Convert.ToDouble(ddlcustomercentric.SelectedText) + Convert.ToDouble(ddlMeeting.SelectedText) + Convert.ToDouble(ddlCommunication.SelectedText) + Convert.ToDouble(ddlQuality.SelectedText) + Convert.ToDouble(ddlLearning.SelectedText) + Convert.ToDouble(ddlparticipation.SelectedText);
                double average = Math.Round(total / 8);
                con.Open();
                sqlcmd.Parameters.AddWithValue("@StaffName", LblStaffName.Text.ToString());
                //sqlcmd.Parameters.AddWithValue("@StaffName",LblStaffName.Text);
                sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
                sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendance.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitude.SelectedText);
                sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlcustomercentric.SelectedText);
                sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeeting.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunication.SelectedText);
                sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQuality.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Learning", ddlLearning.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Participation", ddlparticipation.SelectedText);
                sqlcmd.Parameters.AddWithValue("@staffSuggestion", txtStaffSugg.Text);
                sqlcmd.Parameters.AddWithValue("@StaffRemarks", txtStaffRemarks.Text);
                sqlcmd.Parameters.AddWithValue("@GoodWorkDone", txtGoodWorkDone.Text);
                sqlcmd.Parameters.AddWithValue("@GoodWorkDoneByAnother", txtGoodbyAnother.Text);
                sqlcmd.Parameters.AddWithValue("@Average", average);
                sqlcmd.Parameters.AddWithValue("@Staffid", LblStaffName.Text.ToString());
                //sqlcmd.Parameters.AddWithValue("@Staffid",LblStaffName.Text);
                sqlcmd.Parameters.AddWithValue("@StaffDateStamp", System.DateTime.Now);
                sqlcmd.Parameters.AddWithValue("@flag", "C");
                sqlcmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('The apprisal details have been saved.');", true);
                Clear();
                GetGridData();
                dvAdd.Visible = false;
                dvContent.Visible = true;
            }
            else if (btnSubmit.CommandArgument == "Save")
            {
                sqlcmd.Connection = con;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.CommandText = "proc_UpdatetoHeadFlag";
                if (con.Equals(ConnectionState.Open))
                {
                    con.Close();
                }

                double total = Convert.ToDouble(ddlAttendance.SelectedText) + Convert.ToDouble(ddlAttitude.SelectedText) + Convert.ToDouble(ddlcustomercentric.SelectedText) + Convert.ToDouble(ddlMeeting.SelectedText) + Convert.ToDouble(ddlCommunication.SelectedText) + Convert.ToDouble(ddlQuality.SelectedText) + Convert.ToDouble(ddlLearning.SelectedText) + Convert.ToDouble(ddlparticipation.SelectedText);
                double average = Math.Round(total / 8);
                con.Open();
                sqlcmd.Parameters.AddWithValue("@RSN", URSN);
                sqlcmd.Parameters.AddWithValue("@StaffName", LblStaffName.Text.ToString());
                //sqlcmd.Parameters.AddWithValue("@StaffName",LblStaffName.Text);
                sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
                sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendance.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitude.SelectedText);
                sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlcustomercentric.SelectedText);
                sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeeting.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunication.SelectedText);
                sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQuality.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Learning", ddlLearning.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Participation", ddlparticipation.SelectedText);
                sqlcmd.Parameters.AddWithValue("@staffSuggestion", txtStaffSugg.Text);
                sqlcmd.Parameters.AddWithValue("@StaffRemarks", txtStaffRemarks.Text);
                sqlcmd.Parameters.AddWithValue("@GoodWorkDone", txtGoodWorkDone.Text);
                sqlcmd.Parameters.AddWithValue("@GoodWorkDoneByAnother", txtGoodbyAnother.Text);
                sqlcmd.Parameters.AddWithValue("@Average", average);
                sqlcmd.Parameters.AddWithValue("@Staffid", LblStaffName.Text.ToString());
                //sqlcmd.Parameters.AddWithValue("@Staffid",LblStaffName.Text);
                sqlcmd.Parameters.AddWithValue("@StaffDateStamp", System.DateTime.Now);
                sqlcmd.Parameters.AddWithValue("@flag", "C");
                sqlcmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('The apprisal details have been saved.');", true);
                Clear();
                GetGridData();
                dvAdd.Visible = false;
                dvContent.Visible = true;
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Error');", true);
        }
        finally
        {
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }
        }
    }
    public void Clear()
    {
        txtGoodbyAnother.Text = "";
        txtGoodWorkDone.Text = "";
        txtStaffRemarks.Text = "";
        txtStaffSugg.Text = "";
        ddlAttendance.ClearSelection();
        ddlAttitude.ClearSelection();
        ddlCommunication.ClearSelection();
        ddlcustomercentric.ClearSelection();
        ddlLearning.ClearSelection();
        ddlMeeting.ClearSelection();
        ddlparticipation.ClearSelection();
        ddlQuality.ClearSelection();
        //ddlMonth.ClearSelection();
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand sqlcmd = new SqlCommand();        
        try
        {
            sqlcmd.Connection = con;
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.CommandText = "proc_UpdatetoHeadFlag";
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }

            double total = Convert.ToDouble(ddlAttendance.SelectedText) + Convert.ToDouble(ddlAttitude.SelectedText) + Convert.ToDouble(ddlcustomercentric.SelectedText) + Convert.ToDouble(ddlMeeting.SelectedText) + Convert.ToDouble(ddlCommunication.SelectedText) + Convert.ToDouble(ddlQuality.SelectedText) + Convert.ToDouble(ddlLearning.SelectedText) + Convert.ToDouble(ddlparticipation.SelectedText);
            double average = Math.Round(total / 8);
            con.Open();
            sqlcmd.Parameters.AddWithValue("@RSN",string.IsNullOrEmpty(URSN) ? "" : URSN);
            sqlcmd.Parameters.AddWithValue("@StaffName", LblStaffName.Text.ToString());
            //sqlcmd.Parameters.AddWithValue("@StaffName",LblStaffName.Text);
            sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
            sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendance.SelectedText);
            sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitude.SelectedText);
            sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlcustomercentric.SelectedText);
            sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeeting.SelectedText);
            sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunication.SelectedText);
            sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQuality.SelectedText);
            sqlcmd.Parameters.AddWithValue("@Learning", ddlLearning.SelectedText);
            sqlcmd.Parameters.AddWithValue("@Participation", ddlparticipation.SelectedText);
            sqlcmd.Parameters.AddWithValue("@staffSuggestion", txtStaffSugg.Text);
            sqlcmd.Parameters.AddWithValue("@StaffRemarks", txtStaffRemarks.Text);
            sqlcmd.Parameters.AddWithValue("@GoodWorkDone", txtGoodWorkDone.Text);
            sqlcmd.Parameters.AddWithValue("@GoodWorkDoneByAnother", txtGoodbyAnother.Text);
            sqlcmd.Parameters.AddWithValue("@Average", average);
            sqlcmd.Parameters.AddWithValue("@Staffid", LblStaffName.Text.ToString());
            //sqlcmd.Parameters.AddWithValue("@Staffid",LblStaffName.Text);
            sqlcmd.Parameters.AddWithValue("@StaffDateStamp", System.DateTime.Now);
            sqlcmd.Parameters.AddWithValue("@flag", "S");
            sqlcmd.ExecuteNonQuery();     
            
            con.Close();

            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('The apprisal has been submitted to your appriser for his/her review.');", true);
            Clear();
            GetGridData();
            dvAdd.Visible = false;
            dvMenu.Visible = false;
            dvContent.Visible = true;
            //ddlMonth.Visible = true;
            lblMonth.Visible = true;
        }
        catch (Exception ex)
        {
           
        }

        //DataTable dtPreview = new DataTable();
        //dtPreview.Columns.Add("StaffName", typeof(string));
        //dtPreview.Columns.Add("ForMonthOf", typeof(string));
        //dtPreview.Columns.Add("Attendance", typeof(string));
        //dtPreview.Columns.Add("Attitude", typeof(string));
        //dtPreview.Columns.Add("CustomerCentric", typeof(string));
        //dtPreview.Columns.Add("MeetingDeadlines", typeof(string));
        //dtPreview.Columns.Add("Communication", typeof(string));
        //dtPreview.Columns.Add("QualityOfWork", typeof(string));
        //dtPreview.Columns.Add("Learning", typeof(string));
        //dtPreview.Columns.Add("Participation", typeof(string));
        //dtPreview.Columns.Add("staffSuggestion", typeof(string));
        //dtPreview.Columns.Add("GoodWorkDone", typeof(string));

        //dtPreview.Rows.Add(ddlStaffName.SelectedText, ddlMonth.SelectedText, ddlAttendance.SelectedText, ddlAttitude.SelectedText, ddlcustomercentric.SelectedText, ddlMeeting.SelectedText, ddlCommunication.SelectedText, ddlQuality.SelectedText, ddlLearning.SelectedText, ddlparticipation.SelectedText, txtStaffSugg.Text, txtGoodWorkDone.Text);

        //gvPreview.DataSource = dtPreview;
        //gvPreview.DataBind();
        //gvPreview.Visible = true;
        //dvpreview.Visible = true;
        //dvAdd.Visible = false;

    }
    protected void gvAssesPerform_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (level == 4 || level == 3 || level==2)
        {
            ((DataControlField)gvAssesPerform.Columns
           .Cast<DataControlField>()
           .Where(fld => fld.HeaderText == "Edit")
           .SingleOrDefault()).Visible = false;
            gvAssesPerform.PageSize = 10;
        }
        
    }    
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        DataSet dsRefresh = new DataSet();
        try
        {
            if (e.CommandName.Equals("DUpdate"))
            {
                DetailsView dv = (DetailsView)sender;
                Label lblRSN = (Label)dv.FindControl("Label24");
                Label lblStaff = (Label)dv.FindControl("Label25");
                Label lblMonth = (Label)dv.FindControl("Label26");

                Button LinkButton1 = (Button)dv.FindControl("LinkButton1");
                LinkButton1.Attributes.Add("click", "javascript:return chkconfirm();");

                RadDropDownList ddlAttendanceA = (RadDropDownList)dv.FindControl("ddlAttendanceA");
                RadDropDownList ddlAttitudeA = (RadDropDownList)dv.FindControl("ddlAttitudeA");
                RadDropDownList ddlCustomerCentricA = (RadDropDownList)dv.FindControl("ddlCustomerCentricA");
                RadDropDownList ddlMeetingDeadlinesA = (RadDropDownList)dv.FindControl("ddlMeetingDeadlinesA");
                RadDropDownList ddlCommunicationA = (RadDropDownList)dv.FindControl("ddlCommunicationA");
                RadDropDownList ddlQualityOfWorkA = (RadDropDownList)dv.FindControl("ddlQualityOfWorkA");
                RadDropDownList ddlLearningA = (RadDropDownList)dv.FindControl("ddlLearningA");
                RadDropDownList ddlParticipationA = (RadDropDownList)dv.FindControl("ddlParticipationA");
                RadTextBox txtAdminRemarks = (RadTextBox)dv.FindControl("txtAdminRemarks");
                double total = Convert.ToDouble(ddlAttendanceA.SelectedText) + Convert.ToDouble(ddlAttitudeA.SelectedText) + Convert.ToDouble(ddlCustomerCentricA.SelectedText) + Convert.ToDouble(ddlMeetingDeadlinesA.SelectedText) + Convert.ToDouble(ddlCommunicationA.SelectedText) + Convert.ToDouble(ddlQualityOfWorkA.SelectedText) + Convert.ToDouble(ddlLearningA.SelectedText) + Convert.ToDouble(ddlParticipationA.SelectedText);
                double average = Math.Round(total / 8);

                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Connection = con;
                sqlcmd.CommandText = "proc_UpdateAssesPerformance";
                sqlcmd.CommandType = CommandType.StoredProcedure;
                if (con.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
                con.Open();

                sqlcmd.Parameters.AddWithValue("@RSN", lblRSN.Text);
                sqlcmd.Parameters.AddWithValue("@StaffName", lblStaff.Text);
                sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
                sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendanceA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitudeA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlCustomerCentricA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeetingDeadlinesA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunicationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQualityOfWorkA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Learning", ddlLearningA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Participation", ddlParticipationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@AdminRemarks", txtAdminRemarks.Text);
                sqlcmd.Parameters.AddWithValue("@Average_A", Convert.ToString(average));
                sqlcmd.Parameters.AddWithValue("@Adminid", StaffID.ToString());
                sqlcmd.Parameters.AddWithValue("@AdminDateStamp", DateTime.Now);
                sqlcmd.Parameters.AddWithValue("@flag", "N");

                sqlcmd.ExecuteNonQuery();
                con.Close();

                hiddenrsn.Value = lblRSN.Text;

                ViewState["RSN"] = lblRSN.Text;
                GetGridData();
                dvEdit.Visible = false;
                dvMenu.Visible = false;
                dvContent.Visible = true;               
            }
            else if (e.CommandName.Equals("FUpdate"))
            {
                DetailsView dv = (DetailsView)sender;
                Label lblRSN = (Label)dv.FindControl("Label24");
                Label lblStaff = (Label)dv.FindControl("Label25");
                Label lblMonth = (Label)dv.FindControl("Label26");

                Button LinkButton2 = (Button)dv.FindControl("LinkButton2");
                LinkButton2.Attributes.Add("click", "javascript:return chkconfirm();");

                RadDropDownList ddlAttendanceA = (RadDropDownList)dv.FindControl("ddlAttendanceA");
                RadDropDownList ddlAttitudeA = (RadDropDownList)dv.FindControl("ddlAttitudeA");
                RadDropDownList ddlCustomerCentricA = (RadDropDownList)dv.FindControl("ddlCustomerCentricA");
                RadDropDownList ddlMeetingDeadlinesA = (RadDropDownList)dv.FindControl("ddlMeetingDeadlinesA");
                RadDropDownList ddlCommunicationA = (RadDropDownList)dv.FindControl("ddlCommunicationA");
                RadDropDownList ddlQualityOfWorkA = (RadDropDownList)dv.FindControl("ddlQualityOfWorkA");
                RadDropDownList ddlLearningA = (RadDropDownList)dv.FindControl("ddlLearningA");
                RadDropDownList ddlParticipationA = (RadDropDownList)dv.FindControl("ddlParticipationA");
                RadTextBox txtAdminRemarks = (RadTextBox)dv.FindControl("txtAdminRemarks");
                double total = Convert.ToDouble(ddlAttendanceA.SelectedText) + Convert.ToDouble(ddlAttitudeA.SelectedText) + Convert.ToDouble(ddlCustomerCentricA.SelectedText) + Convert.ToDouble(ddlMeetingDeadlinesA.SelectedText) + Convert.ToDouble(ddlCommunicationA.SelectedText) + Convert.ToDouble(ddlQualityOfWorkA.SelectedText) + Convert.ToDouble(ddlLearningA.SelectedText) + Convert.ToDouble(ddlParticipationA.SelectedText);
                double average = Math.Round(total / 8);

                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Connection = con;
                sqlcmd.CommandText = "proc_UpdateAssesPerformance";
                sqlcmd.CommandType = CommandType.StoredProcedure;
                if (con.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
                con.Open();

                sqlcmd.Parameters.AddWithValue("@RSN", lblRSN.Text);
                sqlcmd.Parameters.AddWithValue("@StaffName", lblStaff.Text);
                sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
                sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendanceA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitudeA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlCustomerCentricA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeetingDeadlinesA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunicationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQualityOfWorkA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Learning", ddlLearningA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Participation", ddlParticipationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@AdminRemarks", txtAdminRemarks.Text);
                sqlcmd.Parameters.AddWithValue("@Average_A", Convert.ToString(average));
                sqlcmd.Parameters.AddWithValue("@Adminid", StaffID.ToString());
                sqlcmd.Parameters.AddWithValue("@AdminDateStamp", DateTime.Now);
                sqlcmd.Parameters.AddWithValue("@flag", "N");

                sqlcmd.ExecuteNonQuery();
                con.Close();
                GetGridData();
                dvEdit.Visible = false;
                dvMenu.Visible = false;
                dvContent.Visible = true;
            }
            else if (e.CommandName.Equals("ConfirmUpdate"))
            {
                DetailsView dv = (DetailsView)sender;
                Label lblRSN = (Label)dv.FindControl("Label24");
                Label lblStaff = (Label)dv.FindControl("Label25");
                Label lblMonth = (Label)dv.FindControl("Label26");

                Button LinkButton4 = (Button)dv.FindControl("LinkButton4");
                LinkButton4.Attributes.Add("click", "javascript:return submitconfirm();");

                RadDropDownList ddlAttendanceA = (RadDropDownList)dv.FindControl("ddlAttendanceA");
                RadDropDownList ddlAttitudeA = (RadDropDownList)dv.FindControl("ddlAttitudeA");
                RadDropDownList ddlCustomerCentricA = (RadDropDownList)dv.FindControl("ddlCustomerCentricA");
                RadDropDownList ddlMeetingDeadlinesA = (RadDropDownList)dv.FindControl("ddlMeetingDeadlinesA");
                RadDropDownList ddlCommunicationA = (RadDropDownList)dv.FindControl("ddlCommunicationA");
                RadDropDownList ddlQualityOfWorkA = (RadDropDownList)dv.FindControl("ddlQualityOfWorkA");
                RadDropDownList ddlLearningA = (RadDropDownList)dv.FindControl("ddlLearningA");
                RadDropDownList ddlParticipationA = (RadDropDownList)dv.FindControl("ddlParticipationA");
                RadTextBox txtAdminRemarks = (RadTextBox)dv.FindControl("txtAdminRemarks");
                double total = Convert.ToDouble(ddlAttendanceA.SelectedText) + Convert.ToDouble(ddlAttitudeA.SelectedText) + Convert.ToDouble(ddlCustomerCentricA.SelectedText) + Convert.ToDouble(ddlMeetingDeadlinesA.SelectedText) + Convert.ToDouble(ddlCommunicationA.SelectedText) + Convert.ToDouble(ddlQualityOfWorkA.SelectedText) + Convert.ToDouble(ddlLearningA.SelectedText) + Convert.ToDouble(ddlParticipationA.SelectedText);
                double average = Math.Round(total / 8);

                SqlCommand sqlcmd = new SqlCommand();
                sqlcmd.Connection = con;
                sqlcmd.CommandText = "proc_UpdateAssesPerformance";
                sqlcmd.CommandType = CommandType.StoredProcedure;
                if (con.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
                con.Open();

                sqlcmd.Parameters.AddWithValue("@RSN", lblRSN.Text);
                sqlcmd.Parameters.AddWithValue("@StaffName", lblStaff.Text);
                sqlcmd.Parameters.AddWithValue("@ForMonthOf", lblMonth.Text);
                sqlcmd.Parameters.AddWithValue("@Attendance", ddlAttendanceA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Attitude", ddlAttitudeA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@CustomerCentric", ddlCustomerCentricA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@MeetingDeadlines", ddlMeetingDeadlinesA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Communication", ddlCommunicationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@QualityOfWork", ddlQualityOfWorkA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Learning", ddlLearningA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@Participation", ddlParticipationA.SelectedText);
                sqlcmd.Parameters.AddWithValue("@AdminRemarks", txtAdminRemarks.Text);
                sqlcmd.Parameters.AddWithValue("@Average_A", Convert.ToString(average));
                sqlcmd.Parameters.AddWithValue("@Adminid", StaffID.ToString());
                sqlcmd.Parameters.AddWithValue("@AdminDateStamp", DateTime.Now);
                sqlcmd.Parameters.AddWithValue("@flag", "Y");

                sqlcmd.ExecuteNonQuery();
                con.Close();
                GetGridData();
                dvEdit.Visible = false;
                dvMenu.Visible = false;
                dvContent.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Error');", true);
        }
        finally
        {
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }
        }

    }
    protected void btnDetailsPage_Click(object sender, EventArgs e)
    {

    }
    protected void btnPContinue_Click(object sender, EventArgs e)
    {
        btnSubmit_Click(sender, e);
    }
    protected void btnpCancel_Click(object sender, EventArgs e)
    {
        dvAdd.Visible = false;
        dvpreview.Visible = false;
        dvEdit.Visible = false;
        dvTest.Visible = false;
        dvMenu.Visible = false;
        Clear();
        GetGridData();
        dvContent.Visible = true;
    }
    protected void detailsUpdate_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {

        if (e.CommandName.Equals("CUpdate"))
        {
            string UpdateRSN = ViewState["RSN"].ToString();
            SqlCommand cmdDetails = new SqlCommand("proc_UpdateFlag", con);
            cmdDetails.CommandType = CommandType.StoredProcedure;
            cmdDetails.Parameters.AddWithValue("@RSN", UpdateRSN);
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmdDetails.ExecuteNonQuery();
            con.Close();
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Assesment details submitted to the Employee');", true);
            dvEdit.Visible = false;
            dvContent.Visible = true;
        }
        else if (e.CommandName.Equals("Cancel"))
        {
            GetGridData();
            dvTest.Visible = false;
            dvEdit.Visible = false;
            dvAdd.Visible = false;
            dvMenu.Visible = false;
            dvContent.Visible = true;
        }
    }
    protected void btnTestSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string UpdateRSN = ViewState["RSN"].ToString();
            SqlCommand cmdDetails = new SqlCommand("proc_UpdateFlag", con);
            cmdDetails.CommandType = CommandType.StoredProcedure;
            cmdDetails.Parameters.AddWithValue("@RSN", UpdateRSN);
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmdDetails.ExecuteNonQuery();
            con.Close();
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Assesment details submitted to the Employee');", true);
            GetGridData();
            dvEdit.Visible = false;
            dvMenu.Visible = false;
            dvContent.Visible = true;

        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.Equals(ConnectionState.Open))
            {
                con.Close();
            }
        }
    }

    protected void lbtnAddCancel_Click(object sender, EventArgs e)
    {
        GetGridData();
        dvAdd.Visible = false;
        dvEdit.Visible = false;
        dvpreview.Visible = false;
        dvMenu.Visible = false;
        dvContent.Visible = true;
    }
    protected void lbtneditCancel_Click(object sender, EventArgs e)
    {
        GetGridData();
        dvAdd.Visible = false;
        dvEdit.Visible = false;
        dvpreview.Visible = false;
        dvMenu.Visible = false;
        dvContent.Visible = true;
    }
    protected void lbtnTestCancel_Click(object sender, EventArgs e)
    {
        GetGridData();
        dvAdd.Visible = false;
        dvEdit.Visible = false;
        dvTest.Visible = false;
        dvMenu.Visible = false;
        dvpreview.Visible = false;
        dvContent.Visible = true;
    }
    protected void gvAssesPerform_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton a = e.Row.FindControl("ImageButton1") as ImageButton;
            //LinkButton lbtnUpdate = e.Row.FindControl("lbtnUpdate") as LinkButton;

            ImageButton imgbtnUpdate = e.Row.FindControl("imgbtnUpdate") as ImageButton;

            Label lblAvgA = e.Row.FindControl("lblAvgA") as Label;

            Label Label13 = e.Row.FindControl("Label13") as Label;
            //string test = Label13.Text;

            Label13.Text = GetMonthYearfromgrid(Label13.Text);

            //LinkButton lbtnComplete = e.Row.FindControl("lbtnComplete") as LinkButton;

            if (a.AlternateText == "Y")
            {
                a.Visible = false;
                a.ToolTip = "Performance already assesed.cannot be edited";
                a.ImageUrl = "~/Images/edit.jpg";

            }
            else
            {
                a.ToolTip = "Click here to submit performance details.";
                a.ImageUrl = "~/Images/EditNew.png";              
            }
            

            //if (!(lbtnUpdate.Text == "C"))
            //{
            //    lbtnUpdate.Visible = false;
            //}
            //else
            //{
            //    lbtnUpdate.Text = "Edit";
            //    lbtnUpdate.ToolTip = "Click here to submit performance details.";
            //}

            if (imgbtnUpdate.AlternateText != "C")
            {
                imgbtnUpdate.ToolTip = "Performance already assesed.cannot be edited";
                imgbtnUpdate.Enabled = false;
                imgbtnUpdate.Visible = false;
                imgbtnUpdate.ImageUrl = "~/Images/update.jpg";
            }
            else
            {
                imgbtnUpdate.ToolTip = "Click here to submit your performance details to your appriser.";
                imgbtnUpdate.ImageUrl = "~/Images/EditNew.png";
            }

            if(level == 3 || level == 4)
            {
                if (imgbtnUpdate.AlternateText == "C")
                {
                    if (lblAvgA.Text == "0.00")
                    {
                        lblAvgA.Text = "Waiting for your submission";
                        lblAvgA.ForeColor = Color.Blue;
                    }
                }
                else if (imgbtnUpdate.AlternateText == "N")
                {
                    lblAvgA.Text = "Waiting for appraiser report";
                    lblAvgA.ForeColor = Color.Blue;
                }
                else
                {
                    if (lblAvgA.Text == "0.00")
                    {
                        lblAvgA.Text = "Waiting for appraiser report";
                        lblAvgA.ForeColor = Color.Blue;
                    }
                }               
            }            

            if (!(level ==4 || level==3 || level==2))
            {
                lblAvgA.Visible = true;
            }
            else if (imgbtnUpdate.AlternateText != "N")
            {
                lblAvgA.Visible = true;
            }
            else
            {
                //lblAvgA.Visible = false;
            }
        }
    }
    protected void lbtnBackHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }
    protected void lbtnunsubmit_Click(object sender, EventArgs e)
    {
        dvAdd.Visible = false;
        dvContent.Visible = false;
        dvEdit.Visible = false;
        dvpreview.Visible = false;
        dvTest.Visible = false;
        dvMenu.Visible = false;
        dvUnSubmitted.Visible = false;   
       
        if(UserLevel == "1")
        {
            LoadStaff();
            GetUnSubmitAssess(Session["UserID"].ToString());
            dvMenu.Visible = true;            
        }
        else
        {
            GetUserAssess(Session["UserID"].ToString());            
            dvUnSubmitted.Visible = true;
        }
    }
    private void LoadStaff()
    {
        DataSet dsAllAssess = new DataSet();
        try
        {
            SqlCommand cmdassessed = new SqlCommand("GetAllStaff", con);
            cmdassessed.CommandType = CommandType.StoredProcedure;           
            SqlDataAdapter dap = new SqlDataAdapter(cmdassessed);
            dap.Fill(dsAllAssess, "tblperfmon");           
            if (dsAllAssess.Tables[0].Rows.Count > 0)
            {
                radstaff.DataSource = dsAllAssess.Tables[0];
                radstaff.DataTextField = "StaffName";
                radstaff.DataValueField = "UserName";
                radstaff.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void lbtnsubappraisal_Click(object sender, EventArgs e)
    {
        GetGridData();
    }
    protected void gvUnSubmitAssess_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUnSubmitAssess.PageIndex = e.NewPageIndex;
        GetUnSubmitAssess(Session["UserID"].ToString());
    }
    public void GetUserAssess(string staffName)
    {
        DataSet dsAllAssess = new DataSet();
        try
        {
            SqlCommand cmdassessed = new SqlCommand("proc_GetAllAssess", con);
            cmdassessed.CommandType = CommandType.StoredProcedure;
            cmdassessed.Parameters.AddWithValue("@staffName", staffName);
            SqlDataAdapter dap = new SqlDataAdapter(cmdassessed);
            dap.Fill(dsAllAssess, "tblperfmon");
            Session["UnDataset"] = (DataSet)dsAllAssess;
            Session["Dataset"] = (DataSet)dsAllAssess;
            if (dsAllAssess.Tables[0].Rows.Count > 0)
            {
                gvUserAssess.DataSource = dsAllAssess;
                gvUserAssess.DataBind();
            }
            else
            {
                gvUserAssess.DataSource = null;
                gvUserAssess.DataBind();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "AlertMsg();", true);
                return;
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void GetUnSubmitAssess(string staffName)
    {
        DataSet dsAllAssess = new DataSet();
        try
        {
            SqlCommand cmdassessed = new SqlCommand("proc_GetAllAssess", con);
            cmdassessed.CommandType = CommandType.StoredProcedure;
            cmdassessed.Parameters.AddWithValue("@staffName",staffName );
            SqlDataAdapter dap = new SqlDataAdapter(cmdassessed);
            dap.Fill(dsAllAssess, "tblperfmon");
            Session["UnDataset"] = (DataSet)dsAllAssess;
            Session["Dataset"] = (DataSet)dsAllAssess;
            if (dsAllAssess.Tables[0].Rows.Count > 0)
            {
                gvUnSubmitAssess.DataSource = dsAllAssess;
                gvUnSubmitAssess.DataBind();
            }
            else
            {
                gvUnSubmitAssess.DataSource = null;
                gvUnSubmitAssess.DataBind();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Alert", "AlertMsg();", true);
                return;
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void gvUnSubmitAssess_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string RSN;
        if (e.CommandName.Equals("View"))
        {
            RSN = e.CommandArgument.ToString();
            dvContent.Visible = false;
            dvUnSubmitted.Visible = false;
            dvMenu.Visible = false;
            dvTest.Visible = true;
            FilterByRSN(RSN, true,(DataSet)Session["UnDataset"]);
        }
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        dvAdd.Visible = false;
        dvContent.Visible = true;
        dvEdit.Visible = false;
        dvpreview.Visible = false;
        dvMenu.Visible = false;
        dvTest.Visible = false;
        dvUnSubmitted.Visible = false;
        GetGridData();
    }
    protected void btnUnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if(radstaff.SelectedText.ToString() != null || radstaff.SelectedText.ToString() != "")
            {
                GetUnSubmitAssess(radstaff.SelectedText.ToString());
            }
            else
            {
                WebMsgBox.Show("Please select staff name to search");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show("Please Check your Internet Connection");
        }
    }
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        dvTest.Visible = false;
        dvContent.Visible = false;
        dvMenu.Visible = false;
        dvAdd.Visible = true;
        btnSubmit.Text = "Save";
        Clear();
        CheckYear(StaffID);
        Button1.Visible = true;
        txtMonth.Visible = false;
        //ddlMonth.Visible = true;
        lblMonth.Visible = true;
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
        GetMonthYear(lblMonth.Text.ToString());
    }
    protected void tabMain_TabClick(object sender, RadTabStripEventArgs e)
    {
        if(e.Tab.SelectedIndex.ToString() =="2")
        {
            GetAppraiserAssess(LblStaffName.Text);
        }
    }
    private void GetAppraiserAssess(string staffName)
    {
        DataSet dsAllAssess = new DataSet();
        try
        {
            SqlCommand cmdassessed = new SqlCommand("proc_GetAppraiser_Asses", con);
            cmdassessed.CommandType = CommandType.StoredProcedure;
            cmdassessed.Parameters.AddWithValue("@staffName",staffName);
            SqlDataAdapter dap = new SqlDataAdapter(cmdassessed);
            dap.Fill(dsAllAssess, "tblperfmon");
            Session["UnDataset"] = (DataSet)dsAllAssess;
            Session["Dataset"] = (DataSet)dsAllAssess;
            if (dsAllAssess.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = dsAllAssess;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "Alert", "AlertMsg();", true);
               //Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "Alert", "<script>alert('There is no records to display')</script>", true);
               //Response.Write("<script>alert('There is no records to display')</script>");
              // return;
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void radstaff_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        btnUnSearch_Click(sender, e);
    }   
    protected void ddlAttendance_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlAttitude_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlcustomercentric_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlMeeting_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlCommunication_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlQuality_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlLearning_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
    protected void ddlparticipation_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }    
    protected void btnExit_Click(object sender, EventArgs e)
    {        
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }
    protected void gvUnSubmitAssess_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblchangemonth = e.Row.FindControl("Label13") as Label;
            lblchangemonth.Text = GetMonthYearfromgrid(lblchangemonth.Text);
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblchangemonth = e.Row.FindControl("Label13") as Label;
            lblchangemonth.Text = GetMonthYearfromgrid(lblchangemonth.Text);
        }
    }
    protected void gvUserAssess_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblchangemonth = e.Row.FindControl("Label13") as Label;
            lblchangemonth.Text = GetMonthYearfromgrid(lblchangemonth.Text);
        }
    }
    protected void gvUserAssess_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUserAssess.PageIndex = e.NewPageIndex;
        GetUserAssess(Session["UserID"].ToString());
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlAttendance.ClearSelection();
        ddlAttitude.ClearSelection();
        ddlCommunication.ClearSelection();
        ddlcustomercentric.ClearSelection();
        ddlLearning.ClearSelection();
        ddlMeeting.ClearSelection();
        ddlparticipation.ClearSelection();
        ddlQuality.ClearSelection();
        txtGoodbyAnother.Text = string.Empty;
        txtGoodWorkDone.Text = string.Empty;
        txtStaffRemarks.Text = string.Empty;
        txtStaffSugg.Text = string.Empty;
        double Avg = CalculateAvg();
        lblAssessAvg.Text = Avg.ToString();
    }
}