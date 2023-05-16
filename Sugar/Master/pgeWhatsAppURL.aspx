<%@ Page Title="Whatsapp URL" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pgeWhatsAppURL.aspx.cs" Inherits="Sugar_Master_pgeWhatsAppURL" %>

<%@ MasterType VirtualPath="~/MasterPage2.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="border-top: 1px dotted rgb(131, 127, 130); border-radius: 3px; width: 90%; margin-left: 30px; float: left; border-bottom: 0px; padding-top: 0px; padding-bottom: 10px; border-left: 0px; border-right: 0px; height: 7px;">
        <legend style="text-align: center;">
            <asp:Label ID="label1" runat="server" Text="Whatsapp URL" Font-Names="verdana"
                ForeColor="White" Font-Bold="true" Font-Size="12px"></asp:Label></legend>
    </fieldset>
    <br /> 
    <br />
    <asp:Panel runat="server" ID="pnlMain">
        <table width="60%" align="center" cellspacing="5">
            <tr>
                <td align="right" style="width: 30%;">
                    <b>Instance Id:</b>
                </td>
                <td align="left" style="width: 30%;">
                    <asp:TextBox runat="server" ID="txtInstance_Id" Width="150px" Height="24px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 30%;">
                    <b>Access Token:</b>
                </td>
                <td align="left" style="width: 30%;">
                    <asp:TextBox runat="server" ID="txtAccess_token" Width="150px" Height="24px"></asp:TextBox>
                </td>
            </tr>
            <%--<tr>
                <td align="right" style="width: 30%;">
                 <b>Drive URL:</b>
                </td>
                <td align="left" style="width: 30%;">
                    <asp:TextBox runat="server" ID="txtDrive_URL" Width="250px" Height="24px"></asp:TextBox>
                </td>
            </tr>--%>
            <tr>
                <td align="right" style="width: 30%;">
                 </td>
            </tr>

            <tr>
                <td 
                align="center" colspan="2">
                    <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="btnHelp" Width="100px" OnClick="btnUpdate_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>



