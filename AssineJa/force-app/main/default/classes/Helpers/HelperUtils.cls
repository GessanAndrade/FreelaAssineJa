public with sharing class HelperUtils {
    
    public static String returnKeyJson(String resultado, String key){

        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resultado);

        if (responseMap.containsKey(key)) {
            
            String stripeId = (String) responseMap.get(key);
            
           return stripeId;
            
        } else {
           return '';
        }
    }

    public static List<Object> getDataJson(String resultado){

        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(resultado);
        
        return (List<Object>) responseMap.get('data'); 
    }
    
    public static boolean haveContentJson(String resultado){

        List<Object> data = getDataJson(resultado);
        
        return haveContentJsonByData(data);
    }

    public static Boolean haveContentJsonByData(List<Object> data){
        return data != null && !data.isEmpty();
    }

    public static Map<String, Object> serelizedJson(String resultado){

        List<Object> data = getDataJson(resultado);

        Map<String, Object> resultMap;
        
        if (haveContentJsonByData(data)) {
            
            resultMap = (Map<String, Object>) data[0];

        } 

        return resultMap;
    }
}