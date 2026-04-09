public with sharing class HelperUtils {
    public static boolean haveContentJson(String resultado){

        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resultado);
        
        List<Object> data = (List<Object>) responseMap.get('data');
        
        return data != null && !data.isEmpty();
    }
}