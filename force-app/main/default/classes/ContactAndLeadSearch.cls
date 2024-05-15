public class ContactAndLeadSearch {
    public static  List<List< sObject>> searchContactsAndLeads(String Nam){
        
        List<List<sObject>> serchName= [FIND :Nam IN NAME FIELDS RETURNING Contact,Lead];
        
        Contact[] cons=(Contact[])serchName[0];
        Lead[] leads=(Lead[])serchName[1];
        System.debug(cons);
        System.debug(leads);
        return serchName;
    }

}