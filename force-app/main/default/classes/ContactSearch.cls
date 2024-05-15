public class ContactSearch {
    public static Contact[] searchForContacts(String LN,String MailPostalCode)
    {
        Contact[] cons= [SELECT Id,Name FROM Contact WHERE LastName=:LN AND MailingPostalCode=:MailPostalCode];
        return cons;
}
}