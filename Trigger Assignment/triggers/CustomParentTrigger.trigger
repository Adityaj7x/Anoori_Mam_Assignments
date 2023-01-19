trigger CustomParentTrigger on CustomParent__c (after insert, after update) {

    if(trigger.isAfter && trigger.isInsert) {
        CustomParentTriggerHandler.afterInsertTrigger(trigger.newMap);
    }
    
    if(trigger.isAfter && trigger.isUpdate) {
        CustomParentTriggerHandler.afterUpdateTrigger(trigger.oldMap, trigger.newMap);
    }
}