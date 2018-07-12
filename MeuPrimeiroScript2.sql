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
#ou ainda
desc pessoas;

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

/*Alterando a estrutura da tabela para acrescentar uma nova coluna "profissao"*/
alter table pessoas
add column profissao varchar(10);

/*Vemos que a coluna foi adicionada com sucesso, porém, ela estána última posição da estrutura da nossa tabela. em algumas situações, 
para melhorar a visualização/legibilidade dos nossos dados dispostos na tabela, podemos querer colocar determinada coluna adicional
em alguma posição específica da estrutura. para fazermos isso, apagamos a coluna com o comando drop column 'nome da coluna'*/
alter table pessoas
drop column profissao;

/*agora vamos adicionar novamente a coluna, mas em uma nova posição, nesse caso, vamos colocá-la após o nome*/
alter table pessoas
add column profissao varchar(10) not null default '' after nome;

/*não é possível adicionar um campo antes de outro com o comando before porque o mesmo não existe. para fazer isso, usamos este método:
a palavra chave vai adicionar o campo como sendo o primeiro da tabela*/
alter table pessoas
add column codigo int first;

/*Agora vamos apagar este campo, pois o mesmo serviu apenas para ilistrar a situação*/
alter table pessoas
drop column codigo;

/*Revisando: para colocar um campo como o primeiro da lista, basta usar a palavra chave 'first'. para colocar o mesmo como sendo o último da
tabela, basta que não usemos nenhuma palavra chave adicional, usando apenas o comando ater table em conjunto com o add column, e a mesma já
será inserida automaticamente no final da tabela. Já para adicionarmos um campo após outro campo específico, basta que usemos a palavra chave 
after''*/

/*também podemos adicionar colunas a um atabela sem usar a palavra chave 'column'. Por exemplo, para adicionarmos novamente a coluna 'codigo'
como sendo a primeira coluna da tabela, sem usar a palavra chave de antes:*/
alter table pessoas
add codigo int first;

/*se nós quisermos alterar as propriedades de algum campo, por exemplo, digamos que percebemos que o campo profissão aceitando somente dez 
caracteres não é o suficiente, e queiramos alterar esta propriedade. Basta usarmos o seguinte recurso:*/
alter table pessoas
modify column profissao varchar(20) not null default '';
/*a palavra chave modify permite alterar o tipo primitivo do campo, e também as constraints. só não conseguimos renomear um campo usando este
comando*/

/*para modificar o nome de uma coluna e tambéa as suas constraints, usamos o comando 'change column [nome anterior] [novo nome + tipo primitivo]'
 como no exemplo abaixo:*/
alter table pessoas
change column profissao prof varchar(20);
/*com este comando podemos mudar também as propiredades do campo, como o not null e o tipo primitivo. para não perdermos as propriedades anteriores,
é recomendável especificar as mesmas durante o uso do comando change*/
alter table pessoas
change column profissao prof varchar(20) not null default '';

/*para renomear a tabela, usamos o comando 'rename to'*/
alter table pessoas
rename to individuos;

/*Renomeando a tabela para o nome anterior*/
alter table individuos
rename to pessoas;

/*vamos criar agora uma tabela chamada cursos para falar dos parâmetros 'if not exists' e 'if exists'*/
create table if not exists cursos(
nome varchar(30) not null unique,
descricao text,
carga int unsigned,
totaulas int unsigned,
ano year default '2018'
)default charset = utf8;
/*o parâmetro 'if not exists' serve para criarmos uma tabela caso ela não exista já o parâmetro 'if exists'serve para apagarmos uma tabela, caso ela 
exista*/

/*falando sobre as novas palavras chave e outros aspectos desta tabela: 

unique: como nesse caso nós não teremos dous cursos com o mesmo nome por uma questão de coerência, usamos esta palavra chave não para identificar um
registro, ou definir o mesmo como uma chave primária, e sim para não deixar que sejam inseridos dous registros com os mesmos valores em relação à 
propriedade/campo em que ele foi inserido. neste caso, não queremos que dois cursos com o mesmo nome sejam inseridos na mesma tabela

unsigned: esta palavra chave inserida no campo carga é oportuna pois já que por se tratar da duração de um curso em horas, nunca teremos um valor negativo,
logo, não precisamos do sinal negativo. Usando o unsigned, limitamos a valoração deste campo apenas para valores sem sinal, ou seja, positivos.alter

*/

/*descrevendo a tabela*/
desc cursos;

/*perceba que criamos a tabela e esquecemos de especificar algum campo que identifique cada registro da mesma de maneira única, neste caso a primary key.
Para isso, não precisamos apagar a tabela, e corrermos o risco inivitável de perder todos os dados existentes, bastando apenas usarmos os comandos de 
alteração da estrutura de tabelas*/
alter table cursos
add column idcurso int first;

