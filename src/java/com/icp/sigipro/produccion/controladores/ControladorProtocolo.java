/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.produccion.controladores;

import com.icp.sigipro.bitacora.modelo.Bitacora;
import com.icp.sigipro.core.SIGIPROServlet;
import com.icp.sigipro.produccion.dao.Catalogo_PTDAO;
import com.icp.sigipro.produccion.dao.Formula_MaestraDAO;
import com.icp.sigipro.produccion.dao.ProtocoloDAO;
import com.icp.sigipro.produccion.modelos.Catalogo_PT;
import com.icp.sigipro.produccion.modelos.Formula_Maestra;
import com.icp.sigipro.produccion.modelos.Paso;
import com.icp.sigipro.produccion.modelos.Protocolo;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ld.conejo
 */
@WebServlet(name = "ControladorProtocolo", urlPatterns = {"/Produccion/Protocolo"})
public class ControladorProtocolo extends SIGIPROServlet {

    //Falta implementar
    private final int[] permisos = {640, 641, 642, 643, 644};
    //-----------------
    private final ProtocoloDAO dao = new ProtocoloDAO();
    private final Formula_MaestraDAO formuladao = new Formula_MaestraDAO();
    private final Catalogo_PTDAO catalogodao = new Catalogo_PTDAO();

    protected final Class clase = ControladorProtocolo.class;
    protected final List<String> accionesGet = new ArrayList<String>() {
        {
            add("index");
            add("ver");
            add("agregar");
            add("eliminar");
            add("editar");
            add("aprobar");

        }
    };
    protected final List<String> accionesPost = new ArrayList<String>() {
        {
            add("agregar");
            add("editar");
            add("rechazar");
        }
    };

