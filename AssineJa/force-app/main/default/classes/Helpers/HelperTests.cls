public with sharing class HelperTests {

    public static Contract createTestContractComplete(){

        Product2 produto = createTestProduct();
        Customer cliente = createTestCustomer();

        return createTestContract(cliente.id, produto.id);
    }

    public static Contract createTestContract(Id customerId, Id productId) {
        Contract c = new Contract(
            
            Name = '001g7000009p9FxAAI',
            Status = 'Activated',
            Product__c = productId,
            Status_adimplencia__c = 'Não definido',
            Customer__c = customerId
        );

        insert c;

        return c;
    }

    public static Customer_Support__c createTestCustomerSupport(String customerId) {

        Customer_Support__c cs = new Customer_Support__c(
            CustuomerID__c = customerId,
            Description__c = 'Test description',
            prioridade__c = 'Alta'
        );

        insert cs;

        return cs;
    }

    public static Customer createTestCustomer() {
        Customer cust = new Customer(
            Name = 'Test Customer',
            Email__c = 'customer@example.com'
        );

        insert cust;

        return cust;
    }

    public static Product2 createTestProduct() {
        Product2 p = new Product2(
            Name = 'Test Product',
            IsActive = true
        );

        insert p;

        return p;

    }
}