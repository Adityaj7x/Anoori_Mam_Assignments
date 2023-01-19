@isTest
public class CustomParentTriggerHandler_Test {

    @isTest
    public static void afterInsertTriggerTest() {
        Test.startTest();
        CustomParent__c cp = new CustomParent__c();
        cp.Status__c = 'Draft';
        insert cp;
        Test.stopTest();
    }
    
    @isTest
    public static void afterUpdateTriggerTest() {
        Test.startTest();
        CustomParent__c cp = new CustomParent__c();
        cp.Status__c = 'Draft';
        insert cp;
        
        cp.Status__c = 'Active';
        update cp;
        
        cp.Status__c = 'Completed';
        update cp;
        
        cp.Status__c = 'Pending';
        update cp;
        
        cp.Status__c = 'Draft ';
        update cp;
        
        cp.Status__c = 'Withdrawn';
        update cp;
        
        cp.Status__c = 'Ready-to-withdraw';
        update cp;
        Test.stopTest();
    }
}