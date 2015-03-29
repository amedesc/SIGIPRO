<%-- 
    Document   : plantilla_general
    Created on : Nov 30, 2014, 9:06:51 PM
    Author     : Boga
--%>

<%@tag description="Plantilla general" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:if test="${sessionScope.usuario == null}">
  <c:redirect url="/Cuenta/IniciarSesion" />
</c:if>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="title"%>
<%@attribute name="direccion_contexto"%>
<%@attribute name="contenido" fragment="true" required="true"%>
<%@attribute name="scripts" fragment="true" required="false"%>
<%@attribute name="css" fragment="true" required="false"%>

<!DOCTYPE html>
<html lang="es">

  <head>
    <title>SIGIPRO - ${title}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="description" content="Instituto Clodomiro Picado - SIGIPRO">
    <meta name="author" content="ICP">

    <!-- CSS -->
    <link href="${direccion_contexto}/recursos/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="${direccion_contexto}/recursos/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="${direccion_contexto}/recursos/css/main.css" rel="stylesheet" type="text/css" media="screen">
    <link href="${direccion_contexto}/recursos/css/sigipro/sigipro.css" rel="stylesheet" type="text/css" media="screen">
    <link href="${direccion_contexto}/recursos/css/sigipro/barra-navegacion.css" rel="stylesheet" type="text/css" media="screen">
    
    <jsp:invoke fragment="css" />

    <!--[if lte IE 9]>
        <link href="${direccion_contexto}/recursos/css/main-ie.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="${direccion_contexto}/recursos/css/main-ie-part2.css" rel="stylesheet" type="text/css" media="screen" />
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${direccion_contexto}/recursos/ico/kingadmin-favicon144x144.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${direccion_contexto}/recursos/ico/kingadmin-favicon114x114.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72"   href="${direccion_contexto}/recursos/ico/kingadmin-favicon72x72.png">
    <link rel="apple-touch-icon-precomposed" sizes="57x57"   href="${direccion_contexto}/recursos/ico/kingadmin-favicon57x57.png">
    <link rel="shortcut icon" href="${direccion_contexto}/favicon.ico">
  </head>

  <body>

    <div class="wrapper">

      <!-- Header -->
      <jsp:include page="/plantillas/header.jsp" />
      <!-- /Header -->

      <!-- Main -->
      <jsp:invoke fragment="contenido" />
      <!-- /Main -->

    </div>

    <!-- Footer -->
    <jsp:include page="/plantillas/footer.jsp" />
    <!-- /Footer -->

    <!-- script references -->
    <script src="${direccion_contexto}/recursos/js/jquery/jquery-2.1.0.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/bootstrap/bootstrap.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/modernizr/modernizr.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/bootstrap-tour/bootstrap-tour.custom.js"></script>
    <script src="${direccion_contexto}/recursos/js/king-common.js"></script>
    <script src="${direccion_contexto}/recursos/js/deliswitch.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>

    <!-- <script src="${direccion_contexto}/recursos/js/plugins/stat/jquery.easypiechart.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/raphael/raphael-2.1.0.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/stat/flot/jquery.flot.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/stat/flot/jquery.flot.resize.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/stat/flot/jquery.flot.time.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/stat/flot/jquery.flot.pie.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/stat/flot/jquery.flot.tooltip.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/jquery-sparkline/jquery.sparkline.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/jquery-mapael/jquery.mapael.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/raphael/maps/usa_states.js"></script>
    <script src="${direccion_contexto}/recursos/js/king-chart-stat.js"></script>
    -->
    <script src="${direccion_contexto}/recursos/js/plugins/datatable/jquery.dataTables.min.js"></script>
    <script src="${direccion_contexto}/recursos/js/plugins/datatable/dataTables.bootstrap.js"></script>
    <script src="${direccion_contexto}/recursos/js/king-table.js"></script>
    <script src="${direccion_contexto}/recursos/js/king-components.js"></script>
    <script src="${direccion_contexto}/recursos/js/king-elements.js"></script>

    <!-- Esta se modificó -->
    <script src="${direccion_contexto}/recursos/js/sigipro/sigipro.js"></script>
    <script src="${direccion_contexto}/recursos/js/sigipro/PermisosRol.js"></script>


    <script src="${direccion_contexto}/recursos/js/plugins/bootbox.js"></script>

    <script src="${direccion_contexto}/recursos/js/sigipro/barra-navegacion.js"></script>
    <script src="${direccion_contexto}/recursos/js/sigipro/cambiar-contrasena.js"></script>
    <script src="${direccion_contexto}/recursos/js/sigipro/CatalogoExterno.js"></script>
    <script src="${direccion_contexto}/recursos/js/sigipro/tabla-sigipro.js"></script>
    <script src="${direccion_contexto}/recursos/js/sigipro/confirmacion-eliminar.js"></script>
     <script src="${direccion_contexto}/recursos/js/sigipro/Serpiente.js"></script>
     <script src="${direccion_contexto}/recursos/js/sigipro/Extraccion.js"></script>
     <script src="${direccion_contexto}/recursos/js/sigipro/Veneno.js"></script>

    

    <script src="${direccion_contexto}/recursos/js/plugins/select2/select2.min.js"></script>
    <script>
      $(document).ready(function () {
        if ($('.sigiproDatePicker').length > 0) {
          $('.sigiproDatePicker').datepicker()
                  .on('changeDate', function () {
                    $(this).datepicker('hide');
                    $(':input:eq(' + ($(':input').index(this) + 1) + ')').focus();
                  });
          $("#fechaActivacion").datepicker({startDate: 0});
        }
      });
    </script>

    <jsp:include page="/plantillas/formCambiarContrasena.jsp" />
    
    <jsp:invoke fragment="scripts" />

  </body>
</html>
