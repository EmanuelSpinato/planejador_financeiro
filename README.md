# Planejador Financeiro

Uma aplicação Flutter para gerenciar transações financeiras. A aplicação permite adicionar, editar e visualizar transações, utilizando o Firebase Firestore para armazenamento.

## Estrutura do Projeto

- `main.dart`: Ponto de entrada da aplicação.
- `models/transaction.dart`: Modelo de dados para transações.
- `services/firebase_service.dart`: Serviço para interagir com o Firebase Firestore.
- `utils/constants.dart`: Definição de constantes usadas no aplicativo.
- `viewmodels/transaction_viewmodel.dart`: ViewModel para gerenciar o estado das transações.
- `views/add_transaction_view.dart`: Tela para adicionar uma nova transação.
- `views/edit_transaction_view.dart`: Tela para editar uma transação existente.
- `views/home_view.dart`: Tela principal que exibe a lista de transações.

## Configuração e Execução

### Pré-requisitos

- Flutter SDK: [Instruções de instalação](https://flutter.dev/docs/get-started/install)
- Firebase CLI: [Instruções de instalação](https://firebase.google.com/docs/cli)

### Configuração

1. Clone o repositório:
   ```bash
   git clone <URL-do-repositório>
   cd planejador_financeiro
