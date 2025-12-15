# Arkite (Prompt IDE)

Arkite é um ambiente de desenvolvimento integrado (IDE) focado em prompts, construído com Flutter e potencializado pela Gemini AI. O objetivo é permitir o gerenciamento de projetos e conversas complexas com LLMs de forma estruturada e persistente.

## 🚀 Funcionalidades Implementadas

### Arquitetura e Core
- **Gerenciamento de Estado:** Utilização do `flutter_riverpod` para injeção de dependência e controle de estado reativo.
- **Persistência de Dados:** Integração com `Isar Database` para armazenamento local de alto desempenho.
- **Estrutura de Código:** Organização em camadas (`ui`, `kernel`, `io`) para separação de responsabilidades.

### Features
- **Autenticação / Onboarding:**
  - Tela `WelcomeScreen` para entrada inicial e configuração da API Key do Gemini.
  - Validação e persistência segura da API Key.
- **Gerenciamento de Projetos:**
  - Modelo de dados `Project` completo com persistência.
  - Providers (`project_providers.dart`) para CRUD de projetos.
  - Interface `ProjectListScreen` para visualização e criação de projetos (código base implementado).
- **Sistema de Chat:**
  - Modelo de dados `Node` para estruturar conversas e contextos.
  - Interface `ChatScreen` com suporte a histórico e interação (código base implementado).
  - Serviço `GeminiService` estruturado para comunicação com a API.

### Design
- Design System base configurado com `AppTheme.darkTheme`.

## 🛠️ Como Rodar o Projeto

Siga os passos abaixo para configurar e executar o ambiente de desenvolvimento:

### Pré-requisitos
- Flutter SDK (Versão recomendada: **3.38.4**)
- Dart SDK

### Passos
1. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

2. **Gere os arquivos de código (Riverpod & Isar):**
   Como o projeto utiliza geração de código, é necessário rodar o build_runner:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

## 📋 Próximos Passos

- [ ] **Integração de Navegação:** Substituir o placeholder na `main.dart` pela `ProjectListScreen` e configurar a rota para a `ChatScreen`.
- [ ] **Integração Gemini:** Conectar totalmente o `GeminiService` à UI do Chat, implementando a conversão correta do histórico de `Node` para o formato esperado pela API.
- [ ] **Refinamento de UI/UX:** Polir as interfaces de lista e chat para melhor experiência do usuário.
- [ ] **Testes:** Expandir a cobertura de testes para os providers e services.
