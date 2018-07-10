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

/*este comando insere informações na tabela pessoas. a leitura correta é: insira na tabela pessoas com as informações
os valores... Eu não preciso informar o id como parâmetro, pois ele foi definido como auto increment*/
insert into pessoas
(nome, nascimento, sexo, peso, altura, nacionalidade)
values
('Thiago','1997-04-04','M','78.6','1.78','Brasil');

/*usado para conferir os dados que estão presentes dentro da tabela pessoas*/
select * from pessoas;

/*inserindo dados novos na tabela pessoas*/
insert into pessoas
(nome, nascimento, sexo, peso, altura,nacionalidade)
values
('Fernando', '1991-5-12', 'M', '89.6', '1.87', 'Brasil');

/*se eu quiser informar o campo id na sintaxe do comando de inserção sem interferir no valor que é gerado automaticamente,
eu posso fazer isso da seguinte forma:*/
insert into pessoas
(id, nome, nascimento, sexo, peso, altura, nacionalidade) 
values
(default, 'Ana', '1988-09-21', 'F', '57.5', '1.66', 'Portugal');

/*já que definimos a nacionalidade por padrão como Brasil, caso a mesma não seja especificada, vamos testar isso inserindo um
novo registro especificando esse campo como sendo o padrão:*/
insert into pessoas
(id, nome, nascimento, sexo, peso, altura, nacionalidade)
values
(default, 'Bernardo', '1989-02-4', 'M', '88.5', '1.89', default);

/*quando a ordem na qual será inserida os dados for a mesma ordem da tabela original definida no comando de criação da tabela,
eu posso omitir parte do comando de inserção de dados, tornando o mesmo mais curto como no exemplo a seguir:*/
insert into pessoas values
(default, 'Maria', '1987-04-26', 'F', '61.1', '1.67', default);

/*não é necessário user um insert into para cada registro diferente que formos inserir no banco de dados. Caso haja a necessidade,
além da meneira completa, e simplificada de se usar o comando insert into, temos outra variação que nos permite inserir diversos
dados, nesse caso, quantos quisermos. Usando essa variação em conjunto com a sintaxe silplificada, ficaria assim:*/
##inserindo cinco novas pessoas no banco de dados:
insert into pessoas values
(default, 'Marta', '1985-10-23', 'F', '59.8', '1.69', 'Irlanda'),
(default, 'Rogério', '1987-08-20', 'M', '99.8', '1.91', 'Alemanha'),
(default, 'Marcos', '1985-07-17', 'M', '89.4', '1.86', 'Inglaterra'),
(default, 'Juliana', '1978-10-23', 'F', '60.3', '1.63', 'Portugal'),
(default, 'Gabriela', '1995-10-23', 'F', '55.3', '1.59', 'Estados Unidos');
