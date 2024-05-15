public class callApi {

    @AuraEnabled
    public static String callCurrency(String b)
    {
        Http http= new Http();
        HttpRequest request= new HttpRequest();
        request.SetMethod('GET');
        request.setEndPoint('https://exchange-rates-api.oanda.com/v1/rates/'+b+'.json?api_key=82365817-a0f3-4f91-8f8e-b05b48df97b1&date=2023-02-27');
        HttpResponse response=http.send(request);
    
        System.debug('GetStatusCode'+response.getStatusCode());
        if(response.getStatusCode()==200)
        {
          return response.getBody();
        }
        else
        {
            return null;
        }  
    }
    @AuraEnabled
     public static String callRates()
    {
        Http http= new Http();
        HttpRequest request= new HttpRequest();
        request.SetMethod('GET');
        request.setEndPoint('https://exchange-rates-api.oanda.com/v1/rates/ADP.json?api_key=82365817-a0f3-4f91-8f8e-b05b48df97b1&date=2023-02-27');
        HttpResponse response=http.send(request);
        
        System.debug('GetStatusCode'+response.getStatusCode());
        Map<String,Object> res= (Map<String,Object>)System.JSON.deserializeUntyped(response.getBody());
        if(response.getStatusCode()==200)
        {
            
            List<Object> los= res.values();
            
        //Map<String,Object> resf= (Map<String,Object>)System.JSON.deserializeUntyped(res);
     
           /* for(String obj:res.keyset())
            {
                System.debug('OBj  '+res.get(obj));
              
            }*/
            
            
			System.debug('OBj  '+los[2]);
			 /* for(Object ob:res.get('obj'))
            {
                System.debug(''+ob);
            }  */          
        //System.debug('GetData'+(res.get('data')));
            
          return response.getBody();
        }
        
        else
        {
            return null;
        }
        
    }
}