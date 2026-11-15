#  Sistema Automotivo – Gestão de Estoque de Veículos

Este projeto foi desenvolvido como requisito parcial para aprovação na disciplina de Programação Orientada a Objetos. Trata-se de um sistema completo (CRUD) para gerenciamento de estoque de veículos, focado na organização de concessionárias e lojas de automóveis.

##  Objetivo do Projeto
O sistema resolve o problema da desorganização de estoques manuais, permitindo o cadastro eficiente de veículos, organização de marcas e modelos, atualização de status, filtros dinâmicos de busca e controle de exclusão baseado em regras de negócio (ex: só é possível excluir veículos vendidos ou descontinuados).

##  Tecnologias Utilizadas

**Backend:**
*   **Java 17** (Linguagem base)
*   **Spring Boot 3.x / 4.x** (Framework principal)
*   **Spring Data JPA / Hibernate** (Persistência e mapeamento objeto-relacional)
*   **Maven** (Gerenciamento de dependências)

**Banco de Dados:**
*   **MySQL 8.0+** (Banco de dados relacional)

**Frontend:**
*   **HTML5, CSS3 e JavaScript (Vanilla)** (Interface consumindo a API REST)

##  Arquitetura e Padrões (POO)
O projeto foi estruturado utilizando o padrão de arquitetura em camadas (MVC), aplicando os pilares da Orientação a Objetos:
*   **Models (Entities):** Representação das tabelas (`Veiculo`, `Modelo`, `Marca`) com uso de encapsulamento (getters/setters) e relacionamentos (`@ManyToOne`, `@OneToMany`).
*   **Repositories:** Interfaces que estendem `JpaRepository` para abstração das consultas SQL (incluindo queries customizadas com `@Query` para filtros dinâmicos).
*   **Services:** Camada responsável pelas regras de negócio (ex: validação para bloqueio de exclusão de veículos com status "Disponível").
*   **Controllers:** Endpoints REST para comunicação HTTP com o Frontend.

##  Como executar o projeto localmente

Para rodar este projeto na sua máquina, você precisará do **Java (JDK 17+)**, **MySQL** e **Maven** instalados.

### 1. Configurar o Banco de Dados
1. Abra o MySQL Workbench (ou terminal do MySQL).
2. Execute o script SQL disponível neste repositório para criar o banco `sistema_automotivo` e as tabelas necessárias (Marca, Modelo e Veiculo).

### 2. Configurar as Credenciais
No arquivo `src/main/resources/application.properties`, altere as configurações de acesso ao banco para as suas credenciais locais:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/sistema_automotivo?useSSL=false&serverTimezone=UTC
spring.datasource.username=SEU_USUARIO_AQUI
spring.datasource.password=SUA_SENHA_AQUI
