public class MetadataService {
    public static void updateCustomMetadata(string token) {
        
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = 'GoogleAuthSetting.AccessToken';
        customMetadata.label = 'AccessToken';
        customMetadata.protected_x = true;
        System.debug('customMetadata' + customMetadata);
        
        Metadata.CustomMetadataValue accessToken = new Metadata.CustomMetadataValue();
        accessToken.field = 'AccessToken__c';
        accessToken.value = token;
        customMetadata.values.add(accessToken);
        System.debug('accessToken' + accessToken);
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        CustomMetadataCallback callback = new CustomMetadataCallback();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        System.debug('mdContainer' + mdContainer);
        System.debug('callback' + callback);
    }
    
    public class CustomMetadataCallback implements Metadata.DeployCallback {
        
        public void handleResult(Metadata.DeployResult result,
           Metadata.DeployCallbackContext context) {
           if (result.status == Metadata.DeployStatus.Succeeded) {
              System.debug(' success : '+ result);
           } else {
              System.debug(' fail : '+ result);
           }
        }
    }
}