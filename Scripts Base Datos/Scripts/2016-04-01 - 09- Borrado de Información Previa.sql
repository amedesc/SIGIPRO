ALTER TABLE control_calidad.tipos_equipos_analisis DROP CONSTRAINT analisis_equipos_analisis;
ALTER TABLE control_calidad.analisis_grupo_solicitud DROP CONSTRAINT analisis_grupo_solicitud_analisis;
ALTER TABLE control_calidad.tipos_reactivos_analisis DROP CONSTRAINT analisis_reactivos_analisis;
ALTER TABLE control_calidad.tipos_muestras_analisis DROP CONSTRAINT tipos_muestras_analisis_analisis;
ALTER TABLE control_calidad.certificados_equipos DROP CONSTRAINT certificadoequipo_equipo;
ALTER TABLE control_calidad.certificados_reactivos DROP CONSTRAINT certificadoreactivo_reactivo;
ALTER TABLE control_calidad.equipos_resultado DROP CONSTRAINT equipos_resultado_resultados;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_resultado;
ALTER TABLE control_calidad.patrones_resultados DROP CONSTRAINT fk_patrones_resultados_resultados;
ALTER TABLE control_calidad.reactivos_resultado DROP CONSTRAINT reacivos_resultado_resultados;
ALTER TABLE control_calidad.patrones_resultados DROP CONSTRAINT fk_patrones_resultados_patrones;
ALTER TABLE control_calidad.patrones_resultados_sp DROP CONSTRAINT fk_patrones_resultados_sp_patrones;
ALTER TABLE control_calidad.informes DROP CONSTRAINT fk_informes_solicitudes;
ALTER TABLE control_calidad.grupos DROP CONSTRAINT grupos_solicitud;
ALTER TABLE control_calidad.tipos_reactivos_analisis DROP CONSTRAINT analisis_reactivos_tiposreactivo;
ALTER TABLE control_calidad.reactivos DROP CONSTRAINT reactivo_tiporeactivo;
ALTER TABLE control_calidad.tipos_equipos_analisis DROP CONSTRAINT analisis_equipos_tiposequipo;
ALTER TABLE control_calidad.equipos DROP CONSTRAINT equipo_tipoequipo;
ALTER TABLE control_calidad.muestras DROP CONSTRAINT muestras_tipo_muestra;
ALTER TABLE control_calidad.tipos_muestras_analisis DROP CONSTRAINT tipos_muestras_analisis_tipos_muestras;
ALTER TABLE control_calidad.resultados DROP CONSTRAINT resultado_analisis_grupo_solicitud;
ALTER TABLE control_calidad.resultados_analisis_sangrias_prueba DROP CONSTRAINT fk_resultados_sp_ags;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_informe;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_resultados_sp;
ALTER TABLE control_calidad.equipos_resultado_sp DROP CONSTRAINT equipos_resultado_resultados_sp;
ALTER TABLE control_calidad.patrones_resultados_sp DROP CONSTRAINT fk_patrones_resultados_resultados_sp;
ALTER TABLE control_calidad.reactivos_resultado_sp DROP CONSTRAINT reacivos_resultado_resultados_sp;

