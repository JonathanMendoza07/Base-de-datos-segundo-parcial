/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     2/9/2021 14:38:23                            */
/*==============================================================*/


drop table CALIFICACIO_MUDANZA;

drop table CAMION;

drop table CHOFER;

drop table CLIENTE;

drop table DETALLE_FACTURA;

drop table DIRECCION;

drop table EMPRESA;

drop table FACTURA;

drop table MUDANZAS;

drop table TIPO_CAMION;

drop table TIPO_MUDANZA;

/*==============================================================*/
/* Table: CALIFICACIO_MUDANZA                                   */
/*==============================================================*/
create table CALIFICACIO_MUDANZA (
   CALIFICAION_ID       SERIAL               not null,
   CALIFICACION_NOMBRE  TEXT                 null,
   constraint PK_CALIFICACIO_MUDANZA primary key (CALIFICAION_ID)
);

/*==============================================================*/
/* Table: CAMION                                                */
/*==============================================================*/
create table CAMION (
   CAMION_ID            SERIAL               not null,
   CHOFER_ID            INT4                 null,
   EMPRESA_NUM          INT4                 not null,
   TIPO_CAMION_ID       INT4                 null,
   FECHA_INGRESO        DATE                 null,
   MARCA                TEXT                 null,
   PLACA                TEXT                 null,
   NUM_REGISTRO         INT4                 null,
   constraint PK_CAMION primary key (CAMION_ID)
);

/*==============================================================*/
/* Table: CHOFER                                                */
/*==============================================================*/
create table CHOFER (
   CHOFER_ID            SERIAL               not null,
   NOMBRE               TEXT                 null,
   APELLIDO             TEXT                 null,
   FECHA_NACIMINETO     DATE                 null,
   ESTADO_CIVIL         TEXT                 null,
   GENERO               TEXT                 null,
   TELEFONO_TRABAJO     CHAR(10)             null,
   TELEFONO_DOMICILIO   CHAR(10)             null,
   CORREO               TEXT                 null,
   TIPO_LICENCIA        TEXT                 null,
   constraint PK_CHOFER primary key (CHOFER_ID)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTE_ID           SERIAL               not null,
   NOMBRE               TEXT                 null,
   CEDULA               CHAR(10)             null,
   APELLIDO             TEXT                 null,
   FECHA_NACIMIENTO     DATE                 null,
   ESTADO_CIVIL         TEXT                 null,
   GENERO               TEXT                 null,
   TELEFONO_TRABAJO     CHAR(10)             null,
   TELEFONO_DOMICILIO   CHAR(10)             null,
   CORREO               TEXT                 null,
   constraint PK_CLIENTE primary key (CLIENTE_ID)
);

/*==============================================================*/
/* Table: DETALLE_FACTURA                                       */
/*==============================================================*/
create table DETALLE_FACTURA (
   DETALLE_FACTU_ID     SERIAL               not null,
   FACTURA_ID           INT4                 not null,
   DETALLE_FACTURA_ID   INT4                 null,
   DET_MUDANZA          TEXT                 null,
   DET_CAMION_AL        INT4                 null,
   DET_PRECIO           INT4                 null,
   constraint PK_DETALLE_FACTURA primary key (DETALLE_FACTU_ID)
);

/*==============================================================*/
/* Table: DIRECCION                                             */
/*==============================================================*/
create table DIRECCION (
   DIRECCION_ID         SERIAL               not null,
   CLIENTE_ID           INT4                 not null,
   DIRECCION_ALIAS      TEXT                 null,
   DIRECCION_DESCRIPCION TEXT                 null,
   DIRECCION_CALLE_     TEXT                 null,
   DRECCION_CODIGOPOSTAL INT4                 null,
   DIRECCION_CIUDAD     TEXT                 null,
   constraint PK_DIRECCION primary key (DIRECCION_ID)
);

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA (
   EMPRESA_NUM          SERIAL               not null,
   MUDANZA              TEXT                 null,
   constraint PK_EMPRESA primary key (EMPRESA_NUM)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   FACTURA_ID           SERIAL               not null,
   MUDANZA_ID           INT4                 not null,
   DETALLE_MUDANZA_ID   INT4                 null,
   DETALLE_CLIENTE_ID   INT4                 null,
   FACTURA_FECHA        DATE                 null,
   PRECIO_TOTAL         INT4                 null,
   constraint PK_FACTURA primary key (FACTURA_ID)
);

