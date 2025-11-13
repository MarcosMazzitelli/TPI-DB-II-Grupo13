<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Horarios.aspx.cs" Inherits="TPI_DB_II_Grupo13.Horarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Horarios Detallados de Médicos</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Horarios_Detallados</strong>.</p>
    <asp:GridView
        ID="GridViewHorarios"
        runat="server"
        AutoGenerateColumns="true"
        CssClass="table table-bordered table-striped mt-3">
    </asp:GridView>

</asp:Content>
