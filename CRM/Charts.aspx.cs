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
using System.Data.OleDb;


public partial class Charts : System.Web.UI.Page
{
    SQLProcs sqlobj = new SQLProcs();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            UserMenuLog uml = new UserMenuLog();
            uml.InsertUserMenuLog(Session["UserID"].ToString(), "Charts", DateTime.Now);

            divLeadSummary.Visible = false;
            divMR5.Visible = false;
            string strUserID = Session["UserID"].ToString();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        divLeadSummary.Visible = true;
        divMR5.Visible = false;
        LoadLeadSourceSummary();
        LoadLeadStatusSummary();
        LoadLeadCategorySummary();
        LoadCampaignSummary();
    }
    protected void btnchart_Click(object sender, EventArgs e)
    {
        divLeadSummary.Visible = false;
        divMR5.Visible = true;
        CLoadLeadSourceSummary();
        CLoadCampaignSummary();
        CLoadReferenceSummary();
    }
    private void CLoadLeadSourceSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_CLeadSummary");
        dsLeadSourceSummaryTotal = sqlobj.SQLExecuteDataset("SP_CLeadSummaryTotal");
        dsLeadSourceSummaryGraph = sqlobj.SQLExecuteDataset("sp_Customerleadsummarygraph");


        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            gvCLeadSourceSummary.DataSource = dsLeadSourceSummary;
            gvCLeadSourceSummary.DataBind();

            gvCLeadSourceSummaryTotal.DataSource = dsLeadSourceSummaryTotal;
            gvCLeadSourceSummaryTotal.DataBind();

            chartcustomerleadsummary.DataSource = dsLeadSourceSummaryGraph;
            chartcustomerleadsummary.DataBind();


            HighlightColor(gvCLeadSourceSummary, 2);


        }
        else
        {
            gvCLeadSourceSummary.DataSource = null;
            gvCLeadSourceSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }

    private void CLoadCampaignSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCampaignSummary = new DataSet();
        DataSet dsCampaignSummaryTotal = new DataSet();
        DataSet dsCampaignSummaryGraph = new DataSet();

        dsCampaignSummary = sqlobj.SQLExecuteDataset("SP_CCampaignSummary");
        dsCampaignSummaryTotal = sqlobj.SQLExecuteDataset("SP_CCampaignSummaryTotal");
        dsCampaignSummaryGraph = sqlobj.SQLExecuteDataset("sp_customercampaignsummarygraph");

        if (dsCampaignSummary.Tables[0].Rows.Count != 0)
        {
            gvCCampaignSummary.DataSource = dsCampaignSummary;
            gvCCampaignSummary.DataBind();

            gvCCampaignSummaryTotal.DataSource = dsCampaignSummaryTotal;
            gvCCampaignSummaryTotal.DataBind();

            chartcustomercampaignsummary.DataSource = dsCampaignSummaryGraph;
            chartcustomercampaignsummary.DataBind();

            HighlightColor(gvCCampaignSummary, 2);
        }
        else
        {
            gvCCampaignSummary.DataSource = null;
            gvCCampaignSummary.DataBind();
        }

        dsCampaignSummary.Dispose();
    }

    private void HighlightColor(GridView gvname, int cellno)
    {
        double startingvalue = 0;
        double checkvalue = 0;
        Int32 previousindex = 0;
        double finalvalue = 0;

        foreach (GridViewRow row in gvname.Rows)
        {

            Int32 ri = row.RowIndex;

            if (ri == 0)
            {
                startingvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);
                gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;
            }
            if (ri != 0)
            {
                checkvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

                if (checkvalue != 0)
                {

                    if (checkvalue > startingvalue)
                    {
                        gvname.Rows[previousindex].BackColor = Color.White;

                        gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;

                        finalvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

                        startingvalue = finalvalue;

                        Session["FinalValue"] = finalvalue;

                        previousindex = ri;


                    }
                }
            }

        }

        foreach (GridViewRow row in gvname.Rows)
        {
            Int32 ri = row.RowIndex;

            startingvalue = Convert.ToDouble(gvname.Rows[ri].Cells[cellno].Text);

            if (Session["FinalValue"] != null)
            {
                finalvalue = Convert.ToDouble(Session["FinalValue"].ToString());

                if (finalvalue == startingvalue)
                {
                    gvname.Rows[ri].BackColor = System.Drawing.Color.Yellow;
                }
            }
        }
    }
    private void CLoadReferenceSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsReferenceSummary = new DataSet();
        DataSet dsReferenceSummaryTotal = new DataSet();
        DataSet dsReferenceSummaryGraph = new DataSet();


        dsReferenceSummary = sqlobj.SQLExecuteDataset("SP_CReferenceSummary");

        dsReferenceSummaryTotal = sqlobj.SQLExecuteDataset("SP_CReferenceSummaryTotal");

        dsReferenceSummaryGraph = sqlobj.SQLExecuteDataset("SP_Customerreferencesummarygraph");

        if (dsReferenceSummary.Tables[0].Rows.Count != 0)
        {
            gvCReferenceSummary.DataSource = dsReferenceSummary;
            gvCReferenceSummary.DataBind();

            gvCReferenceSummaryTotal.DataSource = dsReferenceSummaryTotal;
            gvCReferenceSummaryTotal.DataBind();

            chartcustomerreferencesummary.DataSource = dsReferenceSummaryGraph;
            chartcustomerreferencesummary.DataBind();

            HighlightColor(gvCReferenceSummary, 2);
        }
        else
        {
            gvCReferenceSummary.DataSource = null;
            gvCReferenceSummary.DataBind();
        }

        dsReferenceSummary.Dispose();
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageNTaskList.aspx");
    }
    private void LoadCampaignSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsCampaignSummary = new DataSet();
        DataSet dsCampaignSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsCampaignSummary = sqlobj.SQLExecuteDataset("SP_CampaignSummary");
        //dsCampaignSummaryTotal = sqlobj.SQLExecuteDataset("SP_CampaignSummaryTotal");
        dsLeadSourceSummaryGraph = sqlobj.SQLExecuteDataset("sp_campaignsummarygraph");

        if (dsCampaignSummary.Tables[0].Rows.Count != 0)
        {
            gvCampaignSummary.DataSource = dsCampaignSummary;
            gvCampaignSummary.DataBind();

            gvCampaignSummary.ShowFooter = true;
            gvCampaignSummary.FooterRow.Cells[0].Text = "Total";
            gvCampaignSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvCampaignSummary.FooterRow.Cells[1].Text = dsCampaignSummary.Tables[0].Compute("sum(Sofar)", "").ToString();
            gvCampaignSummary.FooterRow.Cells[3].Text = dsCampaignSummary.Tables[0].Compute("sum(InLast7days)", "").ToString();
            gvCampaignSummary.FooterRow.Cells[4].Text = dsCampaignSummary.Tables[0].Compute("sum(QLD)", "").ToString();

            //gvCampaignSummaryTotal.DataSource = dsCampaignSummaryTotal;
            //gvCampaignSummaryTotal.DataBind();

            chartcampaignsummary.DataSource = dsLeadSourceSummaryGraph;
            chartcampaignsummary.DataBind();

            // HighlightColor(gvCampaignSummary, 2);
        }
        else
        {
            gvCampaignSummary.DataSource = null;
            gvCampaignSummary.DataBind();
        }

        dsCampaignSummary.Dispose();
    }
    private void LoadLeadCategorySummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadCategorySummary = new DataSet();
        DataSet dsLeadCategorySummaryTotal = new DataSet();
        DataSet dsLeadCategorySummaryGraph = new DataSet();

        dsLeadCategorySummary = sqlobj.SQLExecuteDataset("SP_GetCategoryMain");
        // dsLeadCategorySummaryTotal = sqlobj.SQLExecuteDataset("SP_GetCategoryTotal");
        dsLeadCategorySummaryGraph = sqlobj.SQLExecuteDataset("SP_CategoryGraph");

        if (dsLeadCategorySummary.Tables[0].Rows.Count != 0)
        {
            gvLeadCategorySummary.DataSource = dsLeadCategorySummary;
            gvLeadCategorySummary.DataBind();


            gvLeadCategorySummary.ShowFooter = true;
            gvLeadCategorySummary.FooterRow.Cells[0].Text = "Total";
            gvLeadCategorySummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;

            gvLeadCategorySummary.FooterRow.Cells[1].Text = dsLeadCategorySummary.Tables[0].Compute("sum(HotLeads)", "").ToString();
            gvLeadCategorySummary.FooterRow.Cells[2].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Customers)", "").ToString();
            gvLeadCategorySummary.FooterRow.Cells[3].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Vendors)", "").ToString();
            gvLeadCategorySummary.FooterRow.Cells[4].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Others)", "").ToString();

            gvLeadCategorySummary.FooterRow.HorizontalAlign = HorizontalAlign.Center;

            //gvLeadCategorySummary.FooterRow.Cells[1].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Indians)", "").ToString();
            //gvLeadCategorySummary.FooterRow.Cells[2].Text = dsLeadCategorySummary.Tables[0].Compute("sum(Others)", "").ToString();


            //string[] colNames={"Indians","Others"};
            //DataView dvleadcategory = new DataView(dsLeadCategorySummary.Tables[0]);
            //DataTable dtLeadSummaryGraph = dvleadcategory.ToTable(true, colNames);

            //Comment by Prakash.M
            //gvCategorySummaryTotal.DataSource = dsLeadCategorySummaryTotal;
            //gvCategorySummaryTotal.DataBind();

            chartleadcategorysummary.DataSource = dsLeadCategorySummaryGraph;
            chartleadcategorysummary.DataBind();

            // HighlightColor(gvLeadStatusSummary, 1);


        }
        else
        {
            gvLeadCategorySummary.DataSource = null;
            gvLeadCategorySummary.DataBind();
        }

        dsLeadCategorySummary.Dispose();

    }
    private void LoadLeadStatusSummary()
    {

        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_LeadStatusSummary");
        //dsLeadSourceSummaryTotal = sqlobj.SQLExecuteDataset("SP_LeadStatusSummaryTotal");
        dsLeadSourceSummaryGraph = sqlobj.SQLExecuteDataset("sp_leadstatussummarygraph");

        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            gvLeadStatusSummary.DataSource = dsLeadSourceSummary;
            gvLeadStatusSummary.DataBind();

            gvLeadStatusSummary.ShowFooter = true;
            gvLeadStatusSummary.FooterRow.Cells[0].Text = "Total";
            gvLeadStatusSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvLeadStatusSummary.FooterRow.Cells[1].Text = dsLeadSourceSummary.Tables[0].Compute("sum(StatusCount)", "").ToString();

            //gvLeadStatusSummaryTotal.DataSource = dsLeadSourceSummaryTotal;
            //gvLeadStatusSummaryTotal.DataBind();

            chartleadstatussummary.DataSource = dsLeadSourceSummaryGraph;
            chartleadstatussummary.DataBind();

            // HighlightColor(gvLeadStatusSummary, 1);


        }
        else
        {
            gvLeadStatusSummary.DataSource = null;
            gvLeadStatusSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }
    private void LoadLeadSourceSummary()
    {
        SQLProcs sqlobj = new SQLProcs();
        DataSet dsLeadSourceSummary = new DataSet();
        DataSet dsLeadSourceSummaryTotal = new DataSet();
        DataSet dsLeadSourceSummaryGraph = new DataSet();

        dsLeadSourceSummary = sqlobj.SQLExecuteDataset("SP_LeadSummary");
        //dsLeadSourceSummaryTotal = sqlobj.SQLExecuteDataset("SP_LeadSummaryTotal");
        dsLeadSourceSummaryGraph = sqlobj.SQLExecuteDataset("sp_leadsummarygraph");

        if (dsLeadSourceSummary.Tables[0].Rows.Count != 0)
        {
            gvLeadSourceSummary.DataSource = dsLeadSourceSummary;
            gvLeadSourceSummary.DataBind();

            gvLeadSourceSummary.ShowFooter = true;
            gvLeadSourceSummary.FooterRow.Cells[0].Text = "Total";
            gvLeadSourceSummary.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Left;
            gvLeadSourceSummary.FooterRow.Cells[1].Text = dsLeadSourceSummary.Tables[0].Compute("sum(LeadCount)", "").ToString();
            gvLeadSourceSummary.FooterRow.Cells[3].Text = dsLeadSourceSummary.Tables[0].Compute("sum(InLast7Days)", "").ToString();
            gvLeadSourceSummary.FooterRow.Cells[4].Text = dsLeadSourceSummary.Tables[0].Compute("sum(QLD)", "").ToString();

            chartLeadSummary.DataSource = dsLeadSourceSummaryGraph;
            chartLeadSummary.DataBind();

            //gvLeadSourceSummaryTotal.DataSource = dsLeadSourceSummaryTotal;
            //gvLeadSourceSummaryTotal.DataBind();


            // HighlightColor(gvLeadSourceSummary, 2);


        }
        else
        {
            gvLeadSourceSummary.DataSource = null;
            gvLeadSourceSummary.DataBind();
        }

        dsLeadSourceSummary.Dispose();

    }
    protected void onLeadSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvLeadSourceSummary.PageIndex = e.NewPageIndex;
        LoadLeadSourceSummary();
    }
    protected void btnimgLedStatusExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadStatusSummary, gvLeadStatusSummaryTotal };
        Export("LeadStatusSummary.xls", gvList);
    }
    protected void btnimgLedSrcExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadSourceSummary, gvLeadSourceSummaryTotal };
        Export("LeadSourceSummary.xls", gvList);
    }
    protected void btnimgLeadCategoryExport_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvLeadCategorySummary };
        Export("LeadCategorySummary.xls", gvList);
    }
    protected void btnimgCamSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCampaignSummary, gvCampaignSummaryTotal };
        Export("CampaignSummary.xls", gvList);
    }
    protected void btnimgCLedSrcExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCLeadSourceSummary, gvCLeadSourceSummaryTotal };
        Export("CustomerLeadSourceSummary.xls", gvList);
    }
    protected void btnimgCCamSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        GridView[] gvList = new GridView[] { gvCCampaignSummary, gvCCampaignSummaryTotal };
        Export("CustomerCampaignSummary.xls", gvList);
    }
    protected void onReferenceSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        //gvReferenceSummary.PageIndex = e.NewPageIndex;
        //LoadReferenceSummary();
    }
    protected void btnimgCRefSumExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        //GridView[] gvList = new GridView[] { gvReferenceSummary, gvReferenceSummaryTotal };
        //Export("CustomerReferenceSummary.xls", gvList);
    }
    protected void onCampaignSummaryPaging(object sender, GridViewPageEventArgs e)
    {
        gvCampaignSummary.PageIndex = e.NewPageIndex;
        LoadCampaignSummary();
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
            //   add each of the data rows to the table




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
}