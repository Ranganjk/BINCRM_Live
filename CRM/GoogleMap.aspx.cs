using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GoogleMap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["lat"] != "" && Request.QueryString["lon"] != "")
            {
                //txtlat.Text = Request.QueryString["lat"].ToString();
                //txtlon.Text = Request.QueryString["lon"].ToString();
                hdlat.Value = Request.QueryString["lat"].ToString();
                hdlon.Value = Request.QueryString["lon"].ToString();
                hdcus.Value = Request.QueryString["cus"].ToString();
            }
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
}