/*como não podemos adicionar uma coluna e definir a chave primaria simultaneamente usando o comando alter, precisamos usar um segundo comando para fazer isso
que é o add primary key(campo)*/
alter table cursos
add primary key(idcurso);
/*Agora sim temos uma chave primaria para a tabela de cursos. Assim podemos ver que usando a constraint unique, definimos que o nome de cada registro numa tabela
será único, mas não definimos que o mesmo campo será uma chave primária, restando à constrait 'primary key' a incubência de definir tal propriedade*/

/*Começando o conteúdo da aula 7: manipulando registros*/
#primeiramente iremos inserir diversos registros na tabela de cursos
insert into cursos values 
('1', 'HTML4', 'Curso de HTML5', '40', '37', '2014'),
('2', 'algoritmos', 'Lógica de Programação', '20', '15', '2014'),
('3', 'Photoshop', 'Dicas de Photoshop CC', '10', '8', '2014'),
('4', 'PGP', 'Curso de PHP para iniciantes', '40', '10', '2010'),
('5', 'Jarva', 'Introdução à Linguagem Java', '10', '29', '2000'),
('6', 'MySQL', 'Bancos de Dados MySQL', '30', '15', '2016'),
('7', 'Word', 'Curso completo de Word', '40', '30', '2016'),
('8', 'Sapateando', 'Danças Rítmicas', '40', '30', '2018'),
('9', 'Cozinha Árabe', 'Aprenda a Fazer Kibe', '40', '30', '2018'),
('10', 'Youtuber', 'Gerar polêmica e ganhar inscritos', '5', '2', '2018');

/*Foram inieridos propositalmente alguns registros errados para que possamos corrigi-los. Eles são:
linha 1: coluna nome;
linha 4: coluna nome;
linha 4: coluna ano;
linha 5: coluna nome;
linha 5: coluna cara;
linha 5: coluna ano;*/

/*para modificar um registro usamos o comando 'update [nome da tabela] set [nome da coluna] [valor]'; para referenciarmos a linha específica,é
 aconselhável usar a chave primária da tabela como referência, pois assim, teremos certeza de que não tal registro é o único que possui esse 
valor. Para tal, usamos o parâmetro where [campo de ref(Chave primária)] = '[valor]'*/

/*Corrigindo a linha 1*/
update cursos
set nome = 'HTML5'
where idcurso = '1';
/*lemos o comando acima assim: atualize a tabela `cursos` configurando o campo `nome` para o valor 'HTML5' onde o campo `idcurso` for igual a '1'*/

/*agora na linha 4 temos dois erros. é possível alterar os dois simultaneamente assim:*/
update cursos
set nome = 'PHP', ano = '2015' where idcurso = '4';
/*ou seja, para modificarmos varios campos, basta referenciá-los normalmente separando cada um por vírgula*/

/*Agora vamos corrigir a linha 5*/
update cursos
set nome = 'Java', carga = '40', ano = '2015' where idcurso = '5'
limit 1;
/*temos um problema que pode ocorrer, que é no caso de modificarmos acidentalmente mais de uma linha, causando certo dano aos demais dados da
tabela. Podemos evitar que isso aconteça usando o parâmetro 'limit [valor]', que limita a quantidade de linhas (ou registros) que serão 
afetadas pela modificação*/

/*um exemplo de comando que pode prejudicar e alterar indevidamente os dados de uma tabela é o comando abaixo:*/
update cursos
set ano = '2050', carga = '1300' where ano = 2018;
/*Este comando, que por sinal não possui um limit definido, afetaria todos os registros da tabela que possuirem o campo ano igual a 2018*/
/*Ao executar este comando, o sistema do MySQL irá impedir que diversas linhas sejam alteradas altravés do safe update, lançando um erro
no log. É aconselhável que este recurso fique ativado, para que este tipo de risco seja inibido. Uma situação de prejuízo é o caso de o banco
possuir por exemplo, cem mil registros referentes ao valor do salário disponível para depósito, e por falta de atenção, você programar um script
para alterar todos os registros de clientes que possuem o campo primeiro_nome igual a joão para 0, este seria um sério probelema, mas caso seja 
necessário manter esse recurso desativado, é importante sempre ter um backup do último estado consistente do banco de dados.*/

/*indo adiante, temos alguns registros que podemos perceber que estão fora dos temas tratados em TI, nesse caso temos 3 registros que não deveriam
fazer parte do postifólio de cursos. Vamos agora remover cada um deles com o seguinte comando:*/
delete from cursos where idcurso = '8';
delete from cursos where idcurso = '9';
delete from cursos where idcurso = '10';

/*assim como os comandos para inserir alterar dados, também podemos remover vários registros simultaneamente assim. Por exemplo, se quisermos
remover todos os crusos que foram criados em 2018, usariamos o seguinte comando:*/
delete from cursos where ano = '2018'
limit 3;
/*atenção: para que o comando para remover afete vários registros, é necessário desativar o safe update*/

/*també é possível apagar todos os registros de uma tabela de uma só vez com o segunte comando:*/
truncate table cursos;
#ou simplismente
 truncate cursos;
/*Mais eu não farei isso porque não quero peder todos os dados que eu já inseri na minha tabela*/








