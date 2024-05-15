public class AnimalLocator {

    public static String getAnimalNameById(Integer i)
    {
        Http http= new Http();
        HttpRequest request= new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+i);
        request.setMethod('GET');
        HttpResponse response= http.send(request);
        
        
            System.debug(response.getStatusCode());
            Map<String,Object> results= (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            
        	Map<String,Object> animal= (Map<String,Object>) results.get('animal');
           	//List<object> animals= (List<object>) results.get('animals');
        	
        	//for(){}
            
            System.debug('Name:'+ String.valueOf(animal.get('name')));
        
        	
            return String.valueOf(animal.get('name'));
    }
}