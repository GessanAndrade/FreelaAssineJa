public with sharing class ServiceCustomerSupport implements InterfaceCustomerSupport{

    private InterfaceSelectorCustomerSupport icostumersupport;
    private InterfaceSelectCustomer iscostumer;
    private InterfaceRepositoryMain irepository;

    public ServiceCustomerSupport(InterfaceSelectorCustomerSupport icostumersupport, InterfaceSelectCustomer iscostumer, InterfaceRepositoryMain irepository){
        this.icostumersupport = icostumersupport;
        this.iscostumer = iscostumer;
        this.irepository = irepository;
    }

    public void createTicket(String customer, String description, String priority, String add_info){

        Customer_Support__c tsupport = new Customer_Support__c();

        tsupport.CustuomerID__c = customer;
        tsupport.Description__c = description;
        tsupport.prioridade__c = priority;
        tsupport.status__c = 'Aberto';
        tsupport.additional_info__c = add_info;

        irepository.insertCustomerSupport(tsupport);

    }

    public void processoCustomerSupportsAsync(Set<Id> idsSupports){

        List<Customer_Support__c> updateSupportList = new List<Customer_Support__c>();

        List<Customer_Support__c> supportWithData = icostumersupport.getCustomerSupportsByIds(idsSupports);   
        
        for (Customer_Support__c data : supportWithData){

            String idNew =  iscostumer.getCustomerByStripeID(data.CustuomerID__c);

            data.CustuomerID__c = idNew;

            updateSupportList.add(data);
        }

        irepository.updateCustomersSupports(updateSupportList);

    }

}