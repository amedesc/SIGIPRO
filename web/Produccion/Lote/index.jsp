<%-- 
    Document   : index
    Created on : Jun 29, 2015, 4:39:43 PM
    Author     : ld.conejo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:plantilla_general title="Producci�n" direccion_contexto="/SIGIPRO">

    <jsp:attribute name="contenido">

        <jsp:include page="../../plantillas/barraFuncionalidad.jsp" />

        <!-- content-wrapper -->
        <div class="col-md-12 content-wrapper">
            <div class="row">
                <div class="col-md-12 ">
                    <ul class="breadcrumb">
                        <li>Producci�n</li>
                        <li class="active"> 
                            Lotes de Producci�n
                        </li>
                    </ul>
                </div>
            </div>
            <!-- main -->
            <div class="content">
                <div class="main-content">
                    <!-- COLUMN FILTER DATA TABLE -->
                    <div class="widget widget-table">
                        <div class="widget-header">
                            <h3><i class="fa fa-gears"></i> Lotes de Producci�n </h3>
                            <c:if test="${helper_permisos.validarPermiso(sessionScope.listaPermisos, 660)}">
                                <div class="btn-group widget-header-toolbar">
                                    <a class="btn btn-primary btn-sm boton-accion " href="/SIGIPRO/Produccion/Lote?accion=historial">Historial</a>
                                </div>
                            </c:if>
                        </div>
                        ${mensaje}
                        <div class="widget-content">
                            <table class="table table-sorting table-striped table-hover datatable tablaSigipro sigipro-tabla-filter">
                                <!-- Columnas -->
                                <thead> 
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Protocolo</th>
                                        <th>Acci�n</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listaLotes}" var="lote">

                                        <tr id ="${lote.getId_lote()}">
                                            <td>
                                                <a href="/SIGIPRO/Produccion/Lote?accion=ver&id_lote=${lote.getId_lote()}">
                                                    <div style="height:100%;width:100%">
                                                        ${lote.getNombre()}
                                                    </div>
                                                </a>
                                            </td>
                                            <td>
                                                ${lote.getProtocolo().getNombre()}
                                            </td>
                                            <td>
                                                <a class="btn btn-primary btn-sm boton-accion" href="/SIGIPRO/Produccion/Lote?accion=ver&id_lote=${lote.getId_lote()}">Pendiente</a>
                                                <c:if test="${lote.isAprobacion()}">
                                                    <c:if test="${helper_permisos.validarPermiso(sessionScope.listaPermisos, 660)}">
                                                        <a class="btn btn-danger btn-sm boton-accion rechazar-Modal" data-id='${lote.getId_lote()}' data-toggle="modal" data-target="#modalRechazarLote">Rechazar</a>
                                                    </c:if>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- END COLUMN FILTER DATA TABLE -->
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>

    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="/SIGIPRO/recursos/js/sigipro/LoteProduccion.js"></script>
    </jsp:attribute>
</t:plantilla_general>

<t:modal idModal="modalRechazarLote" titulo="Rechazar Lote de Producci�n">
    <jsp:attribute name="form">
        <div class="widget-content" id="class-rechazar-lote">
            <form class="form-horizontal" id="rechazarLote" autocomplete="off" method="get" action="Lote">
                <input hidden="true" name="accion" value="Rechazar">
                <input hidden="true" id='id_lote' name='id_lote' value="">
                <label for="label" class="control-label">�Est� seguro que desea rechazar el Lote de Producci�n?</label>
                <div class="form-group">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i>  Cancelar</button>
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Rechazar Lote</button>            </div>
                </div>
            </form>
        </div>

    </jsp:attribute>
</t:modal>
