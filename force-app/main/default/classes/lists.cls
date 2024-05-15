public class lists {
    public static void displayList(){
    List<String> cars= new List<String>(4);
       cars[0]='ABCD';
    String[] bikes= new String[4];
    bikes.add('Yamaha');
    bikes[0]='Activa';
    System.debug(bikes);
    cars.add(1,'Maruti');
    cars.add('BMW');
    System.debug(cars);
        System.debug(System.url.getOrgDomainUrl());
    }
    public static void checkfetch(){
        //fetchLightningRecordPage flp= new fetchLightningRecordPage();
        System.debug('Outside chechfetch'+fetchLightningRecordPage.fetch);
    }
}