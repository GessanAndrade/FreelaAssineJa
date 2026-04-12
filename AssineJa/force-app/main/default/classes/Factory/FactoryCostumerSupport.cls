public with sharing class FactoryCostumerSupport {
    
    public static ServiceCustomerSupport getServiceCustomerSupport(){

        return new ServiceCustomerSupport(new SelectorCustomerSupport(), new SelectorCustomer(), new RepositoryMain());
        
    }

}