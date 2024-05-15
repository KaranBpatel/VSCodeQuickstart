@isTest
public class TemperatureConverterTest {
    
    @isTest static void  testWarmTemp(){
        
        Decimal celsius= TemparatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    

}