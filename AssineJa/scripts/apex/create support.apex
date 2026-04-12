try{
    String customerIdStripe = 'cus_UJmnIKJIBygaKY';
    String description = 'Fatura Paga!| Id Stripe: cus_UJmnIKJIBygaKY| Assinatura Stripe: N/A| Valor: R$ 5';
    String priority = 'Baixa';
    String add_info = '';

    //ServiceCustomerSupport.createTicket(customerIdStripe, description, priority, add_info); 

    List<Customer_Support__c> cust = [SELECT Name, ID, CustuomerID__c, Description__c, prioridade__c FROM Customer_Support__c];

    for (Customer_Support__c c : cust){
        System.debug('Resultado: ' + cust);
    }

} catch (DmlException e) {
    System.debug('Erro ao inserir: ' + e.getMessage());
}