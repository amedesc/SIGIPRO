/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.controlcalidad.dao;

import com.icp.sigipro.controlcalidad.modelos.AnalisisGrupoSolicitud;
import com.icp.sigipro.controlcalidad.modelos.Grupo;
import com.icp.sigipro.controlcalidad.modelos.Muestra;
import com.icp.sigipro.controlcalidad.modelos.SolicitudCC;
import com.icp.sigipro.controlcalidad.modelos.TipoMuestra;
import com.icp.sigipro.core.DAO;
import com.icp.sigipro.core.SIGIPROException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Boga
 */
public class AnalisisGrupoSolicitudDAO extends DAO {

    public AnalisisGrupoSolicitud obtenerIdentificadorYTipoMuestra(int id_ags) throws SIGIPROException {

        AnalisisGrupoSolicitud resultado = new AnalisisGrupoSolicitud();

        PreparedStatement consulta = null;
        ResultSet rs = null;

        try {

            consulta = getConexion().prepareStatement(
                    " SELECT m.identificador, tm.nombre, s.id_solicitud, s.numero_solicitud " 
                    + " FROM control_calidad.analisis_grupo_solicitud ags "
                    + " INNER JOIN control_calidad.grupos g ON g.id_grupo = ags.id_grupo "
                    + " INNER JOIN control_calidad.solicitudes s ON s.id_solicitud = g.id_solicitud "
                    + "	INNER JOIN control_calidad.grupos_muestras gm ON gm.id_grupo = ags.id_grupo "
                    + "	INNER JOIN control_calidad.muestras m ON m.id_muestra = gm.id_muestra "
                    + "	INNER JOIN control_calidad.tipos_muestras tm ON tm.id_tipo_muestra = m.id_tipo_muestra "
                    + " WHERE ags.id_analisis_grupo_solicitud = ?; "
            );

            consulta.setInt(1, id_ags);

            rs = consulta.executeQuery();
            Grupo grupo = new Grupo();
            resultado.setGrupo(grupo);
            if (rs.next()) {

                SolicitudCC s = new SolicitudCC();
                s.setId_solicitud(rs.getInt("id_solicitud"));
                s.setNumero_solicitud(rs.getString("numero_solicitud"));
                grupo.setSolicitud(s);

                do {

                    TipoMuestra tipo = new TipoMuestra();
                    Muestra muestra = new Muestra();

                    tipo.setNombre(rs.getString("nombre"));
                    muestra.setIdentificador(rs.getString("identificador"));
                    muestra.setTipo_muestra(tipo);
                    grupo.agregarMuestra(muestra);

                } while (rs.next());
            }

        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
            throw new SIGIPROException("Error de comunicación con la base de datos. Notifique al administrador del sistema.");
        } finally {
            cerrarSilencioso(rs);
            cerrarSilencioso(consulta);
            cerrarConexion();
        }

        return resultado;

    }

}
