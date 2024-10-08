@isTest 
private class ScannedDocumentAfterDeleteTest {
    @isTest static void testDeleteScannedDocument() {
        Test.setMock(HttpCalloutMock.class, new GoogleCloudVisionAPIMock());
        
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        
        Scanned_document__c scannedDocument = new Scanned_document__c(Account__c=testAccount.Id);
        insert scannedDocument;
        
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
            );
            insert contentVersion;
            
            // Query for any existing ContentDocumentLink records that link the ContentDocument to the scannedDocument record
            List<ContentDocumentLink> links = [SELECT Id FROM ContentDocumentLink WHERE ContentDocumentId = :contentVersion.ContentDocumentId AND LinkedEntityId = :scannedDocument.Id];
            if (!links.isEmpty()) {
                System.debug(links);
                delete links;
            }
            System.debug(links);  
            
            List<ContentVersion> contentVersions = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id];
            if (!contentVersions.isEmpty()) {
                ContentDocumentLink link = new ContentDocumentLink(
                    ContentDocumentId = contentVersions[0].ContentDocumentId,
                    LinkedEntityId = scannedDocument.Id,
                    ShareType = 'V'
                    );
                insert link;
            }
                
        Test.startTest();
            delete scannedDocument;
        Test.stopTest();

        System.assertEquals(0, [SELECT count() FROM ContentDocument]);
    }
}