<%-- 
    Document   : Formulario
    Created on : 21-ene-2015, 20:28:28
    Author     : Walter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form class="form-horizontal" autocomplete="off" method="post" action="ActivosFijos">
    <div class="col-md-6">
        <input hidden="true" name="id_activo_fijo" value="${activofijo.getId_activo_fijo()}">
        <label for="placa" class="control-label">* Placa del Activo Fijo</label>
        <div class="form-group">
            <div class="col-sm-12">
                <div class="input-group">
                    <input type="number" maxlength="45" placeholder="Placa del activo fijo" class="form-control" name="placa" value="${activofijo.getPlaca()}"
                           required
                           oninvalid="setCustomValidity('Este campo es requerido ')"
                           oninput="setCustomValidity('')" > 
                </div>
            </div>
        </div>
        <label for="equipo" class="control-label">* Equipo</label>
        <div class="form-group">
            <div class="col-sm-12">
                <div class="input-group">
                    <input type="number" maxlength="45" placeholder="Equipo" class="form-control" name="equipo" value="${activofijo.getEquipo()}"
                           required
                           oninvalid="setCustomValidity('Este campo es requerido ')"
                           oninput="setCustomValidity('')" > 
                </div>
            </div>
        </div>
        <label for="marca" class="control-label"> Marca</label>
        <div class="form-group">
            <div class="col-sm-12">
                <div class="input-group">
                    <input type="text" maxlength="45" placeholder="Marca" class="form-control" name="marca" value="${activofijo.getMarca()}"
                </div>
            </div>
        </div>
    </div>
    <label for="fecha_movimiento" class="control-label">*Fecha de Movimiento</label>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="input-group" style="display:table;">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="text" value="${activofijo.getFecha_movimiento()}" pattern="\d{1,2}/\d{1,2}/\d{4}" id="datepicker" class="form-control sigiproDatePicker" name="fecha_movimiento" data-date-format="dd/mm/yyyy" required
                       oninvalid="setCustomValidity('Este campo es requerido ')"
                       onchange="setCustomValidity('')">
            </div>
        </div>
    </div>
</div>
<div class="col-md-6">
    <label for="seccion" class="control-label">Sección</label>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="input-group">
                <%--<span class="input-group-addon"><i class="fa fa-at"></i></span>           SE ELIMINA EL ICONO --%>
                <select id="seleccionSeccion" class="form-control" name="seccion"
                        style='background-color: #fff;' >
                    <c:forEach items="${secciones}" var="seccion">
                        <c:choose>
                            <c:when test="${seccion.getID() == activofijo.getId_seccion()}" >
                                <option value=${seccion.getID()} selected> ${seccion.getNombre_seccion()}</option>
                            </c:when>
                            <c:otherwise>
                                <option value=${seccion.getID()}>${seccion.getNombre_seccion()}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <label for="ubicacion" class="control-label">*Ubicación</label>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="input-group">
                <%--<span class="input-group-addon"><i class="fa fa-at"></i></span>           SE ELIMINA EL ICONO --%>
                <select id="seleccionUbicacion" class="form-control" name="ubicacion"
                        style='background-color: #fff;' >
                    <c:forEach items="${ubicaciones}" var="ubicacion">
                        <c:choose>
                            <c:when test="${ubicacion.getId_ubicacion() == activofijo.getId_ubicacion()}" >
                                <option value=${ubicacion.getId_ubicacion()} selected> ${ubicacion.getNombre()}</option>
                            </c:when>
                            <c:otherwise>
                                <option value=${ubicacion.getId_ubicacion()}>${ubicacion.getNombre()}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>                 
    <label for="fecha_registro" class="control-label">*Fecha de Registro</label>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="input-group" style="display:table;">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="text" value="${activofijo.getFecha_registro()}" pattern="\d{1,2}/\d{1,2}/\d{4}" id="datepicker" class="form-control sigiproDatePicker" name="fecha_registro" data-date-format="dd/mm/yyyy" required
                       oninvalid="setCustomValidity('Este campo es requerido ')"
                       onchange="setCustomValidity('')">
            </div>
        </div>
    </div>
    <label for="estado" class="control-label"> Estado</label>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="input-group">
                <input type="text" maxlength="45" placeholder="Estado" class="form-control" name="estado" value="${activofijo.getEstado()}"
                       required
                       oninvalid="setCustomValidity('Este campo es requerido ')"
                       oninput="setCustomValidity('')" > 
            </div>
        </div>
    </div>
</div>
</div>
<!-- Esta parte es la de los permisos de un rol -->
<p>
    Los campos marcados con * son requeridos.
</p>  

<div class="form-group">
    <div class="modal-footer">
        <button type="button" class="btn btn-danger" onclick="history.back()"><i class="fa fa-times-circle"></i> Cancelar</button>
        <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> ${accion} Activo Fijo</button>
    </div>
</div>


</form>