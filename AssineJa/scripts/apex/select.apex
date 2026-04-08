String resultado = ServiceStripe.customerExists('jennyrosen@example.com');

// 1. Converte a String JSON em um Mapa de objetos
Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resultado);

// 2. Acesse a lista 'data' (a Stripe sempre retorna uma lista na busca)
List<Object> data = (List<Object>) responseMap.get('data');

if (data != null && !data.isEmpty()) {
    
    Map<String, Object> customer = (Map<String, Object>) data[0];
    
    System.debug('ID do Cliente: ' + customer.get('id'));
    System.debug('Nome: ' + customer.get('name'));
    System.debug('Email: ' + customer.get('email'));
    System.debug('Tamanho do resultado:' + resultado.length());
} else {
    System.debug('Nenhum cliente encontrado.');
}