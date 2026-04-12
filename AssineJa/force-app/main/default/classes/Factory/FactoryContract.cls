public with sharing class FactoryContract {

    public static ServiceContract getServiceContract(){

        return new ServiceContract(new SelectorContract(), new ControllerStripe());

    }

}