using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using PMS;

public partial class ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtCPUserID.Focus();
        }
    }

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        if (txtConfirmPwd.Text != string.Empty && txtCurrentPwd.Text != string.Empty && txtPassword.Text != string.Empty && txtConfirmPwd.Text != string.Empty)
        {

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Change Password", DateTime.Now);

            if (txtPassword.Text == txtConfirmPwd.Text)
            {
                try
                {
                    SQLProcs proc = new SQLProcs();
                    DataSet ds = new DataSet();

                    ds = proc.SQLExecuteDataset("SP_GETDTLS", new SqlParameter()
                    {
                        ParameterName = "@IMODE",
                        Direction = ParameterDirection.Input,
                        SqlDbType = SqlDbType.Int,
                        Value = 1
                    }
                    , new SqlParameter()
                    {
                        ParameterName = "@UserID",
                        Direction = ParameterDirection.Input,
                        SqlDbType = SqlDbType.NVarChar,
                        Value = txtCPUserID.Text
                    },
                    new SqlParameter()
                    {
                        ParameterName = "@PWD",
                        Direction = ParameterDirection.Input,
                        SqlDbType = SqlDbType.NVarChar,
                        Value = txtCurrentPwd.Text
                    });
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count == 0)
                        {
                            WebMsgBox.Show("Kindly check your User ID.");
                            return;
                        }
                        if (txtCurrentPwd.Text == ds.Tables[0].Rows[0]["Password"].ToString())
                        {
                            proc.SQLExecuteDataset("SP_CHANGEPASSWORD", new SqlParameter()
                            {
                                ParameterName = "@IMODE",
                                Direction = ParameterDirection.Input,
                                SqlDbType = SqlDbType.Int,
                                Value = 1
                            }
                            , new SqlParameter()
                            {
                                ParameterName = "@RSN",
                                Direction = ParameterDirection.Input,
                                SqlDbType = SqlDbType.BigInt,
                                Value = Convert.ToInt64(ds.Tables[0].Rows[0]["RSN"])
                            },
                            new SqlParameter()
                            {
                                ParameterName = "@PWD",
                                Direction = ParameterDirection.Input,
                                SqlDbType = SqlDbType.NVarChar,
                                Value = txtConfirmPwd.Text
                            });
                            WebMsgBox.Show("Password Changed Successfully");
                            //AutoEmail();
                            //InsertUsageLog();
                        }
                        else
                        {
                            WebMsgBox.Show("Kindly check your current password");
                            return;
                        }
                    }
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message);
                }
            }
            else
            {
                WebMsgBox.Show("Error! New password and Confirm Password do not match. Please re-enter.");
            }
        }
        else
        {
            WebMsgBox.Show("Enter Mandatory Field");
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(GetType(), "CloseScript", " window.close();", true);
    }

    //protected void AutoEmail()
    //{
    //    SqlProcs proc = new SqlProcs();
    //    DataSet ds = new DataSet();
    //    MailFormat format = new MailFormat();
    //    bool mailResult = false;
    //    IAMail mail = new IAMail();

    //    try
    //    {
    //        ds = proc.ExecuteSP("SP_GETClientDTLS", new SqlParameter()
    //        {
    //            ParameterName = "@IMODE",
    //            Direction = ParameterDirection.Input,
    //            SqlDbType = SqlDbType.Int,
    //            Value = 1
    //        }, new SqlParameter()
    //        {
    //            ParameterName = "@UserID",
    //            Direction = ParameterDirection.Input,
    //            SqlDbType = SqlDbType.NVarChar,
    //            Value = txtCPUserID.Text.Trim()
    //        });
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            string[] tomail = { ds.Tables[0].Rows[0]["EmailID"].ToString() };
    //            string[] ccmail = { };
    //            mailResult = mail.SendMail(tomail, ccmail, format.ChangePwd(ds.Tables[0].Rows[0]["Name"].ToString(), ds.Tables[0].Rows[0]["PASSWORD"].ToString()),
    //               "eLMS - SOP Viewer - Password changed for user " + ds.Tables[0].Rows[0]["Name"].ToString());
    //            //WebMsgBox.Show("Your current password has been sent to your email id");
    //        }
    //        else
    //        {
    //            WebMsgBox.Show("User not found. Kindly provide correct User ID.");
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}

    //protected void InsertUsageLog()
    //{
    //    SqlProcs sqlobj = new SqlProcs();
    //    sqlobj.ExecuteNonQuery("SP_InsertUsageLog",
    //                                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtCPUserID.Text.Trim() },
    //                                  new SqlParameter() { ParameterName = "@AccessType", SqlDbType = SqlDbType.NVarChar, Value = "PwdChgd" },
    //                                  new SqlParameter() { ParameterName = "@ProgMenuID", SqlDbType = SqlDbType.NVarChar, Value = "PwdChgd" },
    //        //new SqlParameter() { ParameterName = "@SRSN", SqlDbType = SqlDbType.Decimal, Value = "" },
    //                                  new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                                  new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = txtCPUserID.Text.Trim() },
    //                                  new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = txtCPUserID.Text.Trim() });
    //}
    
}