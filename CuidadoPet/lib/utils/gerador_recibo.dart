import '../models/cliente.dart';
import '../models/carrinho.dart';

/// Classe para gerar recibos formatados
class GeradorRecibo {
  
  /// Gera recibo completo da compra
  static String gerarRecibo({
    required Cliente cliente,
    required Carrinho carrinho,
    required FormaPagamento formaPagamento,
  }) {
    final buffer = StringBuffer();
    final agora = DateTime.now();
    
    // Cabeçalho
    buffer.writeln('');
    buffer.writeln('${'=' * 50}');
    buffer.writeln('              🐾 CUIDAPET 🐾              ');
    buffer.writeln('        Sistema de Auto Atendimento       ');
    buffer.writeln('${'=' * 50}');
    buffer.writeln('');
    
    // Informações do cliente e atendimento
    buffer.writeln('📋 INFORMAÇÕES DO ATENDIMENTO');
    buffer.writeln('-' * 30);
    buffer.writeln('Cliente: ${cliente.nome}');
    buffer.writeln('Atendimento: #${cliente.numeroAtendimento}');
    buffer.writeln('Data: ${_formatarData(agora)}');
    buffer.writeln('Hora: ${_formatarHora(agora)}');
    buffer.writeln('');
    
    // Itens comprados
    buffer.writeln('🛒 ITENS COMPRADOS');
    buffer.writeln('-' * 30);
    
    for (int i = 0; i < carrinho.itens.length; i++) {
      final item = carrinho.itens[i];
      buffer.writeln('${i + 1}. ${item.nome}');
      buffer.writeln('    Código: ${item.codigo}');
      buffer.writeln('    Valor: R\$ ${item.preco.toStringAsFixed(2)}');
      if (i < carrinho.itens.length - 1) buffer.writeln('');
    }
    
    buffer.writeln('');
    
    // Resumo financeiro
    buffer.writeln('💰 RESUMO FINANCEIRO');
    buffer.writeln('-' * 30);
    buffer.writeln('Subtotal: R\$ ${carrinho.getSubtotal().toStringAsFixed(2)}');
    buffer.writeln('Forma de pagamento: ${formaPagamento.nome}');
    
    final desconto = carrinho.getDesconto(formaPagamento);
    if (desconto > 0) {
      buffer.writeln('Desconto (${formaPagamento.getDescontoFormatado()}): -R\$ ${desconto.toStringAsFixed(2)}');
    }
    
    buffer.writeln('');
    buffer.writeln('TOTAL PAGO: R\$ ${carrinho.getTotal(formaPagamento).toStringAsFixed(2)}');
    
    // Rodapé
    buffer.writeln('');
    buffer.writeln('${'=' * 50}');
    buffer.writeln('        Obrigado pela preferência!        ');
    buffer.writeln('     Volte sempre à Cuidapet! 🐾❤️      ');
    buffer.writeln('${'=' * 50}');
    buffer.writeln('');
    
    return buffer.toString();
  }

  /// Gera recibo simplificado para área restrita
  static String gerarReciboRestrito({
    required String nomeCliente,
    required double valor,
    required FormaPagamento formaPagamento,
    required int numeroAtendimento,
  }) {
    final buffer = StringBuffer();
    final agora = DateTime.now();
    
    buffer.writeln('');
    buffer.writeln('${'=' * 40}');
    buffer.writeln('          🐾 CUIDAPET 🐾          ');
    buffer.writeln('       Área Restrita - Funcionário      ');
    buffer.writeln('${'=' * 40}');
    buffer.writeln('');
    buffer.writeln('Cliente: $nomeCliente');
    buffer.writeln('Atendimento: #$numeroAtendimento');
    buffer.writeln('Data/Hora: ${_formatarDataHora(agora)}');
    buffer.writeln('');
    buffer.writeln('Forma de pagamento: ${formaPagamento.nome}');
    buffer.writeln('Valor: R\$ ${valor.toStringAsFixed(2)}');
    buffer.writeln('');
    buffer.writeln('${'=' * 40}');
    buffer.writeln('    Obrigado pela preferência! 🐾    ');
    buffer.writeln('${'=' * 40}');
    buffer.writeln('');
    
    return buffer.toString();
  }

  static String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
           '${data.month.toString().padLeft(2, '0')}/'
           '${data.year}';
  }

  static String _formatarHora(DateTime data) {
    return '${data.hour.toString().padLeft(2, '0')}:'
           '${data.minute.toString().padLeft(2, '0')}';
  }

  static String _formatarDataHora(DateTime data) {
    return '${_formatarData(data)} ${_formatarHora(data)}';
  }
}
