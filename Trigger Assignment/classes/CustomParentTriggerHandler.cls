public class CustomParentTriggerHandler {
    
    public static void afterInsertTrigger(Map<Id,CustomParent__c> newMap) {
        Set<Id> newSet = new Set<Id>();
        for(CustomParent__c cp: newMap.values()) {
            newSet.add(cp.Id);
        }
        List<CustomParent__c> newList2 = new List<CustomParent__c>([Select Id, Name from CustomParent__c where Id in: newSet]);
        List<CustomChild__c> newCCList = new List<CustomChild__c>();
        for(CustomParent__c cp :newList2) {
            CustomChild__c cc = new CustomChild__c();
            cc.CustomChildParent__c = cp.Id;
            newCCList.add(cc);
        }
        insert newCCList;
    }
    
    

    public static void afterUpdateTrigger(Map<Id, CustomParent__c> oldMap, Map<Id, CustomParent__c> newMap) {
        List<CustomParent__c> newCPList = new List<CustomParent__c>();
        for(Id cp: newMap.keyset()) {
            if(newMap.get(cp).Status__c <> oldMap.get(cp).Status__c) {
                newCPList.add(newMap.get(cp));
            }
        }
        
        Map<Id, CustomParent__c> newCPMap = new Map<Id, CustomParent__c>([Select Id, Status__c, Name, (Select Id, Status__c, FromDate__c, ToDate__c, Name from CustomChilds__r) from CustomParent__c]);
        Map<Id, List<CustomChild__c>> cCMap = new Map<Id, List<CustomChild__c>>();
        for(CustomParent__c cp: newCPMap.values()) {
            if(!cp.CustomChilds__r.isEmpty()) {
                cCMap.put(cp.Id, cp.CustomChilds__r);
            }
        }
        
        List<CustomChild__c> custChildUpdateList = new List<CustomChild__c>();
        for(Id cp: cCMap.keyset()) {
            List<CustomChild__c> ccList = new List<CustomChild__c>();
            ccList = cCMap.get(cp);
            for(CustomChild__c cc : ccList) {
                CustomParent__c cp1 = newCPMap.get(cp);
                if(cp1.Status__c == 'Active' || cp1.Status__c == 'Completed') {
                    cc.Status__c = 'Active';
                    cc.FromDate__c = system.today();
                    cc.ToDate__c = cc.FromDate__c + 730;
                    custChildUpdateList.add(cc);
                } else if (cp1.Status__c == 'Pending' || cp1.Status__c == 'Draft') {
                    cc.Status__c = 'Pending';
                    custChildUpdateList.add(cc);
                } else if (cp1.Status__c == 'Withdrawn' || cp1.Status__c == 'Ready-to-withdraw') {
                    cc.Status__c = 'Withdrawn';
                    custChildUpdateList.add(cc);
                }
            }
            
            update custChildUpdateList;
        }
    }
}