# 🐾 Sistema de Auto Atendimento Cuidapet

Sistema completo de autoatendimento desenvolvido em Dart para a loja Cuidapet, oferecendo uma experiência interativa e personalizada para clientes e funcionalidades administrativas para funcionários.

## 📋 Descrição do Sistema

O Sistema de Auto Atendimento Cuidapet foi desenvolvido para otimizar a experiência do cliente no ponto de venda e apoiar o crescimento da empresa. O sistema permite:

- ✨ Atendimento personalizado com saudação baseada no horário
- 🛒 Carrinho de compras com limite de 3 itens
- 💳 Múltiplas formas de pagamento com descontos automáticos
- 🔒 Área restrita para funcionários
- 📊 Relatórios e estatísticas de vendas
- 🧾 Geração automática de recibos

## 🚀 Funcionalidades Principais

### Para Clientes:
- **Mensagem de Boas-vindas Personalizada**: Saudação baseada no horário do dia
- **Visualização de Produtos**: 4 produtos em promoção com códigos e preços
- **Solicitação de Serviços**: 3 serviços disponíveis com informações detalhadas
- **Carrinho de Compras**: Adicionar/remover até 3 itens com validação
- **Finalização com Desconto**: Cálculo automático de descontos por forma de pagamento
- **Recibo Detalhado**: Geração automática de comprovante formatado

### Para Funcionários (Área Restrita):
- **Autenticação**: Acesso protegido por senha (`cuidapetrestrito`)
- **Registro Manual de Vendas**: Inserção direta de vendas no sistema
- **Relatórios em Tempo Real**: Estatísticas do dia e resumo financeiro
- **Busca de Histórico**: Consulta de atendimentos por cliente

### Funcionalidades Extras Implementadas:
1. **📋 Histórico de Atendimentos**: Rastreamento completo de todas as transações
2. **🧾 Geração de Recibos**: Comprovantes formatados para clientes e área restrita

## 🛠️ Tecnologias Utilizadas

- **Linguagem**: Dart 2.19+
- **Paradigma**: Orientação a Objetos (OOP)
- **Interface**: Console interativo
- **Arquitetura**: Modular com separação de responsabilidades

## 📁 Estrutura do Projeto

```
CuidadoPet/
├── bin/
│   └── main.dart                    # Arquivo principal do sistema
├── lib/
│   ├── models/                      # Modelos de dados
│   │   ├── item.dart               # Classe abstrata base
│   │   ├── produto.dart            # Model de produtos
│   │   ├── servico.dart            # Model de serviços
│   │   ├── cliente.dart            # Model de clientes
│   │   ├── carrinho.dart           # Model do carrinho e formas de pagamento
│   │   └── historico_atendimento.dart # Model do histórico
│   ├── services/                    # Camada de serviços
│   │   └── gerenciador_vendas.dart # Gerenciamento de vendas e relatórios
│   └── utils/                       # Utilitários
│       ├── input_validator.dart    # Validação de entradas
│       └── gerador_recibo.dart     # Geração de recibos
├── pubspec.yaml                     # Configuração do projeto
└── README.md                        # Este arquivo
```

## 💰 Formas de Pagamento e Descontos

| Forma de Pagamento | Desconto |
|-------------------|----------|
| 💵 Dinheiro       | 10%      |
| 💳 PIX            | 8%       |
| 💳 Cartão Débito  | 5%       |
| 💳 Cartão Crédito | 0%       |

## 📦 Produtos em Promoção

| Código | Produto | Preço | Categoria |
|--------|---------|-------|-----------|
| 101 | Ração Premium Cães 15kg | R$ 89,90 | Alimentação |
| 102 | Brinquedo Corda Colorida | R$ 15,50 | Brinquedos |
| 103 | Shampoo Antipulgas 500ml | R$ 24,90 | Higiene |
| 104 | Casa de Madeira Média | R$ 199,00 | Acessórios |

## 🛁 Serviços Disponíveis

| Código | Serviço | Preço | Duração |
|--------|---------|-------|---------|
| 201 | Banho e Tosa Completa | R$ 45,00 | 2h |
| 202 | Consulta Veterinária | R$ 80,00 | 30min |
| 203 | Vacinação Múltipla | R$ 65,00 | 15min |

## 🔧 Requisitos para Execução

- **Dart SDK**: Versão 2.19.0 ou superior
- **Sistema Operacional**: Windows, macOS ou Linux
- **Terminal/Console**: Para interação com o sistema

## 📥 Instalação

