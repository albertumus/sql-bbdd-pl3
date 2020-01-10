-- GRUPOS
CREATE GROUP administrador;
CREATE GROUP cajero;
CREATE GROUP gestor;
CREATE GROUP socio;
CREATE GROUP trabajador;

-- PERMISOS
GRANT ALL PRIVILEGES ON DATABASE pl3 TO administrador;
GRANT SELECT, UPDATE, INSERT ON ticket, productos_comprados, productos_devueltos, producto, socio TO cajero;
GRANT SELECT, UPDATE, INSERT, DELETE 
ON tienda, trabajador, cajero, reponedor, ticket, socio, producto, oferta, cupon, opinion, producto_cupon, 
producto_en_oferta,productos_comprados, productos_devueltos, socios_cupon, trabajador_puntua_trabajador
TO gestor;
GRANT SELECT ON socio, socios_cupon TO socio;
GRANT SELECT, UPDATE, INSERT ON cajero,reponedor TO trabajador;

-- USUARIOS
CREATE USER adminis WITH PASSWORD 'eladmin' IN GROUP administrador SUPERUSER;
CREATE USER Alberto WITH PASSWORD 'soyalberto' IN GROUP cajero;
CREATE USER paco WITH PASSWORD 'soypaco' IN GROUP cajero;
CREATE USER Irene WITH PASSWORD 'soyirene' IN GROUP cajero;
CREATE USER gestor1 WITH PASSWORD 'soyg1' IN GROUP gestor;
CREATE USER gestor2 WITH PASSWORD 'soyg2' IN GROUP gestor;
CREATE USER Pepe WITH PASSWORD 'soypepe' IN GROUP socio;
CREATE USER Razvan WITH PASSWORD 'soyraz' IN GROUP socio;
CREATE USER trabajador1 WITH PASSWORD 'soyt1' IN GROUP trabajador;
CREATE USER trabajador2 WITH PASSWORD 'soyt2' IN GROUP trabajador;