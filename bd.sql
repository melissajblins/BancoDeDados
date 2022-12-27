/* Criando Banco */

/* Tabela Hospital */
CREATE TABLE Hospital (
  id INTEGER NOT NULL,
  nome VARCHAR(300) NOT NULL,
  constraint PK_Hospital PRIMARY KEY(id)
);

/* Tabela Ala */
CREATE TABLE Ala (
  id INTEGER NOT NULL, 
  nome VARCHAR(300) NOT NULL,
  idHospital INTEGER NOT NULL,
  constraint PK_Ala PRIMARY KEY(id),
  constraint FK_Ala FOREIGN KEY(idHospital) REFERENCES Hospital(id)
);

/* Herança AlaOperacao */
CREATE TABLE AOperacao(
  andar VARCHAR(50) NOT NULL

) INHERITS (Ala);

/* Herança SalaOperacao */
CREATE TABLE SalaOperacao(
  idSala INTEGER NOT NULL,
  especialidade VARCHAR(200) NOT NULL

) INHERITS (AOperacao);

/* Herança AlaInternacao */
CREATE TABLE AInternacao(
  nomeInternacao VARCHAR(300) NOT NULL

) INHERITS (Ala);

/* Herança LeitoInternacao */
CREATE TABLE LeitoInternacao(
  idLeito INTEGER NOT NULL,
  andar VARCHAR(50) NOT NULL

) INHERITS (AInternacao);

/* Herança AlaConsulta */
CREATE TABLE AConsulta(
  sala VARCHAR(50) NOT NULL,
  andar VARCHAR(50) NOT NULL

) INHERITS (Ala);

/* Tabela Funcionario */
CREATE TABLE Funcionario (
  id INTEGER NOT NULL,
  idHospital INTEGER NOT NULL,
  nome VARCHAR(200) NOT NULL,
  endereco VARCHAR(200) NOT NULL,
  telefone VARCHAR(200) NOT NULL,
  dataContrato date not NULL,
  constraint PK_Funcionario PRIMARY KEY(id),
  constraint FK_Funcionario02 FOREIGN KEY(idHospital) REFERENCES Hospital(id)
);

/* Herança Medico */
CREATE TABLE Medico(
  idAla INTEGER NOT NULL,
  CRM INTEGER NOT NULL,
  especialidade VARCHAR(200) NOT NULL,
  primary key (id),
  constraint FK_Funcionario FOREIGN KEY(idAla) REFERENCES Ala(id)

) INHERITS (Funcionario);


/* Herança Enfermeiro */
CREATE TABLE Enfermeiro(
  idAla INTEGER NOT NULL,
  COREN INTEGER NOT NULL,
  primary key (id),
  constraint FK_Funcionario FOREIGN KEY(idAla) REFERENCES Ala(id)

) INHERITS (Funcionario);

/* Herança Manutencao */
CREATE TABLE Manutencao(
  tipo VARCHAR(200) NOT NULL

) INHERITS (Funcionario);

/* Herança Tecnico */
CREATE TABLE Tecnico(
  tipo VARCHAR(200) NOT NULL

) INHERITS (Funcionario);

/* Substituicao Medico */
CREATE TABLE SubstituicaoMedico (
  idMedico01 INTEGER NOT NULL,
  idMedico02 INTEGER NOT NULL,
  idAla INTEGER NOT NULL,
  data timestamp not NULL,
  constraint FK_SubstituicaoMedico FOREIGN KEY(idMedico01) REFERENCES Medico(id),
  constraint FK_SubstituicaoMedico02 FOREIGN KEY(idMedico02) REFERENCES Medico(id),
  constraint FK_SubstituicaoMedico03 FOREIGN KEY(idAla) REFERENCES Ala(id)
);