1. **Clone ou baixe o projeto**:
   ```bash
   git clone [URL_DO_REPOSITORIO]
   cd CuidadoPet
   ```

2. **Verifique a instalação do Dart**:
   ```bash
   dart --version
   ```

3. **Instale as dependências** (se necessário):
   ```bash
   dart pub get
   ```

## ▶️ Como Executar

1. **Navegue até o diretório do projeto**:
   ```bash
   cd CuidadoPet
   ```

2. **Execute o sistema**:
   ```bash
   dart run bin/main.dart
   ```

3. **Siga as instruções no console** para interagir com o sistema.

## 🎮 Instruções de Uso

### Para Clientes:

1. **Início**: Digite seu nome quando solicitado
2. **Menu Principal**: Use os números para navegar:
   - `1` - Ver produtos em promoção
   - `2` - Solicitar serviços
   - `3` - Visualizar carrinho
   - `4` - Finalizar compra
   - `0` - Sair do sistema

3. **Adicionar Itens**: Digite o código do produto/serviço desejado
4. **Finalizar**: Escolha a forma de pagamento e confirme

### Para Funcionários:

1. **Acesse a área restrita** (opção 5 do menu principal)
2. **Digite a senha**: `cuidapetrestrito`
3. **Use as opções disponíveis**:
   - Registrar vendas manuais
   - Ver estatísticas do dia
   - Buscar histórico de clientes

## 🧪 Exemplo de Uso

```
🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾
  SISTEMA DE AUTO ATENDIMENTO CUIDAPET  
🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾🐾

👤 Digite seu nome: João

Boa tarde, João! Seja bem-vindo(a) à Cuidapet! 🐾
Atendimento #1 - 15/09/2025 às 14:30

========================================
           🐾 MENU PRINCIPAL 🐾
========================================
1. 🏷️  Ver promoções de produtos
2. 🛁  Solicitar serviços
3. 🛒  Listar carrinho de compras
4. ✅  Finalizar carrinho
5. 🔒  Área restrita (funcionários)
0. 🚪  Sair
========================================
```

## 🏗️ Arquitetura e Padrões

### Paradigmas Utilizados:
- **Orientação a Objetos**: Classes, herança, encapsulamento e polimorfismo
- **Programação Funcional**: Uso de funções puras e imutabilidade onde apropriado

### Padrões de Projeto:
- **Factory Method**: Para criação de listas de produtos e serviços
- **Singleton**: Para gerenciamento global de vendas
- **Strategy**: Para diferentes formas de pagamento e cálculos de desconto
- **Template Method**: Para geração de recibos

### Princípios SOLID Aplicados:
- **SRP**: Cada classe tem uma responsabilidade específica
- **OCP**: Extensível para novos produtos/serviços sem modificar código existente
- **LSP**: Produtos e serviços são intercambiáveis através da classe Item
- **ISP**: Interfaces específicas para cada funcionalidade
- **DIP**: Dependências abstraídas através de interfaces

## 🔒 Segurança

- **Validação de Entrada**: Todas as entradas são validadas para prevenir erros
- **Controle de Acesso**: Área restrita protegida por senha
- **Tratamento de Exceções**: Captura e tratamento adequado de erros

## 📊 Relatórios Disponíveis

### Relatório Final do Dia:
- Total de clientes atendidos
- Valor total faturado
- Resumo por forma de pagamento
- Ticket médio de vendas

### Histórico Individual:
- Busca por nome do cliente
- Detalhes de todas as compras realizadas
- Data, hora e valores de cada transação

## 🚀 Melhorias Futuras Sugeridas

- [ ] **Interface Gráfica**: Migrar para Flutter para interface visual
- [ ] **Banco de Dados**: Persistência de dados com SQLite
- [ ] **API REST**: Integração com sistemas externos
- [ ] **Relatórios Avançados**: Gráficos e análises detalhadas
- [ ] **Sistema de Fidelidade**: Programa de pontos para clientes
- [ ] **Agendamento Online**: Sistema de reservas para serviços
- [ ] **Notificações**: Alertas por email/SMS
- [ ] **Multi-idiomas**: Suporte a diferentes idiomas

## 🤝 Contribuidores

Este projeto foi desenvolvido como parte do curso técnico, seguindo as especificações técnicas fornecidas e implementando as melhores práticas de engenharia de software.

## 📝 Licença

Este projeto foi desenvolvido para fins educacionais como parte do curso técnico.

---

**🐾 Cuidapet - Cuidando do seu pet com amor e tecnologia! ❤️**
