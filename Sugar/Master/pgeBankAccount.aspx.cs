using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml.Linq;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;

public partial class Sugar_Master_pgeBankAccount : System.Web.UI.Page
{
    #region data section
    string qry = string.Empty;
    string tblPrefix = string.Empty;
    string tblHead = string.Empty;
    string tblDetails = string.Empty;
    string qryCommon = string.Empty;
    string qryAccountList = string.Empty;
    string searchString = string.Empty;
    string strTextBox = string.Empty;
    string qryDisplay = string.Empty;
    string user = string.Empty;
    string isAuthenticate = string.Empty;
    static WebControl objAsp = null;
    string Action = string.Empty;
    int Detail_ID = 2;
    int Ac_Code = 3;
    int ChqCaption = 5;
    int Amount = 6;
    int Narration = 7;
    int Bank_Date = 8;
    int Mark = 9;
    int Cheque_No = 10;
    int Berror = 11;
    int Mobile_No = 12;
    int Check_Detail_Id = 12;
    int acid = 10;
    int Doc_No = 0;
    int Bid = 0;

    DataTable Maindt = null;
    DataRow dr = null;
    int Rowaction = 13;
    int Srno = 14;

    public static SqlConnection con = null;
    public static SqlCommand cmd = null;
    public static SqlTransaction myTran = null;
    string cs = string.Empty;
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            tblPrefix = Session["tblPrefix"].ToString();
            tblHead = "Bank_AccountHead";
            tblDetails = "";
            qryCommon = "qryBankAccount";
            qryAccountList = "qrymstaccountmaster";
            pnlPopup.Style["display"] = "none";
            user = Session["user"].ToString();
            Maindt = new DataTable();
            dr = null;
            Maindt.Columns.Add("Querys", typeof(string));
            dr = Maindt.NewRow();
            cs = ConfigurationManager.ConnectionStrings["sqlconnection"].ConnectionString;
            con = new SqlConnection(cs);
            if (!Page.IsPostBack)
            {
                hdnfyearcode.Value = Session["year"].ToString();
                hdnfcompanycode.Value = Session["Company_Code"].ToString();
                isAuthenticate = Security.Authenticate(tblPrefix, user);
                string User_Type = clsCommon.getString("Select User_Type from tblUser WHERE User_Name='" + user + "'");
                if (isAuthenticate == "1" || User_Type == "A")
                {
                    Action = Request.QueryString["Action"];
                    if (Action == "1")
                    {

                        hdnfDoc_No.Value = Request.QueryString["Doc_No"];
                        pnlPopup.Style["display"] = "none";
                        ViewState["currentTable"] = null;
                        clsButtonNavigation.enableDisable("N");

                        this.makeEmptyForm("N");
                        ViewState["mode"] = "I";
                        this.showLastRecord();
                        this.enableDisableNavigateButtons();
                        setFocusControl(btnEdit);

                        //hdnf.Value = Request.QueryString["saleid"];
                        //pnlPopup.Style["display"] = "none";
                        //ViewState["currentTable"] = null;
                        //clsButtonNavigation.enableDisable("N");
                        //this.makeEmptyForm("N");
                        //ViewState["mode"] = "I";
                        //this.showLastRecord();
                    }
                    else
                    {
                        string docno = string.Empty;
                        clsButtonNavigation.enableDisable("A");
                        ViewState["mode"] = null;
                        ViewState["mode"] = "I";
                        this.makeEmptyForm("A");
                        this.NextNumber();

                        //setFocusControl(txtAC_CODE);
                        // PurcSaleDo_CoomonFields purc = new PurcSaleDo_CoomonFields();

                    }
                    #region oldcode comment
                    //pnlPopup.Style["display"] = "none";
                    //ViewState["currentTable"] = null;
                    //clsButtonNavigation.enableDisable("N");
                    //this.makeEmptyForm("N");
                    //ViewState["mode"] = "I";
                    //if (Session["SB_NO"] != null)
                    //{
                    //    hdnf.Value = Session["SB_NO"].ToString();
                    //    qry = getDisplayQuery();
                    //    this.fetchRecord(qry);

                    //    Session["SB_NO"] = null;
                    //}
                    //else
                    //{
                    //    this.showLastRecord();
                    //}
                    #endregion
                }
                else
                {
                    Response.Redirect("~/UnAuthorized/Unauthorized_User.aspx", false);
                }
            }
            if (objAsp != null)
                System.Web.UI.ScriptManager.GetCurrent(this).SetFocus(objAsp);
            if (hdnfClosePopup.Value == "Close" || hdnfClosePopup.Value == "")
            {
                //pnlPopup.Style["display"] = "none";
            }
            else
            {
                //pnlPopup.Style["display"] = "block";
                objAsp = btnSearch;
            }
            //txtGStno.Text = "27AABHJ9303C1ZM";
        }
        catch
        {
        }

    }

     #region [makeEmptyForm]
    private void makeEmptyForm(string dAction)
    {

        try
        {
            if (dAction == "N")
            {
                foreach (System.Web.UI.Control c in pnlMain.Controls)
                {
                    if (c is System.Web.UI.WebControls.TextBox)
                    {
                        ((System.Web.UI.WebControls.TextBox)c).Text = "";
                        ((System.Web.UI.WebControls.TextBox)c).Enabled = false;
                    }
                    if (c is System.Web.UI.WebControls.Label)
                    {
                        ((System.Web.UI.WebControls.Label)c).Text = "";
                    }
                }
                pnlPopup.Style["display"] = "none";   
                ViewState["currentTable"] = null;

                btnSave.Text = "Save";
                btntxtDoc_No.Text = "Choose No";
                btntxtDoc_No.Enabled = false;
                txtEditDoc_No.Enabled = true;
                lblMsg.Text = string.Empty;
                txtAc_Code.Enabled = false;
                btnAc_Code.Enabled = false;
                txtbankAc_No.Enabled = false;
                txtbankAc_Name.Enabled = false;
                txtIFSC.Enabled = false;
                txtBranch.Enabled = false; 
              
            }
            if (dAction == "A")
            {
                foreach (System.Web.UI.Control c in pnlMain.Controls)
                {
                    if (c is System.Web.UI.WebControls.TextBox)
                    {
                        ((System.Web.UI.WebControls.TextBox)c).Text = "";
                        ((System.Web.UI.WebControls.TextBox)c).Enabled = true;
                    }
                }
                btnSave.Text = "Save";
                btntxtDoc_No.Text = "Change No";
                btntxtDoc_No.Enabled = true;
                txtEditDoc_No.Enabled = false;
                txtDoc_No.Enabled = false; 
                ViewState["currentTable"] = null; 

                txtAc_Code.Enabled = true;
                btnAc_Code.Enabled = true;
                lblAc_Name.Text = string.Empty; 
             
                btnBack.Enabled = false;
                lblDoc_No.Text = string.Empty;
                txtbankAc_No.Enabled = true;
                txtbankAc_Name.Enabled = true;
                txtIFSC.Enabled = true;
                txtBranch.Enabled = true; 
                
            }

            if (dAction == "S")
            {
                foreach (System.Web.UI.Control c in pnlMain.Controls)
                {
                    if (c is System.Web.UI.WebControls.TextBox)
                    {
                        ((System.Web.UI.WebControls.TextBox)c).Enabled = false;
                    }
                }
                btntxtDoc_No.Text = "Choose No";
                btntxtDoc_No.Enabled = false;
                txtEditDoc_No.Enabled = true;
                lblMsg.Text = string.Empty;

                
                txtAc_Code.Enabled = false;  
                txtbankAc_No.Enabled = false;
                txtbankAc_Name.Enabled = false;
                txtIFSC.Enabled = false;
                txtBranch.Enabled = false; 
              
                btnBack.Enabled = true;
            }
            if (dAction == "E")
            {
                foreach (System.Web.UI.Control c in pnlMain.Controls)
                {
                    if (c is System.Web.UI.WebControls.TextBox)
                    {
                        ((System.Web.UI.WebControls.TextBox)c).Enabled = true;
                    }
                }
                btntxtDoc_No.Text = "Choose No";
                btntxtDoc_No.Enabled = true;
                lblMsg.Text = string.Empty;
                #region logic

                txtAc_Code.Enabled = true;
                txtbankAc_No.Enabled = true;
                txtbankAc_Name.Enabled = true;
                txtIFSC.Enabled = true;
                txtBranch.Enabled = true;

                #endregion
                txtEditDoc_No.Enabled = false;
            }

          }
        catch
        {
        }
    }
     #endregion

     #region [showLastRecord]
    private void showLastRecord()
    {
        try
        {
            string qry = string.Empty;
            qry = getDisplayQuery();
            bool recordExist = this.fetchRecord(qry);
            if (recordExist == true)
            {
                //btnEdit.Focus();
                btnAdd.Focus();
            }
            else                            //new code
            {
                btnEdit.Enabled = false;
                btnDelete.Enabled = false;
            }


        }

        catch
        {
        }
    }
     #endregion

    #region [fetchrecord]
    private bool fetchRecord(string qry)
    {
        try
        {
            bool recordExist = false;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = clsDAL.SimpleQuery(qry);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        
                        string comcode = Session["Company_Code"].ToString();
                        if (hdnfcompanycode.Value != comcode)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), " ", "alert('Selected Records company code & current company code is not same !')", true);
                            return false;
                        }

                      
                        hdnfcompanycode.Value = dt.Rows[0]["Company_Code"].ToString();
                        txtDoc_No.Text = dt.Rows[0]["Doc_No"].ToString();
                        hdnfDoc_No.Value = txtDoc_No.Text;
                        hdnfBid.Value = dt.Rows[0]["Bid"].ToString();
                        txtAc_Code.Text = dt.Rows[0]["Ac_Code"].ToString();
                        txtbankAc_No.Text = dt.Rows[0]["Bankac_No"].ToString();
                        txtbankAc_Name.Text = dt.Rows[0]["Bank_Name"].ToString();
                        txtIFSC.Text = dt.Rows[0]["IFSC_Code"].ToString();
                        txtBranch.Text = dt.Rows[0]["Branch"].ToString();
                        lblAc_Name.Text = dt.Rows[0]["Ac_Name_E"].ToString();
                        
                    }
                }
            }
            return recordExist;
        }
        catch
        {
            return false;
        }
    }
    #endregion

    #region [enableDisableNavigateButtons]
    private void enableDisableNavigateButtons()
    {
        #region enable disable previous next buttons
        int RecordCount = 0;
        string query = "";
        query = "select count(*) from " + tblHead + " where company_code=" + Convert.ToInt32(Session["Company_Code"].ToString());
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = clsDAL.SimpleQuery(query);
        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    RecordCount = Convert.ToInt32(dt.Rows[0][0].ToString());
                }
            }
        }
        if (RecordCount != 0 && RecordCount == 1)
        {
            btnFirst.Enabled = true;
            btnPrevious.Enabled = false;
            btnNext.Enabled = false;
            btnLast.Enabled = false;
        }
        else if (RecordCount != 0 && RecordCount > 1)
        {
            btnFirst.Enabled = true;
            btnPrevious.Enabled = false;
            btnNext.Enabled = false;
            btnLast.Enabled = true;
        }
        if (txtDoc_No.Text != string.Empty)
        {
            if (hdnfDoc_No.Value != string.Empty)
            {
                #region check for next or previous record exist or not
                ds = new DataSet();
                dt = new DataTable();
                query = "SELECT top 1 [Doc_No] from " + tblHead +
                    " where Doc_No>" + Convert.ToInt32(hdnfDoc_No.Value) +
                    " and company_code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + "  ORDER BY Doc_No asc  ";
                ds = clsDAL.SimpleQuery(query);
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        dt = ds.Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            //next record exist
                            btnNext.Enabled = true;
                            btnLast.Enabled = true;
                        }
                        else
                        {
                            //next record does not exist
                            btnNext.Enabled = false;
                            btnLast.Enabled = false;
                        }
                    }
                }
                ds = new DataSet();
                dt = new DataTable();
                query = "SELECT top 1 [Doc_No] from " + tblHead + " where Doc_No<" + Convert.ToInt32(hdnfDoc_No.Value) + " and company_code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + "  ORDER BY doc_no asc  ";
                ds = clsDAL.SimpleQuery(query);
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        dt = ds.Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            //previous record exist
                            btnPrevious.Enabled = true;
                            btnFirst.Enabled = true;
                        }
                        else
                        {
                            btnPrevious.Enabled = false;
                            btnFirst.Enabled = false;
                        }
                    }
                }
                #endregion
            }
        }

        #endregion
    }
    #endregion

    #region Generate Next Number
    private void NextNumber()
    {
        try
        {
            int counts = 0;
            counts = Convert.ToInt32(clsCommon.getString("select count(Doc_No) as Doc_No from " + tblHead + " where Company_Code='" + Session["Company_Code"].ToString() + "' "));
            if (counts == 0)
            {
                txtDoc_No.Text = "1";
                Doc_No = 1;
            }
            else
            {
                Doc_No = Convert.ToInt32(clsCommon.getString("SELECT max(Doc_No) as Doc_No from " + tblHead + " where Company_Code='" + Session["Company_Code"].ToString() + "' ")) + 1;
                txtDoc_No.Text = Doc_No.ToString();
            }

            counts = Convert.ToInt32(clsCommon.getString("SELECT count(Bid) as Bid from " + tblHead + " "));
            if (counts == 0)
            {
                lblDoc_No.Text = "1";
                Bid = 1;
            }
            else
            {
                Bid = Convert.ToInt32(clsCommon.getString("SELECT max(Bid) as Bid from " + tblHead)) + 1;
                lblDoc_No.Text = Bid.ToString();
            }
        }
        catch
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), " ", "alert('Next Record Error!')", true);
        }
    }
    #endregion

    #region [setFocusControl]
    private void setFocusControl(WebControl wc)
    {
        objAsp = wc;
        System.Web.UI.ScriptManager.GetCurrent(this).SetFocus(wc);
    }
    #endregion

    #region [txtEditDoc_No_TextChanged]
    protected void txtEditDoc_No_TextChanged(object sender, EventArgs e)
    {
    }
     #endregion

      #region [txtDoc_No_TextChanged]
    protected void txtDoc_No_TextChanged(object sender, EventArgs e)
    {
    }
      #endregion

     #region [btnAddNew Click]
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string check = txtEditDoc_No.Text;
        if (check == string.Empty)
        {
             clsButtonNavigation.enableDisable("A");
            ViewState["mode"] = null;
            ViewState["mode"] = "I";
            this.makeEmptyForm("A");
            setFocusControl(txtDoc_No);
            pnlPopupDetails.Style["display"] = "none";
            //pnlgrdDetail.Enabled = true;
            Int32 Doc_No = Convert.ToInt32(clsCommon.getString("select count(Doc_No) as Doc_No from " + tblHead + "  where Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + ""));

            if (Doc_No != 0)
            {
                int doc_no = Doc_No + 1;
                Doc_No = doc_no;
            }
            else
            {
                Doc_No = 1;
            }
            txtDoc_No.Text = Convert.ToString(Doc_No);
            setFocusControl(txtAc_Code);
        }
        else
        {
            btnCancel_Click(this, new EventArgs());
        }
    }
     #endregion
     #region [btntxtDoc_No_Click]
    protected void btntxtDoc_No_Click(object sender, EventArgs e)
    {
    }
     #endregion

    #region [btnSave_Click]
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (hdnfcompanycode.Value != Session["Company_Code"].ToString())
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), " ", "alert('Selected Records company code & current company code is not same!')", true);
            return;

        }
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "system", "javascript:pagevalidation();", true);

    }
    #endregion
    #region [btnEdit_Click]
    protected void btnEdit_Click(object sender, EventArgs e)
    {

        ViewState["mode"] = null;
        ViewState["mode"] = "U";
        clsButtonNavigation.enableDisable("E");
        this.makeEmptyForm("E");
        txtDoc_No.Enabled = false;
    }
    #endregion
    #region [btnDelete_Click]
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdconfirm.Value == "Yes")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "system", "javascript:DeleteConform();", true);
            }
        }
        catch
        {

        }
    }
    #endregion
       #region [First]
    protected void btnFirst_Click(object sender, EventArgs e)
    {
    }
       #endregion
       #region [btnCancel_Click]
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        hdnfDoc_No.Value = clsCommon.getString("select count(Doc_No) from " + tblHead + " where Company_Code='" + Convert.ToInt32(Session["Company_Code"].ToString()) + "'");
      
        if (hdnfDoc_No.Value != string.Empty)
        {
            string query = getDisplayQuery();
            bool recordExist = this.fetchRecord(query);
        }
        else
        {
            this.showLastRecord();
        }
        string qry = clsCommon.getString("select count(Doc_No) from " + tblHead + " where Company_Code='" + Convert.ToInt32(Session["Company_Code"].ToString()) + "'");
        if (qry != "0")
        {
            clsButtonNavigation.enableDisable("S");
            this.makeEmptyForm("S");
            this.enableDisableNavigateButtons();
        }
        else
        {
            clsButtonNavigation.enableDisable("N");
            this.makeEmptyForm("N");
            this.enableDisableNavigateButtons();
            btnEdit.Enabled = false;
            btnDelete.Enabled = false;
        }
    }
       #endregion

    #region getDisplayQuery
    private string getDisplayQuery()
    {
        //try
        //{
        //    string qryDisplay = " select * from " + qryCommon
        //        + " where Company_Code='" + Convert.ToInt32(Session["Company_Code"].ToString())
        //        + "' and Year_Code=" + Convert.ToInt32(Session["year"].ToString()) + " and Doc_No=" + hdnf.Value;
        //    //" and Year_Code=" + Convert.ToInt32(Session["year"].ToString()) + " and Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString());
        //    return qryDisplay;
        //}
        try
        {
            //string qryDisplay = "select * from " + qryCommon + " where doc_no=" + hdnf.Value + " and Tran_Type='" + trntype + "' and Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + " and Year_Code=" + Convert.ToInt32(Session["year"].ToString());
            string qryDisplay = "select * from " + qryCommon + " where Doc_No=" + hdnfDoc_No.Value + " ";
            return qryDisplay;
        }
        catch
        {
            return "";
        }
    }
    #endregion


    //   #region [fetchrecord]
    //private bool fetchRecord(string qry)
    //{
    //}
    //   #endregion

      #region [Next]
    protected void btnNext_Click(object sender, EventArgs e)
    {
    }
      #endregion
       #region [Previous]
    protected void btnPrevious_Click(object sender, EventArgs e)
    { 
    }
       #endregion
      #region [Last]
    protected void btnLast_Click(object sender, EventArgs e)
    {
    }
      #endregion

      #region [txtAc_Code_TextChanged]
    protected void txtAc_Code_TextChanged(object sender, EventArgs e)
    {
        try
        { 
            hdnfClosePopup.Value = "txtAc_Code";
            strTextBox = "txtAC_CODE";
            btnSearch_Click(sender, e);
            csCalculations();
        }
        catch
        {
        }
    }
      #endregion
    #region [btnAc_Code_Click]
    protected void btnAc_Code_Click(object sender, EventArgs e)
    {
        try
        {
            pnlPopup.Style["display"] = "block";
            hdnfClosePopup.Value = "txtAc_Code";
            btnSearch_Click(sender, e);
        }
        catch
        {
        }
    }
    #endregion
        #region [btnAdddetails_Click]
    protected void btnAdddetails_Click(object sender, EventArgs e)
    {
    }
        #endregion

   
   
    #region [imgBtnClose_Click]
    protected void imgBtnClose_Click(object sender, EventArgs e)
    {
        try
        {
            //hdnfClosePopup.Value = "Close";
            pnlPopup.Style["display"] = "none";
            txtSearchText.Text = string.Empty;
            grdPopup.DataSource = null;
            grdPopup.DataBind();
        }
        catch
        {
        }
    }
    #endregion

      #region [txtSearchText_TextChanged]
    protected void txtSearchText_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (hdnfClosePopup.Value == "Close")
            {
                txtSearchText.Text = string.Empty;
                pnlPopup.Style["display"] = "none";
                grdPopup.DataSource = null;
                grdPopup.DataBind();
                if (objAsp != null)
                    System.Web.UI.ScriptManager.GetCurrent(this).SetFocus(objAsp);
            }
            else
            {
                pnlPopup.Style["display"] = "block";

                searchString = txtSearchText.Text;
                strTextBox = hdnfClosePopup.Value;

                setFocusControl(btnSearch);
            }
        }
        catch
        {
        }
    }
      #endregion

        #region [btnSearch_Click]
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (searchString != string.Empty && strTextBox == hdnfClosePopup.Value)
            {
                txtSearchText.Text = searchString;
            }
            else
            {
                txtSearchText.Text = txtSearchText.Text;
                searchString = txtSearchText.Text;
            }

            if (hdnfClosePopup.Value == "txtAc_Code")
            {
                lblPopupHead.Text = "--Select Party Code--";
                string qry = "select Ac_Code,Ac_Name_E,CityName from " + qryAccountList + " where Ac_type='B' and Locked=0 and Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + "  and ( Ac_Code like '%" + txtSearchText.Text + "%' or Ac_Name_E like '%" + txtSearchText.Text + "%' or CityName like '%" + txtSearchText.Text + "%') order by Ac_Name_E";
                this.showPopup(qry);
            }

       

        }
        catch
        {
        }
    }
        #endregion

    #region [Popup Button Code]
    protected void showPopup(string qry)
    {
        try
        {
            setFocusControl(txtSearchText);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = clsDAL.SimpleQuery(qry);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        grdPopup.DataSource = dt;
                        grdPopup.DataBind();

                        hdHelpPageCount.Value = grdPopup.PageCount.ToString();
                    }
                    else
                    {
                        grdPopup.DataSource = null;
                        grdPopup.DataBind();

                        hdHelpPageCount.Value = "0";
                    }
                }
            }
        }
        catch
        {
        }
    }
    #endregion

       #region [grdPopup_PageIndexChanging]
    protected void grdPopup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdPopup.PageIndex = e.NewPageIndex;
        this.btnSearch_Click(sender, e);
    }
       #endregion

       #region [grdPopup_PageIndexChanging]
    protected void grdPopup_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
            (e.Row.RowState == DataControlRowState.Normal ||
           e.Row.RowState == DataControlRowState.Alternate))
            {
                e.Row.TabIndex = -1;
                e.Row.Attributes["onclick"] = string.Format("javascript:SelectRow(this, {0});", e.Row.RowIndex);
                e.Row.Attributes["onkeydown"] = "javascript:return SelectSibling(event);";
                e.Row.Attributes["onselectstart"] = "javascript:return false;";
                // e.Row.Attributes["onkeyup"] = "javascript:return selectRow(event);";
            }
        }
        catch
        {
            throw;
        }
    }
       #endregion

      #region [grdPopup_RowDataBound]
    protected void grdPopup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string v = hdnfClosePopup.Value;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (v == "txtAc_Code")
            {
                e.Row.Cells[0].Width = new Unit("100px");
                e.Row.Cells[1].Width = new Unit("400px");
            }
            else
            {
                e.Row.Cells[0].Width = new Unit("100px");
                e.Row.Cells[1].Width = new Unit("400px");
                e.Row.Cells[2].Width = new Unit("200px");
            }
        }
    }
      #endregion

    #region [Account Master Popup Button Code]
    protected void showPopupAccountMaster(string qry)
    {
        try
        {
            setFocusControl(txtSearchText);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = clsDAL.myaccountmaster(qry);

            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        grdPopup.DataSource = dt;
                        grdPopup.DataBind();
                        hdHelpPageCount.Value = grdPopup.PageCount.ToString();
                        pnlPopup.Style["display"] = "block";
                    }
                    else
                    {
                        grdPopup.DataSource = null;
                        grdPopup.DataBind();
                        hdHelpPageCount.Value = "0";
                        pnlPopup.Style["display"] = "block";
                    }
                }
            }
        }
        catch
        {
        }
    }
    #endregion

    #region csCalculations
    private void csCalculations()
    {
        try
        {
            if (strTextBox == "txtAC_CODE")
            {
                string AcName = string.Empty;
                if (txtAc_Code.Text != string.Empty)
                {
                    searchString = txtAc_Code.Text;
                    if (!clsCommon.isStringIsNumeric(searchString))
                    {
                        btnAc_Code_Click(this, new EventArgs());
                    }
                    else
                    {
                        string qry = "";
                        hdnfacid.Value = clsCommon.getString("select accoid from qrymstaccountmaster where ac_code=" + txtAc_Code.Text + " and Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString()) + "");
                        qry = "select Ac_Name_E from " + qryAccountList + " where Ac_Code=" + txtAc_Code.Text + " and Company_Code=" + Convert.ToInt32(Session["Company_Code"].ToString());
                        AcName = clsCommon.getString(qry);

                        if (AcName != string.Empty)
                        {
                            lblAc_Name.Text = AcName;
                            setFocusControl(txtbankAc_No);
                        }
                        else
                        {
                            lblAc_Name.Text = string.Empty;
                            txtAc_Code.Text = string.Empty;
                            setFocusControl(txtAc_Code);
                        }
                    }
                }
                else
                {
                    setFocusControl(txtAc_Code);
                }
            }


            if (strTextBox == "txtAc_Code")
            {
                setFocusControl(txtbankAc_No);
            }

            if (strTextBox == "txtbankAc_No")
            {

                setFocusControl(btnSave);
            }

          
        }
        catch
        {
        }
    } 
    #endregion
}