ALTER TABLE control_calidad.tipos_equipos_analisis ADD CONSTRAINT analisis_equipos_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis) ON DELETE CASCADE;
ALTER TABLE control_calidad.analisis_grupo_solicitud ADD CONSTRAINT analisis_grupo_solicitud_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis) ON DELETE CASCADE;
ALTER TABLE control_calidad.tipos_reactivos_analisis ADD CONSTRAINT analisis_reactivos_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis) ON DELETE CASCADE;
ALTER TABLE control_calidad.tipos_muestras_analisis ADD CONSTRAINT tipos_muestras_analisis_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis) ON DELETE CASCADE;
ALTER TABLE control_calidad.certificados_equipos ADD CONSTRAINT certificadoequipo_equipo FOREIGN KEY (id_equipo) REFERENCES control_calidad.equipos(id_equipo) ON DELETE CASCADE;
ALTER TABLE control_calidad.certificados_reactivos ADD CONSTRAINT certificadoreactivo_reactivo FOREIGN KEY (id_reactivo) REFERENCES control_calidad.reactivos(id_reactivo) ON DELETE CASCADE;
ALTER TABLE control_calidad.equipos_resultado ADD CONSTRAINT equipos_resultado_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado) ON DELETE CASCADE;
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_resultado FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado) ON DELETE CASCADE;
ALTER TABLE control_calidad.patrones_resultados ADD CONSTRAINT fk_patrones_resultados_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado) ON DELETE CASCADE;
ALTER TABLE control_calidad.reactivos_resultado ADD CONSTRAINT reacivos_resultado_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado) ON DELETE CASCADE;
ALTER TABLE control_calidad.patrones_resultados ADD CONSTRAINT fk_patrones_resultados_patrones FOREIGN KEY (id_patron) REFERENCES control_calidad.patrones(id_patron) ON DELETE CASCADE;
ALTER TABLE control_calidad.patrones_resultados_sp ADD CONSTRAINT fk_patrones_resultados_sp_patrones FOREIGN KEY (id_patron) REFERENCES control_calidad.patrones(id_patron) ON DELETE CASCADE;
ALTER TABLE control_calidad.informes ADD CONSTRAINT fk_informes_solicitudes FOREIGN KEY (id_solicitud) REFERENCES control_calidad.solicitudes(id_solicitud) ON DELETE CASCADE;
ALTER TABLE control_calidad.grupos ADD CONSTRAINT grupos_solicitud FOREIGN KEY (id_solicitud) REFERENCES control_calidad.solicitudes(id_solicitud) ON DELETE CASCADE;
ALTER TABLE control_calidad.tipos_reactivos_analisis ADD CONSTRAINT analisis_reactivos_tiposreactivo FOREIGN KEY (id_tipo_reactivo) REFERENCES control_calidad.tipos_reactivos(id_tipo_reactivo) ON DELETE CASCADE;
ALTER TABLE control_calidad.reactivos ADD CONSTRAINT reactivo_tiporeactivo FOREIGN KEY (id_tipo_reactivo) REFERENCES control_calidad.tipos_reactivos(id_tipo_reactivo) ON DELETE CASCADE;
ALTER TABLE control_calidad.tipos_equipos_analisis ADD CONSTRAINT analisis_equipos_tiposequipo FOREIGN KEY (id_tipo_equipo) REFERENCES control_calidad.tipos_equipos(id_tipo_equipo) ON DELETE CASCADE;
ALTER TABLE control_calidad.equipos ADD CONSTRAINT equipo_tipoequipo FOREIGN KEY (id_tipo_equipo) REFERENCES control_calidad.tipos_equipos(id_tipo_equipo) ON DELETE CASCADE;
ALTER TABLE control_calidad.muestras ADD CONSTRAINT muestras_tipo_muestra FOREIGN KEY (id_tipo_muestra) REFERENCES control_calidad.tipos_muestras(id_tipo_muestra) ON DELETE CASCADE;
ALTER TABLE control_calidad.tipos_muestras_analisis ADD CONSTRAINT tipos_muestras_analisis_tipos_muestras FOREIGN KEY (id_tipo_muestra) REFERENCES control_calidad.tipos_muestras(id_tipo_muestra) ON DELETE CASCADE;
ALTER TABLE control_calidad.resultados ADD CONSTRAINT resultado_analisis_grupo_solicitud FOREIGN KEY (id_analisis_grupo_solicitud) REFERENCES control_calidad.analisis_grupo_solicitud(id_analisis_grupo_solicitud) ON DELETE CASCADE;
ALTER TABLE control_calidad.resultados_analisis_sangrias_prueba ADD CONSTRAINT fk_resultados_sp_ags FOREIGN KEY (id_ags) REFERENCES control_calidad.analisis_grupo_solicitud(id_analisis_grupo_solicitud) ON DELETE CASCADE;
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_informe FOREIGN KEY (id_informe) REFERENCES control_calidad.informes(id_informe) ON DELETE CASCADE;
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp) ON DELETE CASCADE;
ALTER TABLE control_calidad.equipos_resultado_sp ADD CONSTRAINT equipos_resultado_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp) ON DELETE CASCADE;
ALTER TABLE control_calidad.patrones_resultados_sp ADD CONSTRAINT fk_patrones_resultados_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp) ON DELETE CASCADE;
ALTER TABLE control_calidad.reactivos_resultado_sp ADD CONSTRAINT reacivos_resultado_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp) ON DELETE CASCADE;



DELETE FROM control_calidad.analisis WHERE id_analisis = 21;

DELETE FROM control_calidad.analisis_grupo_solicitud;
DELETE FROM control_calidad.equipos_resultado;
DELETE FROM control_calidad.equipos_resultado_sp;
DELETE FROM control_calidad.grupos;
DELETE FROM control_calidad.grupos_muestras;
DELETE FROM control_calidad.informes;
DELETE FROM control_calidad.muestras;
DELETE FROM control_calidad.patrones_resultados;
DELETE FROM control_calidad.patrones_resultados_sp;
DELETE FROM control_calidad.reactivos_resultado;
DELETE FROM control_calidad.reactivos_resultado_sp;
DELETE FROM control_calidad.resultados;
DELETE FROM control_calidad.resultados_analisis_sangrias_prueba;
DELETE FROM control_calidad.resultados_informes;
DELETE FROM control_calidad.solicitudes;

