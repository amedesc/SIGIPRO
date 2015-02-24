/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.bodegas.dao;

import com.icp.sigipro.bodegas.modelos.Ingreso;
import com.icp.sigipro.core.DAO;
import com.icp.sigipro.core.PropiedadModelo;
import java.lang.reflect.InvocationTargetException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Boga
 */
public class IngresoDAO extends DAO<Ingreso>
{

  public IngresoDAO()
  {
    super(Ingreso.class, "bodega", "ingresos");
  }

  @Override
  public Ingreso buscar(int id) throws SQLException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException
  {
    String codigoConsulta = "SELECT * FROM " + nombreModulo + "." + nombreTabla + " i INNER JOIN bodega.catalogo_interno ci on ci.id_producto = i.id_producto INNER JOIN seguridad.secciones s on i.id_seccion = s.id_seccion WHERE id_ingreso = ?;";
    
    Ingreso t = tipo.newInstance();
    
    PreparedStatement consulta = getConexion().prepareStatement(codigoConsulta);
    consulta.setInt(1, id);
    ResultSet resultado = ejecutarConsulta(consulta);
    resultado.next();
    return construirObjeto(t.getMetodos("set"), resultado);
  }

  @Override
  public List<Ingreso> buscarPor(String[] campos, Object valor)
  {
    throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public boolean actualizar(Ingreso param)
  {
    throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public boolean eliminar(Ingreso param)
  {
    throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public List<Ingreso> obtenerTodo() throws SQLException, InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException
  {
    return obtenerPorEstado(Ingreso.DISPONIBLE);
  }

  public List<Ingreso> obtenerPorEstado(String condicion) throws SQLException, InstantiationException, IllegalAccessException, InvocationTargetException, NoSuchMethodException
  {
    PreparedStatement consulta = construirConsultaObtenerTodo(condicion);
    return construirLista(ejecutarConsulta(consulta));
  }

  private PreparedStatement construirConsultaObtenerTodo(String condicion) throws SQLException, InstantiationException, IllegalAccessException, InvocationTargetException
  {
    String codigoConsulta = "SELECT * FROM " + nombreModulo + "." + nombreTabla + " i "
                            + " INNER JOIN bodega.catalogo_interno ci on ci.id_producto = " + "i.id_producto "
                            + " INNER JOIN seguridad.secciones s on s.id_seccion = i.id_seccion "
                            + " WHERE i.estado = ?";
    PreparedStatement consulta = getConexion().prepareStatement(codigoConsulta);
    consulta.setString(1, condicion);
    return consulta;
  }

  public boolean registrarIngreso(Ingreso param) throws NoSuchMethodException, IllegalAccessException, InstantiationException, InvocationTargetException, SQLException
  {
    boolean resultado = false;

    PreparedStatement insertIngreso = null;
    PreparedStatement upsertInventario = null;

    try {
      getConexion().setAutoCommit(false);
      insertIngreso = construirInsertar(param);

      if (!(param.getEstado().equalsIgnoreCase(Ingreso.CUARENTENA) || param.getEstado().equalsIgnoreCase(Ingreso.NO_DISPONIBLE))) {
        upsertInventario = construirUpsertInventario(param);
        upsertInventario.executeUpdate();
      }

      insertIngreso.executeUpdate();

      getConexion().commit();
      resultado = true;

    }
    catch (SQLException e) {
      resultado = false;
      e.printStackTrace();
      try {
        getConexion().rollback();
      }
      catch (SQLException ex) {
        ex.printStackTrace();
      }
    }
    finally {
      if (insertIngreso != null) {
        insertIngreso.close();
      }
      if (upsertInventario != null) {
        upsertInventario.close();
      }
      getConexion().setAutoCommit(true);
      getConexion().close();
    }
    return resultado;
  }
  
  public boolean actualizar(Ingreso ingreso, int diferencia) throws SQLException {
    
    boolean resultado = false;
    
    PreparedStatement actualizarIngreso = null;
    PreparedStatement actualizarInventario = null;
    
    boolean resultadoUpdate = false;
    boolean resultadoUpsert = true;
    
    try {

      getConexion().setAutoCommit(false);
      
      actualizarIngreso = getConexion().prepareStatement( " UPDATE bodega.ingresos "
                                                        + " SET id_producto = ?, "
                                                        + "     id_seccion = ?"
                                                        + "     fecha_ingreso = ?"
                                                        + "     fecha_registro = ?"
                                                        + "     fecha_vencimiento = ?"
                                                        + "     cantidad = ?"
                                                        + "     estado = ?"
                                                        + "     precio = ?"
                                                        + " WHERE id_ingreso = ?");
      
      actualizarIngreso.setInt(1, ingreso.getProducto().getId_producto());
      actualizarIngreso.setInt(2, ingreso.getSeccion().getId_seccion());
      actualizarIngreso.setDate(3, ingreso.getFecha_ingreso());
      actualizarIngreso.setDate(4, ingreso.getFecha_registro());
      actualizarIngreso.setDate(5, ingreso.getFecha_vencimiento());
      actualizarIngreso.setInt(6, ingreso.getCantidad());
      actualizarIngreso.setString(7, ingreso.getEstado());
      actualizarIngreso.setInt(8, ingreso.getPrecio());
      actualizarIngreso.setInt(9, ingreso.getId_ingreso());
      
      if(actualizarIngreso.executeUpdate() == 1){
        resultadoUpdate = true;
      } else {
        resultadoUpdate = false;
      }
      
      if(diferencia != 0) {
        ingreso.setCantidad(diferencia);
        actualizarInventario = construirUpsertInventario(ingreso);
        int filasActualizarInventario = actualizarInventario.executeUpdate();
        if ( filasActualizarInventario == 0 || filasActualizarInventario == 1) {
          resultadoUpsert = true;
        } else {
          resultadoUpsert = false;
        }
      } else {
        resultadoUpsert = true;
      }     
      
      resultado = resultadoUpsert && resultadoUpdate;
    }
    catch (SQLException e) {
      resultado = false;
      e.printStackTrace();
      try {
        getConexion().rollback();
      }
      catch (SQLException ex) {
        ex.printStackTrace();
      }
    }
    finally {
      if (resultado) {
        getConexion().commit();
      }
      if (actualizarIngreso != null) {
        actualizarIngreso.close();
      }
      if (actualizarInventario != null) {
        actualizarInventario.close();
      }
      getConexion().close();
    }
    return resultado;
  }

  private PreparedStatement construirUpsertInventario(Ingreso param) throws SQLException
  {
    PreparedStatement upsertInventario = getConexion().prepareStatement(
            " WITH upsert AS "
            + " (UPDATE bodega.inventarios SET stock_actual = stock_actual + ? "
            + "                            WHERE id_producto = ? and id_seccion = ? RETURNING *) "
            + "   INSERT INTO bodega.inventarios(id_producto, "
            + "                                  id_seccion, "
            + "                                  stock_actual "
            + "                                 ) "
            + "                               SELECT ?, "
            + "                                      ?, "
            + "                                      ?  "
            + "                               WHERE NOT EXISTS (SELECT * FROM upsert); ");

    upsertInventario.setInt(1, param.getCantidad());
    upsertInventario.setInt(6, param.getCantidad());

    upsertInventario.setInt(2, param.getProducto().getId_producto());
    upsertInventario.setInt(4, param.getProducto().getId_producto());

    upsertInventario.setInt(3, param.getSeccion().getId_seccion());
    upsertInventario.setInt(5, param.getSeccion().getId_seccion());

    return upsertInventario;
  }

  public boolean decisionesCuarentena(List<Ingreso> porAprobar, List<Ingreso> porRechazar) throws SQLException
  {
    boolean resultado = false;
    boolean resultadoAprobar = false;
    boolean resultadoRechazar = false;

    List<PreparedStatement> consultasAprobar = null;
    PreparedStatement consultaRechazar = null;

    try {

      if (porAprobar.size() > 0) {
        consultasAprobar = prepararConsultaDecision(porAprobar, Ingreso.DISPONIBLE);
      }

      if (porRechazar.size() > 0) {
        List<PreparedStatement> consultasRechazar = prepararConsultaDecision(porRechazar, Ingreso.RECHAZADO);
        consultaRechazar = consultasRechazar.get(0); //solo va a ser una
      }

      getConexion().setAutoCommit(false);

      if (consultasAprobar != null) {
        for (PreparedStatement p : consultasAprobar) {
          p.executeUpdate();
        }
        resultadoAprobar = true;
      }
      else {
        resultadoAprobar = true;
      }

      if (consultaRechazar != null) {
        if (consultaRechazar.executeUpdate() != porRechazar.size()) {
          resultadoRechazar = false;
        }
        else {
          resultadoRechazar = true;
        }
      }
      else {
        resultadoRechazar = true;
      }

      if (resultadoAprobar && resultadoRechazar) {
        resultado = true;
      }
      else {
        getConexion().rollback();
      }
    }
    catch (SQLException e) {
      resultado = false;
      e.printStackTrace();
      try {
        getConexion().rollback();
      }
      catch (SQLException ex) {
        ex.printStackTrace();
      }
    }
    finally {
      if (resultado) {
        getConexion().commit();
      }
      if (consultasAprobar != null) {
        for (PreparedStatement p : consultasAprobar) {
          p.close();
        }
      }
      if (consultaRechazar != null) {
        consultaRechazar.close();
      }

      getConexion().close();
    }
    return resultado;
  }

  private List<PreparedStatement> prepararConsultaDecision(List<Ingreso> ingresos, String estado) throws SQLException
  {
    List<PreparedStatement> listaConsultas = new ArrayList<PreparedStatement>();
    String stringConsulta = " UPDATE " + this.nombreModulo + "." + this.nombreTabla
                            + " SET estado = ? "
                            + " WHERE id_ingreso in (";

    for (Ingreso i : ingresos) {
      stringConsulta += "?,";
    }

    stringConsulta = stringConsulta.substring(0, stringConsulta.length() - 1);
    stringConsulta += ");";

    System.out.println(stringConsulta);

    PreparedStatement consulta = getConexion().prepareStatement(stringConsulta);

    consulta.setString(1, estado);
    int index = 2;

    for (Ingreso i : ingresos) {
      consulta.setInt(index, i.getId_ingreso());
      index++;
      if (estado.equals(Ingreso.DISPONIBLE)) {
        listaConsultas.add(this.construirUpsertInventario(i));
      }
    }

    listaConsultas.add(consulta);

    return listaConsultas;
  }
}
