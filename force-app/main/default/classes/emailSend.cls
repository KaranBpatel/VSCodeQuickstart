public class emailSend {
    
    public static void sendEmail(List<Contact> newList)
    {
        List<Messaging.Email> emailList= new List<Messaging.Email>();
        for(Contact con:newList){
        Messaging.SingleEmailMessage emailmsg= new Messaging.SingleEmailMessage();
        
        String[] toAddress= new String[]{con.Email};
        emailmsg.setToAddresses(toAddress);
        String emailSub= 'Welcome'+con.FirstName;
        emailmsg.setSubject(emailSub);
        String disName= 'Karan Patel';
        emailmsg.setSenderDisplayName(disName);
        String content='Hi'+con.FirstName+'<br/>Welcome to salesforce<br/>Bye';
        
        emailmsg.setHtmlBody(content);
        emailList.add(emailmsg);
        }
        Messaging.SendEmail(emailList);
    }

}