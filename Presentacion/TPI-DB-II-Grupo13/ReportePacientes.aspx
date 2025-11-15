<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ReportePacientes.aspx.cs" Inherits="TPI_DB_II_Grupo13.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Reporte de Turnos por Paciente</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Pacientes_Reporte</strong>.</p>

    <asp:GridView
        ID="GridViewReportePacientes"
        runat="server"
        AutoGenerateColumns="true"
        AllowPaging="true"
        PageSize="7"
        OnPageIndexChanging="GridViewReportePacientes_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3">
    </asp:GridView>
</asp:Content>
