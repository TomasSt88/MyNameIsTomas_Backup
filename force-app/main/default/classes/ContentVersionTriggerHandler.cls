public class ContentVersionTriggerHandler {
    @future(callout=true)
	public static void callGoogleDrive(String cvId){
        String key = System.getenv('MY_GOOGLE_API_K');
   		String secert = System.getenv('MY_GOOGLE_API_SECRET');
    	String redirect_uri = 'https://developers.google.com/oauthplayground';
        String accesstoken;
    	String refreshToken = System.getenv('MY_GOOGLE_API_TOKEN');
        HttpRequest req2 = new HttpRequest();
            req2.setMethod('POST');
            req2.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
            req2.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'client_id=' + key + '&client_secret=' + secert + '&refresh_token='+refreshtoken+'&redirect_uri=' + redirect_uri + '&grant_type=refresh_token';
            req2.setHeader('Content-length', String.valueOf(messageBody.length()));
            req2.setBody(messageBody);
            req2.setTimeout(60 * 1000);
        Http h2 = new Http();
        String resp2;
        HttpResponse res2 = h2.send(req2);
        resp2 = res2.getBody();
        System.debug('resp2-->>'+resp2);
        JSONParser parser = JSON.createParser(resp2);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
            	String fieldName = parser.getText();
            	parser.nextToken();
            if (fieldName == 'access_token') {
            	accesstoken = parser.getText();
            } else if (fieldName == 'expires_in') {
             	Integer expiresIn = parser.getIntegerValue();
            } else if (fieldname == 'token_type') {
             	String tokentype = parser.getText();
            }
        }
   } 
        ContentVersion cv=[select id,title,ContentDocumentId,versiondata from Contentversion where Id =: cvId ];
        
        Blob myBlob = cv.versiondata;
        String url = 'https://www.googleapis.com/upload/drive/v2/files?uploadType=media';
        String authorizationHeader = 'Bearer ' + accesstoken; 
        Integer contentSize = myBlob.size();
        HttpRequest req1 = new HttpRequest();
            req1.setheader('Authorization',authorizationHeader);
            req1.setheader('Content-Length',String.valueOf(contentSize));
            req1.setheader('Content-Type','image/'+'PNG');
            req1.setheader('Content-Type','application/'+'pdf');
            req1.setMethod('POST'); 
            req1.setEndpoint(url); 
            req1.setBodyAsBlob(myBlob); 
        Http h1 = new Http(); 
        Httpresponse resp1 = h1.send(req1);
    }
}