/* Substituicao Enfermeiro */
CREATE TABLE SubstituicaoEnfermeiro (
  idEnfermeiro01 INTEGER NOT NULL,
  idEnfermeiro02 INTEGER NOT NULL,
  idAla INTEGER NOT NULL,
  data timestamp not NULL,
  constraint FK_SubstituicaEnfermeiro FOREIGN KEY(idEnfermeiro01) REFERENCES Enfermeiro(id),
  constraint FK_SubstituicaEnfermeiro02 FOREIGN KEY(idEnfermeiro02) REFERENCES Enfermeiro(id),
  constraint FK_SubstituicaEnfermeiro03 FOREIGN KEY(idAla) REFERENCES Ala(id)
);

/* Tabela Paciente */
CREATE TABLE Paciente (
  id INTEGER NOT NULL,
  nome VARCHAR(200) NOT NULL,
  endereco VARCHAR(200) NOT NULL,
  telefone VARCHAR(200) NOT NULL,
  dataNascimento date not NULL,
  genero VARCHAR(20) NOT NULL,
  tipoConvenio VARCHAR(200) NOT NULL,
  numeroConvenio INTEGER NOT NULL,
  constraint PK_Paciente PRIMARY KEY(id)
);

/* Tabela Atendimento */
CREATE TABLE Atendimento (
  id INTEGER NOT NULL,
  idPaciente INTEGER NOT NULL,
  idMedico INTEGER NOT NULL,
  idSalaConsulta INTEGER NOT NULL,
  tipo VARCHAR(200) NOT NULL,
  data timestamp not NULL,
  constraint PK_Atendimento PRIMARY KEY(id),
  constraint FK_Atendimento FOREIGN KEY(idPaciente) REFERENCES Paciente(id),
  constraint FK_Atendimento02 FOREIGN KEY(idMedico) REFERENCES Medico(id),
  constraint FK_Atendimento03 FOREIGN KEY(idSalaConsulta) REFERENCES Ala(id)
);

/* Tabela Diagnóstico */
CREATE TABLE Diagnostico (
  id INTEGER NOT NULL,
  idAtendimento INTEGER NOT NULL,
  tipo VARCHAR(200) NOT NULL,
  data timestamp not NULL,
  constraint PK_Diagnostico PRIMARY KEY(id),
  constraint FK_Diagnostico FOREIGN KEY(idAtendimento) REFERENCES Atendimento(id)
);

/* Tabela Exames */
CREATE TABLE Exame (
  id INTEGER NOT NULL,
  idAtendimento INTEGER NOT NULL,
  tipo VARCHAR(200) NOT NULL,
  constraint PK_Exame PRIMARY KEY(id),
  constraint FK_Exame FOREIGN KEY(idAtendimento) REFERENCES Atendimento(id)
);

/* Tabela Laboratorio */
CREATE TABLE Laboratorio (
  id INTEGER NOT NULL,
  nome VARCHAR(200) NOT NULL,
  endereco VARCHAR(200) NOT NULL,
  telefone VARCHAR(200) NOT NULL,
  dataContrato date not NULL,
  constraint PK_Laboratorio PRIMARY KEY(id)
);

/* Tabela ExamesCobertos */
CREATE TABLE ExamesCobertos (
  id INTEGER NOT NULL,
  idLaboratorio INTEGER NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  constraint PK_ExamesCobertos PRIMARY KEY(id),
  constraint FK_ExamesCobertos FOREIGN KEY(idLaboratorio) REFERENCES Laboratorio(id)
);

/* Tabela AgendamentoExame */
CREATE TABLE AgendamentoExame (
  idExame INTEGER NOT NULL,
  idLaboratorio INTEGER NOT NULL,
  data timestamp not NULL,
  constraint FK_AgendamentoExame FOREIGN KEY(idExame) REFERENCES Exame(id),
  constraint FK_AgendamentoExame02 FOREIGN KEY(idLaboratorio) REFERENCES Laboratorio(id)
);

/* Tabela SolicitaçãoInternacao */
CREATE TABLE SolicitacaoInternacao (
  id INTEGER NOT NULL,
  idAtendimento INTEGER NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  constraint PK_SolicitacaoInternacao PRIMARY KEY(id),
  constraint FK_SolicitacaoInternacao FOREIGN KEY(idAtendimento) REFERENCES Atendimento(id)
);

