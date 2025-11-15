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
        AllowPaging="true"
        PageSize="7"
        OnPageIndexChanging="GridViewHorarios_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3">
    </asp:GridView>

    <h4 style="margin-top: 40px">Agregar horario (Probar SP_Agregar_Horarios_De_Medicos)</h4>
    <div class="container w-100">
        <div class="row">
            <div class="col-md-4">
                <asp:DropDownList ID="ddlMedico" CssClass="form-select" runat="server"></asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:DropDownList ID="ddlEspecialidad" CssClass="form-select" runat="server"></asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:DropDownList ID="ddlTipoTurno" CssClass="form-select" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <asp:DropDownList ID="ddlDia" CssClass="form-select" runat="server"></asp:DropDownList>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtHoraEntrada" CssClass="form-control" TextMode="Time" runat="server"></asp:TextBox>
                <div style="min-height: 1.5em;">
                    <asp:RequiredFieldValidator ErrorMessage="Campo requerido." ForeColor="Red" ControlToValidate="txtHoraEntrada" runat="server" />
                </div>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="txtHoraSalida" CssClass="form-control" TextMode="Time" runat="server"></asp:TextBox>
                <div style="min-height: 1.5em;">
                    <asp:RequiredFieldValidator ErrorMessage="Campo requerido." ForeColor="Red" ControlToValidate="txtHoraSalida" runat="server" />
                </div>
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnAgregar" runat="server" Text="➕ Agregar" CssClass="btn btn-primary w-100" OnClick="btnAgregar_Click" />
            </div>
            <asp:Label ID="lblErrorSQL" runat="server" CssClass="errorMessage" ForeColor="Red"></asp:Label>

        </div>
    </div>
</asp:Content>
