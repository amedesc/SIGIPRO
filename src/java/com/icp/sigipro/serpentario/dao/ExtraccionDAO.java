/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.serpentario.dao;

import com.icp.sigipro.basededatos.SingletonBD;
import com.icp.sigipro.seguridad.dao.UsuarioDAO;
import com.icp.sigipro.seguridad.modelos.Usuario;
import com.icp.sigipro.serpentario.modelos.Centrifugado;
import com.icp.sigipro.serpentario.modelos.Extraccion;
import com.icp.sigipro.serpentario.modelos.Serpiente;
import com.icp.sigipro.serpentario.modelos.SerpientesExtraccion;
import com.icp.sigipro.serpentario.modelos.UsuariosExtraccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author ld.conejo
 */
public class ExtraccionDAO {
    private Connection conexion;
    
    
    public ExtraccionDAO()
    {
        SingletonBD s = SingletonBD.getSingletonBD();
        conexion = s.conectar();
    } 
    
    
    public boolean insertarExtraccion(Extraccion e){
        boolean resultado = false;
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" INSERT INTO serpentario.extraccion (numero_extraccion, id_especie,ingreso_cv,fecha_extraccion) " +
                                                             " VALUES (?,?,?,?) RETURNING id_extraccion");
            consulta.setString(1, e.getNumero_extraccion());
            consulta.setInt(2, e.getEspecie().getId_especie());
            consulta.setBoolean(3, e.isIngreso_cv());
            consulta.setDate(4, e.getFecha_extraccion());
            
