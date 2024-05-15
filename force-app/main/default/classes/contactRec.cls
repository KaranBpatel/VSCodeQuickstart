public with sharing class contactRec {
    @AuraEnabled
    public static List<Contact> relatedCons(String accId){
        try {
            
            return [SELECT LastName FROM Contact WHERE AccountId=:accId];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}