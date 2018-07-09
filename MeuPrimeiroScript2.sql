/*maneira mais simples de se criar um banco de dados. A diferença entre esta forma e a forma 
seguinte é que sem definir nanhum parâmetro adicional, poderemos futuramente ter problemas
com o tipo de dados inseridos. Por exemplo, quando criamos o banco de dados sem definir tais
parâmetros, podemos ter como resultado um banco de dados com suoporte a um formato de caracteres
que não suporta algumas peculiaridades como acentos, cedilha e outros*/
create database cadastro;

/*maneira mais simples e genérica de se criar uma tabela em um banco de dados. A diferença entre 
esta forma e a posterior é o contexto de utilização. Por exemplo, podemos querer obrigar o sistema
a não aceitar que algum campo não seja preenchido com "not null"; podemos também ter problemas ao
aceitar o valor direto da idade de uma pessoa no banco de dados, pois seria cansativo para o usuário
ter que constantemente alterar a sua idade nas configurações de um dado programa; podemos também
querer limitar a valoração de algum campo para um padrão predefinido; ou podemos também precisar
definir um valor padrão para um cero campo, caso ao mesmo não seja definido algum valor*/
create table if not exists pessoas(
nome varchar(30),
idade tinyint,
peso float,
sexo char,
altura float,
nacionalidade varchar(20)
);

/*comando usado para criar um banco de dados defindo um padrão de caracteres e um  collate
para fururamente não termos problemas com os caracteres usuais no Brasil, que por sinal
São acentuados
*/
create database cadastro
default character set utf8
default collate utf8_general_ci;

/*comando usado para colocar um vanco de dados em estado de uso*/
use cadastro;

/*comando usado para apagar uma tabela. Nesse caso a tabela "pessoas"*/
drop table pessoas;

/*comando usado para detalhar uma tabela. Nesse caso a tebela "pessoas"*/
describe pessoas;

/*comando usado para criar uma tabela no banco de dados. Na aula foi contextualizado um problema 
que poderia surgir, que se trata de uma maneira de identificar de fora única cada pessoa cadastrada
sem usar tal recurso, o tratamento de dados ficaria confuso, pois seria difícil definir se determinados
usuários aparentemente com os mesmos dados não se traram da mesma pessoa; temos também a configuração dos
cmapos peso e da altura como sendo representados respectivamente por 5 algarismos (2 após a vírgula), e 3
algarismos(2 após a vírgula). o valor padrão para o campo nacionalidade, caso ao memso não seja atrubuído 
um valor é "Brasil"*/
create table pessoas(
nome varchar(30) not null,
nascimento date,
sexo enum('M', 'F'),
peso decimal(5,2),
altura decimal(3,2),
nacionalidade varchar(20) default 'Brasil'
)default charset = utf8;

/*esta é uma nova variação do comando anterior. A diferença é que nesse caso, a tabela já vem com o recurso que 
rorna único cada registro criado no banco de dados através deste comando. Criamos o campo "id", que tem como 
propriedades o tipo inteiro(int), não pode ser nulo(not null(ou seja, se houver um registro, ele obrigatoriamente
terá que possuir este atributo valorado)) e ele será incrementado automaticamente a medida que os dados forem sendo
inseridos através deste comando, e na linha final, definimos a chave primária(comando primary key) como sendo o campo id*/
create table if not exists pessoas(
id int not null auto_increment,
nome varchar(30) not null,
nascimento date,
sexo enum('M','F'),
peso decimal(5,2),
altura decimal(3,2),
nacionalidade varchar(20) default 'Brasil',
primary key(id)
)default charset = utf8;

