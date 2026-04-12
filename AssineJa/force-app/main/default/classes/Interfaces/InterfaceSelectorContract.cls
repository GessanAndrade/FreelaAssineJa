public interface InterfaceSelectorContract {

    Contract getContractById(Id contractId);

    List<Contract> getContractsByIds(Set<Id> contractIds);

    List<Contract> getAllContracts();

}