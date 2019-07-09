using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMS;  
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;


public partial class MasterPage : System.Web.UI.MasterPage
{
    string CurrentPage = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           CurrentPage = Page.ToString().Replace("ASP.", "").Replace("_", ".");

           //link1.Attributes.Add("href", "favicon32.ico");
           //link2.Attributes.Add("href", "favicon16.ico");

           rwCustomerProfile.VisibleOnPageLoad = true;
           rwCustomerProfile.Visible = false;


            if (!IsPostBack)
            {


                if (CurrentPage == "login.aspx")
                {
                    //CSmenu.Visible = false;

                    lbSignOut.Visible = false;
                    this.Page.Title = "Login";
                }
                else if (CurrentPage == "managentasklist.aspx")
                {
                    this.Page.Title = "Home";                  
                }
                else if (CurrentPage == "admin.aspx")
                {
                    this.Page.Title = "Admin"; 
                }
                else if (CurrentPage == "newbiz.aspx")
                {
                    this.Page.Title = "NewBiz"; 
                }
                else if (CurrentPage == "diary.aspx")
                {
                    this.Page.Title = "Diary"; 
                }
                else if (CurrentPage == "smreports.aspx")
                {
                    this.Page.Title = "SM Reports";
                }
                else if (CurrentPage == "wmreports.aspx")
                {
                    this.Page.Title = "WM Reports"; 
                }
                else if (CurrentPage == "smxreports.aspx")
                {
                    this.Page.Title = "SMX Reports"; 
                }
                else if (CurrentPage == "wmxreports.aspx")
                {
                    this.Page.Title = "WMX Reports"; 
                }
                else if (CurrentPage == "Charts.aspx")
                {
                    this.Page.Title = "Charts";
                }
                else if (CurrentPage == "mytasks.aspx")
                {
                    this.Page.Title = "Mytasks";
                }
                LoadServerTime(); 
                LoadCompanyDetails();

               string strform = Page.Form.Name.ToString();
               

            }


        }
        catch (Exception ex)
        {
            //ShowMsgBox(ex.Message, "Exception");
        }
    }
    protected void btnCPClose_Click(object sender, EventArgs e)
    {
        rwCustomerProfile.Visible = false;
    }
    
   

    private void LoadCustomerProfile(String customerrsn)
    {
        try
        {
            SQLProcs sqlobj = new SQLProcs();
            DataSet dsCCustStatus = new DataSet();          

            dsCCustStatus = sqlobj.SQLExecuteDataset("proc_GetStaffDetails",
                new SqlParameter() { ParameterName = "@StaffName", SqlDbType = SqlDbType.VarChar, Value = customerrsn.ToString() });

            if (dsCCustStatus.Tables[0].Rows.Count > 0)
            {
                lblName.Text = dsCCustStatus.Tables[0].Rows[0]["StaffName"].ToString();
                //lblscpstatus.Text = dsCCustStatus.Tables[0].Rows[0]["Status"].ToString();
                lblAddr1.Text = dsCCustStatus.Tables[0].Rows[0]["AddrLine1"].ToString();
                lblAddr2.Text = dsCCustStatus.Tables[0].Rows[0]["AddrLine2"].ToString();
                lblCity.Text = dsCCustStatus.Tables[0].Rows[0]["City"].ToString();
                lblState.Text = dsCCustStatus.Tables[0].Rows[0]["State"].ToString();
                lblPostCode.Text = dsCCustStatus.Tables[0].Rows[0]["PostCode"].ToString();
                lblDesig.Text = dsCCustStatus.Tables[0].Rows[0]["Designation"].ToString();
                lblEmail.Text = dsCCustStatus.Tables[0].Rows[0]["StaffEmail"].ToString();
                lblPhone.Text = dsCCustStatus.Tables[0].Rows[0]["StaffPhone"].ToString();
                rwCustomerProfile.Visible = true;
            }

            dsCCustStatus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void LoadServerTime()
    {
        DataSet dsProcess = new DataSet();
        SQLProcs proc = new SQLProcs();
        DataSet dsDT = null;

        dsDT = proc.SQLExecuteDataset("GetServerDateTime");
        //lblDate.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dddd") + " , " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd MMM yyyy | hh : mm tt");
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

            Label1.Text = Session["ProductName"].ToString();
            Label4.Text = Session["ProductByLine"].ToString();

            
            
            
            if (CurrentPage != "login.aspx")
            {
                DataSet dsUserDetails = sqlobj.SQLExecuteDataset("SP_GetUserDetails", new SqlParameter { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });
                if (dsUserDetails.Tables[0].Rows.Count > 0)
                {
                    lbMore.Text = "Signed in as " + " " + Session["UserID"].ToString() + " " + " JobType:" + " " + dsUserDetails.Tables[0].Rows[0]["Designation"].ToString();
                    lbllastlogin.Text = "Your Sign-In was on " + dsUserDetails.Tables[0].Rows[0]["lastloggedin"].ToString();

                    //Add by Prakash.M
                    //DateTime dt = Convert.ToDateTime(dsUserDetails.Tables[0].Rows[0]["lastloggedin"].ToString()); // get current date time
                    //lbllastlogin.Text = "You last logged in on  " + dt.ToString("ddd") + " " + string.Format("{0:dd-MMM-yyyy HH:mm 'Hrs'}", dt);
                   
                }

                //Convert.ToDateTime().ToString("dd MMM yyyy | hh : mm tt")

                dsUserDetails.Dispose();

            }
            Label2.Text = Session["CompanyName"].ToString();
            Label3.Text = Session["Version"].ToString(); 
        }

        

        dsCompanyDetails.Dispose();  
    }

    protected void lblSignOut_Click(object sender, EventArgs e)
    {
        Server.Transfer("Login.aspx");
    }


    protected void lbMore_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }
        LoadCustomerProfile(Session["UserID"].ToString());
        //SqlProcs sqlobj = new SqlProcs();
        //DataSet dsChkPwd = new DataSet();

        //string UName;
        //string Pword;

        //UName = Request.QueryString["UserID"].ToString();

        //dsChkPwd = sqlobj.ExecuteSP("SP_CheckPassword",
        //new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UName });
        
        //Pword = dsChkPwd.Tables[0].Rows[0]["Password"].ToString();

        //Response.Redirect("http://bincrm.com/pnrbcrm/login.cshtml/?Username=" + UName + "&Password=" + Pword);
        
    }



}
