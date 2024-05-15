public class fetchRefrence {
    public static void getFields()
    {
        	String customObjectC='message__c';
        	String customObject= customObjectC.split('__c')[0];
        	customObject=customObject.replaceAll('_','');
        	System.debug('ObjectName >6  '+customObject);
        	String customFieldC='bool2__c';
        	String customField= customFieldC.split('__c')[0];
        	customField=customField.replaceAll('_','');
        	System.debug('ObjectName >6  '+customField);
        
        	String callObjectId='Select+Id,DeveloperName,NamespacePrefix+From+CustomObject+Where+DeveloperName=\''+customObject+'\'';
			String objId=fetchRefrence.callOutObjectId(callObjectId);
        	System.debug('ObjectId > 9 >'+objId);
        	String callfieldId='Select+Id,DeveloperName,NamespacePrefix,TableEnumOrId+From+CustomField+Where+DeveloperName=\''+customField+'\'+AND+TableEnumOrId=\''+objId+'\'';
        	String fieldId=fetchRefrence.callOutObjectId(callfieldId);	
        
        	 Http http= new Http();
        	HttpRequest req= new HttpRequest();
        	req.setMethod('GET');
        	req.setHeader('Content-Type', 'application/json');
        	String paramvalue =UserInfo.getSessionId();
			System.debug('user>>'+paramvalue);
			req.setHeader('Authorization', 'Bearer ' + paramvalue);
        	
        	String endUrl='SELECT+Metadata+FROM+FlexiPage+WHERE+id=\'0M0J2000000blPCKAY\'';
        	req.setendpoint('https://eruditeworks71-dev-ed.develop.my.salesforce.com/services/data/v58.0/tooling/query?q='+endUrl);
        	HttpResponse res= http.send(req);
        MetadataComponentDependency data = (MetadataComponentDependency) JSON.deserialize(res.getBody(), MetadataComponentDependency.class);
      		
        	System.debug('Custom Field   '+data.records[0].RefMetadataComponentName+'  > id ??'+data.records[0].RefMetadataComponentId);
        for(Integer i=0;i<data.size;i++)
        {
            System.debug('comptype###  '+data.records[i].MetadataComponentType+'>>ComponentName###  '+data.records[i].MetadataComponentName);
           
            }
    }  
    public static String callOutObjectId(String endUrl)
    {
        Http http= new Http();
        	HttpRequest req= new HttpRequest();
        	req.setMethod('GET');
        	req.setHeader('Content-Type', 'application/json');
        String paramvalue = UserInfo.getSessionId();
		System.debug('user>>'+paramvalue);
			req.setHeader('Authorization', 'Bearer ' + paramvalue);
        	
        	//String endUrl='SELECT+MetadataComponentType,MetadataComponentName,RefMetadataComponentName,RefMetadataComponentId+FROM+MetadataComponentDependency+WHERE+RefMetadataComponentId=\''+idcustField+'\'';
        	req.setendpoint('https://eruditeworks71-dev-ed.develop.my.salesforce.com/services/data/v58.0/tooling/query?q='+endUrl);
       	
        HttpResponse res= http.send(req);
        	System.debug('Statuscode11>>'+res.getStatuscode());
        	System.debug('Body'+res.getBody());
        	MetadataComponentDependency data = (MetadataComponentDependency) JSON.deserialize(res.getBody(), MetadataComponentDependency.class);
        	String objId= data.records[0].Id;
        return objId;
    }

}