/*==============================================================*/
/* Table: MUDANZAS                                              */
/*==============================================================*/
create table MUDANZAS (
   MUDANZA_ID           SERIAL               not null,
   CHOFER_ID            INT4                 null,
   TIPO_MUDANZA_ID      INT4                 null,
   CALIFICAION_ID       INT4                 not null,
   CLIENTE_ID           INT4                 null,
   FECHA_REGISTRO       DATE                 null,
   FECHA_ENTREGA        DATE                 null,
   ESTADO_MUDANZA       TEXT                 null,
   constraint PK_MUDANZAS primary key (MUDANZA_ID)
);

/*==============================================================*/
/* Table: TIPO_CAMION                                           */
/*==============================================================*/
create table TIPO_CAMION (
   TIPO_CAMION_ID       SERIAL               not null,
   TIPO_CAMION_NOMBRE   TEXT                 null,
   constraint PK_TIPO_CAMION primary key (TIPO_CAMION_ID)
);

/*==============================================================*/
/* Table: TIPO_MUDANZA                                          */
/*==============================================================*/
create table TIPO_MUDANZA (
   TIPO_MUDANZA_ID      SERIAL               not null,
   TIPO_MUDANZA_NOMBRE  TEXT                 not null,
   constraint PK_TIPO_MUDANZA primary key (TIPO_MUDANZA_ID)
);

alter table CAMION
   add constraint FK_CAMION_CAMION_TI_TIPO_CAM foreign key (TIPO_CAMION_ID)
      references TIPO_CAMION (TIPO_CAMION_ID)
      on delete restrict on update restrict;

alter table CAMION
   add constraint FK_CAMION_CHOFER_CA_CHOFER foreign key (CHOFER_ID)
      references CHOFER (CHOFER_ID)
      on delete restrict on update restrict;

alter table CAMION
   add constraint FK_CAMION_EMPRESA_C_EMPRESA foreign key (EMPRESA_NUM)
      references EMPRESA (EMPRESA_NUM)
      on delete restrict on update restrict;

alter table DETALLE_FACTURA
   add constraint FK_DETALLE__DETALLEFA_FACTURA foreign key (FACTURA_ID)
      references FACTURA (FACTURA_ID)
      on delete restrict on update restrict;

alter table DIRECCION
   add constraint FK_DIRECCIO_CLIENTE_D_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (CLIENTE_ID)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_CLIENTE_F_MUDANZAS foreign key (MUDANZA_ID)
      references MUDANZAS (MUDANZA_ID)
      on delete restrict on update restrict;

alter table MUDANZAS
   add constraint FK_MUDANZAS_CALIFICAC_CALIFICA foreign key (CALIFICAION_ID)
      references CALIFICACIO_MUDANZA (CALIFICAION_ID)
      on delete restrict on update restrict;

alter table MUDANZAS
   add constraint FK_MUDANZAS_CHOFER_MU_CHOFER foreign key (CHOFER_ID)
      references CHOFER (CHOFER_ID)
      on delete restrict on update restrict;

alter table MUDANZAS
   add constraint FK_MUDANZAS_CLIENTE_M_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (CLIENTE_ID)
      on delete restrict on update restrict;

alter table MUDANZAS
   add constraint FK_MUDANZAS_TIPOMUDAN_TIPO_MUD foreign key (TIPO_MUDANZA_ID)
      references TIPO_MUDANZA (TIPO_MUDANZA_ID)
      on delete restrict on update restrict;

