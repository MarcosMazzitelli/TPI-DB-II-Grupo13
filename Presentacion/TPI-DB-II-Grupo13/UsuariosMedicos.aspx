<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuariosMedicos.aspx.cs" Inherits="TPI_DB_II_Grupo13.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Lista Usuarios Medicos</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Medicos_ConEstado</strong>.</p>

    <asp:GridView
        ID="GridViewMedicosConEstado"
        runat="server"
        AutoGenerateColumns="true"
        AllowPaging="true"
        PageSize="7"
        OnPageIndexChanging="GridViewMedicosConEstado_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3"
        DataKeyNames="IdMedico"
        OnSelectedIndexChanged="GridViewMedicosConEstado_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                 <asp:LinkButton 
                    ID="btnInactivar"
                    runat="server"
                    CommandName="Select"
                    CssClass="btn btn-outline-danger btn-sm d-flex justify-content-center align-items-center"
                    ToolTip="Inactivar médico">
                    <i class="bi bi-trash-fill"></i>
                </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Label ID="lblErrorSQL" runat="server" ForeColor="Red"></asp:Label>
</asp:Content>
