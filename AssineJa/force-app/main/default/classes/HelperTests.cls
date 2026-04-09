public with sharing class HelperTests {

    public static Contract createTestContact(String customerId, String productId) {
        Contract c = new Contract(
            Name = 'Test',
            Status = 'Active',
            Product__c = productId,
            Status_adimplencia__c = 'Não definido',
            customer__c = customerId
        );

        insert c;

        return c;
    }

    public static Customer_Support__c createTestCustomerSupport(String customerId) {

        Customer_Support__c cs = new Customer_Support__c(
            Customer__c = customerId,
            Description__c = 'Test description',
            prioridade__c = 'Alta'
        );

        insert cs;

        return cs;
    }

    public static Customer createTestCustomer(String productId, String stripeCustomerId) {
        Customer cust = new Customer(
            Name = 'Test Customer',
            Email__c = 'customer@example.com',
            Stripe_Customer_ID__c = stripeCustomerId
        );

        insert cust;

        return cust;
    }

    public static Product2 createTestProduct(String stripeId) {
        Product2 p = new Product2(
            Name = 'Test Product',
            IsActive = true,
            Stripe_price_ID__c = stripeId
        );

        insert p;

        return p;

    }
}