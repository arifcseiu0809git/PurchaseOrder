#region library
using System;

#endregion
public partial class CreditAdd : System.Web.UI.Page
{
    #region public properties and method
    protected string editMode
    {
        get
        {
            return ViewState["editMode"].ToString();
        }
        set
        {
            ViewState["editMode"] = value;
        }
    }
    protected int Id
    {
        get
        {
            return (int)ViewState["Id"];
        }
        set
        {
            ViewState["Id"] = value;
        }
    }
    protected int RFRAISERID
    {
        get
        {
            return (int)ViewState["RFRAISERID"];
        }
        set
        {
            ViewState["RFRAISERID"] = value;
        }
    }
    protected string INVOICENO
    {
        get
        {
            return (string)ViewState["INVOICENO"];
        }
        set
        {
            ViewState["INVOICENO"] = value;
        }
    }

    protected int RFId
    {
        get
        {
            return (int)ViewState["RFId"];
        }
        set
        {
            ViewState["RFId"] = value;
        }
    }




    
    #endregion
    #region page load
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (!Permissions.CreditAdd)
            {
                MsgUtility.showNotPermittedMsg(this.Page);
                return;
            }

            editMode = "add";
            RFId = Id = -1;
            if (!string.IsNullOrEmpty(Request["Id"]))
            {
                Id = int.Parse(Request["Id"]);
                editMode = "edit";
            }
            else if (!string.IsNullOrEmpty(Request["RFId"]))
            {
                RFId = int.Parse(Request["RFId"]);
                editMode = "add";
            }

