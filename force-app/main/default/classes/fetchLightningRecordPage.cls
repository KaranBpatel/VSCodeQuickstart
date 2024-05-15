public class fetchLightningRecordPage {
    public static boolean fetch=true;
    @AuraEnabled
    public static  String fetchfields()
    {
            String usrnm=UserInfo.getFirstName();
        Http http= new Http();
        	HttpRequest req= new HttpRequest();
        	req.setMethod('GET');
        	req.setHeader('Content-Type', 'application/json');
            String paramvalue = UserInfo.getSessionId();
		System.debug('user>>'+paramvalue+' usrnm'+usrnm);
			req.setHeader('Authorization', 'Bearer '+UtilsGetSessionId.getSessionIdFromVFPage(Page.GetSessionId));
        	
        	String endUrl='SELECT+Metadata+FROM+FlexiPage+WHERE+id=\'0M0J2000000blPCKAY\'';
        	req.setendpoint('https://eruditeworks71-dev-ed.develop.my.salesforce.com/services/data/v58.0/tooling/query?q='+endUrl);
       	
        HttpResponse res= http.send(req);
        	System.debug('Statuscode11>>'+res.getStatuscode());
        	System.debug('Body'+res.getBody());
        
       return res.getBody();
    }
    @AuraEnabled
     public static String getdata(String recid){
        //fetchLightningRecordPage flp= new fetchLightningRecordPage();
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get('fielUploader__message__c').getDescribe();
        System.debug('schemaMap'+describeResult);
         return String.valueOf(describeResult);
    }
}