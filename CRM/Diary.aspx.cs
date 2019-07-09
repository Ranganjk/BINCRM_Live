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

public partial class Diary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();

                return;
            }

            dvAP.Visible = false;

            LoadProspectDiary(Session["ProspectRSN"].ToString());
        }
    }

    protected void LoadProspectDiary(string prospectrsn)
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsProspectDiary = new DataSet();
        dsProspectDiary = sqlobj.SQLExecuteDataset("SP_GetProspectDiary", new SqlParameter() { ParameterName = "@ProspectRSN", SqlDbType = SqlDbType.NVarChar, Value = prospectrsn.ToString() });


        if (dsProspectDiary.Tables[0].Rows.Count > 0)
        {


            lbldiaryheadName.Text = dsProspectDiary.Tables[0].Rows[0]["name"].ToString();


            lbldiaryheadStatus.Text = " Status:" + dsProspectDiary.Tables[0].Rows[0]["Status"].ToString();


            lbldiaryheadType.Text = " Type:" + dsProspectDiary.Tables[0].Rows[0]["Type"].ToString();

            gvDiary.DataSource = dsProspectDiary;
            gvDiary.DataBind();

            MergeGrid();
        }

    }

    protected void MergeGrid()
    {
        //for (int i = gvDiary.Rows.Count - 1; i > 0; i--)
        //{
        //    GridViewRow row = gvDiary.Rows[i];
        //    GridViewRow previousRow = gvDiary.Rows[i - 1];
        //    for (int j = 0; j < 1; j++)
        //    {
        //        if (row.Cells[j].Text == previousRow.Cells[j].Text)
        //        {
        //            if (previousRow.Cells[j].RowSpan == 0)
        //            {
        //                if (row.Cells[j].RowSpan == 0)
        //                {
        //                    previousRow.Cells[j].RowSpan += 2;
        //                }
        //                else
        //                {
        //                    previousRow.Cells[j].RowSpan = row.Cells[j].RowSpan + 1;
        //                }
        //                row.Cells[j].Visible = false;
        //            }
        //        }
        //    }
        //}


        for (int i = gvDiary.Rows.Count - 1; i > 0; i--)
        {
            GridViewRow row = gvDiary.Rows[i];
            GridViewRow previousRow = gvDiary.Rows[i - 1];
            for (int j = 0; j < row.Cells.Count - 1; j++)
            {
                //Define what index on your template field cell that contain same value
                if (((LinkButton)row.Cells[0].FindControl("lnktaskid")).Text == ((LinkButton)previousRow.Cells[0].FindControl("lnktaskid")).Text)
                {
                    if (previousRow.Cells[0].RowSpan == 0)
                    {
                        if (row.Cells[0].RowSpan == 0)
                        {
                            previousRow.Cells[0].RowSpan += 2;
                        }
                        else
                        {
                            previousRow.Cells[0].RowSpan = row.Cells[0].RowSpan + 1;
                        }
                        row.Cells[0].Visible = false;
                    }
                }
            }
        }

    }
    protected void onDataBound(object sender, EventArgs e)
    {

    }

    protected void OnDiaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvDiary.PageIndex = e.NewPageIndex;
        LoadProspectDiary(Session["ProspectRSN"].ToString());
        //rwDiary.Visible = true;
    }


    protected void gvDiary_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                //LinkButton  lb = (LinkButton)e.CommandSource;
                //GridViewRow myrow = (GridViewRow)lb.Parent.Parent;
                //GridView mygrid = (GridView)sender;

                SQLProcs sqlobj = new SQLProcs();
                DataSet dsCompanyInformation = new DataSet();

                dsCompanyInformation = sqlobj.SQLExecuteDataset("sp_LoadCompanyInformation");

                if (dsCompanyInformation.Tables[0].Rows.Count > 0)
                {
                    string strISCM = dsCompanyInformation.Tables[0].Rows[0]["ISCM"].ToString();

                    if (strISCM == "True")
                    {



                        string strtaskRSN = gvDiary.DataKeys[index].Value.ToString();

                        Session["TaskRSN"] = strtaskRSN.ToString();

                        lblapmsg.Text = "#" + " " + strtaskRSN.ToString() + " " + "Additional Particulars";

                        // LoadWorkDetails

                        LoadMoreInfo();
                    }
                }
                dsCompanyInformation.Dispose();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadMoreInfo()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsMoreInfo = sqlobj.SQLExecuteDataset("SP_Loadmoreinfo",
            new SqlParameter() { ParameterName = "@TaskID", SqlDbType = SqlDbType.BigInt, Value = Session["TaskRSN"].ToString() });

        if (dsMoreInfo.Tables[0].Rows.Count > 0)
        {
            gvMoreinfo.DataSource = dsMoreInfo;
            gvMoreinfo.DataBind();

            dvAP.Visible = true;

        }
        else
        {
            gvMoreinfo.DataSource = null;
            gvMoreinfo.DataBind();

            dvAP.Visible = false;

        }

        dsMoreInfo.Dispose();
    }
}