/* Tabela AgendamentoInternacao */
CREATE TABLE InternacaoAgendamento (
  id INTEGER NOT NULL,
  idSolicitacao INTEGER NOT NULL,
  idAla INTEGER NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  data timestamp not NULL,
  constraint PK_InternacaoAgendamento PRIMARY KEY(id),
  constraint FK_InternacaoAgendamento FOREIGN KEY(idSolicitacao) REFERENCES SolicitacaoInternacao(id),
  constraint FK_InternacaoAgendamento02 FOREIGN KEY(idAla) REFERENCES Ala(id)
);

/* Populando Banco */
/* Hospital */
insert into Hospital (id, nome) values (1, 'Hospital Santo André'); 
insert into Hospital (id, nome) values (2, 'Hospital São Bernardo'); 

/* Ala */
insert into Ala (id, nome, idHospital) values (1, 'Operacao', 1); 
insert into Ala (id, nome, idHospital) values (2, 'Internacao', 1); 
insert into Ala (id, nome, idHospital) values (3,'Consulta', 1); 
insert into Ala (id, nome, idHospital) values (4, 'Operacao', 2); 
insert into Ala (id, nome, idHospital) values (5, 'Internacao', 2); 
insert into Ala (id, nome, idHospital) values (6, 'Consulta', 2); 

/* Ala Operacacao */
insert into AOperacao (id, nome, idHospital, andar) values (1, 'Operacao', 1, 4); 
insert into AOperacao (id, nome, idHospital, andar) values (4, 'Operacao', 2, 4); 

/* Sala Operacao */
insert into SalaOperacao (id, nome, idHospital, andar, idSala, especialidade) values (1, 'Operacao', 1, 4, 1, 'Transplante');
insert into SalaOperacao (id, nome, idHospital, andar, idSala, especialidade) values (4, 'Operacao', 2, 4, 1, 'Transplante');

/* Ala Internacao */
insert into AInternacao (id, nome, idHospital, nomeInternacao) values (2, 'Internacao', 1, 'Pediatria'); 
insert into AInternacao (id, nome, idHospital, nomeInternacao) values (5, 'Internacao', 2, 'Pediatria'); 

/* Leito Internacao */
insert into LeitoInternacao  (id, nome, idHospital, nomeInternacao, idLeito, andar) values  (2, 'Internacao', 1, 'Pediatria', 1, 2); 
insert into LeitoInternacao  (id, nome, idHospital, nomeInternacao, idLeito, andar) values  (5, 'Internacao', 2, 'Pediatria', 1, 2); 

/* Sala Consulta */
insert into AConsulta (id, nome, idHospital, sala, andar) values (3, 'Consulta', 1, 1, 1); 
insert into AConsulta (id, nome, idHospital, sala, andar) values (6, 'Consulta', 2, 1, 1); 

/* Funcionario */
insert into Funcionario (id, idHospital, nome, endereco, telefone, dataContrato) values (1, 1, 'Melissa', 'Santo André', '40028922', '2020-12-02');

/* Médico */
insert into Medico (id, idHospital, idAla, nome, endereco, telefone, dataContrato, CRM, especialidade) values (2, 1, 1, 'Juliana', 'São Bernardo ', '828930823', '2020-12-02', 1234, 'Cardiologista');
insert into Medico (id, idHospital, idAla, nome, endereco, telefone, dataContrato, CRM, especialidade) values (3, 1, 1, 'Bernardo', 'Caconde', '923923', '2020-12-02', 5678, 'Cardiologista');

/* Enfermeiro */
insert into Enfermeiro (id, idHospital, idAla, nome, endereco, telefone, dataContrato, COREN) values (4, 1, 1, 'Juliana', 'Poços de Caldas', '892322', '2020-12-02', 1423);
insert into Enfermeiro (id, idHospital, idAla, nome, endereco, telefone, dataContrato, COREN) values (5, 2, 1, 'David', 'São Paulo', '87343', '2020-12-02', 57889);

/* Manutenção */
insert into Manutencao (id, idHospital, nome, endereco, telefone, dataContrato, tipo) values (6, 2, 'Luna', 'São Paulo', '98232223', '2020-12-02', 'Hidraulica');