            PopulateData();
        }
    }

    #endregion
    #region button click
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int ErrorCode = SaveData();
        MsgUtility.msg(editMode, ErrorCode, "Credit", this, lblMsg, "");
        if (editMode == "add")
        {
            using (PaymentServices.Service ps = new PaymentServices.Service())
            {
                POS.DAL.Credit c = new POS.DAL.Credit();
                c.CREDITID = ErrorCode;


                if (ErrorCode >= 0)
                {
                    btnSave.Visible = false;
                    ClearData();
                    c = ps.CreditGet(Convert.ToInt32(c.CENTERID), Convert.ToInt32(c.CREDITID), c.CREDITNO, -1, "", "", DateTime.MaxValue, DateTime.MinValue)[0];
                    txtCreditReferenceNo.Text = c.CREDITNO;
                    txtInvoiceNo.Text = c.INVOICENO;
                    // ps.CreditGet(Convert.ToInt32(c.CENTERID),Convert.ToInt32(c.CREDITID), c.CREDITNO,-1,"","",DateTime.MaxValue,DateTime.MinValue)[0].INVOICENO;
                }
            }
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        PaymentServices.Service service = new PaymentServices.Service();
        try
        {

            //find tellerID
            POS.DAL.Credit newCREDIT = new POS.DAL.Credit();
            newCREDIT.CREDITID = Id;
            newCREDIT.INVOICENO = INVOICENO;


            POS.DAL.Credit list = service.CreditGetById(Convert.ToInt32(newCREDIT.CREDITID));
            if (list != null)
            {

                newCREDIT.CREDITDATE = list.CREDITDATE;
                newCREDIT.CREDITAMOUNT = list.CREDITAMOUNT;
            }
            //
            //CREDIT.TELLERID = 
            int ErrorCode = service.CreditDelete(newCREDIT);
            MsgUtility.msg("Delete", ErrorCode, "Credit", this, lblMsg, "");
        }
        catch (Exception ex)
        {
            lblMsg.Text = Resources.ErrorMsg.UnsuccessfullyDeleted + "Crdit";
        }
        finally
        {
            service.Dispose();
        }
    }
  
    
    #endregion
    #region user define function
    private int SaveData()
    {
        int i = -1;
        using (PaymentServices.Service service = new PaymentServices.Service())
        {
            POS.DAL.Credit newCREDIT = new POS.DAL.Credit();
            newCREDIT.CREDITNO = txtCreditReferenceNo.Text.Trim();



            newCREDIT.RFID = RFId;
            newCREDIT.CENTERID = LoginInfo.Current.CenterId;


            newCREDIT.CENTERCODE = LoginInfo.Current.CenterCode;

            newCREDIT.RFRAISERID = RFRAISERID;
            newCREDIT.CREDITAMOUNT = Convert.ToDecimal(txtCreditAmount.Text);
            try
            {
                newCREDIT.CREDITDATE = Convert.ToDateTime(txtCreditDate.Text);
            }
            catch
            {
                newCREDIT.CREDITDATE = DateTime.MinValue;
            }
            newCREDIT.CREDITID = Id;



            newCREDIT.INSTRUMENTDETAIL = txtInstrumentDetail.Text;
            newCREDIT.REMARKS = txtRemarks.Text;


            if (editMode == "edit")
            {
                newCREDIT.INVOICENO = txtInvoiceNo.Text.Trim();
                newCREDIT.LASTUPDATEBY = LoginInfo.Current.UserName;

                i = service.CreditModify(newCREDIT);
            }
            else
            {

                newCREDIT.CREATEBYUSER = LoginInfo.Current.UserName;

                Id = i = service.CreditAdd(newCREDIT);



            }
        }
        return Id;
    }
    private void PopulateData()
    {

        POS.DAL.Credit list = null;
        
        if (editMode.ToLower() == "edit")
        {

            
            
            POS.DAL.Credit newCREDIT = new POS.DAL.Credit();
            newCREDIT.CREDITID = Id;

            using (PaymentServices.Service service = new PaymentServices.Service())
            {
                list = service.CreditGetById(Id);
            }
            if (list !=null)
            {
                INVOICENO = list.INVOICENO;
             //   txtCREDITReferenceNo.Text = list[0].CREDITREFNO;
           
               // txtCREDITDate.Text = list[0].CREDITDATE.ToString("yyyy-MM-dd");


                txtCreditDate.Text = list.CREDITDATE.ToString("yyyy-MM-dd");
                txtCreditReferenceNo.Text = list.CREDITNO;
           
                txtCreditAmount.Text = list.CREDITAMOUNT.ToString("N");
                txtRemarks.Text = list.REMARKS;
                txtInstrumentDetail.Text = list.INSTRUMENTDETAIL;

                txtRFCode.Text = list.RFCODE;
             
                   
                try
                {
                    RFRAISERID = Convert.ToInt32(list.RFRAISERID);
                 
                    
                    
                }
                catch { }
                txtInvoiceNo.Text = list.INVOICENO;


            }
            btnDelete.Visible = Permissions.CreditDelete;
            //btnSave.Visible = Permissions.CREDITModify;
            txtCreditAmount.Enabled = false;
        }
        else
        {




            if (RFId > 0)
            {
                using (RFServices.Service1 rfservice = new RFServices.Service1())
                {
                    POS.DAL.RFMain rf = rfservice.RFMasterGetById(RFId);

                    txtCreditAmount.Text = rf.RFTotal.ToString("N");
                    txtCreditAmount.ReadOnly = true;

                    txtRFCode.Text = rf.RFCODE;
                    txtInvoiceNo.Text = "Auto Generated";

                    RFRAISERID = Convert.ToInt32(rf.RFRAISERID);
                }
            }
            else
            {
                txtRFCode.Text = "";
                txtRFCode.Visible = false;


                lblRFCODE.Visible = false;

            }


         
            txtCreditDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            LoginInfo _current = (LoginInfo)Session["LoginInfo"];

          
            
           
        }
        
       
    }
    private void ClearData()
    {
        
        
        //txtCreditReferenceNo.Text = "";
        
        
        
        
       // txtCreditAmount.Text = "";
        
        
       // txtInvoiceNo.Text = "";
       
        RFId = 0;
    }


    private void ClearTempData()
    {
        
       
        //txtCreditReferenceNo.Text = "";
       
       


    }
  
    #endregion


}