            ResultSet resultadoConsulta = consulta.executeQuery();
            if ( resultadoConsulta.next() ){
                resultado = true;
                e.setId_extraccion(resultadoConsulta.getInt("id_extraccion"));
            }
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
    }
    
    public boolean editarExtraccion(Extraccion e){
        boolean resultado = false;
        try{
            PreparedStatement consulta = getConexion().prepareStatement("UPDATE serpentario.extraccion "
                    + "SET volumen_extraido=?, id_usuario_registro = ?, fecha_registro = ?"
                    + "WHERE id_extraccion=?");

            consulta.setFloat(1,e.getVolumen_extraido());
            consulta.setInt(2,e.getUsuario_registro().getId_usuario());
            consulta.setDate(3,e.getFecha_registro());
            consulta.setInt(4,e.getId_extraccion());
            
            ResultSet resultadoConsulta = consulta.executeQuery();
            if ( resultadoConsulta.next() ){
                resultado = true;
            }
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
    }
    
    public boolean insertarUsuariosExtraccion(List<UsuariosExtraccion> usuariosextraccion){
        boolean resultado = false;
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" INSERT INTO serpentario.usuarios_extraccion (id_extraccion,id_usuario) " +
                                                             " VALUES (?,?);");
            
            if (usuariosextraccion != null){
                
                for (UsuariosExtraccion usuarioextraccion : usuariosextraccion){
                    consulta.setInt(1, usuarioextraccion.getExtraccion().getId_extraccion());
                    consulta.setInt(2, usuarioextraccion.getUsuario().getId_usuario());
                    consulta.executeUpdate();
                }
                resultado = true;
            }

            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
    }
    
    public boolean insertarSerpientesExtraccion(List<SerpientesExtraccion> serpientesextraccion){
        boolean resultado = false;
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" INSERT INTO serpentario.serpientes_extraccion (id_extraccion,id_serpiente) " +
                                                             " VALUES (?,?);");
            
            if (serpientesextraccion != null){
                
                for (SerpientesExtraccion serpienteextraccion : serpientesextraccion){
                    consulta.setInt(1, serpienteextraccion.getExtraccion().getId_extraccion());
                    consulta.setInt(2, serpienteextraccion.getSerpiente().getId_serpiente());
                    consulta.executeUpdate();
                }
                resultado = true;
            }

            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
        
    }
    
      public List<SerpientesExtraccion> parsearSerpientesExtraccion(String serpientes, int id_extraccion) {
            List<SerpientesExtraccion> resultado = null;
            try {
              resultado = new ArrayList<SerpientesExtraccion>();
              List<String> serpientesParcial = new LinkedList<String>(Arrays.asList(serpientes.split("#r#")));
              serpientesParcial.remove("");
              
              SerpienteDAO serpientedao = new SerpienteDAO();
              
              for (String i : serpientesParcial) {
                String[] serpiente = i.split("#c#");
                Extraccion e = this.obtenerExtraccion(id_extraccion);
                Serpiente s = serpientedao.obtenerSerpiente(Integer.parseInt(serpiente[0]));
                resultado.add(new SerpientesExtraccion(s,e));
              }
            } catch (Exception ex) {
              ex.printStackTrace();
              resultado = null;
            }
            return resultado;
          }
    
    public List<Serpiente> obtenerSerpientesExtraccion(int id_extraccion){
        List<Serpiente> resultado = new ArrayList<Serpiente>();
        try{
            PreparedStatement consulta = getConexion().prepareStatement("SELECT serpientes.id_serpiente FROM serpentario.serpientes_extraccion as extraccion INNER JOIN serpentario.serpientes as serpientes ON extraccion.id_serpiente = serpientes.id_serpiente WHERE id_extraccion=?;");
            
            consulta.setInt(1, id_extraccion);
            ResultSet rs = consulta.executeQuery();
            SerpienteDAO serpientedao = new SerpienteDAO();
            while(rs.next()){
                int id_serpiente = rs.getInt("id_serpiente");
                Serpiente serpiente = serpientedao.obtenerSerpiente(id_serpiente);
                resultado.add(serpiente);
            }

            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
        
    }
    
    public List<Usuario> obtenerUsuariosExtraccion(int id_extraccion){
        List<Usuario> resultado = new ArrayList<Usuario>();
        try{
            PreparedStatement consulta = getConexion().prepareStatement("SELECT usuarios.id_usuario FROM serpentario.usuarios_extraccion as extraccion INNER JOIN seguridad.usuarios as usuarios ON extraccion.id_usuario = usuarios.id_usuario WHERE id_extraccion=?;");
            
            consulta.setInt(1, id_extraccion);
            ResultSet rs = consulta.executeQuery();
            UsuarioDAO usuariodao = new UsuarioDAO();
            while(rs.next()){
                int id_usuario = rs.getInt("id_usuario");
                Usuario usuario = usuariodao.obtenerUsuario(id_usuario);
                resultado.add(usuario);
            }

            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
        
    }
    
    public List<Extraccion> obtenerExtracciones(){
        List<Extraccion> resultado = new ArrayList<Extraccion>();
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" SELECT * FROM serpentario.extraccion ");
            ResultSet rs = consulta.executeQuery();
            EspecieDAO especiedao = new EspecieDAO();
            UsuarioDAO usuariodao = new UsuarioDAO();
            while(rs.next()){
                Extraccion extraccion = new Extraccion();
                extraccion.setId_extraccion(rs.getInt("id_extraccion"));
                extraccion.setFecha_extraccion(rs.getDate("fecha_extraccion"));
                extraccion.setFecha_registro(rs.getDate("fecha_registro"));
                extraccion.setIngreso_cv(rs.getBoolean("ingreso_cv"));
                extraccion.setNumero_extraccion(rs.getString("numero_extraccion"));
                extraccion.setVolumen_extraido(rs.getFloat("volumen_extraido"));
                extraccion.setEspecie(especiedao.obtenerEspecie(rs.getInt("id_especie")));
                extraccion.setUsuario_registro(usuariodao.obtenerUsuario(rs.getInt("id_usuario_registro")));
                validarExtraccion(extraccion);
                resultado.add(extraccion);
            }      
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return resultado;
    }
    
    public void validarExtraccion(Extraccion e){
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" SELECT * FROM serpentario.serpientes_extraccion WHERE id_extraccion=? ");
            consulta.setInt(1, e.getId_extraccion());
            ResultSet rs = consulta.executeQuery();
            boolean resultado = false;
            if(rs.next()){
                resultado = true;
            }     
            if (resultado){
                e.setIsSerpiente(true);
            }else{
                e.setIsSerpiente(false);
            }
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
    public Extraccion obtenerExtraccion(int id_extraccion){
        Extraccion extraccion = new Extraccion();
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" SELECT * FROM serpentario.extraccion WHERE id_extraccion=?; ");
            consulta.setInt(1, id_extraccion);
            ResultSet rs = consulta.executeQuery();
            EspecieDAO especiedao = new EspecieDAO();
            UsuarioDAO usuariodao = new UsuarioDAO();
            while(rs.next()){
                extraccion.setId_extraccion(rs.getInt("id_extraccion"));
                extraccion.setFecha_extraccion(rs.getDate("fecha_extraccion"));
                extraccion.setFecha_registro(rs.getDate("fecha_registro"));
                extraccion.setIngreso_cv(rs.getBoolean("ingreso_cv"));
                extraccion.setNumero_extraccion(rs.getString("numero_extraccion"));
                extraccion.setVolumen_extraido(rs.getFloat("volumen_extraido"));
                extraccion.setEspecie(especiedao.obtenerEspecie(rs.getInt("id_especie")));
                extraccion.setUsuario_registro(usuariodao.obtenerUsuario(rs.getInt("id_usuario_registro")));
            }      
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return extraccion;
    }
    
    public Extraccion obtenerCentrifugado(int id_extraccion){
        Centrifugado centrifugado = new Centrifugado();
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" SELECT * FROM serpentario.centrifugado WHERE id_extraccion=?; ");
            consulta.setInt(1, id_extraccion);
            ResultSet rs = consulta.executeQuery();
            UsuarioDAO usuariodao = new UsuarioDAO();
            while(rs.next()){
                centrifugado.setId_extraccion(rs.getInt("id_extraccion"));
                centrifugado.setFecha_volumen_recuperado(rs.getDate("fecha_volumen_recuperado"));
                centrifugado.setVolumen_recuperado(rs.getFloat("volumen_recuperado"));
                centrifugado.setUsuario(usuariodao.obtenerUsuario(rs.getInt("id_usuario")));
            }      
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return extraccion;
    }
    
    public Extraccion obtenerLiofilizacion(int id_extraccion){
        Extraccion extraccion = new Extraccion();
        try{
            PreparedStatement consulta = getConexion().prepareStatement(" SELECT * FROM serpentario.extraccion WHERE id_extraccion=?; ");
            consulta.setInt(1, id_extraccion);
            ResultSet rs = consulta.executeQuery();
            EspecieDAO especiedao = new EspecieDAO();
            UsuarioDAO usuariodao = new UsuarioDAO();
            while(rs.next()){
                extraccion.setId_extraccion(rs.getInt("id_extraccion"));
                extraccion.setFecha_extraccion(rs.getDate("fecha_extraccion"));
                extraccion.setFecha_registro(rs.getDate("fecha_registro"));
                extraccion.setIngreso_cv(rs.getBoolean("ingreso_cv"));
                extraccion.setNumero_extraccion(rs.getString("numero_extraccion"));
                extraccion.setVolumen_extraido(rs.getFloat("volumen_extraido"));
                extraccion.setEspecie(especiedao.obtenerEspecie(rs.getInt("id_especie")));
                extraccion.setUsuario_registro(usuariodao.obtenerUsuario(rs.getInt("id_usuario_registro")));
            }      
            consulta.close();
            conexion.close();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return extraccion;
    }
    
    private Connection getConexion(){
        try{     
            if ( conexion.isClosed() ){
                SingletonBD s = SingletonBD.getSingletonBD();
                conexion = s.conectar();
            }
        }
        catch(Exception ex)
        {
            conexion = null;
        }
        return conexion;
    } 
}