ALTER SEQUENCE control_calidad.analisis_grupo_solicitud_id_analisis_grupo_solicitud_seq RESTART WITH 1;
ALTER SEQUENCE control_calidad.grupos_id_grupo_seq RESTART WITH 1;
ALTER SEQUENCE control_calidad.informes_id_informe_seq RESTART WITH 1;
ALTER SEQUENCE control_calidad.muestras_id_muestra_seq RESTART WITH 1;
ALTER SEQUENCE control_calidad.resultados_id_resultado_seq RESTART WITH 1;
ALTER SEQUENCE control_calidad.solicitudes_id_solicitud_seq RESTART WITH 1;


ALTER TABLE control_calidad.tipos_equipos_analisis DROP CONSTRAINT analisis_equipos_analisis;
ALTER TABLE control_calidad.analisis_grupo_solicitud DROP CONSTRAINT analisis_grupo_solicitud_analisis;
ALTER TABLE control_calidad.tipos_reactivos_analisis DROP CONSTRAINT analisis_reactivos_analisis;
ALTER TABLE control_calidad.tipos_muestras_analisis DROP CONSTRAINT tipos_muestras_analisis_analisis;
ALTER TABLE control_calidad.certificados_equipos DROP CONSTRAINT certificadoequipo_equipo;
ALTER TABLE control_calidad.certificados_reactivos DROP CONSTRAINT certificadoreactivo_reactivo;
ALTER TABLE control_calidad.equipos_resultado DROP CONSTRAINT equipos_resultado_resultados;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_resultado;
ALTER TABLE control_calidad.patrones_resultados DROP CONSTRAINT fk_patrones_resultados_resultados;
ALTER TABLE control_calidad.reactivos_resultado DROP CONSTRAINT reacivos_resultado_resultados;
ALTER TABLE control_calidad.patrones_resultados DROP CONSTRAINT fk_patrones_resultados_patrones;
ALTER TABLE control_calidad.patrones_resultados_sp DROP CONSTRAINT fk_patrones_resultados_sp_patrones;
ALTER TABLE control_calidad.informes DROP CONSTRAINT fk_informes_solicitudes;
ALTER TABLE control_calidad.grupos DROP CONSTRAINT grupos_solicitud;
ALTER TABLE control_calidad.tipos_reactivos_analisis DROP CONSTRAINT analisis_reactivos_tiposreactivo;
ALTER TABLE control_calidad.reactivos DROP CONSTRAINT reactivo_tiporeactivo;
ALTER TABLE control_calidad.tipos_equipos_analisis DROP CONSTRAINT analisis_equipos_tiposequipo;
ALTER TABLE control_calidad.equipos DROP CONSTRAINT equipo_tipoequipo;
ALTER TABLE control_calidad.muestras DROP CONSTRAINT muestras_tipo_muestra;
ALTER TABLE control_calidad.tipos_muestras_analisis DROP CONSTRAINT tipos_muestras_analisis_tipos_muestras;
ALTER TABLE control_calidad.resultados DROP CONSTRAINT resultado_analisis_grupo_solicitud;
ALTER TABLE control_calidad.resultados_analisis_sangrias_prueba DROP CONSTRAINT fk_resultados_sp_ags;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_informe;
ALTER TABLE control_calidad.resultados_informes DROP CONSTRAINT fk_informes_resultados_resultados_sp;
ALTER TABLE control_calidad.equipos_resultado_sp DROP CONSTRAINT equipos_resultado_resultados_sp;
ALTER TABLE control_calidad.patrones_resultados_sp DROP CONSTRAINT fk_patrones_resultados_resultados_sp;
ALTER TABLE control_calidad.reactivos_resultado_sp DROP CONSTRAINT reacivos_resultado_resultados_sp;


