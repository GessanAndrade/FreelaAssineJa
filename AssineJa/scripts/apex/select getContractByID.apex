try {

    String idCod = '800g700000Oq4kwAAB';

    Contract contrct = SelectorContract.getContractById(idCod);

    contrct.Status = 'Activated'; 
    
    update contrct;
    
    Contract contrct2 = SelectorContract.getContractById(idCod);
    System.debug('Complete2: ' + contrct2);

} catch (DmlException e) {
    System.debug('Erro ao atualizar: ' + e.getMessage());
}