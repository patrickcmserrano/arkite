# Arkite (Prompt IDE)

Arkite é um ambiente de desenvolvimento integrado (IDE) focado em prompts, construído com Flutter e potencializado pela **Gemini 2.5 Flash AI**. O objetivo é permitir o gerenciamento de projetos e conversas complexas com LLMs de forma estruturada e persistente.

## 🚀 Funcionalidades Implementadas

### Arquitetura e Core
- **Gerenciamento de Estado:** Utilização do `flutter_riverpod` para injeção de dependência e controle de estado reativo.
- **Persistência de Dados:** Integração com **Drift Database** (SQLite) para armazenamento local robusto e multiplataforma.
- **Suporte Web:** Configuração completa para execução no navegador utilizando `sqlite3.wasm` e Web Workers para o Drift.
- **Estrutura de Código:** Organização em camadas (`ui`, `kernel`, `io`) para separação de responsabilidades.

### Features
- **Autenticação / Onboarding:**
  - Tela `WelcomeScreen` para entrada inicial e configuração da API Key do Gemini.
  - Validação e persistência segura da API Key.
- **Gerenciamento de Projetos:**
  - Modelo de dados `Project` (Tabela Drift).
  - Providers e Repositório (`DriftRepository`) para CRUD de projetos.
  - Interface `ProjectListScreen` funcional para listagem e criação de projetos.
- **Sistema de Chat:**
  - Modelo de dados `Node` (Tabela Drift) para estruturar conversas.
  - Interface `ChatScreen` implementada.
  - Serviço `GeminiService` estruturado para comunicação com a API.

### Gemini 2.5 Flash - Capacidades
- **Modelo:** `gemini-2.5-flash` (Stable Version)
- **Limites de Tokens:**
  - Input: 1,048,576 tokens
  - Output: 65,536 tokens
- **Tipos de Entrada Suportados:** Texto, Imagens, Vídeo, Áudio
- **Capacidades Habilitadas:**
  - ✅ Batch API
  - ✅ Caching
  - ✅ Code Execution
  - ✅ File Search
  - ✅ Function Calling
  - ✅ Grounding with Google Maps
  - ✅ Search Grounding
  - ✅ Structured Outputs
  - ✅ Thinking
  - ✅ URL Context
- **Não Suportado:** Audio Generation, Image Generation, Live API
- **Última Atualização:** June 2025
- **Knowledge Cutoff:** January 2025

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

2. **Gere os arquivos de código (Riverpod & Drift):**
   Como o projeto utiliza geração de código (Drift e Riverpod), é necessário rodar o build_runner:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Execute o aplicativo:**
   
   **Desktop (Windows/Linux/macOS):**
   ```bash
   flutter run -d windows
   ```
   *(Ou linux/macos dependendo do seu SO)*

   **Web:**
   ```bash
   flutter run -d chrome
   ```
   *Nota: Certifique-se de que os arquivos `sqlite3.wasm` e `drift_worker.dart.js` estejam corretamente na pasta `web` (já incluídos no repositório).*

## 📋 Próximos Passos (TODO List)

- [ ] **Integração Fina do Chat:** Validar o fluxo completo de mensagens e respostas com a API do Gemini persistindo no Drift.
- [ ] **Tree Walker:** Implementar algoritmos avançados para navegação na árvore de conversa (Nodes).
- [ ] **Refinamento de UI/UX:** Melhorar feedback visual durante o loading e tratativa de erros.
- [ ] **Testes:** Expandir a cobertura de testes para o `DriftRepository` e ViewModels.
