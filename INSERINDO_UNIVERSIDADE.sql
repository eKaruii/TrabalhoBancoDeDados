
use UniversidadeBD;

INSERT INTO Aluno (matricula, Nome, Telefone, Endereco,Curso_Codigo)
VALUES 
(1001, 'Maria Carla', '27998765432', 'Rua das Acácias, 120',10),
(1002, 'Isabel Emilia', '28999876543', 'Av. Central, 45',20),
(1003, 'Daphne Rocha', '28997654321', 'Praça das Flores, 300',15),
(1004, 'Mariana Costa', '27996543210', 'Rua das Palmeiras, 85',18),
(1005, 'Gustavo Almeida', '28995432109', 'Av. Beira-Mar, 500',15);

INSERT INTO Curso (Codigo, Nome,Professor_Matricula)  
VALUES  
(10, 'Engenharia de Software',1234),  
(20, 'Administração',5670),  
(15, 'Ciência da Computação',5678),  
(18, 'Medicina',2345);  

INSERT INTO Disciplina (Codigo, Nome, Semestre, Vagas, Materia_Codigo, Professor_Matricula)
VALUES
(101, 'Lógica 1', 1, 50, 10, 1234), 
(102, 'Cálculo 1', 1, 45, 15, 5678),
(102, 'Análise de dados', 2, 45, 20, 5670),
(103, 'Biologia 1', 2, 40, 18, 2345); 

INSERT INTO Materia (Codigo, Nome, CargaHoraria)
VALUES
(1, 'Álgebra Linear', 60),      
(2, 'Física Experimental', 80),  
(3, 'Química Orgânica', 40),   
(4, 'Cálculo Diferencial e Integral', 90);

INSERT INTO Email (EnderecoEmail, Aluno_Matricula)
VALUES
('maria.carla@hotmail.com', 1001),
('isabel.emilia@gamil.com', 1002),
('daphne.rocha@gmail.com', 1003),
('mariana.costa@hotmail.com', 1004),
('gustavo.almeida@gmail.com', 1005);

INSERT INTO Professor (Matricula, Email, Nome, Coordenador_Matricula)
VALUES
('0001', 'joao.silva@gmail.com', 'João Silva', NULL), 
('0002', 'ana.souza@gmail.com', 'Ana Souza', '0001'), 
('0003', 'pedro.martins@gmail.com', 'Pedro Martins', '0001'),
('0004', 'lucas.gomes@gmail.com', 'Lucas Gomes', '0002');

INSERT  INTO Disciplina_has_Aluno (Disciplina_Codigo, Disciplina_Materia_Codigo, Disciplina_Professor_Matricula, Aluno_Matricula)
VALUES 
(101, 10, 1234, 1001),  
(103, 10, 2345, 1002),  
(102, 15, 5678, 1003),  
(102, 15, 5678, 1004),  
(103, 18, 2345, 1005); 

INSERT INTO Materia_has_Curso (Materia_Codigo, Curso_Codigo)
VALUES 
(1, 10),  
(2, 10),  
(4, 10), 

(1, 15),  
(2, 15),  
(4, 15),  

(1, 20),  
(4, 20), 

(2, 18), 
(3, 18);  

