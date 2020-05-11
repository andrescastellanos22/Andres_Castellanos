drop database netflix;
create database netflix;
use netflix;

create table tipo_documento(
id_documento varchar(10)not null,
siglas varchar(5)not null,
nom_tip_doc varchar(20)not null
);
alter table tipo_documento add primary key(id_documento);

create table plan(
id_plan int not null,
nom_plan varchar(30)not null,
costo int,
caract_plan text
);
alter table plan add primary key(id_plan);

create table rol(
id_rol int not null,
nom_rol varchar(20)not null
);
alter table rol add primary key(id_rol);

create table peliculas(
id_peliculas int not null,
nom_peliculas varchar(110)not null,
duracion time,
añoest year,
sinopsis text,
estado tinyint
);
alter table peliculas add primary key(id_peliculas);

create table series(
id_series int not null,
nom_series varchar(110)not null,
num_temp tinyint,
añoest year,
sinopsis text,
calificacion float,
estado tinyint
);
alter table series add primary key(id_series);

create table categoria(
id_cate int not null,
nom_cate varchar(30)not null
);
alter table categoria add primary key(id_cate);

create table idioma(
id_idioma int not null,
nom_idioma varchar(15)not null
);
alter table idioma add primary key(id_idioma);

create table tipo_pago(
id_tipo_pago int not null,
nomb_pago varchar(25)not null
);
alter table tipo_pago add primary key(id_tipo_pago);

create table usuario(
id_num_docu varchar(12)not null,
nom_1 varchar(20)not null,
nom_2 varchar(20),
ape_1 varchar(20)not null,
ape_2 varchar(20),
email varchar(80)not null,
contra varchar(30)not null,
fk_id_documento varchar(10)not null,
fk_id_rol int not null,
fk_id_plan int not null
);

alter table usuario add primary key(id_num_docu,fk_id_documento);
alter table usuario add constraint fk_id_documento foreign key(fk_id_documento) references tipo_documento(id_documento) on update cascade;
alter table usuario add constraint fk_id_rol foreign key(fk_id_rol) references rol(id_rol) on update cascade;
alter table usuario add constraint fk_id_plan foreign key(fk_id_plan) references plan(id_plan) on update cascade;

create table perfil(
id_perfil int not null,
nom_perfil varchar(20)not null,
avatar blob,
fk_id_num_docu varchar(12)not null,
fk_id_documento varchar(10)not null
);

alter table perfil add primary key(id_perfil);
alter table perfil add constraint fk_id_num_docu foreign key(fk_id_num_docu,fk_id_documento) references usuario (id_num_docu,fk_id_documento) on update cascade;

create table factura(
id_factura int not null,
fecha date not null,
hora time not null,
fk_id_num_docu varchar(15)not null,
fk_id_documento varchar(15)not null,
fk_id_tipo_pago int not null,
fk_id_plan int not null
);

alter table factura add primary key(id_factura, fk_id_num_docu ,fk_id_documento);
alter table factura add constraint fkid_num_docu foreign key (fk_id_num_docu,fk_id_documento) references usuario (id_num_docu,fk_id_documento) on update cascade;
alter table factura add constraint fkid_plan foreign key (fk_id_plan) references plan (id_plan) on update cascade;
alter table factura add constraint fkid_tipo_pago foreign key(fk_id_tipo_pago) references tipo_pago (id_tipo_pago) on update cascade;

create table categoria_pelicula(
fk_id_peliculas int not null,
fk_id_cate int not null
);

alter table categoria_pelicula add primary key(fk_id_peliculas,fk_id_cate);
alter table categoria_pelicula add constraint fk_id_peliculas foreign key(fk_id_peliculas) references peliculas(id_peliculas) on update cascade;
alter table categoria_pelicula add constraint fk_id_cate foreign key (fk_id_cate) references categoria(id_cate) on update cascade;

create table idioma_peliculas(
fk_id_peliculas int not null,
fk_id_idioma int not null
);
alter table idioma_peliculas add primary key(fk_id_peliculas,fk_id_idioma);
alter table idioma_peliculas add constraint fk_idpeliculas foreign key(fk_id_peliculas) references peliculas(id_peliculas) on update cascade;
alter table idioma_peliculas add constraint fk_id_idioma foreign key(fk_id_idioma) references idioma(id_idioma) on update cascade;

create table peliculas_perfil(
fk_id_peliculas int not null,
fk_id_perfil int not null
);

alter table peliculas_perfil add primary key (fk_id_peliculas,fk_id_perfil);
alter table peliculas_perfil add constraint fkid_peliculas foreign key(fk_id_peliculas) references peliculas (id_peliculas) on update cascade;
alter table peliculas_perfil add constraint fkid_perfil foreign key(fk_id_perfil) references perfil (id_perfil) on update cascade;

create table categoria_series(
fk_id_cate int not null,
fk_id_series int not null
);

alter table categoria_series add primary key(fk_id_cate,fk_id_series);
alter table  categoria_series add constraint fkid_cate foreign key(fk_id_cate) references categoria(id_cate) on update cascade;
alter table categoria_series add constraint fkid_series foreign key(fk_id_series) references series(id_series) on update cascade; 
 
create table series_perfil(
fk_id_series int not null,
fk_id_perfil int not null
);

alter table series_perfil add primary key(fk_id_series,fk_id_perfil);
alter table series_perfil add constraint fk_id_series foreign key(fk_id_series) references series (id_series) on update cascade;
alter table series_perfil add constraint fk_id_perfil foreign key(fk_id_perfil) references perfil (id_perfil) on update cascade;

 create table temporadas(
 id_temporadas int  not null,
 num_temporadas tinyint not null,
 fk_id_series int  not null
 );
 
alter table temporadas add primary key (id_temporadas);
alter table temporadas add constraint fk_idseries foreign key (fk_id_series) references series (id_series) on update cascade;
 
 create table capitulos(
 id_capitulos int not null,
 nom_capitulos varchar(90)not null,
 num_capitulos tinyint,
 duracion time,
fk_id_temporadas int not null
 );
 
alter table capitulos add primary key (id_capitulos);
alter table capitulos add constraint fk_id_temporadas foreign key (fk_id_temporadas) references temporadas (id_temporadas) on update cascade;

 create table idioma_capitulos(
 fk_id_capitulos int not null,
 fk_id_idioma int not null
);

alter table idioma_capitulos add primary key (fk_id_idioma,fk_id_capitulos);
alter table idioma_capitulos add constraint fk_id_capitulos foreign key (fk_id_capitulos) references capitulos (id_capitulos) on update cascade;
alter table idioma_capitulos add constraint fk_ididioma foreign key (fk_id_idioma) references idioma (id_idioma) on update cascade;

create table servidor_correo(
id_servidor_correo int not null,
nom_servidor_correo varchar(45) not null
);
alter table servidor_correo add primary key (id_servidor_correo);

create table log_error(
id_error int  not null,
descripcion_error varchar(200) not null,
fecha_error datetime not null
);
alter table log_error add primary key (id_error);