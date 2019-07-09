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
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.IO;

public partial class AppTheme_HomeMST : System.Web.UI.MasterPage
{
    SQLProcs proc = new SQLProcs();
    string CurrentPage = "";
    string staffemail;
    string staffdesign;
    static string ToMail;    
    protected void Page_Load(object sender, EventArgs e)
    {
        CurrentPage = Page.ToString().Replace("ASP.", "").Replace("_", ".");
        if (CurrentPage == "login.aspx")
        {
            dvHead.Visible = false;
        }
        else
        {
            dvHead.Visible = true;
            LoginDetails();
        }
        if (!IsPostBack)
        {
            LoadCompanyDetails();
           // rwFeedback.VisibleOnPageLoad = true;
           // rwFeedback.Visible = false;
            staffemail = "";
            staffdesign = "";            
        }

    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        // InsertUsageLog();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
    public void LoginDetails()
    {
        DataSet dsUserDetails = proc.SQLExecuteDataset("SP_GetUserDetails", new SqlParameter { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
        if (dsUserDetails.Tables[0].Rows.Count > 0)
        {
            lbMore.Text = "Signed in as " + " " + Session["UserID"].ToString() + " " + " JobType:" + " " + dsUserDetails.Tables[0].Rows[0]["Designation"].ToString();
            lbllastlogin.Text = "Your Sign-In was on " + dsUserDetails.Tables[0].Rows[0]["lastloggedin"].ToString();
            staffemail = dsUserDetails.Tables[0].Rows[0]["StaffEmail"].ToString();
            staffdesign = dsUserDetails.Tables[0].Rows[0]["Designation"].ToString();
        }
        dsUserDetails.Dispose();
    }
    protected void LoadCompanyDetails()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCompanyDetails = new DataSet();

        dsCompanyDetails = sqlobj.SQLExecuteDataset("SP_GetCompanyDetails");
        if (dsCompanyDetails.Tables[0].Rows.Count != 0)
        {
            Session["Version"] = dsCompanyDetails.Tables[0].Rows[0]["versionnumber"].ToString();
            Session["CompanyName"] = dsCompanyDetails.Tables[0].Rows[0]["companyname"].ToString();
            lblproductname.Text = dsCompanyDetails.Tables[0].Rows[0]["productname"].ToString();
            lblcmpname.Text = Session["CompanyName"].ToString();
            lblversion.Text = Session["Version"].ToString();
            CompanyUrl.HRef = "http://" + dsCompanyDetails.Tables[0].Rows[0]["CompanyWebsite"].ToString();
            CompanyUrl.InnerText = dsCompanyDetails.Tables[0].Rows[0]["Company"].ToString();
            DeveloperUrl.HRef = "http://" + dsCompanyDetails.Tables[0].Rows[0]["DeveloperWebsite"].ToString();
            DeveloperUrl.InnerText = dsCompanyDetails.Tables[0].Rows[0]["Developer"].ToString();
            ToMail = dsCompanyDetails.Tables[0].Rows[0]["Fromemailid"].ToString();

            Session["DefaultCountry"] = dsCompanyDetails.Tables[0].Rows[0]["DefaultCountry"].ToString();

        }
    }
    protected void lbtnFeedback_Click(object sender, EventArgs e)
    {
       // txtFeedMsg.Text = string.Empty;
       // txtFeedRegards.Text = Session["UserID"].ToString();
        //ddlfeedback.SelectedIndex  = 0;
       // rwFeedback.Visible = true;
    }
    protected void btnFeedSend_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PMS"].ConnectionString);
        try
        {
            string mailserver = string.Empty;
            string user = string.Empty;
            string pwd = string.Empty;
            string sentby = string.Empty;
            //string ToMail="prakash.m@innovatussystems.com";      

            SQLProcs sqlobj = new SQLProcs();           
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
                StreamReader reader = new StreamReader(Server.MapPath("~/Feedback.htm"));
                string readFile = reader.ReadToEnd();
                string myString = "";
                myString = readFile;
                //myString = myString.Replace("$$FeedBack$$", txtFeedMsg.Text.ToString());
                //myString = myString.Replace("$$Regards$$", txtFeedRegards.Text.ToString());
                //myString = myString.Replace("$$Designation$$", staffdesign);
                //myString = myString.Replace("$$Company$$", lblcmpname.Text.ToString());

                SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                MailAddress From = new MailAddress(user, ToMail);
                MailMessage myMail = new System.Net.Mail.MailMessage();
                myMail.From = From;
                myMail.To.Add(new MailAddress(ToMail));
                myMail.CC.Add(new MailAddress(staffemail));
                //myMail.Subject ="Regards " + txtFeedRegards.Text +" : " + txtFeedSubject.Text;
                //myMail.Subject = ddlfeedback.SelectedValue;
                //myMail.Body = txtFeedMsg.Text;
                myMail.Body = myString.ToString();
                mySmtpClient.UseDefaultCredentials = false;
                System.Net.NetworkCredential basicAuthenticationInfo = new
                  System.Net.NetworkCredential(user, pwd);
                mySmtpClient.Credentials = basicAuthenticationInfo;
                mySmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                mySmtpClient.EnableSsl = true;
                myMail.SubjectEncoding = System.Text.Encoding.UTF8;

                myMail.BodyEncoding = System.Text.Encoding.UTF8;
                myMail.IsBodyHtml = true;
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(ValidateServerCertificate);
                mySmtpClient.Send(myMail);
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Your feedback submitted successfully');", true);

               // txtFeedMsg.Text = string.Empty;
               // txtFeedRegards.Text = string.Empty;
                //ddlfeedback.SelectedIndex = 0;
               // rwFeedback.Visible = false;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
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
    protected void btnFeedClose_Click(object sender, EventArgs e)
    {
        //rwFeedback.Visible = false;
    }
}
