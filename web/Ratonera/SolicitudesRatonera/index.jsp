<%-- 
    Document   : index
    Created on : Mar 26, 2015, 4:02:57 PM
    Author     : Amed
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:plantilla_general title="Ratonera" direccion_contexto="/SIGIPRO">

  <jsp:attribute name="contenido">

    <jsp:include page="../../plantillas/barraFuncionalidad.jsp" />

    <!-- content-wrapper -->
    <div class="col-md-12 content-wrapper">
      <div class="row">
        <div class="col-md-4 ">
          <ul class="breadcrumb">
            <li>Bioterio - Ratonera</li>
            <li> 
              <a href="/SIGIPRO/Ratonera/SolicitudesRatonera?">Solicitudes Ratonera</a>
            </li>
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
              <h3><i class="fa fa-barcode"></i> Solicitudes Ratonera </h3>
              <div class="btn-group widget-header-toolbar">
                <a class="btn btn-primary btn-sm boton-accion" href="/SIGIPRO/Ratonera/SolicitudesRatonera?accion=agregar">Realizar Solicitud</a>
              </div>
            </div>
            ${mensaje}
            <div class="widget-content">
              <table class="table table-sorting table-striped table-hover datatable tablaSigipro sigipro-desc-filter">
                <!-- Columnas -->
                <thead> 
                  <tr>
                    <th>N�mero de Solicitud</th>
                    <th>Fecha de Solicitud</th>
                    <th>Usuario Solicitante</th>
                    <th>N�mero de Animales</th>
                    <th>Peso</th>
                    <th>N�mero de Cajas</th>
                    <th>Estado</th>
                      <c:if test="${admin}">
                      <th> Cambio Estado</th>
                      </c:if>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach items="${listaSolicitudesRatonera}" var="solicitud">

                    <tr id ="${solicitud.getId_solicitud()}">
                      <td>
                        <a href="/SIGIPRO/Ratonera/SolicitudesRatonera?accion=ver&id_solicitud=${solicitud.getId_solicitud()}">
                          <div style="height:100%;width:100%">
                            N�mero ${solicitud.getId_solicitud()}
                          </div>
                        </a>
                      </td>
                      <td>${solicitud.getFecha_solicitud()}</td>
                      <td>${solicitud.getUsuario_solicitante().getNombreCompleto()}</td>
                      <td>${solicitud.getNumero_animales()}</td>
                      <td>${solicitud.getPeso_requerido()}</td>
                      <td>${solicitud.getNumero_cajas()}</td>
                      <td>${solicitud.getEstado()}</td>
                      <c:if test="${admin}">
                        <c:choose>
                          <c:when test="${solicitud.getEstado().equals('Pendiente')}">
                            <td>
                              <a class="btn btn-primary btn-sm boton-accion confirmableAprobar" data-texto-confirmacion="aprobar esta solicitud" data-href="/SIGIPRO/Ratonera/SolicitudesRatonera?accion=aprobar&id_solicitud=" onclick="AprobarSolicitud(${solicitud.getId_solicitud()})">Aprobar</a>
                              <a class="btn btn-danger btn-sm boton-accion" onclick="RechazarSolicitud(${solicitud.getId_solicitud()})">Rechazar</a>
                            </td>
                          </c:when>
                          <c:otherwise>
                            <c:choose>
                              <c:when test="${solicitud.getEstado().equals('Aprobada') || solicitud.getEstado().equals('Abierta')}">
                                <td>
                                  <a class="btn btn-primary btn-sm boton-accion "  onclick="entregarSolicitud(${solicitud.getId_solicitud()})" >Entregar</a>
                                </td>
                              </c:when>
                              <c:otherwise>
                                <td>
                                  <button class="btn btn-danger btn-sm boton-accion" disabled >Solicitud Completada</a>
                                </td>
                              </c:otherwise>
                            </c:choose>
                          </c:otherwise>
                        </c:choose>
                      </c:if>
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

      <t:modal idModal="ModalAutorizar" titulo="Autenticaci�n">

        <jsp:attribute name="form">
          <h5> Para validar la entrega, el usuario recipiente debe iniciar sesi�n. </h5>
          <form class="form-horizontal" id="form_modalautorizar" data-show-auth="${show_modal_auth}" method="post" action="SolicitudesRatonera">
            <input hidden="true" name="id_solicitud_auth" id="id_solicitud_auth" value="${id_solicitud_authent}">
            <input hidden="true" name="id_solicitud_auth2" id="id_solicitud_auth2" >
            <input hidden="true" name="accion" value="Entregar" id="accion" >
            <input type="text" id="usr-sol1"  name="num_an1" hidden="true">
            <input type="text" id="prd1"  name="peso1" hidden="true">
            <input type="text" id="cnt1"  name="cajas1" hidden="true">
            <input type="text" id="sex1"  name="sex1" hidden="true">
            <input type="text" id="cepa1"  name="cepa1" hidden="true">
            ${mensaje_auth}

            <label for="usr" class="control-label">Usuario</label>
            <div class="form-group">
              <div class="col-sm-12">
                <div class="input-group" style="display:table;">
                  <input type="text" id="usr"  name="usr" required
                         oninvalid="setCustomValidity('Este campo es requerido ')"
                         onchange="setCustomValidity('')">
                </div>
              </div>
            </div>
            <label for="passw" class="control-label">Contrase�a</label>
            <div class="form-group">
              <div class="col-sm-12">
                <div class="input-group" style="display:table;">
                  <input type="password" id="passw" name="passw" required
                         oninvalid="setCustomValidity('Este campo es requerido ')"
                         onchange="setCustomValidity('')">
                </div>
                <p id='mensajeValidaci�n' style='color:red;'><p>
              </div>
            </div>

            <hr>
            <h4> Informaci�n sobre la entrega </h4>
            <div class="form-group">
              <div class="col-sm-12">
                <label for="num-sol" class="control-label"> N�mero de Solicitud: </label>  
                <input type="text" id="num-sol"  name="num_sol" disabled>
              </div>
              <div class="col-sm-12">
                <label for="usr-sol" class="control-label"> Numero de animales: </label>
                <input type="text" id="usr-sol"  name="num_an" disabled>
              </div>
              <div class="col-sm-12">
                <label for="prd" class="control-label"> Peso:  </label>
                <input type="text" id="prd"  name="peso" disabled>
              </div>
              <div class="col-sm-12">
                <label for="cnt" class="control-label"> Numero Cajas: </label>
                <input type="text" id="cnt"  name="cajas" disabled>
              </div>
              <div class="col-sm-12">
                <label for="cnt" class="control-label"> Sexo: </label>
                <input type="text" id="sex"  name="sex" disabled>
              </div>
              <input type="text" id="cepa"  name="cepa" disabled hidden="true">
            </div>

            <div class="form-group">
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancelar</button>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Aceptar</button>
              </div>
            </div>
          </form>


        </jsp:attribute>

      </t:modal>

      <t:modal idModal="ModalEntrega" titulo="Informaci�n de la Entrega">

        <jsp:attribute name="form">
          <h4> Por favor introduzca la informaci�n de la entrega: </h4>
          <hr>
          <form class="form-horizontal" id="form_modalautorizar" data-show-auth="${show_modal_auth}" method="post" action="SolicitudesRatonera">
            <input hidden="true" name="id_solicitud_ent" id="id_solicitud_ent">
            <div class="form-group">
              <div class="col-sm-12">
                <label for="usr-sol" class="control-label"> Numero de animales: </label>
                <input type="text" id="numero_animales"  name="numero_animales">
              </div>
              <div class="col-sm-12">
                <label for="prd" class="control-label"> Peso:  </label>
                <select id="peso_entrega" class="select2" name="peso_entrega" required
                        oninvalid="setCustomValidity('Este campo es requerido')" style='background-color: #fff;' onchange="setCustomValidity('')">
                  <c:forEach items="${pesos}" var="peso">
                    <c:choose>
                      <c:when test="${solicitud.getPeso_requerido() == peso}" >
                        <option value=${peso} selected> ${peso}</option>
                      </c:when>
                      <c:otherwise>
                        <option value=${peso}> ${peso}</option>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-12">
                <label for="cnt" class="control-label"> Numero Cajas: </label>
                <input type="text" id="numero_cajas"  name="numero_cajas" >
              </div>
              <div class="col-sm-12">
                <label for="cnt" class="control-label"> Sexo: </label>
                <select id="sexo" class="select2" name="sexo" required
                        oninvalid="setCustomValidity('Este campo es requerido')" style='background-color: #fff;' onchange="setCustomValidity('')">
                  <c:forEach items="${sexos}" var="sexo">
                    <c:choose>
                      <c:when test="${solicitud.getSexo() == sexo}" >
                        <option value=${sexo} selected> ${sexo}</option>
                      </c:when>
                      <c:otherwise>
                        <option value=${sexo}> ${sexo}</option>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-12">
                <label for="cnt" class="control-label"> Cepa: </label>
                <select id="id_cepa" class="select2" name="id_cepa" required
                        oninvalid="setCustomValidity('Este campo es requerido')" style='background-color: #fff;' onchange="setCustomValidity('')">
                  <c:forEach items="${cepas}" var="cepa">
                    <c:choose>
                      <c:when test="${solicitud.getCepa().getId_cepa() == cepa.getId_cepa()}" >
                        <option value=${cepa.getId_cepa()} selected> ${cepa.getNombre()}</option>
                      </c:when>
                      <c:otherwise>
                        <option value=${cepa.getId_cepa()}> ${cepa.getNombre()}</option>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="form-group">
              <div class="modal-footer">                
                <a class="btn btn-danger btn-sm boton-danger "  data-dismiss="modal"  >Cancelar</a>
                <a class="btn btn-primary btn-sm boton-accion "  onclick="confirmarAuth()" >Aceptar</a>
              </div>
            </div>
          </form>


        </jsp:attribute>

      </t:modal>

      <t:modal idModal="ModalRechazar" titulo="Observaciones">

        <jsp:attribute name="form">
          <h5> �Est� seguro que desea rechazar esta solicitud? De ser as� por favor indique las observaciones: </h5>
          <form class="form-horizontal" id="form_modalrechazar" data-show-auth="${show_modal_auth}" method="post" action="SolicitudesRatonera">
            <input hidden="true" name="id_solicitud_rech" id="id_solicitud_rech" >
            <input hidden="true" name="accion" value="Rechazar" id="accion" >
            ${mensaje_auth}
            <label for="observaciones" class="control-label">Observaciones</label>
            <div class="form-group">
              <div class="col-sm-12">
                <div class="input-group" style="display:table;">
                  <textarea rows="5" cols="50" maxlength="500" placeholder="Observaciones" class="form-control" id="observaciones" name="observaciones_rechazo" >${ubicacion.getDescripcion()}</textarea>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times-circle"></i> Cancelar</button>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check-circle"></i> Aceptar</button>
              </div>
            </div>
          </form>


        </jsp:attribute>

      </t:modal>

    </jsp:attribute>
    <jsp:attribute name="scripts">
      <script src="/SIGIPRO/recursos/js/sigipro/solicitudesRatonera.js"></script>
    </jsp:attribute>

  </t:plantilla_general>

