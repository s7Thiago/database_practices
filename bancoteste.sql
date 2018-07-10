create database if not exists bancoteste
default character set utf8
default collate utf8_general_ci;

use bancoteste;
drop database movefun;

create table if not exists usuarios(
nome varchar(15) not null,
sobrenome varchar(40) not null,
cpf varchar(11) not null,
rg int not null,
username varchar(20) not null,
tipo enum('usuario_comum','motorista'),
sexo enum('M','F') not null,
nascimento date not null,
tipo_sanguineo enum('A-', 'A+', 'B-', 'B+', 'O-', 'O+', 'AB-', 'AB+'),
telefone varchar(15),
latitude float not null,
longitude float not null,
estado char not null
)default charset utf8;