    // <editor-fold defaultstate="collapsed" desc="Métodos Get">
    protected void getAgregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);

        String redireccion = "Protocolo/Agregar.jsp";
        Protocolo p = new Protocolo();
        List<Formula_Maestra> formulas_maestras = formuladao.obtenerFormulas_Maestras();
        request.setAttribute("protocolo", p);
        request.setAttribute("formulas_maestras", formulas_maestras);
        //Meter Catalogo de Producto Terminado
        request.setAttribute("catalogo_pt", catalogodao.obtenerCatalogos_PT());
        //Meter Pasos de Protocolo
        //request.setAttribute("pasos","['1','Nombre']");
        request.setAttribute("accion", "Agregar");
        redireccionar(request, response, redireccion);
    }

    protected void getIndex(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermisosMultiple(permisos, request);
        String redireccion = "Protocolo/index.jsp";
        List<Protocolo> protocolos = dao.obtenerProtocolos();
        request.setAttribute("listaProtocolos", protocolos);
        redireccionar(request, response, redireccion);
    }

    protected void getVer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermisosMultiple(permisos, request);
        String redireccion = "Protocolo/Ver.jsp";
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        try {
            Protocolo p = dao.obtenerProtocolo(id_protocolo);
            request.setAttribute("protocolo", p);
            redireccionar(request, response, redireccion);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    protected void getEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);
        String redireccion = "Protocolo/Editar.jsp";
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        Protocolo p = dao.obtenerProtocolo(id_protocolo);
        request.setAttribute("protocolo", p);
        request.setAttribute("accion", "Editar");
        redireccionar(request, response, redireccion);

    }

    protected void getEliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        boolean resultado = false;
        try {
            resultado = dao.eliminarProtocolo(id_protocolo);
            if (resultado) {
                //Funcion que genera la bitacora 
                bitacora.setBitacora(id_protocolo, Bitacora.ACCION_ELIMINAR, request.getSession().getAttribute("usuario"), Bitacora.TABLA_PROTOCOLO, request.getRemoteAddr());
                //----------------------------
                request.setAttribute("mensaje", helper.mensajeDeExito("Protocolo eliminado correctamente"));
            } else {
                request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser eliminado ya que tiene elementos asociados."));
            }
            this.getIndex(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser eliminado ya que tiene elementos asociados."));
            this.getIndex(request, response);
        }

    }

    protected void getAprobar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        //1 - Calidad, 2 - Regente, 3 - Coordinador, 4 - Director
        int actor = Integer.parseInt(request.getParameter("actor"));
        Protocolo p = dao.obtenerAprobaciones(id_protocolo);
        boolean resultado = false;
        try {
            switch (actor) {
                case 1:
                    validarPermiso(641, request);
                    resultado = dao.aprobarProtocolo(id_protocolo, actor);
                    p.setAprobacion_calidad(true);
                    break;
                case 2:
                    validarPermiso(642, request);
                    if (p.getAprobacion_calidad()) {
                        resultado = dao.aprobarProtocolo(id_protocolo, actor);
                        p.setAprobacion_regente(true);
                    }
                    break;
                case 3:
                    validarPermiso(643, request);
                    if (p.getAprobacion_calidad()) {
                        resultado = dao.aprobarProtocolo(id_protocolo, actor);
                        p.setAprobacion_coordinador(true);
                    }
                    break;
                case 4:
                    validarPermiso(644, request);
                    if (p.getAprobacion_calidad() && p.getAprobacion_coordinador() && p.getAprobacion_regente()) {
                        resultado = dao.aprobarProtocolo(id_protocolo, actor);
                        p.setAprobacion_direccion(true);
                    }
                    break;
            }
            if (resultado) {
                //Funcion que genera la bitacora 
                bitacora.setBitacora(p.parseJSON(), Bitacora.ACCION_APROBAR, request.getSession().getAttribute("usuario"), Bitacora.TABLA_PROTOCOLO, request.getRemoteAddr());
                //----------------------------
                request.setAttribute("mensaje", helper.mensajeDeExito("Protocolo aprobado correctamente"));
            } else {
                request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser aprobado. Le faltan otras aprobaciones para estar validado."));
            }
            this.getIndex(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser aprobado."));
            this.getIndex(request, response);
        }

    }
    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Métodos Post">
    protected void postAgregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);
        boolean resultado = false;
        Protocolo p = construirObjeto(request);
        resultado = dao.insertarProtocolo(p);
        if (resultado) {
            request.setAttribute("mensaje", helper.mensajeDeExito("Protocolo agregado correctamente"));
            //Funcion que genera la bitacora
            bitacora.setBitacora(p.parseJSON(), Bitacora.ACCION_AGREGAR, request.getSession().getAttribute("usuario"), Bitacora.TABLA_PROTOCOLO, request.getRemoteAddr());
            //*----------------------------*
            this.getIndex(request, response);
        } else {
            request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser agregado. Inténtelo de nuevo."));
            this.getAgregar(request, response);
        }

    }

    protected void postEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);
        boolean resultado = false;
        Protocolo p = construirObjeto(request);
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        p.setId_protocolo(id_protocolo);
        resultado = dao.editarProtocolo(p);
        if (resultado) {
            //Funcion que genera la bitacora
            bitacora.setBitacora(p.parseJSON(), Bitacora.ACCION_EDITAR, request.getSession().getAttribute("usuario"), Bitacora.TABLA_PROTOCOLO, request.getRemoteAddr());
            //*----------------------------*
            request.setAttribute("mensaje", helper.mensajeDeExito("Protocolo editado correctamente"));
            this.getIndex(request, response);
        } else {
            request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser editado. Inténtelo de nuevo."));
            request.setAttribute("id_protocolo", id_protocolo);
            this.getEditar(request, response);
        }
    }
    
    protected void postRechazar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validarPermiso(640, request);
        boolean resultado = false;
        Protocolo p = new Protocolo();
        int id_protocolo = Integer.parseInt(request.getParameter("id_protocolo"));
        p.setId_protocolo(id_protocolo);
        String observaciones = request.getParameter("observaciones");
        String actor = request.getParameter("actor");
        p.setObservaciones(observaciones + " - Rechazada por: "+actor);
        resultado = dao.rechazarProtocolo(p.getId_protocolo(), p.getObservaciones());
        if (resultado) {
            //Funcion que genera la bitacora
            bitacora.setBitacora(p.parseJSON(), Bitacora.ACCION_RECHAZAR, request.getSession().getAttribute("usuario"), Bitacora.TABLA_PROTOCOLO, request.getRemoteAddr());
            //*----------------------------*
            request.setAttribute("mensaje", helper.mensajeDeExito("Protocolo rechazado correctamente"));
            this.getIndex(request, response);
        } else {
            request.setAttribute("mensaje", helper.mensajeDeError("Protocolo no pudo ser rechazado. Inténtelo de nuevo."));
            this.getIndex(request, response);
        }
    }
  // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="Métodos Modelo">
    private Protocolo construirObjeto(HttpServletRequest request) {
        Protocolo p = new Protocolo();
        p.setNombre(request.getParameter("nombre"));
        p.setDescripcion(request.getParameter("descripcion"));
        Catalogo_PT pt = new Catalogo_PT();
        //pt.setId_catalogo_pt(Integer.parseInt(request.getParameter("id_catalogo_pt")));
        p.setProducto(pt);
        Formula_Maestra fm = new Formula_Maestra();
        fm.setId_formula_maestra(Integer.parseInt(request.getParameter("id_formula_maestra")));
        p.setFormula_maestra(fm);
        
        //Meter los pasos
        
        return p;
    }
    
    public List<String> parseListaPasos(List<Paso> pasos) {
        List<String> respuesta = new ArrayList<String>();
        for (Paso p : pasos) {
            String tipo = "[";
            tipo += p.getId_paso() + ",";
            tipo += "\"" + p.getNombre() + "\"]";
            respuesta.add(tipo);
        }
        return respuesta;
    }

    // </editor-fold>
    // <editor-fold defaultstate="collapsed" desc="Métodos abstractos sobreescritos">
    @Override
    protected void ejecutarAccion(HttpServletRequest request, HttpServletResponse response, String accion, String accionHTTP) throws ServletException, IOException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        List<String> lista_acciones;
        if (accionHTTP.equals("get")) {
            lista_acciones = accionesGet;
        } else {
            lista_acciones = accionesPost;
        }
        if (lista_acciones.contains(accion.toLowerCase())) {
            String nombreMetodo = accionHTTP + Character.toUpperCase(accion.charAt(0)) + accion.substring(1);
            Method metodo = clase.getDeclaredMethod(nombreMetodo, HttpServletRequest.class, HttpServletResponse.class);
            metodo.invoke(this, request, response);
        } else {
            Method metodo = clase.getDeclaredMethod(accionHTTP + "Index", HttpServletRequest.class, HttpServletResponse.class);
            metodo.invoke(this, request, response);
        }
    }

    @Override
    protected int getPermiso() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

  // </editor-fold>
}
