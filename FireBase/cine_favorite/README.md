# CineFavoriite - Formativa
Construir um Aplicativo do Zero - O CineFavorite permiteré criar uma conta e buscar filmes em uma API e montar uma galeria pessola de films favoritos com posters e notas


## Objetivos
- Criar uma galeria Personalizada Por Usário de Filmes Favoritos
- Conectar o App com uma API( base de Dados) de Filmes
- Permirtir a criação de contas para cada Usuários
- Listar Filmes por palavras chaves

## levantamento de Requisitos do Projeto
- ### Funcionais

- ## não Funcionais

## Recursos do Projeto
- Flutter/ Dart
- FireBase (Authentication/FireStore DataBase)
- Figma
- Vscode

## Diagramas

1. ### Classes
     Demonstar O Funcionamento das Entidades do Sistema
     - Usuario (User) : classe já modelada pelo FirebaseAuth
     - email
     - passaword
     - uid
     - login()
     - create()
     - logout()

   - FilmeFavorito: Classe modelada pelo DEV
        - number: id
        - string: Título
        - String: Poster
        - double: Rating
        - adicionar()
        - remover()
        - listar()
        - updateNota()

        ```mermaid
        ClassDiagram
            class User{
                +String uid
                +String email
                +String passaword
                +createUser()
                +login()
                +logout()
            }

        Class FavoriteMovie{
            +String id
            +String title
            +String posterPath
            +Double Reating
            +addFavorite()
            +removeFavorite()
            +updateFavorite()
            +readList()
        }

      User "1"--"1+" FavoriteMovie: "save"

   ```

2. ### Uso
    Ações que os Atores podem fazer
    - User:
        - Registrar
        - Login
        - Logout
        - Procurar Filmes API
        - Salvar Filmes Favoritos
        - Dar Nota aos Filmes
        - Remover dos Favoritos

        ```mermid
            graph TD
                subgraph "Ações"
                    uc1([Registrar-se])
                    uc2([Logar-se])
                    uc3([Logout])
                    uc4([Procurar Filmes])
                    uc5([Slavar Filmes Favoritos])
                    uc6([Dar nota ao Filme])
                    uc7([Remover dos favoritos])
                end

                user([Usuário])

                user --> uc1 
                user --> uc2 
                user --> uc3 
                user --> uc4 
                user --> uc5 
                user --> uc6 
                user --> uc7

                uc1 --> uc2
                uc2 --> uc4
                uc2 --> uc5
                uc2 --> uc6
                uc2 --> uc7
    ```
3. ### Fluxo
    Determine o Caminho percorrido pelo ator para executar uma ação

    - Ação de Login

    ```mermaid

    graph TD

        A[Início] --> B{Login Usuário}
        B --> C[Inserir email e senha]
        C --> D{Validar as credenciais}
        D --> E[sim]
        E --> F[Tela de Favoritos]
        D --> G[não]
        G --> E

    ```

## Prototipagem
   - Link Figma: https://www.figma.com/proto/5FANFPHB5uh0jvGYFls1yD/Sem-t%C3%ADtulo?node-id=0-1&t=jdfIcuHRtfChzCPV-1

## Codificação