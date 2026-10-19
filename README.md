<div align="center">

# Acorde

**Aprenda Espanhol Rioplatense (Argentina) através de Letras de Músicas**

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B.svg?style=flat-square&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-0175C2.svg?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![SQLite](https://img.shields.io/badge/Drift-SQLite-07405e.svg?style=flat-square&logo=sqlite&logoColor=white)](https://drift.simonbinder.eu)
[![Riverpod](https://img.shields.io/badge/State-Riverpod_2.0-blueviolet.svg?style=flat-square)](https://riverpod.dev)
[![AI Engine](https://img.shields.io/badge/AI_Engine-Groq_%7C_Gemini-FF6D38.svg?style=flat-square)](https://groq.com)
[![Platform](https://img.shields.io/badge/Platform-Android_%7C_Windows-black.svg?style=flat-square)](#download--instalação)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)

<br/>

[Download APK (Android)](#download--instalação) &nbsp;&bull;&nbsp; [Download Windows (x64)](#download--instalação) &nbsp;&bull;&nbsp; [Arquitetura](#arquitetura) &nbsp;&bull;&nbsp; [Identidade Visual](#identidade-visual-navigate)

</div>

---

## Visão Geral

O **Acorde** é uma aplicação pessoal de código aberto em Flutter concebida para o domínio do **espanhol rioplatense** — a variante falada na Argentina e no Uruguai — a partir do repertório musical local (rock nacional, tango, cumbia villera e trap).

Ao inserir a letra de uma canção, a inteligência artificial analisa as estrofes, divide a obra em uma trilha de estudo progressiva e desmembra cada trecho em **cinco pilares pedagógicos estruturados**.

---

## Os Cinco Pilares Pedagógicos

Cada lição diária desdobra o trecho lírico em cinco blocos de estudo:

| Pilar | Foco Pedagógico | Exemplo Rioplatense |
| :--- | :--- | :--- |
| **1. Pronúncia & Fonética** | Entonação, fonética do *yeísmo rehilado* (sons de *sh/ch* para **ll** e **y**), ritmo silábico e aspiração do **s** final. | *"Yo sé"* pronunciado como *"Sho sé"*; *"playa"* como *"plasha"*. |
| **2. Gírias & Lunfardo** | Vocabulário coloquial de Buenos Aires, níveis de formalidade e contexto de uso no cotidiano. | *Che*, *posta*, *chabón*, *laburo*, *quilombo*, *mina*, *guita*. |
| **3. Gramática & Voseo** | Conjugação verbal e pronominal exclusiva da bacia do Rio da Prata contrastada com o português brasileiro. | *Vos tenés*, *vos sos*, imperativos acentuados na última sílaba (*mirá*, *escuchá*, *andá*). |
| **4. Falsos Cognatos** | Armadilhas de sentido entre o português e o espanhol presentes na estrofe para evitar desvios semânticos. | *Todavía* (ainda), *largo* (comprido), *embarazada* (grávida), *apellido* (sobrenome). |
| **5. Vocabulário & Revisão** | Flashcards dinâmicos com áudio nativo (TTS em *es-AR*) e agendamento automático na repetição espaçada. | Salvamento com um toque e revisão nos intervalos ótimos. |

---

## Algoritmo de Repetição Espaçada

O sistema implementa o algoritmo de retenção espaçada (SRS) com progressão em quatro estágios baseada no modelo de intervalo crescente:

```text
[Novo Vocábulo Salvo]
         │
         ▼
     [Nível 1]  ──>  Revisão em 1 dia
         │
   Acertou?
  ┌──────┴──────┐
  │ Sim         │ Não
  ▼             ▼
[Nível 2]    [Nível 1] (Reinicia ciclo)
(3 dias)
  │
[Nível 3]
(7 dias)
  │
[Nível 4]
(14 dias de consolidação)
```

- **Resposta Correta**: Eleva o item para o estágio subsequente (+1 nível), dobrando o intervalo de tempo.
- **Resposta Incorreta**: O item retorna imediatamente ao Nível 1 (revisão no dia seguinte), garantindo fixação completa.

---

## Identidade Visual (Design System Navigate)

O Acorde adota uma direção de arte inspirada em cartazes tipográficos modernistas e pôsteres de música:

- **Contraste Rígido**: Ausência intencional de degradês, sombras falsas ou fotografias dispersivas.
- **Tipografia de Alto Impacto**:
  - **Títulos**: *Archivo Black* com entrelinha compacta (`0.88`) e espaçamento entre letras reduzido.
  - **Interface & Leitura**: *DM Sans* (400 a 700, 13px a 18px), proporcionando clareza e ritmo de leitura.
- **Geometria**: Botões em formato de pílula contínua (*pill buttons*) e cartões com cantos arredondados de 25px.
- **Ação Única**: A cor de destaque de ação primária é restrita a `#c7ff69` com texto escuro `#141414`.

### Paleta Estrutural

```text
Superfície Principal   #141414  ████  Fundo escuro profundo
Superfície Elevada     #232323  ████  Cartões e módulos
Leitura da Estrofe     #fdf9f0  ████  Fundo claro para imersão no texto lírico
Ação Primária          #c7ff69  ████  Botões principais de conclusão e avanço
Celebração & Logo      #ff6d38  ████  Ponto de destaque da marca "a."
```

---

## Arquitetura de Software

O projeto segue os princípios de **Clean Architecture** com segmentação por funcionalidades (*Feature-First*):

```text
lib/
├── core/
│   ├── ai_gateway/           # Provedores de IA (Groq, Gemini) sobre abstração unificada
│   ├── database/             # Drift ORM (SQLite) com 7 tabelas e migrações tipadas
│   ├── storage/              # Chaveiro criptografado via flutter_secure_storage
│   ├── theme/                # Tokens de design Navigate (AppColors, AppTypography)
│   ├── tts/                  # Text-to-speech nativo com detecção de voz es-AR e fallback
│   └── widgets/              # Componentes base (PillButton, QuintetIcon, FloatingNavBar)
├── features/
│   ├── splash/               # Abertura animada da marca com física elástica
│   ├── navigation/           # Shell principal e barra de navegação flutuante
│   ├── onboarding/           # Questionário adaptativo de 5 etapas e perfil do estudante
│   ├── music/                # Cadastro de músicas, divisão em seções e biblioteca
│   ├── lesson/               # Estudo diário dos 5 pilares, áudio e cartões 3D
│   ├── vocab/                # Sessão de revisão espaçada com virada tridimensional
│   └── settings/             # Gerenciamento de chaves, seleção de IA e exclusão de dados
└── main.dart                 # Inicialização com ProviderScope e verificação de perfil
```

---

## Segurança & Privacidade

1. **Armazenamento no Chaveiro do Sistema Operacional**:
   Chaves de API (Groq ou Google Gemini) são salvas exclusivamente via `flutter_secure_storage` utilizando o *Android Keystore* e o *Windows Data Protection API (DPAPI)*. Nenhuma chave é persistida em texto puro ou enviada a servidores intermediários.

2. **Banco de Dados 100% Local**:
   O histórico de músicas, análises, perfis e cartões de memória reside estritamente no dispositivo em banco SQLite gerenciado pelo Drift.

3. **Consentimento Explícito Prévio**:
   O app solicita confirmação formal antes da primeira requisição contendo letras a qualquer modelo de linguagem externo.

4. **Direito ao Esquecimento**:
   A tela de configurações dispõe de opção para exclusão completa e definitiva de todos os registros locais em uma única operação.

---

## Download & Instalação

Os binários compilados estão disponíveis na aba de [Releases do GitHub](https://github.com/brunoosz/acorde/releases):

| Versão | Formato | Descrição |
| :--- | :--- | :--- |
| **Android** | `.apk` | Compatível com Android 8.0+ (ARM64 / ARMv7 / x86_64) |
| **Windows** | `.zip` (`.exe`) | Pacote autônomo de 64 bits para Windows 10 e 11 |

---

## Como Executar Localmente

### Pré-requisitos
- Flutter SDK (versão 3.24 ou superior)
- Dart SDK (versão 3.5 ou superior)

### Passo a Passo

```bash
# 1. Clonar o repositório
git clone https://github.com/brunoosz/acorde.git
cd acorde

# 2. Obter dependências do ecossistema Flutter
flutter pub get

# 3. Gerar tabelas do Drift e serializadores
dart run build_runner build --delete-conflicting-outputs

# 4. Executar os testes automatizados
flutter test

# 5. Executar o aplicativo no dispositivo ou emulador conectado
flutter run
```

---

## Testes Automatizados

A suíte de testes unitários e de widgets valida a integridade das regras de negócio:

```bash
flutter test
```

- **Spaced Repetition Algorithm**: Validação de avanços de nível (1 a 4) e reset imediato em falhas.
- **AI Gateway & Parsing**: Higienização de cercas de código Markdown, tratamento de erro 429 (rate limit) e validação de chaves ausentes.
- **User Profile**: Formatação do contexto pedagógico para prompts de IA.
- **Widget & Design System**: Verificação de renderização do logotipo na tela de abertura animada, barra flutuante e paleta Navigate.

---

## Licença

Distribuído sob a licença **MIT**. Consulte `LICENSE` para mais detalhes.
