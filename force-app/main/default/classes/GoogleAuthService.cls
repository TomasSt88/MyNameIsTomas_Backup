public class GoogleAuthService {
    // change to own Key and Secret
    private static String key = System.getenv('MY_GOOGLE_API_KEY');
   	private static String secert = System.getenv('MY_GOOGLE_API_SECRET');
    private static string redirect_url = 'https://mynameistomas-dev-ed.develop.my.salesforce.com/services/authcallback/GoogleVisionAPI_Auth';
    private static string authUrl='https://accounts.google.com/o/oauth2/auth';
    private static string scope='https://www.googleapis.com/auth/cloud-vision';
    private static string tokenUrl='https://oauth2.googleapis.com/token';
    
    @AuraEnabled
    public static String createAuthURL() {
        String key = EncodingUtil.urlEncode(key,'UTF-8');
        String url = EncodingUtil.urlEncode(redirect_url,'UTF-8');
        String authurl = '';
        authurl = authUrl+'?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope='+scope+
            '&redirect_url='+url+
            '&access_type=offline'+
           	'&prompt=consent';
        System.debug(authurl);
        return authurl;
    }
    
    @AuraEnabled
    public static boolean getAccessToken(String code)
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        
        String messageBody ='code='+code+'&client_id='+key+
            '&client_secret='+secret+
            '&redirect_url='+redirect_url+
            '&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
       	System.debug('messageBody:'+messageBody);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        responseText = response.getBody();
        system.debug('responseText:'+responseText);
        Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
        String token =  String.valueOf(responseMap.get('access_token'));
        System.debug('token:'+token);
        
        //Update token in custom metadata 
        MetadataService.updateCustomMetadata(token);
        return true;
    }
}