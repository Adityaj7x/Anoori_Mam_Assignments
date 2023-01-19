@isTest
public class ApexClassforLwcDatatable_Test {
    
    
    @testsetup
    public static void testSetup(){
        Case cs = new Case();
        cs.Status = 'New';
        cs.Origin = 'Phone';
        cs.Case_type__c = 'Triage';
        insert cs;
        
        Case cs1 = new Case();
        cs1.Status = 'Working';
        cs1.Origin = 'Web';
        cs1.Case_type__c = 'Triage';
        cs1.ParentId = cs.Id;
        insert cs1;
        
        Case cs2 = new Case();
        cs2.Status = 'Escalated';
        cs2.Origin = 'Email';
        cs2.Case_type__c = 'Triage';
        insert cs2;
        
        Case cs3 = new Case();
        cs3.Status = 'Escalated';
        cs3.Origin = 'Email';
        cs3.Case_type__c = 'Investigation';
        insert cs3;
        
        
    }
    
    
    @isTest
    public static void showComponentMethodTest1(){
        Test.startTest();
        list<Case> caseList = [Select Id From Case];
        ApexClassforLwcDatatable.showComponentMethod(caseList[0].Id);
        Test.stopTest();
    }
    
    @isTest
    public static void showComponentMethodTest2(){
        Test.startTest();
        list<Case> caseList = [Select Id From Case];
        ApexClassforLwcDatatable.showComponentMethod(caseList[1].Id);
        Test.stopTest();
    }
    
    @isTest
    public static void getCaseTest1(){
        Test.startTest();
        list<Case> caseList = [Select Id From Case];
        ApexClassforLwcDatatable.getCase(caseList[0].Id);
        Test.stopTest();
    }
    
    @isTest
    public static void getCaseTest2(){
        Test.startTest();
        list<Case> caseList = [Select Id From Case];
        ApexClassforLwcDatatable.getCase(caseList[3].Id);
        Test.stopTest();
    }
    
    @isTest
    public static void updateCaseTest(){
        Test.startTest();
        list<Case> caseList = [Select Id From Case];
        ApexClassforLwcDatatable.updateCase(caseList[0].Id, caseList[1].Id);
        Test.stopTest();
    }
}