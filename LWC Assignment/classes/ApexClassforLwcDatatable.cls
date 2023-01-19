public with sharing class ApexClassforLwcDatatable {

    @AuraEnabled(cacheable=true)
    public static Boolean showComponentMethod(String recordIdMainCase) {
        List<Case> caseList = [SELECT Id, ParentId fROM Case WHERE Id=:recordIdMainCase ];
        if(caseList[0].ParentId == NULL) {
            return true;
        } else {
            return false;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getCase(String recordIdCase){
        // System.debug('RecordIdcase: ' + recordIdCase);
        List<Case> caseList1=[SELECT Id, CaseNumber, Case_type__c
        FROM Case
        Where id=:recordIdCase];
        // system.debug('caseList1: ' + caseList1);
        String caseTypeMain = caseList1[0].Case_type__c;
        // System.debug('caseTypeMain: ' + caseTypeMain);

        List<Case> caseList = [SELECT Id, CaseNumber, Case_type__c, Priority, Status FROM Case Where Case_type__c=:caseTypeMain AND Id != :recordIdCase];
        if(!caseList.isEmpty()) {
            system.debug('caseList: ' + caseList);
            return caseList;
        }
        return NULL;
    }

    @AuraEnabled
    public static void updateCase(String parentRecordIdCase, String caseIdMain) {
        string parentIdNew = parentRecordIdCase;
        string caseIdMainNew = caseIdMain;
        System.debug('caseIdMainNew: '+ caseIdMainNew);
        System.debug('parentIdNew: '+ parentIdNew);
        List<Case> caseList2=[SELECT Id, CaseNumber, Case_type__c, ParentId
        FROM Case
        Where id=:caseIdMainNew];
        
        caseList2[0].ParentId = parentIdNew;
        update caseList2;
    }
}