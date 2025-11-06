# PAGINA_WEB

Aplicación web Java (JSP/Servlets) desarrollada en NetBeans con base de datos MySQL.

## Requisitos
- JDK 17+
- NetBeans 12+
- Servidor: GlassFish o Tomcat
- MySQL 8+
- Connector/J

## Configuración de la base de datos
1. Importa el archivo `db/backup.sql` en MySQL Workbench:
   - Server → Data Import → Import from Self-Contained File → selecciona `db/backup.sql`
   - Start Import
2. Copia `config/db.properties.example` a `config/db.properties` y completa usuario y contraseña.

## Ejecución
1. Abre el proyecto en NetBeans.
2. Configura tu servidor (Tomcat o GlassFish).
3. Ejecuta y abre: `http://localhost:8080/PAGINA_WEB/`

