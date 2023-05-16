<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pgeBankAccount.aspx.cs" Inherits="Sugar_Master_pgeBankAccount" %>

<%@ MasterType VirtualPath="~/MasterPage2.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script type="text/javascript" language="javascript">
            debugger;
            document.addEventListener('keyup', function (event) {
                if (event.defaultPrevented) {
                    return;
                }

                var key = event.key || event.keyCode;

                if (key === 'Escape' || key === 'Esc' || key === 27) {
                    //                doWhateverYouWantNowThatYourKeyWasHit();
                    debugger;
                    document.getElementById("<%=pnlPopup.ClientID %>").style.display = "none";
                var hdnfClosePopupValue = document.getElementById("<%= hdnfClosePopup.ClientID %>").value;
                    if (hdnfClosePopupValue == "txtAc_Code") {
                    document.getElementById("<%=txtAc_Code.ClientID %>").focus();
                }
                
                document.getElementById("<%=txtSearchText.ClientID %>").value = "";
                document.getElementById("<%= hdnfClosePopup.ClientID %>").value = "Close";
            }
        });
    </script>

       <script type="text/javascript" language="javascript">
           var SelectedRow = null;
           var SelectedRowIndex = null;
           var UpperBound = null;
           var LowerBound = null;
           function SelectSibling(e) {
               var e = e ? e : window.event;
               var KeyCode = e.which ? e.which : e.keyCode;
               if (KeyCode == 40) {
                   SelectRow(SelectedRow.nextSibling, SelectedRowIndex + 1);
               }
               else if (KeyCode == 38) {
                   SelectRow(SelectedRow.previousSibling, SelectedRowIndex - 1);
               }
               else if (KeyCode == 13) {
                   document.getElementById("<%=pnlPopup.ClientID %>").style.display = "none";
                document.getElementById("<%=txtSearchText.ClientID %>").value = "";
                var hdnfClosePopupValue = document.getElementById("<%= hdnfClosePopup.ClientID %>").value;
                var grid = document.getElementById("<%= grdPopup.ClientID %>");
                document.getElementById("<%= hdnfClosePopup.ClientID %>").value = "Close";

                var pageCount = document.getElementById("<%= hdHelpPageCount.ClientID %>").value;


                pageCount = parseInt(pageCount);
                if (pageCount > 1) {
                    SelectedRowIndex = SelectedRowIndex + 1;
                }

                if (hdnfClosePopupValue == "txtAc_Code") {
                    document.getElementById("<%=txtAc_Code.ClientID %>").value = grid.rows[SelectedRowIndex + 1].cells[0].innerText;
                    document.getElementById("<%=lblAc_Name.ClientID %>").innerText = grid.rows[SelectedRowIndex + 1].cells[1].innerText;
                    document.getElementById("<%=txtAc_Code.ClientID %>").focus();
                } 
            }
}
function SelectRow(CurrentRow, RowIndex) {
    UpperBound = parseInt('<%= this.grdPopup.Rows.Count %>') - 1;
            LowerBound = 0;
            if (SelectedRow == CurrentRow || RowIndex > UpperBound || RowIndex < LowerBound)
                if (SelectedRow != null) {
                    SelectedRow.style.backgroundColor = SelectedRow.originalBackgroundColor;
                    SelectedRow.style.color = SelectedRow.originalForeColor;
                }
            if (CurrentRow != null) {
                CurrentRow.originalBackgroundColor = CurrentRow.style.backgroundColor;
                CurrentRow.originalForeColor = CurrentRow.style.color;
                CurrentRow.style.backgroundColor = '#DCFC5C';
                CurrentRow.style.color = 'Black';
            }
            SelectedRow = CurrentRow;
            SelectedRowIndex = RowIndex;
            setTimeout("SelectedRow.focus();", 0);
        }
    </script>
    <script type="text/javascript">
        debugger;
        function AC_Code(e) {
            debugger;
            if (e.keyCode == 112) {
                debugger;
                e.preventDefault();
                $("#<%=pnlPopup.ClientID %>").show();
                $("#<%=btnAc_Code.ClientID %>").click();

            }
            if (e.keyCode == 9) {
                e.preventDefault();
                var unit = $("#<%=txtAc_Code.ClientID %>").val();

                unit = "0" + unit;
                $("#<%=txtAc_Code.ClientID %>").val(unit);
                __doPostBack("txtAc_Code", "TextChanged");

            }

        }
        </script>
       <script type="text/javascript">
           function DeleteConform() {
               debugger;
               $("#loader").show();

               {
                   var DocNo = document.getElementById("<%= hdnfDoc_No.ClientID %>").value;
                var Autoid = document.getElementById("<%= hdnfBid.ClientID %>").value; 
                var Company_Code = '<%= Session["Company_Code"] %>'; 

                   var XML = "<ROOT><BankAccount Doc_No='" + DocNo + "' Bid='" + Autoid + "' Company_Code='" + Company_Code + "'></BankAccount></ROOT>";
                var spname = "Sp_BankAccount";
                var status = document.getElementById("<%= btnDelete.ClientID %>").value;
                $.ajax({
                    type: "POST",
                    url: "../xmlExecuteDMLQry.asmx/ExecuteXMLQry",
                    data: '{XML:"' + XML + '",status:"' + status + '",spname:"' + spname + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //success: OnSuccess,
                    //failure: function (response) {
                    //    alert(response.d);
                    //    $("#loader").hide();
                    //},
                    //error: function (response) {
                    //    alert(response.d);
                    //    $("#loader").hide();
                    //}
                });
                window.open('../Transaction/pgePaymentNote_Utility.aspx', "_self");
                //   ProcessXML(XML, status, spname);
            }
        }
       

        function pagevalidation() {
            debugger;
            try {
                $("#loader").show();
                var doc_no = 0, Bid = 0;
                var status = document.getElementById("<%= btnSave.ClientID %>").value;
                var spname = "Sp_BankAccount";
                var XML = "<ROOT>";
                if (status == "Update") {
                    Doc_No = document.getElementById("<%= hdnfDoc_No.ClientID %>").value;
                    Bid = document.getElementById("<%= hdnfBid.ClientID %>").value;
                }
                 
                 
                var Ac_Code = $("#<%=txtAc_Code.ClientID  %>").val() == "" ? 0 : $("#<%=txtAc_Code.ClientID %>").val();
                var Bankac_No = $("#<%=txtbankAc_No.ClientID  %>").val() == "" ? 0 : $("#<%=txtbankAc_No.ClientID %>").val();
                var Bank_Name = $("#<%=txtbankAc_Name.ClientID  %>").val() == "" ? 0 : $("#<%=txtbankAc_Name.ClientID %>").val();
                var IFSC_Code = $("#<%=txtIFSC.ClientID  %>").val() == "" ? 0 : $("#<%=txtIFSC.ClientID %>").val();
                var Branch = $("#<%=txtBranch.ClientID  %>").val() == "" ? 0 : $("#<%=txtBranch.ClientID %>").val(); 

                var acid = document.getElementById("<%= hdnfacid.ClientID %>").value == "" ? 0 : document.getElementById("<%= hdnfacid.ClientID %>").value;
                
                var USER = '<%= Session["user"] %>';  
                var Company_Code = '<%= Session["Company_Code"] %>';
 

                var LocalVoucherInsertUpdet;
                var Gledger_Insert = ""; Gledger_values = "";
                var Gledger_Delete = "";
                debugger;
                var DOCNO = "";
                //if (status == "Save") {
                //    LocalVoucherInsertUpdet = "Modified_By='' Created_By='" + USER + "'"; 
                //}
                LocalVoucherInsertUpdet = "Modified_By='' Created_By='" + USER + "'";
                if (status == "Update") {
                    LocalVoucherInsertUpdet = "Modified_By='" + USER + "' Created_By=''";
                    DOCNO = "Doc_No='" + Doc_No + "'";
                }
                debugger;

                XML = XML + "<BankAccount " + DOCNO + " Ac_Code='" + Ac_Code + "' Bankac_No='" + Bankac_No + "' Bank_Name='" + Bank_Name + "' IFSC_Code='" + IFSC_Code + "' " +
                   "Branch='" + Branch + "'  acid='" + acid + "' Company_Code='" + Company_Code + "' Bid='" + Bid + "' " + LocalVoucherInsertUpdet +">";



                XML = XML + "</BankAccount></ROOT>";
                ProcessXML(XML, status, spname);
            }
            catch (exx) {
                $("#loader").hide();
                alert(exx)
            }

            function ProcessXML(XML, status, spname) {
                debugger;

                $.ajax({
                    type: "POST",
                    url: "../xmlExecuteDMLQry.asmx/ExecuteXMLQry",
                    data: '{XML:"' + XML + '",status:"' + status + '",spname:"' + spname + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                        $("#loader").hide();
                    },
                    error: function (response) {
                        alert(response.d);
                        $("#loader").hide();
                    }
                });


                function OnSuccess(response) {
                    debugger;
                    $("#loader").hide();
                    if (status != "Delete") {
                        if (response.d.length > 0) {
                            var word = response.d;
                            var len = word.length;
                            var pos = word.indexOf(",");
                            var id = word.slice(0, pos);
                            var doc = word.slice(pos + 1, len);
                            if (status == "Save") {
                                alert('Sucessfully Added Record !!! Doc_No=' + doc)
                            }

                            else {
                                alert('Sucessfully Updated Record !!! Doc_No=' + doc)
                            }
                            window.open('../Master/pgeBankAccount.aspx?Bid=' + id + '&Action=1', "_self");

                        }
                    }
                    else {
                        var num = parseInt(response.d);

                        if (isNaN(num)) {
                            alert(response.d)

                        }
                        else {
                            window.open('../Master/pgeBankAccount.aspx', "_self");
                        }
                    }

                }

            }

        }
           //function Citymaster() {
           //    var Action = 2;
           //    var doc_no = 0; 
           //    window.open('../Master/pgeBankAccount.aspx?Doc_No=' + doc_no + '&Action=' + Action);
           //}
    </script>
       <script type="text/javascript">
           function Confirm() {
               var confirm_value = document.createElement("INPUT");
               confirm_value.type = "hidden";
               confirm_value.name = "confirm_value";
               if (confirm("Do you want to delete data?")) {
                   confirm_value.value = "Yes";
                   document.getElementById("<%= hdconfirm.ClientID %>").value = "Yes";
            }
            else {
                confirm_value.value = "No";
                document.getElementById("<%= hdconfirm.ClientID %>").value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function PaymentToReport(doc_no, paymentto) {

            window.open('../Master/pgeBankAccount.aspx?doc_no=' + doc_no + '&paymentto=' + paymentto);
        }

        function Back() {
            window.open('../Master/pgeBankAccount.aspx', '_self');
        }
    </script>
        <style type="text/css">
        #loader
        {
            width: 100%;
            height: 100%;
            background-color: gray;
            position: fixed;
            margin: -0.7%;
            opacity: 0.6;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <fieldset style="border-top: 1px dotted rgb(131, 127, 130); border-radius: 3px; width: 90%;
            margin-left: 30px; float: left; border-bottom: 0px; padding-top: 0px; padding-bottom: 10px;
            border-left: 0px; border-right: 0px; height: 7px;">
            <legend style="text-align: center;">
                <asp:Label ID="label1" runat="server" Text="   Bank Account   " Font-Names="verdana"
                    ForeColor="White" Font-Bold="true" Font-Size="12px"></asp:Label></legend>
        </fieldset>
        <div id="loader" align="center" style="display: none; width: 90%; margin-left: 30px;
            float: left; border-bottom: 0px; padding-top: 0px; padding-bottom: 10px; border-left: 0px;
            border-right: 0px;">
            <img height="20%" width="20%" src="../Images/ajax-loader3.gif" />
        </div>
      <asp:UpdatePanel ID="UpdatePanelMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
              <asp:HiddenField ID="hdnfClosePopup" runat="server" />
            <asp:HiddenField ID="hdnfBid" runat="server" />
              <asp:HiddenField ID="hdnfyearcode" runat="server" />
            <asp:HiddenField ID="hdnfcompanycode" runat="server" /> 
            <asp:HiddenField ID="hdnfDoc_No" runat="server" />
            <asp:HiddenField ID="hdnfacid" runat="server" />
            <asp:HiddenField ID="hdconfirm" runat="server" />
            <asp:HiddenField ID="hdHelpPageCount" runat="server" />

     <table width="100%" align="left">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New" CssClass="btnHelp" Width="90px"
                            ValidationGroup="save" OnClick="btnAdd_Click"  Height="24px" />

                         <asp:Button ID="btnSave" runat="server"  
                                    Text="Save" CssClass="btnHelp" Width="90px" TabIndex="8" Height="24px" ValidationGroup="add"
                                    OnClick="btnSave_Click" />

                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btnHelp" Width="90px"
                            ValidationGroup="save" OnClick="btnEdit_Click" Height="24px" />

                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btnHelp" Width="90px"
                            ValidationGroup="add" OnClick="btnDelete_Click" OnClientClick="Confirm()" Height="24px" />

                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnHelp" Width="90px"
                            ValidationGroup="save" Height="24px" TabIndex="48" OnClientClick="BACK()" />

                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnHelp" Width="90px"
                            ValidationGroup="save" OnClick="btnCancel_Click" Height="24px" />

                        <asp:Button ID="btnFirst" runat="server" Text="<<" ToolTip="First" CssClass="btnHelp"
                            OnClick="btnFirst_Click" Width="90px" Height="24px" />
                        <asp:Button ID="btnPrevious" runat="server" Text="<" ToolTip="First" CssClass="btnHelp"
                            OnClick="btnPrevious_Click" Width="90px" Height="24px" />
                        <asp:Button ID="btnNext" runat="server" Text=">" ToolTip="First" CssClass="btnHelp"
                            OnClick="btnNext_Click" Width="90px" Height="24px" />
                        <asp:Button ID="btnLast" runat="server" Text=">>" ToolTip="First" CssClass="btnHelp"
                            OnClick="btnLast_Click" Width="90px" Height="24px" />
                       
                               
                    </td>
                </tr>
            </table>
              <asp:Panel ID="pnlMain" runat="server" Font-Names="verdana" Font-Bold="true" ForeColor="Black"
                Font-Size="Small" Style="margin-left: 30px; margin-top: 0px; z-index: 100;">
                <table style="width: 30%;" align="center" cellpadding="4" cellspacing="4">
                    <tr>
                        <td align="left" colspan="2">
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Font-Italic="true" Font-Names="verdana"
                                Font-Size="Small" ForeColor="Red"></asp:Label>
                        </td>

                              <tr>
                            <td align="left" style="width: 20%;">
                                Change No:
                            </td>
                            <td align="left" style="width: 30%;">
                                 <asp:TextBox Height="24px" ID="txtEditDoc_No" runat="Server" CssClass="txt" TabIndex="1"
                                    Width="90px" Style="text-align: left;" AutoPostBack="false" OnTextChanged="txtEditDoc_No_TextChanged"
                                    onKeyDown="changeno(event);"></asp:TextBox>
                                <ajax1:FilteredTextBoxExtender runat="server" ID="txtxf" FilterType="Numbers" InvalidChars="."
                                    TargetControlID="txtEditDoc_No">
                                </ajax1:FilteredTextBoxExtender>
                                &nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Italic="true" Font-Names="verdana"
                                    Font-Size="Small" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                          <tr>
                            <td align="left" style="width: 30%;">
                                Doc No:
                            </td>
                            <td align="left" style="width: 30%;">
                                 <asp:TextBox Height="24px" ID="txtDoc_No" runat="Server" CssClass="txt" TabIndex="2"
                                    Width="90px" Style="text-align: left;" AutoPostBack="false" OnTextChanged="txtDoc_No_TextChanged"></asp:TextBox>
                                <asp:Button Width="90px" Height="24px" ID="btntxtDoc_No" runat="server" Text="..."
                                    OnClick="btntxtDoc_No_Click" CssClass="btnHelp" />
                                <asp:Label ID="lblDoc_No" runat="server" CssClass="lblName" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 30%;">
                              Ac Code:
                            </td>
                            <td align="left" style="width: 30%;">
                                   <asp:TextBox Height="24px" ID="txtAc_Code" runat="Server" CssClass="txt" TabIndex="3"
                                    Width="90px" Style="text-align: left;" AutoPostBack="true" OnTextChanged="txtAc_Code_TextChanged"   onkeydown="AC_Code(event);"></asp:TextBox>
                                <asp:Button Width="20px" Height="24px" ID="btnAc_Code" runat="server" Text="..."
                                    OnClick="btnAc_Code_Click" CssClass="btnHelp" />
                                <asp:Label ID="lblAc_Name" runat="server" CssClass="lblName"></asp:Label>
                            </td>
                        </tr>
                           
                         
                               <tr>
                            <td align="left" style="width: 30%;">
                               Bank AC No.:
                            </td>
                            <td align="left" style="width: 30%;">
                               <asp:TextBox ID="txtbankAc_No" runat="Server" CssClass="txt" TabIndex="4" Width="220px"
                                Style="text-align: left;" AutoPostBack="false" Height="24px"></asp:TextBox>
                            </td>
                        </tr>
                                <tr>
                            <td align="left" style="width: 30%;">
                                Bank AC Name.:
                            </td>
                            <td align="left" style="width: 30%;">
                                <asp:TextBox ID="txtbankAc_Name" runat="Server" CssClass="txt" TabIndex="5" Width="220px"
                                Style="text-align: left;" AutoPostBack="false" Height="24px"></asp:TextBox>
                            </td>
                        </tr>
                                <tr>
                            <td align="left" style="width: 30%;">
                               IFSC:
                            </td>
                            <td align="left" style="width: 30%;">
                 <asp:TextBox ID="txtIFSC" runat="Server" CssClass="txt" TabIndex="6" Width="220px"
                                Style="text-align: left;" AutoPostBack="false" Height="24px"></asp:TextBox>
                            </td>
                        </tr> 
                                <tr>
                            <td align="left" style="width: 30%;">  
                             Branch:
                            </td>
                            <td align="left" style="width: 30%;">
                            <asp:TextBox ID="txtBranch" runat="Server" CssClass="txt" TabIndex="7" Width="220px"
                                Style="text-align: left;" AutoPostBack="false" Height="24px"></asp:TextBox>
                            </td>
                        </tr>     
                </table>
            </asp:Panel>
            
            <asp:Panel onkeydown="closepopup(event);" ID="pnlPopup" runat="server" Width="70%"
                align="center" ScrollBars="None" BackColor="#FFFFE4" Direction="LeftToRight"
                Style="z-index: 5000; position: absolute; display: none; float: right; max-height: 1000px; min-height: 700px; box-shadow: 1px 1px 8px 2px; background-position: center; left: 10%; top: 10%;">
                <asp:ImageButton ID="imgBtnClose" runat="server" ImageUrl="~/Images/closebtn.jpg"
                    Width="20px" Height="20px" Style="float: right; vertical-align: top;" OnClick="imgBtnClose_Click"
                    ToolTip="Close" />
                <table width="95%">
                    <tr>
                        <td align="center" style="background-color: #F5B540; width: 100%;">
                            <asp:Label ID="lblPopupHead" runat="server" Font-Size="Medium" Font-Names="verdana"
                                Font-Bold="true" ForeColor="White"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Search Text:
                            <asp:TextBox onkeydown="SelectFirstRow(event);" ID="txtSearchText" runat="server"
                                Width="250px" Height="20px" AutoPostBack="false" OnTextChanged="txtSearchText_TextChanged"></asp:TextBox>
                            <asp:Button onkeydown="closepopup(event);" ID="btnSearch" runat="server" Text="Search"
                                CssClass="btnSubmit" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlInner" runat="server" Width="100%" Direction="LeftToRight" BackColor="#FFFFE4"
                                Style="z-index: 5000; float: right; overflow: auto; height: 680px">
                                <asp:GridView Font-Bold="true" CssClass="select" AllowPaging="true" PageSize="25"
                                    OnPageIndexChanging="grdPopup_PageIndexChanging" ID="grdPopup" runat="server"
                                    AutoGenerateColumns="true" EmptyDataText="No Records Found" HeaderStyle-BackColor="#6D8980"
                                    HeaderStyle-ForeColor="White" OnRowCreated="grdPopup_RowCreated" OnRowDataBound="grdPopup_RowDataBound"
                                    Style="table-layout: fixed;">
                                    <HeaderStyle Height="30px" ForeColor="White" BackColor="#6D8980" />
                                    <RowStyle Height="25px" ForeColor="Black" Wrap="false" />
                                    <PagerStyle BackColor="Tomato" ForeColor="White" Width="100%" Font-Bold="true" />
                                    <PagerSettings Position="TopAndBottom" />
                                </asp:GridView>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlPopupDetails" runat="server" BackColor="GhostWhite" Width="955px"
                BorderColor="Teal" BorderWidth="1px" Height="300px" BorderStyle="Solid" Style="z-index: 4999; left: 20%; top: 20%; position: absolute; display: none; font-weight: bold; box-shadow: 1px 2px 10px 2px;">
            </asp:Panel>
                 </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

