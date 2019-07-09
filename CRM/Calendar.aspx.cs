using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PMS;
using System.Web.Security;
using System.Net.Mail;

public partial class Calendar : System.Web.UI.Page
{
    SQLProcs sqlobj = new SQLProcs();
    protected static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
    public static string UserName;
    static string strUserLevel;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserID"] == null)
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }

                UserMenuLog uml = new UserMenuLog();
                uml.InsertUserMenuLog(Session["UserID"].ToString(), "Calendar", DateTime.Now);

                UserName = Session["UserID"].ToString();
                strUserLevel = Session["UserLevel"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    [WebMethod]
    public static string AddSaveTime(string Savetime)
    {
        string flag = "";
        try
        {
            if (Savetime == "")
            {
                flag = "false";
                return flag;
            }
            SQLProcs sqlobj = new SQLProcs();
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                                  new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = Savetime },
                                                  new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                                  );
            flag = "true";
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }
    [WebMethod]
    public static string GetSaveTime()
    {
        DataSet dsSaveTime = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("SP_GetSaveTimeEntry", con);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsSaveTime, "temp");
        }
        catch (Exception ex)
        {          
        }
        return dsSaveTime.GetXml();
    }

    [WebMethod]
    public static string GetTasksDetails(string taskid)
    {
        DataSet dsTasksdet = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("GetLatestTracker", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@taskid", taskid);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsTasksdet, "temp");
        }
        catch (Exception ex)
        {          
        }
        return dsTasksdet.GetXml();
    }

    [WebMethod]
    public static string GetStaff()
    {      
        DataSet dsStaff = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("proc_GetStaff", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@staffname", UserName);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsStaff, "temp");           
        }
        catch (Exception ex)
        {           
        }
        return dsStaff.GetXml();
    }
    public class Event
    {
        public Int64? EventID { get; set; }
        public string EventName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string color { get; set; }
        public string Url { get; set; }
        public string allday { get; set; }
        public string imageurl { get; set; }
    }
    [WebMethod]
    public static string AddTask(string CustName, string AssignTo, string Tasks, string Fdate)
    {
        SQLProcs sqlobj = new SQLProcs();
        string flag = "";
        string strCustomerName = "";
        string custMail = "";
        string MobileNo = "";
        string title = "";
        try
        {
            string strStatus = "";
            string strdocfive = "";
            string chkAppts ="";
            //chkAppts = CheckAppointments(Fdate);
            //if (chkAppts == "false")
            //{
            //    flag = "false";
            //    WebMsgBox.Show("Appointment already booked for the day and time");
            //    return flag;
            //}
            //DateTime dtDate = Convert.ToDateTime(Fdate);
            //Fdate = dtDate.ToString("yyyy-MM-dd hh:mm");
            DataSet dsCuststatus = new DataSet();
            dsCuststatus = sqlobj.SQLExecuteDataset("sp_getcustomerdetails",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = CustName });

            if (dsCuststatus.Tables[0].Rows.Count > 0)
            {
                strStatus = dsCuststatus.Tables[0].Rows[0]["custstatus"].ToString();
                strCustomerName = dsCuststatus.Tables[0].Rows[0]["Name"].ToString();
                custMail = dsCuststatus.Tables[0].Rows[0]["Email"].ToString();
                MobileNo = dsCuststatus.Tables[0].Rows[0]["Mobile"].ToString();
                title = dsCuststatus.Tables[0].Rows[0]["title"].ToString();
            }

            dsCuststatus.Dispose();

            if (strStatus == "7CUS" || strStatus == "OTHR" || strStatus == "VNDR")
            {
                strdocfive = "CUST";
            }
            else
            {
                strdocfive = "LEAD";
            }

            DataSet TaskID = sqlobj.SQLExecuteDataset("SP_InsertNewTask",
                                                new SqlParameter() { ParameterName = "@CustName", SqlDbType = SqlDbType.NVarChar, Value = CustName },
                                                new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = AssignTo },
                                                new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = "#Aptmnt" },
                                                new SqlParameter() { ParameterName = "@TaskType", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                new SqlParameter() { ParameterName = "@TaskAssigned", SqlDbType = SqlDbType.NVarChar, Value = Tasks },
                                                new SqlParameter() { ParameterName = "@AssignedOn", SqlDbType = SqlDbType.DateTime, Value = Fdate },
                                                new SqlParameter() { ParameterName = "@AssignedBy", SqlDbType = SqlDbType.NVarChar, Value = UserName },
                                                new SqlParameter() { ParameterName = "@TargetDate", SqlDbType = SqlDbType.DateTime, Value = Fdate },
                                                new SqlParameter() { ParameterName = "@OtherAssignees", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                                                new SqlParameter() { ParameterName = "@QtyOfWork", SqlDbType = SqlDbType.NVarChar, Value = "BI" },
                                                new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                new SqlParameter() { ParameterName = "@Complexity", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                                                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UserName },
                                                new SqlParameter() { ParameterName = "@Docfive", SqlDbType = SqlDbType.NVarChar, Value = strdocfive.ToString() }
                                                );
            if (Fdate != null)
            {
                sqlobj.ExecuteSQLNonQuery("sp_updatefollowupdate_calendar",
                    new SqlParameter() { ParameterName = "@Followupdate", SqlDbType = SqlDbType.VarChar, Value = Fdate },
                    new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = TaskID.Tables[3].Rows[0]["RSN"].ToString() }
                    );
                SendmailWithIcsAttachment(UserName, strCustomerName.ToString(), "#Aptmnt", Convert.ToString(Tasks), Convert.ToDateTime(Fdate), custMail, MobileNo, UserName, title);

            }
            WebMsgBox.Show("The activity will now appear in the Tasks list of the concerned person.");
            flag = "true";
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        //InsertUsageLog();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
    public static void SendmailWithIcsAttachment(string touser, string customer, string reference, string comments, DateTime followupdate, string custEmail, string MobileNo, string AssignTo, string title)
    {
        SQLProcs sqlobj = new SQLProcs();
        string AdminName = "";
        string AdminContact = "";
        try
        {
            //public string Location { get; set; }
            string Location = "";          

            MailMessage msg = new MailMessage();
            DataSet dsAdmin = new DataSet();
            dsAdmin = sqlobj.SQLExecuteDataset("GetAdminDetails");
            if(dsAdmin != null && dsAdmin.Tables[0].Rows.Count > 0)
            {
                AdminName = dsAdmin.Tables[0].Rows[0]["CompanyName"].ToString();
                AdminContact = dsAdmin.Tables[0].Rows[0]["ContactMobile"].ToString();
            }
            //Now we have to set the value to Mail message properties

            string tomail = "";

            DataSet dsemail = sqlobj.SQLExecuteDataset("SP_GetMailId",
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = touser.ToString() });

            if (dsemail.Tables[0].Rows.Count > 0)
            {
                tomail = dsemail.Tables[0].Rows[0]["StaffEmail"].ToString();
            }

            dsemail.Dispose();

            if (tomail.ToString() != "")
            {
                string strmcusername = "";
                string strmcpassword = "";
                string strmcfromname = "";

                DataSet dsmc = sqlobj.SQLExecuteDataset("SP_GetMailCredential");
                if (dsmc.Tables[0].Rows.Count > 0)
                {
                    strmcusername = dsmc.Tables[0].Rows[0]["username"].ToString();
                    strmcpassword = dsmc.Tables[0].Rows[0]["password"].ToString();
                    strmcfromname = dsmc.Tables[0].Rows[0]["sentbyuser"].ToString();
                }

                dsmc.Dispose();

                MailClass M = new MailClass();
                M.AppointMail(strmcusername, strmcfromname, tomail.ToString(), touser.ToString(), customer, reference, comments,
                    followupdate, strmcusername.ToString(), strmcpassword.ToString(), custEmail, AdminName, AdminContact, MobileNo, AssignTo, title);
            }
        }
        catch (Exception ex)
        {
            // CreateLogFiles Err = new CreateLogFiles();
            String[] contents = { ex.Message.ToString() };
            //System.IO.File.WriteAllLines(Server.MapPath("error.txt"), contents);
        }
    }
    [WebMethod]
    public static string LoadAssignedTo()
    {
        DataSet dsAssignTo = new DataSet();
        SqlCommand cmd = new SqlCommand("SP_FetchStaffDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserID", "");
        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsAssignTo, "temp");
        return dsAssignTo.GetXml();
    }
    [WebMethod]
    public static string LoadProspectCustomer()
    {
        DataSet dsCustName = new DataSet();
        SqlCommand cmd = new SqlCommand("SP_FetchDropDown", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@iMode", 15);
        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsCustName, "test");
        return dsCustName.GetXml();
    }
    [WebMethod]
    public static List<Event> GetEvents()
    {
        List<Event> events;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        SqlCommand cmd = new SqlCommand("AppointmentEventsAllDays", con);
        cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@date", DateTime.Today);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        events = new List<Event>();        
        if (dr.HasRows)
        {
            int i = 0;
            int cmp = 0;
            int png = 0;
            int up = 0;
            while (dr.Read())
            {
                i = i + 1;
                Event _Event = new Event();
                DateTime dtStart = Convert.ToDateTime(dr["Followupdate"]);
                DateTime dtTest = DateTime.Now;

                string formattedDate = dtStart.ToString("MM/dd/yyyy hh:mm");

                string mno = dr["Mobile"].ToString();
                
                //_Event.EventID = i;
                _Event.EventID = Convert.ToInt64(dr["RSN"].ToString());
                _Event.EventName = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                _Event.StartDate = dtStart.DayOfWeek + "," + formattedDate;
                _Event.EndDate = dtStart.DayOfWeek + "," + formattedDate;
                //string test = DateTime.Now.DayOfWeek + ", " + DateTime.Now.AddDays(i + 2).ToString();
                int sts = Convert.ToInt16(dr["status"].ToString());
                if (sts == 0 && dtTest >= dtStart)
                {
                    _Event.color = "#FF0000";
                    png = png + 1;
                }
                else if (sts == 98 && dtTest >= dtStart)
                {
                    _Event.color = "#008000";
                    cmp = cmp + 1;
                }
                else
                {
                    _Event.color = "";
                    up = up + 1;
                }
                events.Add(_Event);
            }
        }
        dr.Close();
        con.Close();
        //HttpContext.Current.Session["events"] = events;
        return events;
    }

    [WebMethod]
    public static List<Event> GetEventsByUsers(string username)
    {
        List<Event> events;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);       
        SqlCommand cmd = new SqlCommand("AppointmentEventsForStaffs", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@staffname", username);
        if(con.State.Equals(ConnectionState.Open))
        {
            con.Close();
        }
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        events = new List<Event>();
        if (dr.HasRows)
        {
            int i = 0;            
            while (dr.Read())
            {
                i = i + 1;
                Event _Event = new Event();
                DateTime dtStart = Convert.ToDateTime(dr["Followupdate"]);
                DateTime dtTest = DateTime.Now;

                string formattedDate = dtStart.ToString("MM/dd/yyyy HH:mm");               

                string mno = dr["Mobile"].ToString();

                //_Event.EventID = i;
                _Event.EventID = Convert.ToInt64(dr["RSN"].ToString());
                //_Event.EventName = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                if (strUserLevel == "1Manager" || strUserLevel == "2CoOrdinator")
                {
                    if (UserName == dr["Assignee"].ToString())
                    {
                        _Event.EventName = dr["Name"].ToString();
                    }
                    else
                    {
                        _Event.EventName = dr["Name"].ToString() + " (" + dr["Assignee"].ToString() + ")";
                    }                   
                }
                else
                {
                    _Event.EventName = dr["Name"].ToString();
                }
                _Event.StartDate = dtStart.DayOfWeek + "," + formattedDate;
                _Event.EndDate = dtStart.DayOfWeek + "," + formattedDate;              
               
                //string test = DateTime.Now.DayOfWeek + ", " + DateTime.Now.AddDays(i + 2).ToString();
                int sts = Convert.ToInt16(dr["status"].ToString());

                if (sts == 2)
                {                    
                    _Event.EventName =  dr["Name"].ToString() + " (" + dr["Event"].ToString() + " )";
                    _Event.Url = dr["Name"].ToString();
                    _Event.color = "#ff0000";                    
                }
                else if (dtTest.ToString("MM/dd/yyyy") == dtStart.ToString("MM/dd/yyyy"))
                {
                    if(sts == 0 || sts == 1)
                    {
                        _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                        _Event.color = "";
                        //_Event.imageurl = "Calender/app.png";
                    } 
                    else if(sts == 98)
                    {
                        _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                        _Event.color = "#ddf6dd";
                        if (dr["Event"].ToString().Contains("Done"))
                        {
                            _Event.imageurl = "Calender/ok.png";
                        }
                        else
                        {
                            _Event.imageurl = "Calender/cancel.png";
                        }                        
                    }
                }
                else if ((sts == 0 || sts == 1) && dtTest > dtStart)
                {
                    _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                    _Event.color = "#f68f75";
                    //_Event.imageurl = "Calender/app.png";
                }
                //else if (sts == 1 && dtTest > dtStart)
                //{
                //    _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                //    _Event.color = "#f68f75";                    
                //}
                else if (sts == 98 && dtTest > dtStart)
                {
                    _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                    _Event.color = "#ddf6dd";
                    if (dr["Event"].ToString().Contains("Done"))
                    {
                        _Event.imageurl = "Calender/ok.png";
                    }
                    else
                    {
                        _Event.imageurl = "Calender/cancel.png";
                    }
                }
                else if (sts == 98 && dtTest < dtStart)
                {
                    _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                    _Event.color = "#ddf6dd";
                    if (dr["Event"].ToString().Contains("Done"))
                    {
                        _Event.imageurl = "Calender/ok.png";
                    }
                    else
                    {
                        _Event.imageurl = "Calender/cancel.png";
                    }
                }                
                else
                {
                    _Event.Url = dr["Name"].ToString() + '\n' + mno.ToString() + '\n' + dr["Event"].ToString();
                    _Event.color = "";                    
                }                
                events.Add(_Event);
            }
        }
        dr.Close();
        con.Close();
        //HttpContext.Current.Session["events"] = events;
        return events;
    }
    private static string IsProspectExisting(string prospectname, string mobile)
    {
        string IsExisting;
        SQLProcs sqlobj = new SQLProcs();
        DataSet dspe = new DataSet();
        dspe = sqlobj.SQLExecuteDataset("SP_CheckExistingProspect",
            new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = prospectname },
            new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = mobile });
        if (dspe.Tables[0].Rows.Count > 0)
        {
            IsExisting = dspe.Tables[0].Rows[0]["RSN"].ToString();
        }
        else
        {
            IsExisting = "false";
        }
        return IsExisting;
    }
    [WebMethod]
    public static string AddProspects(string title,string Name, string Mobile, string Email)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsRSN = new DataSet();
        string flag = "";
        try
        {
            //if (IsProspectExisting(Name, Mobile))
            //{
            //    flag = "false";
            //    return flag;
            //}
            string stsflag = IsProspectExisting(Name, Mobile);
            if (stsflag != "false")
            {
                flag = stsflag;
                return flag;
            }
            else
            {
                string strNotes = "";
                //string struid = Session["UserID"].ToString();
                dsRSN = sqlobj.SQLExecuteDataset("sp_insertprospects_Calendar",
                                   new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = title },
                                   new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = Name },
                                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "0REG" },
                                   new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = "PROSPECT" },
                                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Street", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@PostalCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@State", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Phone", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Mobile", SqlDbType = SqlDbType.NVarChar, Value = Mobile },
                                   new SqlParameter() { ParameterName = "@Email", SqlDbType = SqlDbType.NVarChar, Value = Email },
                                   new SqlParameter() { ParameterName = "@PersonalMail", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@New_Old", SqlDbType = SqlDbType.NVarChar, Value = "New" },

                                   new SqlParameter() { ParameterName = "@Vip_Imp", SqlDbType = SqlDbType.NVarChar, Value = null },

                                   new SqlParameter() { ParameterName = "@Notes", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@LeadSource", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Compaign", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Budget", SqlDbType = SqlDbType.NVarChar, Value = null },
                                   new SqlParameter() { ParameterName = "@Requirements", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@ProjectCode", SqlDbType = SqlDbType.NVarChar, Value = null },

                                   new SqlParameter() { ParameterName = "@M_Id", SqlDbType = SqlDbType.NVarChar, Value = UserName },
                                   new SqlParameter() { ParameterName = "@CompanyName", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@ACManager", SqlDbType = SqlDbType.NVarChar, Value = null }

                                   );
                flag = dsRSN.Tables[0].Rows[0][0].ToString();
            }           
            //flag = "true";
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }
    [WebMethod]
    public static string UpdateTasks(string Taskid, string comments, string status, string stscommnts)
    {
        SQLProcs sqlobj = new SQLProcs();
        String flag = "";
        try
        {
            //DateTime dtDate = Convert.ToDateTime(date);
            ////date = "";
            //date = dtDate.ToString("yyyy-MM-dd");
            DataSet dsTasks = new DataSet();
            dsTasks = sqlobj.SQLExecuteDataset("GetTaskTrackDetails",
                new SqlParameter() { ParameterName = "@taskid", SqlDbType = SqlDbType.BigInt, Value = Taskid });
             //sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrackWD_Appoint",
            sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrackWD_Appoint",
                           new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = Taskid },
                           new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = comments + "(" + stscommnts + ")" },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UserName },
                           new SqlParameter() { ParameterName = "@FollowupDate", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dsTasks.Tables[0].Rows[0]["Followupdate"].ToString()) },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = status.ToString() },
                           new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = null },
                           new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Trackon"].ToString() },
                           new SqlParameter() { ParameterName = "@TimeSpent", SqlDbType = SqlDbType.Decimal, Value = null },
                           new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Assignedto"].ToString() },
                           new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Projectname"].ToString() },
                           new SqlParameter() { ParameterName = "@ProjectStatus", SqlDbType = SqlDbType.NVarChar, Value = null },
                           new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = "02" },
                           new SqlParameter() { ParameterName = "@StatusCommnts ", SqlDbType = SqlDbType.NVarChar, Value = stscommnts }
                           );

            sqlobj.ExecuteSQLNonQuery("UpdateCustStatus",
                new SqlParameter { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(dsTasks.Tables[0].Rows[0]["Projectname"].ToString()) },
                new SqlParameter() { ParameterName = "@ustatus", SqlDbType = SqlDbType.VarChar, Value = stscommnts });

            flag = "true";
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }
    //string Taskid, string comments, string date, string status
    //[WebMethod]
    //public static string UpdateTasks(string Taskid, string comments, string status, string date)
    //{
    //    SQLProcs sqlobj = new SQLProcs();
    //    String flag="";
    //    try
    //    {
    //        //DateTime dtDate = Convert.ToDateTime(date);
    //        ////date = "";
    //        //date = dtDate.ToString("yyyy-MM-dd");
    //        DataSet dsTasks = new DataSet();
    //        dsTasks = sqlobj.SQLExecuteDataset("GetTaskTrackDetails",
    //            new SqlParameter() { ParameterName = "@taskid", SqlDbType = SqlDbType.BigInt, Value = Taskid });
    //        sqlobj.ExecuteSQLNonQuery("SP_InsertTaskTrackWD",
    //                       new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.Float, Value = Taskid },
    //                       new SqlParameter() { ParameterName = "@TrkComments", SqlDbType = SqlDbType.NVarChar, Value = comments },
    //                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UserName },
    //                       new SqlParameter() { ParameterName = "@FollowupDate", SqlDbType = SqlDbType.DateTime, Value = date },
    //                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = status.ToString() },
    //                       new SqlParameter() { ParameterName = "@Value", SqlDbType = SqlDbType.Decimal, Value = null },
    //                       new SqlParameter() { ParameterName = "@TrackOn", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Trackon"].ToString() },
    //                       new SqlParameter() { ParameterName = "@TimeSpent", SqlDbType = SqlDbType.Decimal, Value = null },
    //                       new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Assignedto"].ToString() },
    //                       new SqlParameter() { ParameterName = "@ProjectName", SqlDbType = SqlDbType.NVarChar, Value = dsTasks.Tables[0].Rows[0]["Projectname"].ToString() },
    //                       new SqlParameter() { ParameterName = "@ProjectStatus", SqlDbType = SqlDbType.NVarChar, Value = null },
    //                       new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = null }
    //                       );
    //        flag = "true";
    //    }
    //    catch (Exception ex)
    //    {
    //        flag = "false";
    //    }
    //    return flag;
    //}   

    [WebMethod]
    public static string CheckAppointments(string date)
    {
        string flag = "";
        DateTime DT = Convert.ToDateTime(date);
        try
        {
            using (SqlCommand cmd = new SqlCommand("CheckAppointmentExists"))
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@date", DT.ToString("yyyy-MM-dd HH:mm"));
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                dap.Fill(ds, "temp");
                if(ds.Tables[0].Rows.Count > 0 && ds != null)
                {
                    //flag = "true";
                    return ds.GetXml();
                }
            }           
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }

    public class Appointments
    {
        public string Date { get; set; }
        public Int64 Total { get; set; }
        public Int64 Done { get; set; }
        public Int64 Scheduled { get; set; }
    }

    [WebMethod]
    public static string[] GetUsers(string keyword)
    {
        List<string> retList = new List<string>();
        try
        {
            using (SqlCommand cmd = new SqlCommand("GetCustomerAuto"))
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@term", keyword);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        //retList.Add(dr["RSN"].ToString());
                        //retList.Add(dr["Name"].ToString());
                        retList.Add(string.Format("{0}|{1}", dr["Name"], dr["RSN"]));
                    }
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
        }
        return retList.ToArray();
    }

    [WebMethod]
    public static List<Appointments> GetCounts(int i,string date)
    {
        List<Appointments> AppList = new List<Appointments>();
        DateTime DT = Convert.ToDateTime(date);
        try
        {
            using (SqlCommand cmd = new SqlCommand("GetAppointmentsCount"))
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@i", i);
                cmd.Parameters.AddWithValue("@Date", DT.ToString("yyyy-MM-dd"));
                con.Open();
                using(SqlDataReader dr=cmd.ExecuteReader())
                {
                    if(dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            Appointments App = new Appointments();
                            App.Total = Convert.ToInt64(dr["Total"].ToString());
                            App.Done = Convert.ToInt64(dr["Done"].ToString());
                            App.Scheduled = Convert.ToInt64(dr["Scheduled"].ToString());

                            App.Date = DT.ToString("dd-MMM-yyyy");

                            AppList.Add(App);
                        }             
                    }
                    else
                    {
                        Appointments App = new Appointments();
                        App.Total = 0;
                        App.Done = 0;
                        App.Scheduled = 0;

                        App.Date = DT.ToString("dd-MMM-yyyy");

                        AppList.Add(App);
                    }                         
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {            
        }
        return AppList.ToList();
    }
}