/* Tecnico */
insert into Tecnico (id, idHospital, nome, endereco, telefone, dataContrato, tipo) values (7, 2, 'Karina', 'Diadema', '9283923', '2020-12-02', 'Química');

/* Substituição Médico */
insert into SubstituicaoMedico (idMedico01, idMedico02, idAla, data) values (2, 3, 1, '2022-12-02 17:03:00');
 
/* Substituição Enfermeiro */
insert into SubstituicaoEnfermeiro (idEnfermeiro01, idEnfermeiro02, idAla, data) values (4, 5, 1, '2022-12-02 17:07:00');  

/* Paciente */
insert into Paciente (id, nome, endereco, telefone, dataNascimento, genero, tipoConvenio, numeroConvenio) values (1, 'Bob', 'Caconde', '8347384', '2005-04-05', 'Masculino', 'Sulamerica', 1234);
insert into Paciente (id, nome, endereco, telefone, dataNascimento, genero, tipoConvenio, numeroConvenio) values (2, 'Michelle', 'Diadema', '9283082390', '2010-04-28', 'Feminino', 'Amil', 1437);
insert into Paciente (id, nome, endereco, telefone, dataNascimento, genero, tipoConvenio, numeroConvenio) values (3, 'Rosângela', 'Diadema', '9283082390', '1982-02-28', 'Feminino', 'Amil', 56434);

/* Atendimento */
insert into Atendimento (id, idPaciente, idMedico, idSalaConsulta, tipo, data) values (4567, 1, 2, 1, 'Primeira', '2022-06-26');
insert into Atendimento (id, idPaciente, idMedico, idSalaConsulta, tipo, data) values (4389, 2, 3, 1, 'Primeira', '2022-06-26');
insert into Atendimento (id, idPaciente, idMedico, idSalaConsulta, tipo, data) values (5678, 2, 3, 1, 'Retorno', '2022-07-09');
insert into Atendimento (id, idPaciente, idMedico, idSalaConsulta, tipo, data) values (3467, 3, 2, 1, 'Primeira', '2022-11-27');

/* Diagnostico */ 
insert into Diagnostico (id, idAtendimento, tipo, data) values (56, 4567, 'Virose', '22022-06-26 17:07:00');

/* Exames */
insert into Exame (id, idAtendimento, tipo) values (34, 4389, 'Hemograma');
insert into Exame (id, idAtendimento, tipo) values (39, 3467, 'Ressonância');

/* Laboratorio */
insert into Laboratorio (id, nome, endereco, telefone, dataContrato) values (98, 'Notre Dame', 'São Bernardo', '62922992', '2021-02-06');
insert into Laboratorio (id, nome, endereco, telefone, dataContrato) values (45, 'Santa Joana', 'São Paulo', '98920230', '2021-02-06');

/* Exames Cobertos */
insert into ExamesCobertos (id, idLaboratorio, descricao) values (1, 98, 'Hemograma');
insert into ExamesCobertos (id, idLaboratorio, descricao) values (2, 45, 'Hemograma');
insert into ExamesCobertos (id, idLaboratorio, descricao) values (3, 98, 'Ressonância');
insert into ExamesCobertos (id, idLaboratorio, descricao) values (4, 45, 'Ressonância');

/* Agendamento Exame */
insert into AgendamentoExame (idExame, idLaboratorio, data) values (34, 98, '2022-06-27 09:00:00');
insert into AgendamentoExame (idExame, idLaboratorio, data) values (39, 45, '2022-11-28 09:00:00');

/* Solicitação Internacao */
insert into SolicitacaoInternacao (id, idAtendimento, descricao) values (67, 4389, 'Urgente');
insert into SolicitacaoInternacao (id, idAtendimento, descricao) values (73, 3467, 'Transplante');

/* Agendamento Internacao */
insert into InternacaoAgendamento (id, idSolicitacao, idAla, descricao, data) values (56, 67, 2, 'Urgente', '2022-06-30');
