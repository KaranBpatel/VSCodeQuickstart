trigger sendEmil on Contact (after undelete) {

    if(!Trigger.isInsert){
    emailSend.sendEmail(Trigger.new);
    }
}