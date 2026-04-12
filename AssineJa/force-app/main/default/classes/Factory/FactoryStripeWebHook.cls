public without sharing class FactoryStripeWebHook {
    public static ServiceStripeWebHook getServiceStripeWebHook(){
        return new ServiceStripeWebHook(new ServiceCustomerSupport(
                                                                   new SelectorCustomerSupport(), 
                                                                   new SelectorCustomer(),
                                                                   new RepositoryMain())
                                                                   );
    }
}