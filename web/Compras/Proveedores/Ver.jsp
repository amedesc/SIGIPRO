<%-- 
    Document   : Ver
    Created on : Jan 11, 2015, 11:57:19 AM
    Author     : Walter
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.icp.sigipro.compras.modelos.Proveedor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:plantilla_general title="Compras" direccion_contexto="/SIGIPRO">

  <jsp:attribute name="contenido">

    <jsp:include page="../../plantillas/barraFuncionalidad.jsp" />

    <!-- content-wrapper -->
    <div class="col-md-12 content-wrapper">
      <div class="row">
        <div class="col-md-4 ">
          <ul class="breadcrumb">
            <li>Compras</li>
            <li> 
              <a href="/SIGIPRO/Compras/Proveedores?">Proveedores</a>
            </li>
            <li class="active"> ${proveedor.getNombre_proveedor()} </li>
          </ul>
        </div>
        <div class="col-md-8 ">
          <div class="top-content">

          </div>
        </div>
      </div>
      <!-- main -->
      <div class="content">
        <div class="main-content">
          <!-- COLUMN FILTER DATA TABLE -->
          <div class="widget widget-table">
            <div class="widget-header">
              <h3><i class="fa fa-truck"></i> ${proveedor.getNombre_proveedor()} </h3>
              <div class="btn-group widget-header-toolbar">
                <c:set var="contienePermisoEliminar" value="false" />
                <c:forEach var="permiso" items="${sessionScope.listaPermisos}">
                  <c:if test="${permiso == 1 || permiso == 16}">
                    <c:set var="contienePermisoEliminar" value="true" />
                  </c:if>
                </c:forEach>
                <c:if test="${contienePermisoEliminar}">
                  <a class="btn btn-danger btn-sm boton-accion confirmable"  data-texto-confirmacion="eliminar el proveedor" data-href="/SIGIPRO/Compras/Proveedores?accion=eliminar&id_proveedor=${proveedor.getId_proveedor()}">Eliminar</a>
                </c:if>

                <c:set var="contienePermisoEditar" value="false" />
                <c:forEach var="permiso" items="${sessionScope.listaPermisos}">
                  <c:if test="${permiso == 1 || permiso == 15}">
                    <c:set var="contienePermisoEditar" value="true" />
                  </c:if>
                </c:forEach>
                <c:if test="${contienePermisoEditar}">
                  <a class="btn btn-warning btn-sm boton-accion" href="/SIGIPRO/Compras/Proveedores?accion=editar&id_proveedor=${proveedor.getId_proveedor()}">Editar</a>
                </c:if>
              </div>
            </div>
            ${mensaje}
            <div class="widget-content">
              <table>
                <tr><td> <strong>Nombre del Proveedor:   </strong></td> <td>${proveedor.getNombre_proveedor()} </td></tr>
                <tr><td> <strong>Teléfono 1:</strong> <td>${proveedor.getTelefono1()} </td></tr>
                <tr><td> <strong>Teléfono 2:</strong> <td>${proveedor.getTelefono2()} </td></tr>
                <tr><td> <strong>Teléfono 3:</strong> <td>${proveedor.getTelefono3()} </td></tr>
                <tr><td> <strong>Correo:</strong> <td>${proveedor.getCorreo()} </td></tr>
              </table>
              <br>
            </div>
          </div>
          <!-- END WIDGET TICKET TABLE -->
        </div>
        <!-- /main-content -->
      </div>
      <!-- /main -->
    </div>
    <div class="widget-content">
      <div class="modal fade" id="ModalEliminarProveedor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
              <h4 class="modal-title" id="myModalLabel">Confirmación</h4>
            </div>
            <div class="modal-body">
              <form>
                <h5 class="title">¿Está seguro que desea eliminar el Proveedor?</h5>
                <br><br>
                <input hidden="false" id="controlIDProveedor" name="id_proveedor" value="${proveedor.getId_proveedor()}">
                <div class="form-group">
                  <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancelar</button>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle" href="/SIGIPRO/Compras/Proveedores/index.jsp"></i> Confirmar</button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

  </jsp:attribute>

</t:plantilla_general>
