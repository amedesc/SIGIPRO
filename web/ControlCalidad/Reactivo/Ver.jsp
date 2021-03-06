<%-- 
    Document   : Ver
    Created on : Jul 1, 2015, 1:47:03 PM
    Author     : ld.conejo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:plantilla_general title="Control de Calidad" direccion_contexto="/SIGIPRO">

    <jsp:attribute name="contenido">

        <jsp:include page="../../plantillas/barraFuncionalidad.jsp" />

        <!-- content-wrapper -->
        <div class="col-md-12 content-wrapper">
            <div class="row">
                <div class="col-md-12 ">
                    <ul class="breadcrumb">
                        <li>Control de Calidad</li>
                        <li> 
                            <a href="/SIGIPRO/ControlCalidad/Reactivo?">Reactivos</a>
                        </li>
                        <li class="active"> ${reactivo.getNombre()} </li>
                    </ul>
                </div>
            </div>
            <!-- main -->
            <div class="content">
                <div class="main-content">
                    <!-- COLUMN FILTER DATA TABLE -->
                    <div class="widget widget-table">
                        <div class="widget-header">
                            <h3><i class="fa fa-gears"></i> ${reactivo.getNombre()} </h3>
                            <div class="btn-group widget-header-toolbar">
                                <c:if test="${helper_permisos.validarPermiso(sessionScope.listaPermisos, 533)}">
                                    <a class="btn btn-danger btn-sm boton-accion confirmable" data-texto-confirmacion="eliminar el reactivo" data-href="/SIGIPRO/ControlCalidad/Reactivo?accion=eliminar&id_reactivo=${reactivo.getId_reactivo()}">Eliminar</a>
                                </c:if>
                                <c:if test="${helper_permisos.validarPermiso(sessionScope.listaPermisos, 532)}">
                                    <a class="btn btn-warning btn-sm boton-accion" href="/SIGIPRO/ControlCalidad/Reactivo?accion=editar&id_reactivo=${reactivo.getId_reactivo()}">Editar</a>
                                </c:if>
                                <c:set var="contienePermisoAdministrarCertificado" value="false" />
                                <c:if test="${helper_permisos.validarPermiso(sessionScope.listaPermisos, 531)}">
                                    <c:set var="contienePermisoAdministrarCertificado" value="true" />
                                </c:if>
                            </div>
                        </div>
                        ${mensaje}
                        <div class="widget-content">
                            <table class="tabla-ver">
                                <tr><td> <strong>Nombre del Reactivo: </strong></td> <td>${reactivo.getNombre()} </td></tr>
                                <tr><td> <strong>Tipo de Reactivo: </strong></td> <td>${reactivo.getTipo_reactivo().getNombre()} </td></tr>
                                <c:if test="${!reactivo.getPreparacion().equals('')}">
                                    <tr><td> <strong>Preparación: </strong> <td><a href="/SIGIPRO/ControlCalidad/Reactivo?accion=preparacion&id_reactivo=${reactivo.getId_reactivo()}">Descargar Preparación</a></td></tr>
                                </c:if>
                            </table>
                            <br>
                        </div>
                        <div class="col-md-12">
                            <div class="widget widget-table">
                                <div class="widget-header">
                                    <h3><i class="fa fa-download"></i> Certificados</h3>
                                    <div class="btn-group widget-header-toolbar">
                                        <c:if test="${contienePermisoAdministrarCertificado}">
                                            <a class="btn btn-primary btn-sm boton-accion certificado-Modal" data-id='${reactivo.getId_reactivo()}' data-toggle="modal" data-target="#modalCertificado">Agregar Certificado</a>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="widget-content">
                                    <table class="table table-sorting table-striped table-hover datatable tablaSigipro sigipro-desc-filter">
                                        <!-- Columnas -->
                                        <thead> 
                                            <tr>
                                                <th>Fecha del Certificado</th>
                                                <th>Certificado</th>
                                                    <c:if test="${contienePermisoAdministrarCertificado}">
                                                    <th>Eliminar</th>
                                                    </c:if>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${certificados}" var="certificado">
                                                <tr id ="${certificado.getId_certificado_reactivo()}"> 
                                                    <td>
                                                        ${certificado.getFecha_certificado()}
                                                    </td>
                                                    <td>
                                                        <a href="/SIGIPRO/ControlCalidad/Reactivo?accion=certificado&id_certificado_reactivo=${certificado.getId_certificado_reactivo()}&nombre=${reactivo.getNombre()}">Descargar Certificado</a>
                                                    </td>
                                                    <c:if test="${contienePermisoAdministrarCertificado}">
                                                        <td>
                                                            <a class="btn btn-danger btn-sm boton-accion eliminarCertificado-Modal" data-id='${certificado.getId_certificado_reactivo()}' data-toggle="modal" data-target="#modalEliminarCertificado">Eliminar</a>
                                                        </td>  
                                                    </c:if>

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- END WIDGET TICKET TABLE -->
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>

    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="/SIGIPRO/recursos/js/sigipro/Reactivo.js"></script>
    </jsp:attribute>
</t:plantilla_general>


<t:modal idModal="modalCertificado" titulo="Agregar Certificado">
    <jsp:attribute name="form">
        <div class="widget-content">
            <form class="form-horizontal" enctype='multipart/form-data' id="agregarCertificado" autocomplete="off" method="post" action="Reactivo">
                <input hidden="true" name="accion" value="Certificado">
                <input hidden="true" id='id_reactivo_certificado' name='id_reactivo_certificado'>
                
                <label for="observaciones" class="control-label">*Certificado</label>
                <div class="form-group">
                    <div class="col-sm-12">
                        <div class="input-group">
                            <input type="file" id="certificado" name="certificado"  accept="application/pdf,image/jpeg,image/gif,image/png" required
                                   oninvalid="setCustomValidity('No es un archivo permitido. ')"
                                   onchange="setCustomValidity('')"/>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>  Cancelar</button>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Agregar Certificado</button>            </div>
                </div>
            </form>
        </div>

    </jsp:attribute>

</t:modal>

<t:modal idModal="modalEliminarCertificado" titulo="Eliminar Certificado de Reactivo">
    <jsp:attribute name="form">
        <div class="widget-content">
            <form class="form-horizontal" id="eliminarCertificado" autocomplete="off" method="get" action="Reactivo">
                <input hidden="true" name="accion" value="Eliminarcertificado">
                <input hidden="true" id='id_certificado_reactivo' name='id_certificado_reactivo' value="">
                <label for="label" class="control-label">¿Está seguro que desea eliminar el certificado de reactivo?</label>

                <div class="form-group">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>  Cancelar</button>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Eliminar Certificado</button>            </div>
                </div>
            </form>
        </div>

    </jsp:attribute>

</t:modal>