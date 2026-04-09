String resultado = ServiceStripe.createStripeCustomer('testando1','jennyrosen2@example.com');

// 1. Converte o JSON em um Mapa
Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resultado);

// 2. Verifique se o ID existe diretamente no mapa (sem lista 'data')
if (responseMap.containsKey('id')) {
    
    // Agora você acessa os campos diretamente do mapa principal
    String stripeId = (String) responseMap.get('id');
    String customerName = (String) responseMap.get('name');
    
    System.debug('ID Gerado: ' + stripeId);
    System.debug('Nome do Cliente: ' + customerName);
    System.debug('JSON Completo: ' + resultado);
    
} else if (responseMap.containsKey('error')) {
    // Caso a Stripe retorne um erro (ex: e-mail inválido)
    Map<String, Object> errorMap = (Map<String, Object>) responseMap.get('error');
    System.debug('Erro da Stripe: ' + errorMap.get('message'));
} else {
    System.debug('Nenhum cliente foi cadastrado.');
}