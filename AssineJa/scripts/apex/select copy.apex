List<Contract> contr = SelectorContract.getAllContracts();

for (Contract c : contr){
    System.debug('Geral: ' + c);
}

Contract contrct = SelectorContract.getContractById('800g700000O1vknAAB');

System.debug('ID: ' + contrct);