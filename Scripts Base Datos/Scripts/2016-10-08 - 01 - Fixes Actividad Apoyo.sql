ALTER TABLE PRODUCCION.HISTORIAL_ACTIVIDAD_APOYO
ADD COLUMN REQUIERE_COORDINACION BOOLEAN;

ALTER TABLE PRODUCCION.HISTORIAL_ACTIVIDAD_APOYO
ADD COLUMN REQUIERE_REGENCIA BOOLEAN;

ALTER TABLE PRODUCCION.RESPUESTA_AA
ADD COLUMN APROBACION_COORDINACION BOOLEAN;

ALTER TABLE PRODUCCION.RESPUESTA_AA
ADD COLUMN APROBACION_REGENCIA BOOLEAN;

ALTER TABLE PRODUCCION.HISTORIAL_RESPUESTA_AA
RENAME COLUMN id_usuario_aprobar to id_usuario_aprobar_coordinacion;

ALTER TABLE PRODUCCION.HISTORIAL_RESPUESTA_AA
RENAME COLUMN id_usuario_revisar to id_usuario_cerrar;

ALTER TABLE PRODUCCION.HISTORIAL_RESPUESTA_AA
ADD COLUMN ID_USUARIO_APROBAR_REGENCIA INT;

ALTER TABLE ONLY PRODUCCION.HISTORIAL_RESPUESTA_AA ADD CONSTRAINT FK_ID_USUARIO_APROBAR_REGENCIA FOREIGN KEY (ID_USUARIO_APROBAR_REGENCIA) REFERENCES SEGURIDAD.USUARIOS(ID_USUARIO);

UPDATE SEGURIDAD.PERMISOS
SET NOMBRE = '[produccion]CerrarActividadApoyo', DESCRIPCION='Permite cerrar una actividad de apoyo realizada.'
WHERE id_permiso = 678;

UPDATE SEGURIDAD.PERMISOS
SET NOMBRE = '[produccion]AprobarCoordinacionActividadApoyo', DESCRIPCION='Permite a coordinacion aprobar o rechazar una actividad de apoyo realizada.'
WHERE id_permiso = 679;

INSERT INTO seguridad.permisos(id_permiso, nombre, descripcion) VALUES (682, '[produccion]AprobarRegenciaActividadApoyo', 'Permite a regencia aprobar o rechazar una actividad de apoyo realizada.');

INSERT INTO seguridad.permisos_menu_principal(id_permiso, id_menu_principal) VALUES (682, 632);

ALTER TABLE PRODUCCION.ACTIVIDAD_APOYO
ADD COLUMN version_anterior INT;

ALTER TABLE PRODUCCION.RESPUESTA_AA
ADD COLUMN version_usada INT;

ALTER TABLE PRODUCCION.RESPUESTA_PXP
ADD COLUMN version_usada INT;

ALTER TABLE PRODUCCION.RESPUESTA_AA
ADD COLUMN OBSERVACIONES CHARACTER VARYING (200);
