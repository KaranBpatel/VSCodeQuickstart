public class ocrTest {
    @AuraEnabled
    public static void getOcrResp()
    {
        Http http = new Http();
        HttpRequest request= new HttpRequest();
        request.setMethod('POST');
       // request.setHeader('{"apikey": "helloworld","020191ef5788957": ""}');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('APIKEY', '020191ef5788957');
        request.setEndpoint('https://api.ocr.space/parse/image');
        String body= '{ '+'"isOverlayRequired":"true",'+'"url":"https://cloudinary-marketing-res.cloudinary.com/images/w_1000,c_scale/v1679921049/Image_URL_header/Image_URL_header-png"'+' s}';
        request.setbody(body);
       // request.setBody('[{"isOverlayRequired":"true","url":"https://cloudinary-marketing-res.cloudinary.com/images/w_1000,c_scale/v1679921049/Image_URL_header/Image_URL_header-png"}]');
                        
        HttpResponse response= http.send(request);
        
        System.debug('StatusCode'+response.getStatusCode());
        System.debug('Body'+response.getBody());
    }
    @AuraEnabled
    public static String getRequest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://api.ocr.space/parse/imageurl?apikey=020191ef5788957&url=https://cloudinary-marketing-res.cloudinary.com/images/w_1000,c_scale/v1679921049/Image_URL_header/Image_URL_header-png&language=chs&isOverlayRequired=true');
        HttpResponse response= http.send(request);
        System.debug('status code'+response.getStatusCode());
        System.debug('status code'+response.getBody());
        return response.getBody();
    }
}