# Lista de Contatos usando Flutter, BLoC, Cubit e Back4App

Este é um aplicativo simples de Lista de Contatos desenvolvido utilizando Flutter, gerenciamento de estado com BLoC e Cubit, e integração com a plataforma Back4App para realizar requisições HTTP e armazenar os dados no Shared Preferences.

O objetivo deste aplicativo é demonstrar boas práticas de arquitetura e uso de tecnologias populares para o desenvolvimento de aplicativos móveis.

## Recursos

- Exibir uma lista de contatos com nome, número de telefone.
- Adicionar novos contatos com informações completas.
- Editar informações existentes de contatos.
- Realizar requisições HTTP para obter e enviar dados da lista de contatos para o Back4App.

## Arquitetura e Estrutura do Projeto

O projeto segue uma arquitetura baseada em BLoC e Cubit para o gerenciamento de estado. A estrutura de pastas é organizada da seguinte forma:

- **lib/**
  - **core/**: Contém os arquivos relacionados aos BLoCs.
  - **data/**: Contém os modelos de dados utilizados no aplicativo, a comunicação com o banco e seus respectivos repositories.
  - **pages/**: Contém as diferentes telas do aplicativo, os arquivos relacionados aos BLoCs.

## Contribuição

Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhorias, sinta-se à vontade para abrir uma issue ou enviar um pull request.
