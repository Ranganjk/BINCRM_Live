using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Net;
using ClsPaymentGatewayDet;

public partial class PaymentSuccess : System.Web.UI.Page
{
    static ClsPayDetails payDetails;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                try
                {
                    payDetails = new ClsPayDetails();
                }
                catch (Exception ex)
                {

                }

                string[] merc_hash_vars_seq;
                string merc_hash_string = string.Empty;
                string merc_hash = string.Empty;
                string order_id = string.Empty;
                string hash_seq = payDetails.GetAdminParamsDetails().Rows[0]["HashSequence"].ToString();
                //"key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";
                
                if (Request.Form["status"] == "success")
                {
                    merc_hash_vars_seq = hash_seq.Split('|');
                    Array.Reverse(merc_hash_vars_seq);
                    merc_hash_string = payDetails.GetAdminParamsDetails().Rows[0]["Salt"].ToString() + "|" + Request.Form["status"];
                    //ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];
                    foreach (string merc_hash_var in merc_hash_vars_seq)
                    {
                        merc_hash_string += "|";
                        merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");
                    }
                    merc_hash = Generatehash512(merc_hash_string).ToLower();
                    if (merc_hash != Request.Form["hash"])
                    {
                        Response.Write("Hash value did not matched");
                    }
                    else
                    {
                        double bal = Convert.ToDouble(Request.Form["udf3"]) + Convert.ToDouble(Request.Form["udf5"]);
                        Session["NewBal"] = bal;
                        LblAmount.Text = "Rs." + Request.Form["Amount"];
                        LblNewBal.Text = "New Balance : Rs." + Math.Round(bal).ToString();
                        double a = Math.Round(bal/10);
                        LblGoodFor.Text = "Good for : " + a.ToString()+" CCC Ids";
                        //LblOldBalance.Text = Request.Form["udf5"];
                        LblTotAmt.Text = Math.Round(Convert.ToDouble(Request.Form["Amount"])).ToString();
                        LblServiceTax.Text = Request.Form["udf1"];
                        LblSBCess.Text = Request.Form["udf2"];
                        LblFinalAmt.Text = Request.Form["udf3"];
                        //LblNewBalance.Text = Math.Round(bal).ToString();
                        LblInvoiceNo.Text = Request.Form["Txnid"];
                        LblDate.Text = DateTime.Now.ToString("dd-MMM-yyyy ddd HH:mm") + " Hrs.";
                        
                        DataSet dsDet = new DataSet();
                        dsDet = payDetails.GetData();
                        if (payDetails.billingDetails.Rows.Count > 0)
                        {
                            LblInvoiceTo.Text = payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString();
                            LblBillingAddress.Text = payDetails.billingDetails.Rows[0]["AddressLine2"].ToString();
                        }


                        /*SqlProcs proc = new SqlProcs();
                        DataSet dsDet = new DataSet();
                        dsDet = proc.ExecuteSP("SP_PAYMENTADMIN",
                            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 }
                            );
                        if (dsDet.Tables[0].Rows.Count > 0)
                        {
                            LblInvoiceTo.Text = dsDet.Tables[0].Rows[0]["InvoiceTo"].ToString();
                            LblBillingAddress.Text = dsDet.Tables[0].Rows[0]["BillingAddress"].ToString();
                        }*/
                        savedet();
                    }

                    payDetails.fromId = payDetails.GetAdminParamsDetails().Rows[0]["FromID"].ToString();
                    payDetails.MailPwd = payDetails.GetAdminParamsDetails().Rows[0]["Password"].ToString();
                    payDetails.MailIDs = payDetails.GetAdminParamsDetails().Rows[0]["MailIDs"].ToString().Split(';');
                    payDetails.CCMailIDs = payDetails.GetAdminParamsDetails().Rows[0]["CCMailIDs"].ToString().Split(';');
                    payDetails.BCCMailIDs = payDetails.GetAdminParamsDetails().Rows[0]["CCMailIDs"].ToString().Split(';');
                    String strDate = DateTime.Now.ToString("dd-MMM-yyyy");
                    payDetails.MailSubject = "Payment Transaction - Success";
                    String strDescription="";
                    if(Session["Description"]!=null)
                    {
                        strDescription = Session["Description"].ToString();
                    }
                    System.Globalization.CultureInfo Indian = new System.Globalization.CultureInfo("hi-IN");

                    String strTotAmt = String.Format(Indian, "{0:N}", Convert.ToDouble(LblTotAmt.Text));
                    String strSrvTax = String.Format(Indian, "{0:N}", Convert.ToDouble(LblServiceTax.Text));
                    String strSBCess = String.Format(Indian, "{0:N}", Convert.ToDouble(LblSBCess.Text));
                    String strFinalAmt = String.Format(Indian, "{0:N}", Convert.ToDouble(LblFinalAmt.Text));
                    //String strNewBal = String.Format(Indian, "{0:N}", Convert.ToDouble(LblNewBalance.Text));


                    payDetails.MailBody = "<table ><tr><td><b>The Transaction - " + LblInvoiceNo.Text + " made successfully on " + LblDate.Text + "</b><br/><br/></td></tr></table>";
                    payDetails.MailBody += "<table><tr><td><b>Transaction Description</b></td><td><b> - " + strDescription + "</b></td></tr></table>";
                    payDetails.MailBody += "<table border=\"1\"><tr><tr><td><b>Recharge Amount</b></td><td align='right'><b>" + strTotAmt + "</b></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><b>Service Tax</b></td><td align='right'><b>" + strSrvTax + "</b></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><b>Swachh Bharath CESS</b></td><td align='right'><b>" + strSBCess + "</b><br/></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><b>Total Amount Payable</b></td><td align='right'><b>" + strFinalAmt + "</b></td></tr></table>";
                    //payDetails.MailBody += "<tr><tr><td><b>The Balance Amount</b></td><td align='right'><b>" + strNewBal + "</b></td></tr></table>";
                    payDetails.MailBody += "<table><tr><tr><td><b>The Service Tax and Swachh Bharath CESS deducted from Total Amount</b></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><span style=\"color:#0066CC;\">This is an automated report, please do not reply.</span><br/></td></tr>";
                    //payDetails.MailBody += "<tr><tr><td><span style=\"color:#0066CC;\">If you wish to add any more points, please inform us.</span><br/></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><span style=\"color:#0066CC;\"><b>Assuring our best services always.</b></span><br/></td></tr>";
                    payDetails.MailBody += "<tr><tr><td><span style=\"color:#0066CC;\"><b>Innovatus Systems Special Support Team</b></span><br/></td></tr></table>";

                    payDetails.CreatedOn = DateTime.Now.ToString("yyyy-MM-dd");
                    if (Session["UserName"] != null)
                        payDetails.CreatedBy = Session["UserName"].ToString();
                    else
                        payDetails.CreatedBy = Session["PayUser"].ToString();
                    payDetails.Senton = DateTime.Now.ToString("yyyy-MM-dd");
                    if (Session["USERID"]!=null)
                         payDetails.Sentby = Session["USERID"].ToString();
                    else
                        payDetails.Sentby = Session["PayUser"].ToString();

                    payDetails.SendMail();


                    string strMessage="Txn ID : "+LblInvoiceNo.Text+"\r\nDescription:"+strDescription+"\r\nRecharge Amt : "+strTotAmt+"\r\nService Tax : "+strSrvTax+"\r\nSwachhBharath CESS : "+strSBCess+"\r\nTotal Amount : "+strFinalAmt+"\r\n";

                    //string contactno=payDetails.billingDetails.Rows[0]["CONTACTNO"].ToString();
                    payDetails.MobileNo = payDetails.billingDetails.Rows[0]["CONTACTNO"].ToString();
                    //payDetails.MobileNo = "9884087364";
                    payDetails.smstext = strMessage;
                    //payDetails.CreatedOn = DateTime.Now.ToString("yyyy-MM-dd");
                    //payDetails.CreatedBy = Session["UserName"].ToString();
                    payDetails.SendSMS();
                }
                else
                {
                    Response.Write("Hash value did not matched");
                }

            }
        }
        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");
        }
    }
    public string Generatehash512(string text)
    {
        byte[] message = Encoding.UTF8.GetBytes(text);
        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;
    }
    protected void BtnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            string fname = "RechargeSuccess " + DateTime.Now.ToString("dd-MM-yyyy");
            BtnPrint.Visible = false;
            Response.ClearContent();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + fname + "_Details.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            PnlPaymentDet.RenderControl(hw);
            Document pdfDoc = new Document(PageSize.A4, 10f, 20f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            StringReader sr = new StringReader(sw.ToString());
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
            BtnPrint.Visible = true;
        }
        catch (Exception ex)
        {
            BtnPrint.Visible = true;
        }
    }
    protected void savedet()
    {
        try
        {
            payDetails.imode = 1;
            payDetails.TxnInvoiceNo = Request.Form["txnid"];
            payDetails.TxnAmount = Math.Round(Convert.ToDouble(Request.Form["Amount"]));
            payDetails.TxnSERVICETAX = Math.Round(Convert.ToDouble(Request.Form["udf1"]));
            payDetails.TxnSBCess = Math.Round(Convert.ToDouble(Request.Form["udf2"]));
            payDetails.TxnFinalAmount = Math.Round(Convert.ToDouble(Request.Form["udf3"]));
            payDetails.TxnBalance = Math.Round(Convert.ToDouble(Session["NewBal"]));
            payDetails.TxnDesc = Convert.ToString(Session["Desc"]);
            payDetails.TxnTXNMODE = "CR";
            payDetails.TxnC_ID = Convert.ToString(Session["PayUser"]);
            payDetails.SaveTxn();
            /*SqlProcs proc = new SqlProcs();

            proc.ExecuteSP("SP_AMTTXNS",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@InvoiceNo", SqlDbType = SqlDbType.NVarChar, Value = Request.Form["txnid"] },
                new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["Amount"])) },
                new SqlParameter() { ParameterName = "@SERVICETAX", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf1"])) },
                new SqlParameter() { ParameterName = "@SBCess", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf2"])) },
                new SqlParameter() { ParameterName = "@FinalAmount", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf3"])) },
                new SqlParameter() { ParameterName = "@Balance", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Session["NewBal"])) },
                new SqlParameter() { ParameterName = "@Desc", SqlDbType = SqlDbType.VarChar, Value = Convert.ToString(Session["Desc"]) },
                new SqlParameter() { ParameterName = "@TXNMODE", SqlDbType = SqlDbType.Char, Value = "CR" },
                new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.VarChar, Value = Convert.ToString(Session["PayUser"]) }
                );*/
        }
        catch (Exception ex)
        {

        }
    }

    protected void BtnHome_Click(object sender, EventArgs e)
    {
        if (Session["HomePage"] != null)
            Response.Redirect(Session["HomePage"].ToString());
    }

    protected void BtnPayDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("PayDetails.aspx");
    }
    protected void BtnHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentHistory.aspx");
    }
    protected void BtnStatement_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentStatement.aspx");
    }
}