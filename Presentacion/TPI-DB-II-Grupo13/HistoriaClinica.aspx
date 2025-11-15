<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="HistoriaClinica.aspx.cs" Inherits="TPI_DB_II_Grupo13.HistoriaClinica" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="mb-4 ms-3">
        <h1 class="display-5">Historia Clínica de 
       
            <asp:Label ID="lblNombrePaciente" runat="server"></asp:Label>
        </h1>
        <p>
            DNI:
            <asp:Label ID="lblDni" runat="server"></asp:Label>
            | 
        Fecha de Nacimiento:
            <asp:Label ID="lblFechaNacimiento" runat="server"></asp:Label>
        </p>
    </div>
    <div class="row mb-3 ms-3">
    </div>

    <div class="accordion ms-3 mt-3 me-3" id="acordeonHC">
        <asp:Repeater runat="server" ID="repeaterHC">
            <ItemTemplate>
                <div class="accordion-item">
                    <%--Titulo y boton--%>
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button"
                            data-bs-toggle="collapse" <%--indica que es un acordeon--%>
                            data-bs-target="#collapse-<%# Eval("Id")%>">
                            <%--vincula el div con el id de la HC para redirigir--%>
                            <strong><%# Eval("Fecha") %></strong>

                            -

                            <%# Eval("Especialidad") %>
                        </button>
                    </h2>
                    <%--Contenido--%>
                    <div id="collapse-<%# Eval("Id") %>" class="accordion-collapse collapse" <%--asigna el ID para que el botón lo conozca--%>
                        data-bs-parent="#acordeonHC">
                        <div class="accordion-body">

                            <strong>Descripcion detallada:</strong>
                            <p><%# Eval("DescripcionHistoria") %></p>
                            <hr />
                            Atendido por: Dr. <%# Eval("NombreMedico") %> <%# Eval("ApellidoMedico") %>
                            (<%# Eval("Especialidad") %>)
                        </div>
                    </div>
                </div>


            </ItemTemplate>
        </asp:Repeater>
    </div>




</asp:Content>
