<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TurnosPacientes.aspx.cs" Inherits="TPI_DB_II_Grupo13.TurnosPacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Turnos Detallados</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Pacientes_Turnos</strong>.</p>
    <asp:GridView
        ID="GridViewTurnos"
        runat="server"
        AutoGenerateColumns="true"
        CssClass="table table-bordered table-striped mt-3">
    </asp:GridView>

</asp:Content>
