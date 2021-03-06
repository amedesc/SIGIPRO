/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.seguridad.dao;

import com.icp.sigipro.basededatos.SingletonBD;
import com.icp.sigipro.seguridad.modelos.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Amed
 */
public class PermisoRolDAO
{

    public boolean insertarPermisoRol(int idrol, int idpermiso)
    {
        boolean resultado = false;

        try {
            SingletonBD s = SingletonBD.getSingletonBD();
            Connection conexion = s.conectar();

            if (conexion != null) {
                PreparedStatement consulta = conexion.prepareStatement("INSERT INTO SEGURIDAD.permisos_roles "
                                                                       + " (id_rol, id_permiso) "
                                                                       + " VALUES "
                                                                       + " (?,? )");
                consulta.setInt(1, idrol);
                consulta.setInt(2, idpermiso);
                int resultadoConsulta = consulta.executeUpdate();
                if (resultadoConsulta == 1) {
                    resultado = true;
                }
                consulta.close();
                conexion.close();
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

        return resultado;
    }

    public boolean EliminarPermisoRol(int p_idrol, int p_idpermiso)
    {
        boolean resultado = false;

        try {
            SingletonBD s = SingletonBD.getSingletonBD();
            Connection conexion = s.conectar();

            if (conexion != null) {
                PreparedStatement consulta = conexion.prepareStatement("DELETE FROM seguridad.permisos_roles s "
                                                                       + "WHERE  s.id_rol = ? AND s.id_permiso = ? "
                );
                consulta.setInt(1, p_idrol);
                consulta.setInt(2, p_idpermiso);
                int resultadoConsulta = consulta.executeUpdate();
                if (resultadoConsulta == 1) {
                    resultado = true;
                }
                consulta.close();
                conexion.close();
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

        return resultado;
    }

    public List<PermisoRol> parsearUsuarios(String[] permisos, int idRol)
    {
        List<PermisoRol> resultado = new ArrayList<PermisoRol>();
        for (String permiso : permisos) {
            resultado.add(new PermisoRol(idRol, Integer.parseInt(permiso)));
        }
        return resultado;
    }
}
