using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Net;
using PMS;
//using ProudMonkey.Common.Controls;
using System.Threading;
using System.Globalization;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using System.IO;

public partial class Login : System.Web.UI.Page
{
    //protected clcommon objclcommon;

    SQLProcs sqlobj = new SQLProcs();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DataSet dsProcess = new DataSet();
            SQLProcs proc = new SQLProcs();
            DataSet dsDT = null;
            
            rwDownloadMail.VisibleOnPageLoad = true;
            rwDownloadMail.Visible = false;
            RadWindow1.Visible = false;           
           
            if (!IsPostBack)
            {
                LoadMsg();
                LoadCampaignMsg();

                txtPlainPassword.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
            }
        }
        catch (Exception ex)
        {
            //ShowMsgBox(ex.Message, "Exception");
        }
    }


    protected void LoadCheckDate()
    {
        SQLProcs proc = new SQLProcs();
        DataSet dsDT = null;
        dsDT = proc.SQLExecuteDataset("GetServerDateTime");
        Session["CheckDemoDate"] = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("yyyy-MM-dd");
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

    protected void LoadCompanyDetails()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCompanyDetails = new DataSet();

        dsCompanyDetails = sqlobj.SQLExecuteDataset("SP_GetCompanyDetails");
        if (dsCompanyDetails.Tables[0].Rows.Count != 0)
        {
            Session["ProductName"] = dsCompanyDetails.Tables[0].Rows[0]["productname"].ToString();
            Session["ProductByLine"] = dsCompanyDetails.Tables[0].Rows[0]["productbyline"].ToString();
            Session["Version"] = dsCompanyDetails.Tables[0].Rows[0]["versionnumber"].ToString();
            Session["CompanyName"] = dsCompanyDetails.Tables[0].Rows[0]["companyname"].ToString();

            //lblCustDet.Text = Session["ProductName"].ToString();
            //lblproductbyline.Text = Session["ProductByLine"].ToString();
            //  lblcompanyName.Text = Session["CompanyName"].ToString();
            // lblVersion.Text = Session["Version"].ToString() ; 


        }

    }

    [System.Web.Services.WebMethod]
    public static void checkbalance()
    {
       // btnHidden_Click(null, null);
        WebMsgBox.Show("success");
    }

   
    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        try
        {

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsChkAct = new DataSet();
            DataSet dsChkPwd = new DataSet();
            DataSet dsChkSt = new DataSet();
            DataSet dsChkPwdDt = new DataSet();

            Session["UserID"] = string.Empty;

            Session["SUPASSWORD"] = txtPlainPassword.Text;

            DataSet dsCompanyDetails = new DataSet();


            if (txtUserID.Text == "admin" && txtPlainPassword.Text == "a#m$n~")
            {
                Session["UserID"] = txtUserID.Text;
                Session["SUPASSWORD"] = txtPlainPassword.Text;

                Response.Redirect("Admin.aspx");

                //FormsAuthentication.RedirectFromLoginPage(txtUserID.Text, false);

            }

            else
            {
                // -- Start check balance

                 DateTime LastDebitDate;
                 DateTime CurrentDate;

                DataSet dsCheckFirstLogin = sqlobj.SQLExecuteDataset("SP_GetDebitDate");

                if (dsCheckFirstLogin.Tables[0].Rows.Count > 0)
                {
                   
                    string sdate =   dsCheckFirstLogin.Tables[0].Rows[0]["LastDebitDate"].ToString();
                    string ldd = "";
                    string cdd = "";

                    if (dsCheckFirstLogin.Tables[1].Rows.Count > 0)
                    {

                        LastDebitDate = Convert.ToDateTime(dsCheckFirstLogin.Tables[0].Rows[0]["LastDebitDate"].ToString());

                        CurrentDate = DateTime.Now;

                        ldd = LastDebitDate.ToString("dd-MM-yyyy");
                        cdd = CurrentDate.ToString("dd-MM-yyyy");
                    }
                    else
                    {

                        LastDebitDate = DateTime.Now.AddDays(-1);

                        CurrentDate = DateTime.Now;

                        ldd = LastDebitDate.ToString("dd-MM-yyyy");
                        cdd = CurrentDate.ToString("dd-MM-yyyy");
                    }


                       if (ldd.Equals(cdd))
                       {


                           dsCompanyDetails = sqlobj.SQLExecuteDataset("SP_GetCompanyDetails");
                           if (dsCompanyDetails.Tables[0].Rows.Count != 0)
                           {
                               string strproductname = dsCompanyDetails.Tables[0].Rows[0]["productname"].ToString();

                               if (strproductname != "")
                               {


                                   dsChkAct = sqlobj.SQLExecuteDataset("proc_LoginCheck",
                                     new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                                     new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = Session["SUPASSWORD"].ToString() });

                                   if (dsChkAct != null && dsChkAct.Tables.Count > 0 && dsChkAct.Tables[0].Rows.Count > 0)
                                   {
                                       ////Check Status
                                       //dsChkSt = sqlobj.SQLExecuteDataset("SP_CheckStatus",
                                       //    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                                       //    new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });

                                       if (dsChkAct.Tables[0].Rows.Count != 0)
                                       {

                                           dsChkPwd = sqlobj.SQLExecuteDataset("SP_CheckUIPwd",
                                               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                                               new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = Session["SUPASSWORD"].ToString() });

                                           if (dsChkPwd.Tables[0].Rows.Count == 0)
                                           {


                                               //Session["UserID"] = txtUserID.Text.Trim();
                                               Session["UserID"] = dsChkAct.Tables[0].Rows[0]["UserID"].ToString();


                                               Session["Action"] = "LogIn";

                                               InsertLoginAudit();

                                               InsertUsageLog();


                                               FormsAuthentication.RedirectFromLoginPage(txtUserID.Text, false);



                                               //Response.Redirect("ManageNTaskList.aspx?UserName=" + dsChkSt.Tables[0].Rows[0]["UserID"].ToString());


                                               //Response.Redirect("Home.aspx");

                                               return;


                                           }
                                           else
                                           {
                                               Session["UserID"] = txtUserID.Text;
                                               Session["Action"] = "Failed";

                                               InsertLoginAudit();

                                               ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);
                                               return;
                                           }

                                       }
                                       else
                                       {
                                           Session["UserID"] = txtUserID.Text;
                                           Session["Action"] = "Failed";

                                           InsertLoginAudit();

                                           WebMsgBox.Show("Access Denied: User is Terminated/Blocked");
                                           //msgbox.ShowError("Access Denied: User is Terminated/Blocked");      


                                       }

                                   }

                                   else
                                   {
                                       Session["UserID"] = txtUserID.Text;
                                       Session["Action"] = "Failed";

                                       InsertLoginAudit();

                                       WebMsgBox.Show("Access Denied: Invalid User ID / Password");
                                       return;
                                   }
                               }
                               else
                               {
                                   WebMsgBox.Show("OOPS! Something is broken! Contact the dealer from whom you bought the software license.");
                               }

                           }
                       }
                       else
                       {
                           //RadWindowManager1.RadConfirm("<b>FIRST SIGN-IN FOR THE DAY</b>.<br/><b>USAGE FEES WILL BE DEDUCTED NOW.</b><br/><b>CONFIRM?</b>", "confirmStatusCallbackFn", 400, 200, null, "Confirm");

                           ScriptManager.RegisterStartupScript(this, this.GetType(), "CallConfirmBox", "CallConfirmBox();", true);



                           // ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFun1", "confirmStatusCallbackFn();", true);

                           // RadWindowManager1.onclien
                           //RadWindow2.VisibleOnPageLoad = true;
                           // RadWindow2.Visible = true;
                       }


                   

                    //else
                    //{
                    //    //RadWindowManager1.RadConfirm("<b>FIRST SIGN-IN FOR THE DAY</b>.<br/><b>USAGE FEES WILL BE DEDUCTED NOW.</b><br/><b>CONFIRM?</b>", "confirmStatusCallbackFn", 400, 200, null, "Confirm");

                    //    // ScriptManager.RegisterStartupScript(this, this.GetType(), "CallConfirmBox", "CallConfirmBox();", true);
                    //    // ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyFun1", "confirmStatusCallbackFn();", true);

                    //    Response.Redirect("PayDetails.aspx", false);
                    //}



                }
               
            }

            // End check Balance
        }
        
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void InsertLoginAudit()
    {
        HttpBrowserCapabilities browser = Request.Browser;


        string strBrowserName = browser.Browser;

        string strBrowerDevice = browser.Platform;

        string hostName = Dns.GetHostName();

        string myIP = Dns.GetHostByName(hostName).AddressList[0].ToString();


        SQLProcs sqlobj = new SQLProcs();
        sqlobj.ExecuteSQLNonQuery("SP_tblloginaudit",
                                      new SqlParameter() { ParameterName = "@StaffID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                      new SqlParameter() { ParameterName = "@Action", SqlDbType = SqlDbType.NVarChar, Value = Session["Action"].ToString() },
                                      new SqlParameter() { ParameterName = "@Browser", SqlDbType = SqlDbType.NVarChar, Value = strBrowserName.ToString() },
                                      new SqlParameter() { ParameterName = "@Device", SqlDbType = SqlDbType.NVarChar, Value = strBrowerDevice.ToString() },
                                      new SqlParameter() { ParameterName = "@IPAddress", SqlDbType = SqlDbType.NVarChar, Value = myIP.ToString() });
    }
    protected void InsertUsageLog()
    {
        SQLProcs sqlobj = new SQLProcs();
        sqlobj.ExecuteSQLNonQuery("SP_LoginAudit",
                                      new SqlParameter() { ParameterName = "@Script", SqlDbType = SqlDbType.NVarChar, Value = "/LogIn.aspx" },
                                      new SqlParameter() { ParameterName = "@User", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                      new SqlParameter() { ParameterName = "@Action", SqlDbType = SqlDbType.NVarChar, Value = "LogIn" },
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

    protected void btnChangePwd_Click(object sender, EventArgs e)
    {

        //Page.ClientScript.RegisterStartupScript(this.GetType(), "My function", "OpenPopup();", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);
    }


    protected void btnSignInMobile_Click(object sender, EventArgs e)
    {

        try
        {

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsChkAct = new DataSet();
            DataSet dsChkPwd = new DataSet();
            DataSet dsChkSt = new DataSet();
            DataSet dsChkPwdDt = new DataSet();

            Session["UserID"] = string.Empty;
            //Check User
            //dsChkAct = sqlobj.SQLExecuteDataset("SP_CheckUser",
            //    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
            //    new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });

            dsChkAct = sqlobj.SQLExecuteDataset("proc_LoginCheck",
                        new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                        new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });

            if (dsChkAct != null && dsChkAct.Tables.Count > 0 && dsChkAct.Tables[0].Rows.Count > 0)
            {
                //Check Status
                //dsChkSt = sqlobj.SQLExecuteDataset("SP_CheckStatus",
                //    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                //    new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });
                if (dsChkAct.Tables[0].Rows.Count != 0)
                {

                    dsChkPwd = sqlobj.SQLExecuteDataset("SP_CheckUIPwd",
                        new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                        new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });
                    if (dsChkPwd.Tables[0].Rows.Count == 0)
                    {
                        //Session["UserID"] = txtUserID.Text.Trim();
                        Session["UserID"] = dsChkAct.Tables[0].Rows[0]["UserID"].ToString();


                        Session["Action"] = "LogIn";

                        InsertLoginAudit();

                        InsertUsageLog();


                        //Response.Redirect("ManageNTaskList.aspx?UserName=" + dsChkSt.Tables[0].Rows[0]["UserID"].ToString());
                        //Response.Redirect("Home.aspx");

                        Response.Redirect("MHome.aspx");

                        return;


                    }
                    else
                    {
                        Session["UserID"] = txtUserID.Text;
                        Session["Action"] = "Failed";

                        InsertLoginAudit();

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);
                        return;
                    }

                }
                else
                {
                    Session["UserID"] = txtUserID.Text;
                    Session["Action"] = "Failed";

                    InsertLoginAudit();

                    WebMsgBox.Show("Access Denied: User is Terminated/Blocked");
                    //msgbox.ShowError("Access Denied: User is Terminated/Blocked");      


                }

            }
            else
            {
                Session["UserID"] = txtUserID.Text;
                Session["Action"] = "Failed";

                InsertLoginAudit();

                WebMsgBox.Show("Access Denied: Invalid User ID / Password");
                return;
            }
        }




        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnGettingStarted_Click(object sender, EventArgs e)
    {

    }
    protected void lnkGettingStarted_Click(object sender, EventArgs e)
    {
        RadWindow1.VisibleOnPageLoad = true;
        RadWindow1.Visible = true;
        RadWindow1.NavigateUrl = "http://bincrm.com/aboutbcrm/GettingStarted.pdf";
    }
    protected void lnkAbout_Click(object sender, EventArgs e)
    {
        RadWindow1.VisibleOnPageLoad = true;
        RadWindow1.Visible = true;
        RadWindow1.NavigateUrl = "http://bincrm.com/aboutbcrm/BiNCRMFeatures_L.pdf";
    }
    protected void lnkVideo_Click(object sender, EventArgs e)
    {

    }
    protected void lnkScenarios_Click(object sender, EventArgs e)
    {
        RadWindow1.VisibleOnPageLoad = true;
        RadWindow1.Visible = true;
        RadWindow1.NavigateUrl = "http://bincrm.com/aboutbcrm/Scenarios.pdf";
    }
    protected void lnkMobileApp_Click(object sender, EventArgs e)
    {
        rwDownloadMail.Visible = true;
    }
    protected void btnMailCancel_Click(object sender, EventArgs e)
    {
        rwDownloadMail.Visible = false;
    }
    public static bool ValidateServerCertificate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
    {
        if (sslPolicyErrors == SslPolicyErrors.None)
            return true;
        else
        {
            return true;
        }
    }

    protected void btnMailSave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        try
        {
            string mailserver = string.Empty;
            string user = string.Empty;
            string pwd = string.Empty;
            string sentby = string.Empty;

            SQLProcs sqlobj = new SQLProcs();
            DataSet dsMobileApp = sqlobj.SQLExecuteDataset("SP_GetMobileApp");
            if (dsMobileApp.Tables[0].Rows.Count > 0)
            {
                string downloadLink = dsMobileApp.Tables[0].Rows[0]["MobileAppLink"].ToString();
                string productname = dsMobileApp.Tables[0].Rows[0]["ProductName"].ToString();
                string companyname = dsMobileApp.Tables[0].Rows[0]["companyname"].ToString();
                string ccmailid = dsMobileApp.Tables[0].Rows[0]["fromemailid"].ToString();

                StreamReader reader = new StreamReader(Server.MapPath("~/MobileApp.html"));
                string readFile = reader.ReadToEnd();
                string myString = "";
                myString = readFile;
                myString = myString.Replace("$$Link$$", downloadLink);
                myString = myString.Replace("$$Product$$", companyname);

                SqlCommand cmd = new SqlCommand(string.Concat("SELECT * FROM cpmailcredentials"), con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet dsCredential = new DataSet();
                da.Fill(dsCredential);

                if (dsCredential != null && dsCredential.Tables.Count > 0)
                {
                    foreach (DataRow row in dsCredential.Tables[0].Rows)
                    {
                        mailserver = row["mailserver"].ToString();
                        user = row["username"].ToString();
                        pwd = row["password"].ToString();
                        sentby = row["sentbyuser"].ToString();
                    }
                    //user = "mail.info3ssolutions@gmail.com";
                    SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                    MailAddress From = new MailAddress(ccmailid, ccmailid);
                    //MailAddress From = new MailAddress(user, user);
                    MailMessage myMail = new System.Net.Mail.MailMessage();
                    myMail.From = From;
                    myMail.To.Add(new MailAddress(txtMailID.Text));
                    myMail.CC.Add(new MailAddress(ccmailid.ToString()));
                    myMail.Subject = "Here is the link to the mobile app.";
                    myMail.Body = myString.ToString();
                    mySmtpClient.UseDefaultCredentials = false;
                    System.Net.NetworkCredential basicAuthenticationInfo = new
                      System.Net.NetworkCredential(user, pwd);
                    mySmtpClient.Credentials = basicAuthenticationInfo;
                    //mySmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    mySmtpClient.EnableSsl = true;
                    myMail.SubjectEncoding = System.Text.Encoding.UTF8;

                    myMail.BodyEncoding = System.Text.Encoding.UTF8;
                    myMail.IsBodyHtml = true;
                    ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(ValidateServerCertificate);
                    mySmtpClient.Send(myMail);
                    dsMobileApp.Dispose();
                    reader.Dispose();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Email with link sent.Please check your Mail');", true);

                    rwDownloadMail.Visible = false;
                    btnMailCancel_Click(sender, e);
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Failed to send Mail');", true);
        }
    }

    protected void btnHidden_Click(object sender, EventArgs e)
    {

        DataSet dsBalance = sqlobj.SQLExecuteDataset("SP_GetBalance");

        if (dsBalance.Tables[0].Rows.Count > 0)
        {
            decimal creditlimit = Convert.ToDecimal(dsBalance.Tables[0].Rows[0]["CreditLimit"].ToString());
            decimal AvailableBalance = Convert.ToDecimal(dsBalance.Tables[0].Rows[0]["CreditBalance"].ToString());


            //decimal AvailableBalance = -230;


           

            if (AvailableBalance < creditlimit)
            {
                Response.Redirect("PayDetails.aspx", false);
            }
            else
            {

            
                if ((AvailableBalance < 0) && (AvailableBalance > creditlimit))
               {   
               // WebMsgBox.Show("Please recharge quickly to avoid disconnecting.");

                   Session["AlertMsg"] = "Please recharge quickly to avoid disconnecting";
               }

                DataSet dsdebitamount = sqlobj.SQLExecuteDataset("SP_DayUsageBilling");

                dsdebitamount.Dispose();


               DataSet dsCompanyDetails = sqlobj.SQLExecuteDataset("SP_GetCompanyDetails");
                if (dsCompanyDetails.Tables[0].Rows.Count != 0)
                {
                    string strproductname = dsCompanyDetails.Tables[0].Rows[0]["productname"].ToString();

                    if (strproductname != "")
                    {


                       DataSet dsChkAct = sqlobj.SQLExecuteDataset("proc_LoginCheck",
                          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                          new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = Session["SUPASSWORD"].ToString() });

                        if (dsChkAct != null && dsChkAct.Tables.Count > 0 && dsChkAct.Tables[0].Rows.Count > 0)
                        {
                            ////Check Status
                            //dsChkSt = sqlobj.SQLExecuteDataset("SP_CheckStatus",
                            //    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                            //    new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = txtPlainPassword.Text });

                            if (dsChkAct.Tables[0].Rows.Count != 0)
                            {

                               DataSet dsChkPwd = sqlobj.SQLExecuteDataset("SP_CheckUIPwd",
                                    new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
                                    new SqlParameter() { ParameterName = "@Password", SqlDbType = SqlDbType.NVarChar, Value = Session["SUPASSWORD"].ToString() });

                                if (dsChkPwd.Tables[0].Rows.Count == 0)
                                {


                                    //Session["UserID"] = txtUserID.Text.Trim();
                                    Session["UserID"] = dsChkAct.Tables[0].Rows[0]["UserID"].ToString();


                                    Session["Action"] = "LogIn";

                                    InsertLoginAudit();

                                    InsertUsageLog();


                                    FormsAuthentication.RedirectFromLoginPage(txtUserID.Text, false);


                                    return;


                                }
                                else
                                {
                                    Session["UserID"] = txtUserID.Text;
                                    Session["Action"] = "Failed";

                                    InsertLoginAudit();

                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigateDir2();", true);
                                    return;
                                }

                            }
                            else
                            {
                                Session["UserID"] = txtUserID.Text;
                                Session["Action"] = "Failed";

                                InsertLoginAudit();

                                WebMsgBox.Show("Access Denied: User is Terminated/Blocked");
                                //msgbox.ShowError("Access Denied: User is Terminated/Blocked");      


                            }

                        }

                        else
                        {
                            Session["UserID"] = txtUserID.Text;
                            Session["Action"] = "Failed";

                            InsertLoginAudit();

                            WebMsgBox.Show("Access Denied: Invalid User ID / Password");
                            return;
                        }
                    }
                    else
                    {
                        WebMsgBox.Show("OOPS! Something is broken! Contact the dealer from whom you bought the software license.");
                    }

                }
                
            }



        }

        dsBalance.Dispose();
    }
}

 