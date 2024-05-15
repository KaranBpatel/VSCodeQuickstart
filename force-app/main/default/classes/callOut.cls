public class callOut {

    public static void callOut(){
        
        Http http= new Http();
        HttpRequest request= new HttpRequest();
        request.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200)
        {
	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
            List<object> animals= (List<object>) results.get('animals');
            
            System.debug('Received animal:');
            
            for(Object animal:animals)
            {
                System.debug(animal);
            }
        }
        
        
    }
    public static void addData()
    {
        Http http = new Http();
        HttpRequest request= new HttpRequest();
        request.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/json;charset=UTF-8');
		request.setbody('{"name":"Karan"}');

		HttpResponse response= http.send(request);

		if(response.getStatusCode()!= 201)
		{
 		   System.debug('Status code was not expected '+response.getStatusCode()+':'+response.getStatus());
		}	
		else
        {
 		   System.debug(response.getBody());
			}
        
        
   		 }	
    
    
            }