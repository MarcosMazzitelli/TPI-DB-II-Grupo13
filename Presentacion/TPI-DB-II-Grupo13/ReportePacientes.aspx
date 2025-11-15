<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ReportePacientes.aspx.cs" Inherits="TPI_DB_II_Grupo13.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Reporte de Turnos por Paciente</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Pacientes_Reporte</strong>.</p>

    <asp:GridView
        ID="GridViewReportePacientes"
        runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="IdPaciente"
        AllowPaging="true"
        PageSize="7"
        OnSelectedIndexChanged="GridViewReportePacientes_SelectedIndexChanged"
        OnPageIndexChanging="GridViewReportePacientes_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3">

        <Columns>

            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:LinkButton runat="server"
                        CommandName="Select"
                        ShowSelectButton="True"
                        SelectText="Ver Historia"
                        ToolTip="Ver Historia Clínica"
                        ControlStyle-CssClass="btn btn-info btn-sm"
                        ButtonType="Link"
                        CssClass="btn btn-info btn-sm">
                    <i class="bi bi-eye-fill"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <%--Boton modificar estado del turno--%>

            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
            <asp:BoundField DataField="Documento" HeaderText="Documento" />
            <asp:BoundField DataField="Edad" HeaderText="Edad" />
            <asp:BoundField DataField="TurnosTotales" HeaderText="Turnos Totales" />
            <asp:BoundField DataField="TurnosCancelados" HeaderText="Turnos Cancelados" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
            <asp:BoundField DataField="FechaNacimiento" HeaderText="Fecha Nac." DataFormatString="{0:dd/MM/yyyy}" />
        </Columns>

    </asp:GridView>
</asp:Content>
