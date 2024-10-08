public class ScannedDocumentAfterDelete {
    public static void deleteRelatedContentDocuments(List<Scanned_Document__c> scannedDocuments) {
        List<Id> scannedDocumentIds = new List<Id>();
        for (Scanned_Document__c scannedDocument : scannedDocuments) {
            scannedDocumentIds.add(scannedDocument.Id);
        }
        System.debug('@@@ scannedDocumentIds ' + scannedDocumentIds);

        List<ContentDocumentLink> links = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :scannedDocumentIds];
        System.debug('@@@ ContentDocumentLink ' + links);
        List<Id> contentDocumentIds = new List<Id>();
        for (ContentDocumentLink link : links) {
            contentDocumentIds.add(link.ContentDocumentId);
        }
        System.debug('@@@ contentDocumentIds ' + contentDocumentIds);

        List<ContentDocument> contentDocumentsToDelete = [SELECT Id FROM ContentDocument WHERE Id IN :contentDocumentIds];
        System.debug('@@@ contentDocumentsToDelete ' + contentDocumentsToDelete);
        delete contentDocumentsToDelete;
    }
}