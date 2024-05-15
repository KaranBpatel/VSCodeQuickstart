public with sharing class FileController {
   // FileController.getFileNames('0015h00001ezA2SAAU');
    @AuraEnabled(cacheable=true)
    public static List<String> getFileNames(Id id) {
        List<String> fileNames = new List<String>();
        
        // Query ContentDocumentLinks associated with the Account
        List<ContentDocumentLink> documentLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :id];
        
        // Retrieve ContentDocumentIds
        Set<Id> contentDocumentIds = new Set<Id>();
        for(ContentDocumentLink link : documentLinks) {
            contentDocumentIds.add(link.ContentDocumentId);
        }
        
        // Query ContentDocuments to get file names
        List<ContentDocument> documents = [SELECT Title,Id FROM ContentDocument WHERE Id IN :contentDocumentIds];
        // List<ContentVersion> conv=[SELECT id,ContentUrl FROM ContentVersion WHERE ContentDocumentId];
        // System.debug('conv : '+conv);
        // Extract file names
        for(ContentDocument doc : documents) {
            fileNames.add(doc.Title);
            System.debug(doc.Id+'doc.Title: ' + doc.Title);
        }
        
        return fileNames;
    }

    @AuraEnabled(cacheable=true)
    public static map<id,String> getFilePreview(Id id)
    {
        List<ContentDocumentLink> condocId = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :id];
        List<id> docId= new List<id>();
        for (ContentDocumentLink docLink : conDocId) {
            docId.add(docLink.ContentDocumentId);
        }
        List<ContentVersion> docs= [SELECT ContentDocumentId, FileExtension, Title,Versiondata 
        FROM ContentVersion WHERE ContentDocumentId IN : docId];
        Map<Id,String> mapIdTitle = new Map<Id,String>();
        String pdfData='';
        for(ContentVersion dc:docs)
        {
            mapIdTitle.put(dc.ContentDocumentId,dc.Title);
            pdfData = EncodingUtil.base64Encode(dc.versiondata);
            System.debug('pdfData'+pdfData);
        }
        System.debug('Log files'+mapIdTitle);
        return mapIdTitle;
    }
    
}