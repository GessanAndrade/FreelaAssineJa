@isTest
public class ServiceStripeMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String endpoint = req.getEndpoint();

        if (endpoint.contains('/customers/search')) {
            res.setBody('{"object": "search_result", "data": [{"id": "cus_test_123", "email": "test@example.com"}]}');
            res.setStatusCode(200);
        } 
        
        else if (endpoint.contains('/prices/search')) {
            res.setBody('{"object": "search_result", "data": [{"id": "price_123", "active": true}]}');
            res.setStatusCode(200);
        }
        
        else if (endpoint.contains('/customers')) {
            res.setBody('{"id": "cus_test_123", "object": "customer"}');
            res.setStatusCode(201);
        } 
        
        else if (endpoint.contains('/subscriptions')) {
            res.setBody('{"id": "sub_test_123", "object": "subscription", "status": "active"}');
            res.setStatusCode(200);
        } 
        
        else if (endpoint.contains('/accounts')) {
            res.setBody('{"id": "acct_test_123", "object": "account", "type": "standard"}');
            res.setStatusCode(200);
        }
        
        return res;
    }
}