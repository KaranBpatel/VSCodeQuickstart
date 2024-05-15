public class emailTemplate1 {

    @AuraEnabled
    public static List<EmailTemplate> emailTemp(){
        
        List<EmailTemplate> etp= [SELECT Subject,Name,Id,Body from EmailTemplate LIMIT 4];
        return etp;
  
    }
}