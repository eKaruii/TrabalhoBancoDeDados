use RestauranteBD;
INSERT INTO Cliente (nome_cliente,endereco,CPF)
VALUES 
("Maria Carla","Reta da Penha,456","123.567.890.90"), 
("Isabel Emília","Itapuã,156","178.507.890.98"), 
("Daphne Rocha","Praia da Costa,234","190.517.866.92");

INSERT INTO Mesa (numero_mesa)
VALUES
(1),
(2),
(3),
(4);

INSERT INTO Atendente(matricula,nome_atendente,salario,AtendenteSenior_matricula)
VALUES      
(1,"Julia Paiva", 1345.00,2),
(2,"Roberto Silva", 2135.00,null),
(3,"Adriana Santos", 2135.00,null),
(4,"Renata Lima", 1345.00,3);

INSERT INTO Bebida (nome_bebida, preco_bebida)
VALUES ('Coca-Cola', 5.50),
       ('Água Mineral', 2.00),
       ('Suco de Laranja', 4.80);
       
INSERT INTO Prato (nome_prato, preco_prato)
VALUES ('Pizza Margherita', 35.00),
       ('Espaguete à Bolonhesa', 28.00),
       ('Lasanha de Carne', 30.00);
       
INSERT INTO Telefone(numero_telefone,Atendente_matricula)
VALUES
("27999678975", 1),
("27999678123", 2),
("28999663456", 3),
("27999670987", 4);


INSERT INTO Pedido (hora_inicio, hora_fim, Cliente_id, Mesa_numero, Atendente_matricula)
VALUES 
  ('2025-03-28 12:30:00', '2025-03-28 13:00:00', 1, 1, 2),
  ('2025-03-28 13:15:00', '2025-03-28 13:50:00', 2, 2, 3),
  ('2025-03-28 14:00:00', '2025-03-28 14:45:00', 3, 3, 1),
  ('2025-03-28 16:00:00', '2025-03-28 16:25:00', 2, 4, 4);
  
  INSERT INTO Bebida_has_Pedido (Bebida_codigo_bebida, Pedido_numero_Pedido)
VALUES
(1, 3), 
(2, 4); 

INSERT INTO Prato_has_Pedido (Prato_codigo_prato, Pedido_numero_Pedido)
VALUES
(1, 4),  
(2, 3),
(1,2),
(3,1);  






