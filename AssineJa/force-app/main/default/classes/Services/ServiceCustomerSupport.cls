public with sharing class ServiceCustomerSupport {

    public static void createTicket(String customer, String description, String priority, String add_info){

        Customer_Support__c tsupport = new Customer_Support__c();

        tsupport.CustuomerID__c = customer;
        tsupport.Description__c = description;
        tsupport.prioridade__c = priority;
        tsupport.status__c = 'Aberto';
        tsupport.additional_info__c = add_info;

        insert tsupport;

    }

}