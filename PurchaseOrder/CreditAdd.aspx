<%@ Page Language="C#" MasterPageFile="~/MasterPages/Modal.master" AutoEventWireup="true"
    CodeFile="CreditAdd.aspx.cs" Inherits="CreditAdd" Title="Credit Add" %>

<%@ Register TagPrefix="uc1" TagName="CRV" Src="~/UserControl/CRV.ascx" %>
<%@ Register Src="UserControl/datetimePicker/WebUserControl.ascx" TagName="WebUserControl"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function print() {

            $(".crtoolbar input[src $='print.gif']")[0].click();

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc2:WebUserControl ID="WebUserControl1" runat="server" />
    <div class="modal-body thickbox-modal" style="text-align: left">
        <div class="col-12 col-md-12 col-lg-12">
            <div class="col-12">
                <asp:UpdatePanel ID="lstpanel" runat="server">
                    <ContentTemplate>
                        <div class="contenttext">
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Credit Ref No" class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtCreditReferenceNo" runat="server" CssClass="form-control" Text="Auto Generated" ReadOnly="true"
                                        MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Credit Amount." class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtCreditAmount" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" ID="lblRFCODE" Text="RF CODE" class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtRFCode" runat="server" CssClass="form-control" ReadOnly="true" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Invoice No. " class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Credit Date" class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtCreditDate" type="date" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Remarks" class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label runat="server" Text="Instrument Detail" class="col-sm-3 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtInstrumentDetail" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="msg">
                                <asp:Label ID="lblMsg" runat="server">
                                </asp:Label>
                            </div>
                            <div style="display: none">
                                <uc1:CRV ID="uccrv" runat="server" EnableViewState="true" Visible="true" />
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="uccrv" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div class="modal-footer bg-whitesmoke br">
        <div class="footer" runat="server" id="div1">
            <asp:Button ID="btnSave" CssClass="btn btn-info" OnClientClick="return fnValidate();" runat="server" Text="Save" OnClick="btnSave_Click" />
            <asp:Button ID="btnDelete" CssClass="btn btn-info" runat="server" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
        </div>
    </div>
</asp:Content>
