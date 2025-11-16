<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TurnosPacientes.aspx.cs" Inherits="TPI_DB_II_Grupo13.TurnosPacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Turnos Detallados</h2>
    <p>Esta grilla lee directamente de la vista <strong>V_Pacientes_Turnos</strong>.</p>
    <asp:GridView
        ID="GridViewTurnos"
        runat="server"
        AutoGenerateColumns="false"
        AllowPaging="true"
        PageSize="7"
        OnPageIndexChanging="GridViewTurnos_PageIndexChanging"
        CssClass="table table-bordered table-striped mt-3"
        DataKeyNames="IdTurno"
        OnSelectedIndexChanged="GridViewTurnos_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton
                        ID="btnCancelarTurno"
                        runat="server"
                        CommandName="Select"
                        CssClass="btn btn-outline-danger btn-sm d-flex justify-content-center align-items-center"
                        ToolTip="Inactivar médico">
                        <i class="bi bi-x-circle-fill"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="NombrePaciente" HeaderText="Nombre Paciente" />
            <asp:BoundField DataField="ApellidoPaciente" HeaderText="Apellido Paciente" />
            <asp:BoundField DataField="Documento" HeaderText="Documento" />
            <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
            <asp:BoundField DataField="NombreMedico" HeaderText="Nombre Medico" />
            <asp:BoundField DataField="ApellidoMedico" HeaderText="Apellido Medico" />
            <asp:BoundField DataField="FechaYHora" HeaderText="Fecha y Hora" />
            <asp:BoundField DataField="TipoDeTurno" HeaderText="Tipo Turno" />
            <asp:BoundField DataField="EsSobreTurno" HeaderText="Es Sobreturno" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />

        </Columns>

    </asp:GridView>
    <%--SACAR TURNO--%>
    <div class="card shadow-sm">
        <div class="card-header text-center">
            <h4 class="mb-0">Registrar Turno (Probar SP_Registrar_Turno)</h4>
        </div>
        <div class="card-body">
            <div class="container w-100">
                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label">Paciente:</label>
                        <asp:DropDownList ID="ddlPacientes_Turno" CssClass="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Médico</label>
                        <asp:DropDownList ID="ddlMedicos_Turno" CssClass="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Especialidad</label>
                        <asp:DropDownList ID="ddlEspecialidad_Turno" CssClass="form-select" runat="server"></asp:DropDownList>
                    </div>
                    <div class="row">

                        <div class="col-md-4">
                            <label class="form-label">Tipo de Turno:</label>
                            <asp:DropDownList ID="ddlTipoTurno_Turno" CssClass="form-select" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Fecha y Hora:</label>
                            <asp:TextBox ID="txtFecha_Turno" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        </div>
                        <div class="md-2 form-check">
                            <asp:CheckBox ID="chkEsSobreTurno_Turno" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Es Sobreturno</label>
                        </div>

                    </div>
                    <div class="row justify-content-center text-center mt-4">

                        <div class="col-md-4 align-items-center">
                            <label class="form-label">Observaciones (Opcional):</label>
                            <asp:TextBox ID="txtObservaciones_Turno" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row justify-content-center text-center mt-3">
                        <div class="col-md-3">
                            <asp:Button ID="btnAgregar_Turno" runat="server" Text="➕ Agregar" CssClass="btn btn-primary w-100" OnClick="btnAgregar_Turno_Click" />
                        </div>
                    </div>
                    <div class="mt-3">
                        <asp:Label ID="lblErrorSQL_Turnos" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>
                        <asp:Label ID="lblRegistroCorrecto" runat="server" CssClass="alert alert-success d-block" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
