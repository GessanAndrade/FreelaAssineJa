@isTest
private class ServiceStripeTest {

    @isTest
    static void testCustomerExistsSuccess() {
        Test.setMock(HttpCalloutMock.class, new ServiceStripeMock());
        
        Test.startTest();
        String exists = ServiceStripe.customerExists('test@example.com');
        Test.stopTest();
        
    }

    @isTest
    static void testCreateStripeCustomer() {
        Test.setMock(HttpCalloutMock.class, new ServiceStripeMock());

        Test.startTest();
        String result = ServiceStripe.createStripeCustomer('Test User', 'test@example.com');
        Test.stopTest();

        System.assertNotEquals(null, result);
        System.assert(result.contains('cus_test_123'));
    }

    @isTest
    static void testCreateStripeSubscription() {
        Test.setMock(HttpCalloutMock.class, new ServiceStripeMock());

        Test.startTest();
        String result = ServiceStripe.createStripeSubscription('cus_test_123', 'price_test_456');
        Test.stopTest();

        System.assertNotEquals(null, result);
        System.assert(result.contains('sub_test_123'));
    }

    @isTest
    static void testApiErrorScenario() {
        
        Test.setMock(HttpCalloutMock.class, new StripeErrorMock());

        Test.startTest();
        String customerResult = ServiceStripe.createStripeCustomer('User', 'email@test.com');
        String customerCheck = ServiceStripe.customerExists('email@test.com');
        Test.stopTest();

        System.assertEquals(null, customerResult, 'Deveria retornar null em caso de erro de criação');
    }

    private class StripeErrorMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(400);
            res.setBody('{"error": {"message": "Invalid Request"}}');
            return res;
        }
    }
}