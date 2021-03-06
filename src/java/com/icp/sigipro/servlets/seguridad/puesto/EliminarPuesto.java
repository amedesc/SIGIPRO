/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.servlets.seguridad.puesto;

import com.icp.sigipro.bitacora.dao.BitacoraDAO;
import com.icp.sigipro.bitacora.modelo.Bitacora;
import com.icp.sigipro.core.SIGIPROServlet;
import com.icp.sigipro.seguridad.dao.PuestoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.security.sasl.AuthenticationException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Walter
 */
@WebServlet(name = "EliminarPuesto", urlPatterns = {"/Seguridad/Puestos/EliminarPuesto"})
public class EliminarPuesto extends SIGIPROServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EliminarPuesto</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EliminarPuesto at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
              try{
                HttpSession sesion = request.getSession();
                List<Integer> listaPermisos = (List<Integer>) sesion.getAttribute("listaPermisos");
                if(validarPermiso(listaPermisos)) {
                  processRequest(request, response);
                } else {
                  throw new AuthenticationException();
                }
              } catch(AuthenticationException ex){
                ServletContext context = this.getServletContext();
                context.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
              }

        PrintWriter out;
        out = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        try {
            String id_puesto = request.getParameter("controlIDPuesto");

            PuestoDAO s = new PuestoDAO();

            boolean Exito = s.EliminarPuesto(id_puesto);
            
            //Funcion que genera la bitacora
            BitacoraDAO bitacora = new BitacoraDAO();
            bitacora.setBitacora(Integer.parseInt(id_puesto),Bitacora.ACCION_ELIMINAR,request.getSession().getAttribute("usuario"),Bitacora.TABLA_PUESTO,request.getRemoteAddr());
            //*----------------------------*

            if (Exito) {
                request.setAttribute("mensaje", "<div class=\"alert alert-success alert-dismissible\" role=\"alert\">"
                        + "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>\n"
                        + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span aria-hidden=\"true\">&times;</span><span class=\"sr-only\">Close</span></button>"
                        + "El puesto se ha eliminado correctamente"
                        + "</div>");
            } else {
                request.setAttribute("mensaje", "<div class=\"alert alert-danger alert-dismissible\" role=\"alert\">"
                        + "<span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>\n"
                        + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span aria-hidden=\"true\">&times;</span><span class=\"sr-only\">Close</span></button>"
                        + "El puesto no pudo ser eliminado porque está asignado a uno o más usuarios"
                        + "</div>");
            }
            request.getRequestDispatcher("/Seguridad/Puestos/").forward(request, response);

        } finally {
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    @Override
    protected int getPermiso() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
