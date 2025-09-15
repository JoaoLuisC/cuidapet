# 📚 Wiki do Projeto Sistema de Auto Atendimento CuidaPet

## 📋 Índice

1. [Diagrama de Caso de Uso (UML)](#diagrama-de-caso-de-uso-uml)
2. [Diagrama de Classe (UML)](#diagrama-de-classe-uml)
3. [Paradigmas de Programação](#paradigmas-de-programação-adotados-e-justificativas)
4. [Padrões de Projeto Aplicados](#padrões-de-projeto-aplicados)
5. [Registro de Decisões Técnicas](#registro-de-decisões-técnicas)
6. [Descrição das Funcionalidades Extras](#descrição-das-funcionalidades-extras)
7. [Relato de Dificuldades e Soluções](#relato-de-dificuldades-enfrentadas-e-soluções-adotadas)
8. [Sugestões de Melhorias Futuras](#sugestões-de-melhorias-futuras)
9. [Fluxograma Geral do Sistema](#fluxograma-geral-do-sistema)
10. [Convenções de Código](#convenções-de-código)
11. [Checklist de Testes Manuais](#checklist-de-testes-manuais)

---

## 1. Diagrama de Caso de Uso (UML)

```
                          Sistema de Auto Atendimento CuidaPet
    
    ┌─────────────────────────────────────────────────────────────────────────────┐
    │                                                                             │
    │    Cliente                                    Funcionário                   │
    │       │                                          │                         │
    │       │                                          │                         │
    │       ├── Ver Produtos em Promoção               ├── Autenticar Acesso     │
    │       │                                          │                         │
    │       ├── Solicitar Serviços                     ├── Registrar Venda Manual│
    │       │                                          │                         │
    │       ├── Gerenciar Carrinho ─────────────┐      ├── Ver Estatísticas     │
    │       │   ├── Adicionar Item             │      │                         │
    │       │   ├── Remover Item               │      ├── Buscar Histórico      │
    │       │   └── Visualizar Carrinho        │      │                         │
    │       │                                  │      │                         │
    │       ├── Finalizar Compra ──────────────┤      │                         │
    │       │   ├── Selecionar Pagamento      │      │                         │
    │       │   ├── Aplicar Desconto          │      │                         │
    │       │   └── Gerar Recibo              │      │                         │
    │       │                                  │      │                         │
    │       └── Receber Atendimento ───────────┘      │                         │
    │           Personalizado                         │                         │
    │                                                │                         │
    └─────────────────────────────────────────────────────────────────────────────┘
                                        │
                                        │
                               ┌────────▼────────┐
                               │  Sistema        │
                               │  ├─ Produtos    │
                               │  ├─ Serviços    │
                               │  ├─ Vendas      │
                               │  └─ Relatórios  │
                               └─────────────────┘
```

### Atores:
- **Cliente**: Usuário final que utiliza o sistema para compras
- **Funcionário**: Usuário administrativo com acesso restrito
- **Sistema**: Gerencia dados e operações

### Casos de Uso Principais:
1. **Ver Produtos em Promoção**: Cliente visualiza produtos disponíveis
2. **Solicitar Serviços**: Cliente seleciona serviços oferecidos
3. **Gerenciar Carrinho**: Adicionar/remover itens (máximo 3)
4. **Finalizar Compra**: Processar pagamento com desconto
5. **Autenticar Acesso**: Funcionário acessa área restrita
6. **Registrar Venda Manual**: Funcionário registra vendas extras
7. **Ver Estatísticas**: Relatórios de vendas e performance
8. **Buscar Histórico**: Consultar atendimentos anteriores

---

## 2. Diagrama de Classe (UML)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│                              <<abstract>>                                      │
│                                 Item                                           │
│                         ┌─────────────────┐                                    │
│                         │ - codigo: int   │                                    │
│                         │ - nome: String  │                                    │
│                         │ - preco: double │                                    │
│                         │                 │                                    │
│                         │ + toString()    │                                    │
│                         │ + operator==()  │                                    │
│                         │ + hashCode      │                                    │
│                         └─────────────────┘                                    │
│                                   △                                            │
│                      ┌────────────┴──────────────┐                             │
│                      │                           │                             │
│              ┌───────▼──────┐            ┌──────▼──────┐                       │
│              │   Produto    │            │   Servico   │                       │
│              │──────────────│            │─────────────│                       │
│              │- categoria:  │            │- duracao:   │                       │
│              │  String      │            │  String     │                       │
│              │- descricao:  │            │- descricao: │                       │
│              │  String      │            │  String     │                       │
│              │              │            │             │                       │
│              │+ toString()  │            │+ toString() │                       │
│              │+ static      │            │+ static     │                       │
│              │getProdutos   │            │getServicos  │                       │
│              │Promocao()    │            │Disponiveis()│                       │
│              └──────────────┘            └─────────────┘                       │
│                                                                                 │
│  ┌─────────────────┐    ┌──────────────────┐    ┌─────────────────────────────┐ │
│  │     Cliente     │    │     Carrinho     │    │   HistoricoAtendimento      │ │
│  │─────────────────│    │──────────────────│    │─────────────────────────────│ │
│  │- nome: String   │    │- _itens: List    │    │- cliente: Cliente          │ │
│  │- numeroAtend.:  │    │+ maxItens: int   │    │- itensComprados: List       │ │
│  │  int            │    │                  │    │- valorTotal: double         │ │
│  │- dataHora:      │    │+ adicionarItem() │    │- formaPagamento:            │ │
│  │  DateTime       │    │+ removerItem()   │    │  FormaPagamento             │ │
│  │                 │    │+ getSubtotal()   │    │- dataHora: DateTime         │ │
│  │+ getSaudacao    │    │+ getDesconto()   │    │                             │ │
│  │Personalizada()  │    │+ getTotal()      │    │+ toString()                 │ │
│  │+ getInfo        │    │+ toString()      │    │+ getResumo()               │ │
│  │Atendimento()    │    │+ getResumo       │    └─────────────────────────────┘ │
│  └─────────────────┘    │Finalizacao()     │                                    │
│                         └──────────────────┘                                    │
│                                                                                 │
│     ┌─────────────────────────────────────────────────────────────────────┐     │
│     │                    <<enumeration>>                                 │     │
│     │                   FormaPagamento                                   │     │
│     │─────────────────────────────────────────────────────────────────────│     │
│     │ DINHEIRO("Dinheiro", 0.10)                                         │     │
│     │ CARTAO_CREDITO("Cartão de Crédito", 0.0)                          │     │
│     │ CARTAO_DEBITO("Cartão de Débito", 0.05)                           │     │
│     │ PIX("PIX", 0.08)                                                   │     │
│     │                                                                     │     │
│     │ - nome: String                                                      │     │
│     │ - desconto: double                                                  │     │
│     │                                                                     │     │
│     │ + getDescontoFormatado(): String                                    │     │
│     │ + toString(): String                                                │     │
│     └─────────────────────────────────────────────────────────────────────┘     │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────────┐ │
│  │                        GerenciadorVendas                                    │ │
│  │─────────────────────────────────────────────────────────────────────────────│ │
│  │ - _proximoNumeroAtendimento: int (static)                                   │ │
│  │ - _totalFaturado: double (static)                                           │ │
│  │ - _historico: List<HistoricoAtendimento> (static)                          │ │
│  │                                                                             │ │
│  │ + proximoNumeroAtendimento: int (static get)                                │ │
│  │ + totalClientesAtendidos: int (static get)                                  │ │
│  │ + totalFaturado: double (static get)                                        │ │
│  │ + historico: List<HistoricoAtendimento> (static get)                       │ │
│  │                                                                             │ │
│  │ + registrarVenda(Cliente, Carrinho, FormaPagamento): void (static)         │ │
│  │ + registrarVendaRestrita(String, double, FormaPagamento): void (static)    │ │
│  │ + gerarRelatorioFinal(): String (static)                                   │ │
│  │ + obterHistoricoCliente(String): List<HistoricoAtendimento> (static)       │ │
│  │ + resetarDados(): void (static)                                             │ │
│  └─────────────────────────────────────────────────────────────────────────────┘ │
│                                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────────────┐ │
│  │                            Utility Classes                                  │ │
│  │─────────────────────────────────────────────────────────────────────────────│ │
│  │ InputValidator                    │  GeradorRecibo                          │ │
│  │ + lerString()                     │  + gerarRecibo()                        │ │
│  │ + lerInteiro()                    │  + gerarReciboRestrito()               │ │
│  │ + lerDouble()                     │  - _formatarDataHora()                  │ │
│  │ + confirmarAcao()                │  - _gerarCabecalho()                    │ │
│  │ + validarCodigo()                │  - _gerarRodape()                       │ │
│  │ + limparTela()                    │                                         │ │
│  │ + exibirTitulo()                  │                                         │ │
│  │ + exibirSeparador()               │                                         │ │
│  │ + aguardarEnter()                 │                                         │ │
│  └─────────────────────────────────────────────────────────────────────────────┘ │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Relacionamentos:
- **Herança**: `Produto` e `Servico` herdam de `Item` (abstrata)
- **Composição**: `Carrinho` contém lista de `Item`
- **Agregação**: `HistoricoAtendimento` referencia `Cliente` e `FormaPagamento`
- **Dependência**: Classes utilizam serviços de `GerenciadorVendas` e utilitários

---

## 3. Paradigmas de Programação Adotados e Justificativas

### 3.1 Orientação a Objetos (OOP) - Principal

**Justificativas:**
- **Encapsulamento**: Dados privados com métodos de acesso controlado (ex: `_itens` no `Carrinho`)
- **Herança**: Reutilização de código com `Item` como classe base para `Produto` e `Servico`
- **Polimorfismo**: Tratamento uniforme de produtos e serviços através da classe `Item`
- **Abstração**: Modelagem clara do domínio do problema (loja de pets)

**Exemplos no código:**
```dart
// Herança e abstração
abstract class Item {
  final int codigo;
  final String nome;
  final double preco;
}

class Produto extends Item {
  final String categoria;
  final String descricao;
}

// Encapsulamento
class Carrinho {
  final List<Item> _itens = []; // Privado
  List<Item> get itens => List.unmodifiable(_itens); // Acesso controlado
}
```

### 3.2 Programação Funcional (Elementos)

**Justificativas:**
- **Imutabilidade**: Uso de `List.unmodifiable()` e campos `final`
- **Funções Puras**: Métodos que não alteram estado externo
- **Operações de Lista**: `fold()`, `map()`, `where()` para transformações

**Exemplos no código:**
```dart
// Função pura para cálculo
double getSubtotal() {
  return _itens.fold(0.0, (total, item) => total + item.preco);
}

// Transformações funcionais
final codigosValidos = itensDisponiveis.map((item) => item.codigo).toList();
final historico = _historico.where((atendimento) => 
  atendimento.cliente.nome.toLowerCase() == nomeCliente.toLowerCase()).toList();
```

### 3.3 Programação Estruturada (Base)

**Justificativas:**
- **Modularidade**: Separação clara de responsabilidades em classes e métodos
- **Sequencial**: Fluxo lógico de execução bem definido
- **Procedural**: Métodos estáticos para operações utilitárias

---

## 4. Padrões de Projeto Aplicados

### 4.1 Factory Method

**Localização**: Classes `Produto` e `Servico`
```dart
static List<Produto> getProdutosPromocao() {
  return [
    Produto(codigo: 101, nome: 'Ração Premium Cães 15kg', ...),
    // ...
  ];
}
```

**Justificativa**: Centraliza a criação de objetos complexos e facilita manutenção.

### 4.2 Singleton (Implícito)

**Localização**: Classe `GerenciadorVendas`
```dart
class GerenciadorVendas {
  static int _proximoNumeroAtendimento = 1;
  static double _totalFaturado = 0.0;
  static final List<HistoricoAtendimento> _historico = [];
}
```

**Justificativa**: Garante estado único global para vendas e estatísticas.

### 4.3 Strategy

**Localização**: Enum `FormaPagamento`
```dart
enum FormaPagamento {
  dinheiro('Dinheiro', 0.10),
  cartaoCredito('Cartão de Crédito', 0.0),
  cartaoDebito('Cartão de Débito', 0.05),
  pix('PIX', 0.08);
}
```

**Justificativa**: Permite diferentes estratégias de desconto por forma de pagamento.

### 4.4 Template Method

**Localização**: Classe `GeradorRecibo`
```dart
static String gerarRecibo({...}) {
  // Template para geração de recibo
  final buffer = StringBuffer();
  buffer.writeln(_gerarCabecalho());
  buffer.writeln(_gerarCorpo(...));
  buffer.writeln(_gerarRodape());
  return buffer.toString();
}
```

**Justificativa**: Define estrutura comum para geração de diferentes tipos de recibo.

### 4.5 Builder (Implícito)

**Localização**: Classe `StringBuffer` para formatação
```dart
String toString() {
  final buffer = StringBuffer();
  buffer.writeln('🛒 CARRINHO DE COMPRAS');
  buffer.writeln('=' * 50);
  // ... construção gradual
  return buffer.toString();
}
```

**Justificativa**: Constrói strings complexas de forma incremental e legível.

---

## 5. Registro de Decisões Técnicas

### 5.1 Linguagem: Dart

**Decisão**: Utilizar Dart como linguagem principal
**Justificativa**: 
- Sintaxe moderna e expressiva
- Orientação a objetos robusta
- Null safety nativo
- Boa performance para aplicações console

### 5.2 Arquitetura: Modular

**Decisão**: Separar em camadas (models, services, utils)
**Justificativa**:
- Facilita manutenção e teste
- Separação clara de responsabilidades
- Reutilização de código
- Escalabilidade

### 5.3 Interface: Console

**Decisão**: Interface via terminal/console
**Justificativa**:
- Simplicidade de implementação
- Foco na lógica de negócio
- Portabilidade entre sistemas
- Baixo overhead de recursos

### 5.4 Validação: Centralizada

**Decisão**: Classe `InputValidator` para todas as validações
**Justificativa**:
- Consistência na validação
- Reutilização de código
- Facilita manutenção
- Tratamento uniforme de erros

### 5.5 Estado: Estático

**Decisão**: Uso de variáveis estáticas para estado global
**Justificativa**:
- Simplicidade para aplicação console
- Estado único por execução
- Acesso direto sem instanciação

### 5.6 Estrutura de Dados: Listas

**Decisão**: Usar `List<>` para coleções
**Justificativa**:
- Performance adequada para volumes pequenos
- API rica para manipulação
- Ordenação natural mantida

---

## 6. Descrição das Funcionalidades Extras

### 6.1 📋 Histórico de Atendimentos Completo

**Descrição**: Sistema de rastreamento de todas as transações realizadas.

**Funcionalidades**:
- Registro automático de todas as vendas
- Busca por nome do cliente
- Histórico detalhado com data, hora, itens e valores
- Persistência durante execução do programa

**Implementação**:
```dart
class HistoricoAtendimento {
  final Cliente cliente;
  final List<String> itensComprados;
  final double valorTotal;
  final FormaPagamento formaPagamento;
  final DateTime dataHora;
}
```

**Benefícios**:
- Auditoria de vendas
- Atendimento personalizado
- Análise de comportamento do cliente
- Suporte a resolução de problemas

### 6.2 🧾 Geração Automática de Recibos

**Descrição**: Sistema de geração de comprovantes formatados e profissionais.

**Funcionalidades**:
- Recibos para clientes (após compra)
- Recibos para área restrita (vendas manuais)
- Formatação profissional com ASCII art
- Informações completas da transação

**Tipos de Recibo**:
1. **Recibo do Cliente**: Detalhes da compra com itens, preços e desconto
2. **Recibo Restrito**: Registro simplificado para vendas manuais

**Exemplo de Formato**:
```
🐾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🐾
                        🧾 RECIBO CUIDAPET 🧾
🐾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🧾🐾

Cliente: João Silva
Atendimento: #1
Data/Hora: 15/09/2025 às 14:30

ITENS COMPRADOS:
- Ração Premium Cães 15kg .............. R$ 89,90
- Brinquedo Corda Colorida ............. R$ 15,50

Subtotal: ................................. R$ 105,40
Desconto PIX (8%): ........................ R$ 8,43
TOTAL: .................................... R$ 96,97
```

### 6.3 ⏰ Saudação Personalizada por Horário

**Descrição**: Sistema de saudação dinâmica baseada no horário do atendimento.

**Lógica**:
- 05:00 - 11:59: "Bom dia"
- 12:00 - 17:59: "Boa tarde"  
- 18:00 - 04:59: "Boa noite"

**Implementação**:
```dart
String getSaudacaoPersonalizada() {
  final hora = dataHora.hour;
  String saudacao;
  
  if (hora >= 5 && hora < 12) {
    saudacao = 'Bom dia';
  } else if (hora >= 12 && hora < 18) {
    saudacao = 'Boa tarde';
  } else {
    saudacao = 'Boa noite';
  }
  
  return '$saudacao, $nome! Seja bem-vindo(a) à Cuidapet! 🐾';
}
```

### 6.4 📊 Sistema de Relatórios Avançados

**Descrição**: Relatórios detalhados para análise de vendas e performance.

**Métricas Incluídas**:
- Total de clientes atendidos
- Valor total faturado
- Resumo por forma de pagamento
- Ticket médio de vendas
- Distribuição de vendas por período

**Exemplo de Relatório**:
```
📊 RELATÓRIO FINAL DO DIA
========================================
Data: 15/09/2025
Total de clientes atendidos: 5
Valor total faturado: R$ 450,75

💰 RESUMO POR FORMA DE PAGAMENTO:
Dinheiro: 2 vendas - R$ 180,50
PIX: 2 vendas - R$ 165,25
Cartão de Débito: 1 venda - R$ 105,00

📈 TICKET MÉDIO:
R$ 90,15
========================================
```

---

## 7. Relato de Dificuldades Enfrentadas e Soluções Adotadas

### 7.1 Gerenciamento de Estado Global

**Dificuldade**: Como manter estado consistente entre diferentes partes do sistema sem usar banco de dados.

**Problema Específico**:
- Múltiplas classes precisavam acessar dados de vendas
- Risco de inconsistência entre diferentes instâncias
- Necessidade de persistência durante execução

**Solução Adotada**:
```dart
class GerenciadorVendas {
  static int _proximoNumeroAtendimento = 1;
  static double _totalFaturado = 0.0;
  static final List<HistoricoAtendimento> _historico = [];
}
```

**Benefícios da Solução**:
- Estado único e consistente
- Acesso direto sem instanciação
- Simplicidade de implementação
- Controle centralizado

### 7.2 Validação de Entrada do Usuário

**Dificuldade**: Garantir robustez contra entradas inválidas do usuário.

**Problemas Enfrentados**:
- Usuários digitando letras onde esperamos números
- Códigos de produtos inexistentes
- Confirmações ambíguas (s/n)
- Overflow de carrinho

**Solução Adotada**:
```dart
class InputValidator {
  static int lerInteiro(String prompt, {int? min, int? max}) {
    while (true) {
      try {
        stdout.write(prompt);
        final input = stdin.readLineSync() ?? '';
        final numero = int.parse(input);
        
        if (min != null && numero < min) continue;
        if (max != null && numero > max) continue;
        
        return numero;
      } catch (e) {
        print('❌ Entrada inválida! Digite um número válido.');
      }
    }
  }
}
```

**Características da Solução**:
- Try-catch para capturar erros
- Loops até entrada válida
- Validação de intervalo
- Mensagens de erro claras

### 7.3 Formatação de Recibos e Relatórios

**Dificuldade**: Criar saídas visuais atrativas em interface console.

**Desafios**:
- Alinhamento de texto
- Larguras variáveis de conteúdo
- Caracteres especiais para desenho
- Formatação de moeda

**Solução Adotada**:
```dart
static String _gerarCabecalho() {
  return '🐾🧾${'🧾' * 33}🐾\n'
         '${' ' * 24}🧾 RECIBO CUIDAPET 🧾\n'
         '🐾🧾${'🧾' * 33}🐾';
}

// Alinhamento com pontos
'${item.nome} ${'.' * (40 - item.nome.length)} R\$ ${item.preco.toStringAsFixed(2)}'
```

**Resultados Obtidos**:
- Visual profissional e atrativo
- Informações bem organizadas
- Legibilidade em qualquer terminal
- Identidade visual consistente

### 7.4 Limitação do Carrinho (3 itens)

**Dificuldade**: Implementar limitação lógica sem frustrar o usuário.

**Requisitos Conflitantes**:
- Máximo 3 itens por carrinho
- Não permitir itens duplicados
- Interface amigável para remoção
- Feedback claro sobre limitações

**Solução Adotada**:
```dart
class Carrinho {
  static const int maxItens = 3;
  
  bool adicionarItem(Item item) {
    if (isFull) return false;
    if (_itens.contains(item)) return false;
    
    _itens.add(item);
    return true;
  }
  
  bool get isFull => _itens.length >= maxItens;
}
```

**Melhorias Implementadas**:
- Verificação prévia antes de tentar adicionar
- Mensagens informativas sobre status do carrinho
- Opção fácil de remoção de itens
- Indicador visual de capacidade

### 7.5 Diferentes Tipos de Usuário

**Dificuldade**: Implementar níveis de acesso sem sistema de autenticação complexo.

**Requisitos**:
- Clientes: acesso livre às funcionalidades básicas
- Funcionários: acesso a área restrita
- Autenticação simples mas segura
- Funcionalidades específicas por tipo

**Solução Adotada**:
```dart
static void _acessarAreaRestrita() {
  const String senhaRestrita = 'cuidapetrestrito';
  
  final senha = InputValidator.lerString('🔑 Digite a senha: ');
  
  if (senha != senhaRestrita) {
    print('\n❌ Senha incorreta! Acesso negado.');
    return;
  }
  
  _menuFuncionario();
}
```

**Características**:
- Senha hardcoded para simplicidade
- Separação clara de menus
- Funcionalidades exclusivas por perfil
- Fluxo intuitivo de autenticação

---

## 8. Sugestões de Melhorias Futuras

### 8.1 Persistência de Dados

**Problema Atual**: Dados são perdidos quando o programa encerra.

**Melhorias Propostas**:
- **Banco de Dados SQLite**: Para persistência local
- **Arquivos JSON**: Para configurações e dados simples
- **Backup Automático**: Salvamento periódico dos dados
- **Importação/Exportação**: Funcionalidades para migração

**Implementação Sugerida**:
```dart
class DatabaseManager {
  static Future<void> salvarVendas() async {
    final file = File('vendas.json');
    final data = GerenciadorVendas.historico.map((h) => h.toJson()).toList();
    await file.writeAsString(jsonEncode(data));
  }
  
  static Future<void> carregarVendas() async {
    // Implementação de carregamento
  }
}
```

### 8.2 Interface Gráfica

**Problema Atual**: Interface console limitada para usuários finais.

**Opções de Tecnologia**:
- **Flutter Desktop**: Para aplicação nativa
- **Flutter Web**: Para acesso via navegador
- **Dart + HTML**: Para web simples
- **API REST**: Para integração com frontends diversos

**Benefícios Esperados**:
- Experiência visual mais atrativa
- Interação mais intuitiva
- Suporte a imagens de produtos
- Interface responsiva

### 8.3 Sistema de Categorias

**Melhoria**: Expandir sistema de categorização de produtos.

**Funcionalidades Propostas**:
- Filtros por categoria
- Busca por nome/descrição
- Produtos relacionados
- Categorias hierárquicas

**Estrutura Sugerida**:
```dart
class Categoria {
  final String nome;
  final Categoria? categoriaPai;
  final List<Categoria> subcategorias;
  
  List<Produto> getProdutosDaCategoria() {
    // Implementação
  }
}
```

### 8.4 Sistema de Desconto Avançado

**Melhoria**: Sistema mais flexível de promoções e descontos.

**Funcionalidades**:
- **Cupons de Desconto**: Códigos promocionais
- **Desconto por Volume**: Quantidade de itens
- **Programa de Fidelidade**: Pontos por compra
- **Promoções Temporais**: Validade limitada

**Implementação Sugerida**:
```dart
abstract class Promocao {
  double calcularDesconto(Carrinho carrinho);
  bool isValida();
}

class CupomDesconto extends Promocao {
  final String codigo;
  final double percentual;
  final DateTime validade;
}
```

### 8.5 Relatórios Avançados

**Melhoria**: Sistema de relatórios mais completo e configurável.

**Funcionalidades Propostas**:
- **Gráficos**: Visualização de dados
- **Filtros Temporais**: Por período específico
- **Relatórios Customizados**: Campos selecionáveis
- **Exportação**: PDF, Excel, CSV
- **Agendamento**: Relatórios automáticos

### 8.6 Integração com Sistemas Externos

**Melhorias de Integração**:
- **Sistema de Pagamento**: PIX, cartões reais
- **Estoque**: Controle automático de inventário
- **CRM**: Gestão de relacionamento com cliente
- **Nota Fiscal**: Emissão automática
- **Email/SMS**: Notificações automáticas

### 8.7 Multilíngue e Acessibilidade

**Funcionalidades**:
- **Internacionalização**: Suporte a múltiplos idiomas
- **Acessibilidade**: Suporte a leitores de tela
- **Temas**: Modo escuro/claro
- **Fonte Ajustável**: Tamanhos de texto

### 8.8 Mobile e Omnichannel

**Expansão de Plataformas**:
- **App Mobile**: Para clientes e funcionários
- **Sistema Web**: Administração completa
- **Kiosk Mode**: Totems de autoatendimento
- **Integração WhatsApp**: Atendimento híbrido

---

## 9. Fluxograma Geral do Sistema

```
                                    🚀 INÍCIO
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │    Exibir Boas-vindas   │
                            └─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │   Solicitar Nome        │
                            │   do Cliente            │
                            └─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │   Criar Cliente         │
                            │   + Saudação            │
                            └─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │   Exibir Menu           │
                            │   Principal             │
                            └─────────────────────────┘
                                        │
                  ┌─────────────────────┼─────────────────────┐
                  │                     │                     │
                  ▼                     ▼                     ▼
        ┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
        │ 1. Ver Produtos │   │ 2. Ver Serviços │   │ 3. Ver Carrinho │
        └─────────────────┘   └─────────────────┘   └─────────────────┘
                  │                     │                     │
                  ▼                     ▼                     ▼
        ┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
        │ Exibir Lista    │   │ Exibir Lista    │   │ Exibir Itens    │
        │ de Produtos     │   │ de Serviços     │   │ + Opções        │
        └─────────────────┘   └─────────────────┘   └─────────────────┘
                  │                     │                     │
                  ▼                     ▼                     ▼
        ┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
        │ Adicionar ao    │   │ Adicionar ao    │   │ Remover Item?   │
        │ Carrinho?       │   │ Carrinho?       │   │                 │
        └─────────────────┘   └─────────────────┘   └─────────────────┘
                  │                     │                     │
                  └─────────────────────┼─────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │ 4. Finalizar Carrinho   │
                            └─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │ Carrinho Vazio?         │
                            └─────────────────────────┘
                                        │
                                    Sim │ Não
                ┌───────────────────────┼─────────────────────┐
                │                       │                     │
                ▼                       ▼                     ▼
    ┌─────────────────┐     ┌─────────────────┐   ┌─────────────────┐
    │ Mensagem Erro   │     │ Exibir Resumo   │   │ 5. Área         │
    │ + Voltar Menu   │     │ do Carrinho     │   │ Restrita        │
    └─────────────────┘     └─────────────────┘   └─────────────────┘
                                        │                     │
                                        ▼                     ▼
                            ┌─────────────────────────┐   ┌─────────────────┐
                            │ Selecionar Forma        │   │ Validar Senha   │
                            │ de Pagamento            │   │                 │
                            └─────────────────────────┘   └─────────────────┘
                                        │                     │
                                        ▼                 Erro │ OK
                            ┌─────────────────────────┐        │
                            │ Calcular Total          │        ▼
                            │ + Desconto              │   ┌─────────────────┐
                            └─────────────────────────┘   │ Menu            │
                                        │                │ Funcionário     │
                                        ▼                └─────────────────┘
                            ┌─────────────────────────┐           │
                            │ Confirmar Compra?       │           ▼
                            └─────────────────────────┘   ┌─────────────────┐
                                        │                │ • Venda Manual  │
                                    Sim │ Não            │ • Estatísticas  │
                ┌───────────────────────┼─────────       │ • Buscar        │
                │                       │                │   Histórico     │
                ▼                       │                └─────────────────┘
    ┌─────────────────┐                 │                         │
    │ Registrar Venda │                 │                         │
    │ + Gerar Recibo  │                 │                         │
    └─────────────────┘                 │                         │
                │                       │                         │
                ▼                       │                         │
    ┌─────────────────┐                 │                         │
    │ Exibir Recibo   │                 │                         │
    │ + Confirmação   │                 │                         │
    └─────────────────┘                 │                         │
                │                       │                         │
                └───────────────────────┼─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │ 0. Sair do Sistema      │
                            └─────────────────────────┘
                                        │
                                        ▼
                            ┌─────────────────────────┐
                            │ Atender Outro Cliente?  │
                            └─────────────────────────┘
                                        │
                                    Sim │ Não
                ┌───────────────────────┼───────────────
                │                       │
                ▼                       ▼
    ┌─────────────────┐     ┌─────────────────────────┐
    │ Limpar Tela +   │     │ Gerar Relatório Final   │
    │ Voltar Início   │     │ + Estatísticas do Dia   │
    └─────────────────┘     └─────────────────────────┘
                │                       │
                └───────────────────────┼─────────────
                                        │
                                        ▼
                                    🏁 FIM
```

### Fluxos Paralelos e Condicionais:

1. **Fluxo Principal**: Cliente → Menu → Ações → Finalização
2. **Fluxo de Validação**: Constante em todas as entradas
3. **Fluxo de Erro**: Retorno ao menu anterior com mensagem
4. **Fluxo Administrativo**: Área restrita com funcionalidades especiais
5. **Fluxo de Repetição**: Loop principal para atender múltiplos clientes

---

## 10. Convenções de Código

### 10.1 Nomenclatura

#### Classes
```dart
// ✅ PascalCase para classes
class SistemaCuidapet { }
class GerenciadorVendas { }
class InputValidator { }
```

#### Variáveis e Métodos
```dart
// ✅ camelCase para variáveis e métodos
String nomeCliente;
int numeroAtendimento;
void adicionarItem();
double getSubtotal();
```

#### Constantes
```dart
// ✅ camelCase para constantes
static const String senhaRestrita = 'cuidapetrestrito';
static const int maxItens = 3;
```

#### Variáveis Privadas
```dart
// ✅ Underscore prefix para membros privados
final List<Item> _itens = [];
static int _proximoNumeroAtendimento = 1;
```

### 10.2 Estrutura de Arquivos

```
lib/
├── models/           # Modelos de dados
│   ├── item.dart
│   ├── produto.dart
│   ├── servico.dart
│   ├── cliente.dart
│   ├── carrinho.dart
│   └── historico_atendimento.dart
├── services/         # Lógica de negócio
│   └── gerenciador_vendas.dart
└── utils/           # Utilitários e helpers
    ├── input_validator.dart
    └── gerador_recibo.dart
```

### 10.3 Formatação

#### Indentação
```dart
// ✅ 2 espaços para indentação
class Produto extends Item {
  final String categoria;
  
  Produto({
    required super.codigo,
    required super.nome,
    required super.preco,
    required this.categoria,
  });
}
```

#### Quebras de Linha
```dart
// ✅ Quebras lógicas em métodos longos
static void _executarAtendimentoCliente(Cliente cliente) {
  InputValidator.limparTela();
  print(cliente.getSaudacaoPersonalizada());
  print(cliente.getInfoAtendimento());

  final carrinho = Carrinho();

  while (true) {
    _exibirMenuPrincipal(carrinho);
    // ...
  }
}
```

### 10.4 Comentários

#### Documentação de Classes
```dart
/// Classe abstrata base para produtos e serviços
abstract class Item {
  // ...
}
```

#### Comentários Explicativos
```dart
// Cria lista de códigos válidos
final codigosValidos = itensDisponiveis.map((item) => item.codigo).toList();

// Tenta adicionar ao carrinho
if (carrinho.adicionarItem(item)) {
  // ...
}
```

### 10.5 Tratamento de Erros

```dart
// ✅ Try-catch específico
static int lerInteiro(String prompt, {int? min, int? max}) {
  while (true) {
    try {
      final numero = int.parse(input);
      return numero;
    } catch (e) {
      print('❌ Entrada inválida! Digite um número válido.');
    }
  }
}
```

### 10.6 Uso de String Interpolation

```dart
// ✅ String interpolation ao invés de concatenação
print('Cliente: ${cliente.nome}');
print('Total: R\$ ${valor.toStringAsFixed(2)}');

// ❌ Evitar concatenação
print('Cliente: ' + cliente.nome);
```

### 10.7 Imports

```dart
// ✅ Imports organizados
import '../lib/models/cliente.dart';
import '../lib/models/produto.dart';
import '../lib/models/servico.dart';
import '../lib/models/carrinho.dart';
import '../lib/models/item.dart';
import '../lib/services/gerenciador_vendas.dart';
import '../lib/utils/input_validator.dart';
import '../lib/utils/gerador_recibo.dart';
```

---

## 11. Checklist de Testes Manuais

### 11.1 ✅ Funcionalidades Básicas do Cliente

#### 🛒 Gerenciamento de Carrinho
- [ ] **Adicionar produto válido** - Testar código 101 (Ração)
- [ ] **Adicionar serviço válido** - Testar código 201 (Banho e Tosa)
- [ ] **Tentar adicionar código inválido** - Testar código 999
- [ ] **Adicionar item duplicado** - Tentar adicionar mesmo item duas vezes
- [ ] **Atingir limite do carrinho** - Adicionar 3 itens e tentar adicionar o 4º
- [ ] **Remover item existente** - Remover item do carrinho
- [ ] **Tentar remover item inexistente** - Código não presente no carrinho
- [ ] **Visualizar carrinho vazio** - Verificar mensagem apropriada
- [ ] **Visualizar carrinho com itens** - Verificar formatação e totais

#### 💳 Finalização de Compras
- [ ] **Finalizar carrinho vazio** - Verificar bloqueio com mensagem
- [ ] **Finalizar com dinheiro** - Verificar desconto de 10%
- [ ] **Finalizar com PIX** - Verificar desconto de 8%
- [ ] **Finalizar com cartão débito** - Verificar desconto de 5%
- [ ] **Finalizar com cartão crédito** - Verificar sem desconto
- [ ] **Cancelar finalização** - Escolher "Não" na confirmação
- [ ] **Verificar cálculos** - Conferir subtotal, desconto e total
- [ ] **Geração de recibo** - Verificar formatação e informações

### 11.2 🔒 Área Restrita (Funcionários)

#### 🔐 Autenticação
- [ ] **Senha correta** - Digitar 'cuidapetrestrito'
- [ ] **Senha incorreta** - Testar senha inválida
- [ ] **Acesso ao menu funcionário** - Verificar opções disponíveis

#### 💰 Venda Manual
- [ ] **Registrar venda válida** - Nome + valor + forma pagamento
- [ ] **Valores decimais** - Testar R$ 10,50
- [ ] **Valores grandes** - Testar R$ 1000,00
- [ ] **Cancelar registro** - Escolher "Não" na confirmação
- [ ] **Geração de recibo restrito** - Verificar formato específico

#### 📊 Relatórios
- [ ] **Estatísticas sem vendas** - Sistema recém iniciado
- [ ] **Estatísticas com vendas** - Após realizar algumas vendas
- [ ] **Busca cliente existente** - Nome de cliente que comprou
- [ ] **Busca cliente inexistente** - Nome não cadastrado
- [ ] **Busca case-insensitive** - 'joão' vs 'João'

### 11.3 🎯 Validações de Entrada

#### 📝 Entrada de Dados
- [ ] **Números válidos** - Entradas dentro do intervalo
- [ ] **Números inválidos** - Letras onde espera número
- [ ] **Números fora do intervalo** - Menor que mínimo ou maior que máximo
- [ ] **Strings vazias** - Testar campos obrigatórios
- [ ] **Confirmações S/N** - Testar 's', 'S', 'n', 'N'
- [ ] **Confirmações inválidas** - Testar 'x', '1', etc.

#### 🔢 Validação de Códigos
- [ ] **Códigos de produto válidos** - 101, 102, 103, 104
- [ ] **Códigos de serviço válidos** - 201, 202, 203
- [ ] **Códigos inexistentes** - 999, 0, -1

### 11.4 🌟 Funcionalidades Especiais

#### ⏰ Saudação Personalizada
- [ ] **Período manhã** - Entre 05:00 e 11:59
- [ ] **Período tarde** - Entre 12:00 e 17:59
- [ ] **Período noite** - Entre 18:00 e 04:59

#### 📋 Histórico
- [ ] **Primeiro cliente** - Número de atendimento #1
- [ ] **Múltiplos clientes** - Sequência numérica correta
- [ ] **Persistência durante execução** - Dados mantidos entre atendimentos

### 11.5 🔄 Fluxos Completos

#### 🛍️ Compra Completa do Cliente
1. [ ] Iniciar sistema
2. [ ] Inserir nome do cliente
3. [ ] Verificar saudação personalizada
4. [ ] Adicionar 2 produtos ao carrinho
5. [ ] Adicionar 1 serviço ao carrinho
6. [ ] Visualizar carrinho completo
7. [ ] Finalizar com PIX
8. [ ] Verificar recibo gerado
9. [ ] Confirmar registro no histórico

#### 👨‍💼 Venda Funcionário Completa
1. [ ] Acessar área restrita
2. [ ] Autenticar com senha
3. [ ] Registrar venda manual
4. [ ] Verificar geração de recibo
5. [ ] Consultar estatísticas atualizadas
6. [ ] Buscar histórico do cliente
7. [ ] Retornar ao menu principal

#### 🔁 Múltiplos Atendimentos
1. [ ] Atender primeiro cliente
2. [ ] Finalizar atendimento
3. [ ] Escolher atender outro cliente
4. [ ] Verificar limpeza da tela
5. [ ] Atender segundo cliente
6. [ ] Verificar numeração correta
7. [ ] Finalizar sistema
8. [ ] Verificar relatório final

### 11.6 🛡️ Testes de Robustez

#### 🚫 Cenários de Erro
- [ ] **Interrupção abrupta** - Ctrl+C durante execução
- [ ] **Entradas extremas** - Strings muito longas
- [ ] **Números negativos** - Onde não são esperados
- [ ] **Caracteres especiais** - Emojis, acentos em nomes
- [ ] **Sequências rápidas** - Múltiplas entradas seguidas

#### 🔄 Stress Test
- [ ] **Carrinho cheio repetidamente** - Adicionar e remover várias vezes
- [ ] **Múltiplas finalizações canceladas** - Testar consistência
- [ ] **Alternância entre menus** - Navegar rapidamente
- [ ] **Vendas em sequência** - 10+ vendas consecutivas

### 11.7 📋 Verificações de Qualidade

#### 🎨 Interface e Usabilidade
- [ ] **Mensagens claras** - Todas as instruções são compreensíveis
- [ ] **Emojis visíveis** - Símbolos renderizam corretamente
- [ ] **Formatação consistente** - Alinhamentos e espaçamentos
- [ ] **Feedback adequado** - Confirmações e mensagens de erro
- [ ] **Navegação intuitiva** - Fluxo lógico entre telas

#### 📊 Dados e Cálculos
- [ ] **Precisão decimal** - Valores monetários corretos
- [ ] **Totalizações** - Somas e descontos precisos
- [ ] **Formatação monetária** - R$ x,xx sempre
- [ ] **Datas e horários** - Formato brasileiro dd/mm/aaaa
- [ ] **Sequências numéricas** - Atendimentos numerados corretamente

### 11.8 ✅ Critérios de Aceitação

#### ✔️ Sistema Aprovado Se:
- [ ] Todos os fluxos principais funcionam corretamente
- [ ] Validações impedem entradas inválidas
- [ ] Cálculos financeiros estão precisos
- [ ] Interface é clara e profissional
- [ ] Não há erros ou crashes durante uso normal
- [ ] Dados são consistentes durante toda a execução
- [ ] Relatórios apresentam informações corretas
- [ ] Autenticação funciona adequadamente

#### ❌ Sistema Reprovado Se:
- [ ] Permite finalizar carrinho vazio
- [ ] Cálculos de desconto incorretos
- [ ] Crash durante operação normal
- [ ] Dados perdidos ou inconsistentes
- [ ] Interface confusa ou com erros de formatação
- [ ] Validações permitem entradas inválidas
- [ ] Área restrita acessível sem senha

---

## 📚 Conclusão da Wiki

Esta wiki documenta completamente o **Sistema de Auto Atendimento CuidaPet**, fornecendo uma visão abrangente de sua arquitetura, implementação e funcionalidades. O sistema demonstra a aplicação prática de conceitos de programação orientada a objetos, padrões de projeto e boas práticas de desenvolvimento.

### 🎯 Principais Conquistas:
- ✅ Sistema funcional e robusto
- ✅ Arquitetura bem estruturada e extensível
- ✅ Interface intuitiva e profissional
- ✅ Funcionalidades extras que agregam valor
- ✅ Código bem documentado e testável

### 📈 Impacto do Projeto:
O sistema CuidaPet representa uma solução completa para automação de vendas em pet shops, demonstrando como a tecnologia pode melhorar a experiência do cliente e a eficiência operacional do negócio.

**🐾 Cuidapet - Cuidando do seu pet com amor e tecnologia! ❤️**

---

*Última atualização: 15 de setembro de 2025*
*Versão do Sistema: 1.0*
*Desenvolvido em Dart*
