public with sharing class FactoryCustomer {
   
    public static ServiceCustomer getServiceCustomer(){
        return new ServiceCustomer(new RepositoryMain());
    }
    
}