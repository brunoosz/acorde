# Acorde 🎵🇦🇷

> App pessoal em Flutter para aprender **espanhol rioplatense (Argentina)** a partir de letras de músicas.

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org)

---

## 📖 Visão Geral

O **Acorde** transforma qualquer letra de música argentina (rock nacional, tango, cumbia ou trap) em um curso intensivo e personalizado dividido em dias.

Cada trecho estudado é desmembrado em **cinco pilares pedagógicos**:
1. 🎙️ **Pronúncia**: Fonética rioplatense (o "ll" e "y" com som de *sh/ch*, *s* aspirado, ritmo e entonação).
2. 💬 **Gírias & Lunfardo**: Expressões locais argentinas (*che*, *posta*, *chabón*, *quilombo*, *laburo*), com nível de formalidade e contexto.
3. 📖 **Gramática & Voseo**: Estruturas verbais exclusivas (*tenés*, *sos*, *mirá*, *andá*) contrastadas com o português brasileiro.
4. ⚠️ **Falsos Cognatos**: Armadilhas de vocabulário entre português e espanhol presentes no trecho.
5. 🔖 **Vocabulário & Revisão**: Salve palavras com um toque e revise-as no sistema de repetição espaçada automática (1, 3, 7 e 14 dias).

---

## 🎨 Identidade Visual ("Navigate")

O app adota o estilo de pôster chapado, sem sombras ou degradês, com contraste rigoroso e tipografia pesada:
- **Títulos**: *Archivo Black* com entrelinha compacta (`0.88`) e espaçamento negativo.
- **Corpo & Interface**: *DM Sans* com pesos 400 a 700 (13px a 18px).
- **Paleta de Cores**:
  - Fundo escuro: `#141414`
  - Superfície elevada: `#232323`
  - Fundo claro de leitura da aula: `#fdf9f0`
  - Destaque / celebração: `#ff6d38`
  - **Ação única**: `#c7ff69` (texto `#141414`)
  - **Quinteto fixo dos 5 pilares**:
    - Pronúncia / Música: `#7a78ff`
    - Gírias: `#00a652`
    - Gramática: `#ff6d38`
    - Falsos cognatos: `#ffc412`
    - Vocabulário: `#478bff`

---

## 🏛️ Arquitetura

O projeto é estruturado por features (*Feature-First*):

```text
lib/
├── core/
│   ├── ai_gateway/     # Interface unificada AiProvider, Groq e Gemini compatíveis com OpenAI
│   ├── database/       # Drift (SQLite) com 7 tabelas e repetição espaçada
│   ├── storage/        # Armazenamento seguro de chaves com flutter_secure_storage
│   ├── theme/          # Paleta Navigate, tipografia Archivo Black / DM Sans
│   ├── tts/            # Text-to-speech (es-AR com fallback inteligente)
│   └── widgets/        # Componentes reaproveitáveis (PillButton, QuintetIcon, FloatingNavBar)
└── features/
    ├── navigation/     # Shell com barra de navegação flutuante em pílula
    ├── onboarding/     # Questionário inicial de 5 passos e perfil do estudante
    ├── music/          # Cadastro de músicas, divisão em estrofes e biblioteca
    ├── lesson/         # Aula do dia, os 5 pilares, controle de velocidade e cards que viram
    ├── vocab/          # Flashcards de repetição espaçada (1, 3, 7 e 14 dias)
    └── settings/       # Configuração dinâmica de IA, teste de conexão e exclusão de dados
```

---

## 🔒 Segurança & Privacidade

- **Chaves de API**: Digitadas pelo usuário nas configurações e salvas exclusivamente no chaveiro nativo seguro do dispositivo (`flutter_secure_storage`). Nunca versionadas ou enviadas a servidores intermediários.
- **Armazenamento Local**: Letras de músicas, respostas do perfil e vocabulário ficam salvos somente no SQLite local do aparelho.
- **Consentimento**: Aviso explícito antes do primeiro envio de qualquer letra a um provedor externo de IA.
- **Privacidade total**: Botão *"Apagar todos os meus dados"* para reset completo das tabelas e credenciais.

---

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.24+
- Android Studio / Emulador Android ou dispositivo conectado

### Instalação
```bash
# 1. Clonar o repositório
git clone https://github.com/exemplo/acorde.git
cd acorde

# 2. Instalar as dependências
flutter pub get

# 3. Gerar código do Drift e ícones
dart run build_runner build --delete-conflicting-outputs
dart run flutter_launcher_icons

# 4. Executar os testes
flutter test

# 5. Rodar no dispositivo
flutter run
```

---

## 📄 Licença

Projeto desenvolvido sob a licença MIT.
