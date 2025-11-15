<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Medicos.aspx.cs" Inherits="TPI_DB_II_Grupo13.Medicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Médicos y Especialidades</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Medicos_Especialidades</strong>.</p>

    <asp:GridView
        ID="GridViewMedicos"
        runat="server"
        AutoGenerateColumns="true"
        AllowPaging="true"
        PageSize="7"
        OnPageIndexChanging="GridViewMedicos_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3">
    </asp:GridView>

</asp:Content>
