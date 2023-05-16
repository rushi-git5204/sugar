<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pgeSaleBill_Print.aspx.cs" Inherits="Sugar_Report_pgeSaleBill_Print"  MasterPageFile="~/MasterPage3.master" %>

<%@ MasterType VirtualPath="~/MasterPage3.master" %>
<%@ Register Assembly="CrystalDecisions.Web,Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"> 
<%--    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>--%>
    <title></title>
    <script type="text/javascript">
        function sendPdfToWatsapp(bill_no, content, fileName, instanceid, accesstoken, message, mobile, authKey, mobtxt) {
            debugger;
            // var Opening_Bal =
            var string = mobtxt;
            // var string = document.getElementById("")
            //var string =  $("#<%=txtWhatsapp.ClientID %>").val() == "" ? 0 : $("#<%=txtWhatsapp.ClientID %>").val();
                   var stringArray = (new Function("return [" + string + "];")());
                   var strcountarry = stringArray.length;

                   for (var i = 0; i < strcountarry; i++) {
                       var filenamenew = stringArray[i] + fileName;
                       whatsappApi(bill_no, content, filenamenew, instanceid, accesstoken, message, stringArray[i], authKey);
                   }

               }
        function Print() {
            debugger;
            var dvReport = document.getElementById("printReady");
            for (var i = 0; i < 8; i++) {
                if (i % 2 == 0) {
                    var frame1 = printReady.getElementsByTagName("iframe")[i];
                    if (navigator.appName.indexOf("Chrome") != -1) {
                        frame1.name = frame1.id;
                        window.frames[frame1.id].focus();
                        window.frames[frame1.id].print();
                    }
                    else {
                        var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
                        frameDoc.print();
                    }
                }
            }

        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanelMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdconfirm" runat="server" />
        <div id="printReady">
            <asp:Button ID="btnprintdialog" Text="Print" runat="server" OnClientClick="return Print()" />
            <asp:Button ID="btnPDF" runat="server" Text="Open PDF" Width="80px" OnClientClick="return CheckEmail();"
                OnClick="btnPDF_Click" />

            <asp:Button ID="btnMail" runat="server" Text="Sale PDF" Width="80px" OnClientClick="return CheckEmail();"
                OnClick="btnMail_Click" />
            <asp:TextBox runat="server" ID="txtEmail" Width="300px"></asp:TextBox>

             <asp:Button ID="btnmilltransport" runat="server" Text="Trans PDF" Width="80px" OnClientClick="return CheckEmail();"
                OnClick="btnmilltransport_Click" />
            <asp:TextBox runat="server" ID="txtTransportmail" Width="300px"></asp:TextBox>

             <asp:Button ID="btnpurchmail" runat="server" Text="Refer PDF" Width="80px" OnClientClick="return CheckEmail();"
                OnClick="btnpurchmail_Click" />
            <asp:TextBox runat="server" ID="txtpurmail" Width="300px"></asp:TextBox>

             <asp:Button ID="btnallmail" runat="server" Text=" All Mail" Width="80px" OnClientClick="return CheckEmail();"
                OnClick="btnallmail_Click" />
            <br />
            <br />
            Sale Bill To:
             <asp:TextBox runat="server" ID="txtWhatsapp" Width="150px" placeholder="Enter MobNo" OnTextChanged="txtWhatsapp_TextChanged"  AutoPostBack="True" ></asp:TextBox>
             <asp:Button runat="server" ID="btnWhatsApp" Text="WhatsApp" CssClass="btnHelp" Height="24px"
                    Width="80px" OnClick="btnWhatsApp_Click" />
            Transport :
             <asp:TextBox runat="server" ID="txtTransportWhatsapp" Width="150px" placeholder="Enter MobNo"></asp:TextBox>
            
                           Driver  :
             <asp:TextBox runat="server" ID="txtDriverWhatsapp" Width="150px" placeholder="Enter MobNo"></asp:TextBox>
         <asp:Button runat="server" ID="btnTransportWhatsApp" Text="Transport WhatsApp" CssClass="btnHelp" Height="24px"
                    Width="140px" OnClick="btnTransportWhatsApp_Click" />
                     Refer By:
             <asp:TextBox runat="server" ID="txtrefWhatsapp" Width="150px" placeholder="Enter MobNo"></asp:TextBox>
         <asp:Button runat="server" ID="btnrefWhatsApp" Text="Refer WhatsApp" CssClass="btnHelp" Height="24px"
                    Width="140px" OnClick="btnrefWhatsApp_Click" />   
            <br />
                  Shipped To  :
             <asp:TextBox runat="server" ID="txtShippedWhatsapp" Width="150px" placeholder="Enter MobNo"></asp:TextBox>
         <asp:Button runat="server" ID="btnShippedWhatsApp" Text="Shipped WhatsApp" CssClass="btnHelp" Height="24px"
                    Width="140px" OnClick="btnShippedWhatsApp_Click" />
               <asp:Button runat="server" ID="btnAllWhatsApp" Text="All WhatsApp" CssClass="btnHelp" Height="24px"
                    Width="140px" OnClick="btnAllWhatsApp_Click" />


            <CR:CrystalReportViewer ID="crySaleBill_Print" runat="server" AutoDataBind="false" />
        </div>
 </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
