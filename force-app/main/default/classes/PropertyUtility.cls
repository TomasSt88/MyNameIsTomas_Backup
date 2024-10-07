public class PropertyUtility {
    public static void newListedProperties() {
        List<Property__c> newPropList = [SELECT Name, Broker__r.Email__c, Days_On_Market__c FROM Property__c WHERE Days_On_Market__c <= 30];
        List<Property__c> processedPropList = new List<Property__c>();
        for(Property__c property : newPropList) {
            processedPropList.add(property);
            String propEmail = property.Name + ' : ' + property.Broker__r.Email__c;
            System.debug(propEmail);
        }
    }
}