ALTER TABLE control_calidad.tipos_equipos_analisis ADD CONSTRAINT analisis_equipos_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis);
ALTER TABLE control_calidad.analisis_grupo_solicitud ADD CONSTRAINT analisis_grupo_solicitud_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis);
ALTER TABLE control_calidad.tipos_reactivos_analisis ADD CONSTRAINT analisis_reactivos_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis);
ALTER TABLE control_calidad.tipos_muestras_analisis ADD CONSTRAINT tipos_muestras_analisis_analisis FOREIGN KEY (id_analisis) REFERENCES control_calidad.analisis(id_analisis);
ALTER TABLE control_calidad.certificados_equipos ADD CONSTRAINT certificadoequipo_equipo FOREIGN KEY (id_equipo) REFERENCES control_calidad.equipos(id_equipo);
ALTER TABLE control_calidad.certificados_reactivos ADD CONSTRAINT certificadoreactivo_reactivo FOREIGN KEY (id_reactivo) REFERENCES control_calidad.reactivos(id_reactivo);
ALTER TABLE control_calidad.equipos_resultado ADD CONSTRAINT equipos_resultado_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado);
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_resultado FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado);
ALTER TABLE control_calidad.patrones_resultados ADD CONSTRAINT fk_patrones_resultados_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado);
ALTER TABLE control_calidad.reactivos_resultado ADD CONSTRAINT reacivos_resultado_resultados FOREIGN KEY (id_resultado) REFERENCES control_calidad.resultados(id_resultado);
ALTER TABLE control_calidad.patrones_resultados ADD CONSTRAINT fk_patrones_resultados_patrones FOREIGN KEY (id_patron) REFERENCES control_calidad.patrones(id_patron);
ALTER TABLE control_calidad.patrones_resultados_sp ADD CONSTRAINT fk_patrones_resultados_sp_patrones FOREIGN KEY (id_patron) REFERENCES control_calidad.patrones(id_patron);
ALTER TABLE control_calidad.informes ADD CONSTRAINT fk_informes_solicitudes FOREIGN KEY (id_solicitud) REFERENCES control_calidad.solicitudes(id_solicitud);
ALTER TABLE control_calidad.grupos ADD CONSTRAINT grupos_solicitud FOREIGN KEY (id_solicitud) REFERENCES control_calidad.solicitudes(id_solicitud);
ALTER TABLE control_calidad.tipos_reactivos_analisis ADD CONSTRAINT analisis_reactivos_tiposreactivo FOREIGN KEY (id_tipo_reactivo) REFERENCES control_calidad.tipos_reactivos(id_tipo_reactivo);
ALTER TABLE control_calidad.reactivos ADD CONSTRAINT reactivo_tiporeactivo FOREIGN KEY (id_tipo_reactivo) REFERENCES control_calidad.tipos_reactivos(id_tipo_reactivo);
ALTER TABLE control_calidad.tipos_equipos_analisis ADD CONSTRAINT analisis_equipos_tiposequipo FOREIGN KEY (id_tipo_equipo) REFERENCES control_calidad.tipos_equipos(id_tipo_equipo);
ALTER TABLE control_calidad.equipos ADD CONSTRAINT equipo_tipoequipo FOREIGN KEY (id_tipo_equipo) REFERENCES control_calidad.tipos_equipos(id_tipo_equipo);
ALTER TABLE control_calidad.muestras ADD CONSTRAINT muestras_tipo_muestra FOREIGN KEY (id_tipo_muestra) REFERENCES control_calidad.tipos_muestras(id_tipo_muestra);
ALTER TABLE control_calidad.tipos_muestras_analisis ADD CONSTRAINT tipos_muestras_analisis_tipos_muestras FOREIGN KEY (id_tipo_muestra) REFERENCES control_calidad.tipos_muestras(id_tipo_muestra);
ALTER TABLE control_calidad.resultados ADD CONSTRAINT resultado_analisis_grupo_solicitud FOREIGN KEY (id_analisis_grupo_solicitud) REFERENCES control_calidad.analisis_grupo_solicitud(id_analisis_grupo_solicitud);
ALTER TABLE control_calidad.resultados_analisis_sangrias_prueba ADD CONSTRAINT fk_resultados_sp_ags FOREIGN KEY (id_ags) REFERENCES control_calidad.analisis_grupo_solicitud(id_analisis_grupo_solicitud);
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_informe FOREIGN KEY (id_informe) REFERENCES control_calidad.informes(id_informe);
ALTER TABLE control_calidad.resultados_informes ADD CONSTRAINT fk_informes_resultados_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp);
ALTER TABLE control_calidad.equipos_resultado_sp ADD CONSTRAINT equipos_resultado_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp);
ALTER TABLE control_calidad.patrones_resultados_sp ADD CONSTRAINT fk_patrones_resultados_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp);
ALTER TABLE control_calidad.reactivos_resultado_sp ADD CONSTRAINT reacivos_resultado_resultados_sp FOREIGN KEY (id_resultado_sp) REFERENCES control_calidad.resultados_analisis_sangrias_prueba(id_resultado_analisis_sp);
