global class BatchDeleteContentDocuments implements Database.Batchable<sObject> {
    global Integer recordsDeleted = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, (SELECT Id FROM ContentDocumentLinks) FROM ContentDocument WHERE ContentAssetId = NULL AND Id NOT IN (SELECT ContentDocumentId FROM ContentWorkspaceDoc)';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<ContentDocument> scope){
        List<ContentDocumentLink> linksToDelete = new List<ContentDocumentLink>();
        for (ContentDocument doc : scope) {
            linksToDelete.addAll(doc.ContentDocumentLinks);
        }
        delete linksToDelete;

        recordsDeleted += scope.size();
        delete scope;
    }

    global void finish(Database.BatchableContext BC){
        System.debug('Deleted records: ' + recordsDeleted);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'tomas.stranak1@gmail.com'});
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('The BatchDeleteContentDocuments batch job has completed. ' + recordsDeleted + ' records were deleted.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}