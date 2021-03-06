/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.bodegas.modelos;

import com.icp.sigipro.configuracion.modelos.Seccion;
import com.icp.sigipro.seguridad.modelos.Usuario;
import java.lang.reflect.Field;
import org.json.JSONObject;

/**
 *
 * @author Amed
 */
public class Prestamo {
  private int id_solicitud;
  private int id_seccion_presta;
  private int id_usuario_aprobo;
  
  private Solicitud solicitud;
  private Seccion  seccion_presta;
  private Usuario usuario_aprobo;
  
  public Prestamo(){}
  
      //Parsea a JSON la clase de forma automatica y estandarizada para todas las clases
    public String parseJSON(){
        Class _class = this.getClass();
        JSONObject JSON = new JSONObject();
        try{
            Field properties[] = _class.getDeclaredFields();
            for (int i = 0; i < properties.length; i++) {
                Field field = properties[i];
                if (i != 0){
                    JSON.put(field.getName(), field.get(this));
                }else{
                    JSON.put("id_objeto", field.get(this));
                }
            }          
        }catch (Exception e){
            
        }
        return JSON.toString();
    }

  public void setId_solicitud(int id){ this.id_solicitud = id;}
  public void setId_seccion_presta(int id){ this.id_seccion_presta = id;}
  public void setId_usuario_aprobo(int id){ this.id_usuario_aprobo = id;}
  
   public void setSolicitud(Solicitud s){this.solicitud = s;}
   public void setSeccion(Seccion s){this.seccion_presta = s;}
   public void setUsuario(Usuario s){this.usuario_aprobo = s;}
   
  public int getId_solicitud () {return id_solicitud; }
  public int getId_seccion_presta () {return id_seccion_presta; }
  public int getId_usuario_aprobo(){ return id_usuario_aprobo;}
  public Solicitud getSolicitud(){return solicitud;}
  public Usuario getUsuario(){return usuario_aprobo;}
  public Seccion getSeccion(){return seccion_presta;}
}
