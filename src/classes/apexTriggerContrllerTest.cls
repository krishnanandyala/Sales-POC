@IsTest
public class apexTriggerContrllerTest {
    private static testmethod void trigger1(){
    Test.startTest();
   	apexTriggerContrller aptc =new apexTriggerContrller();
   	aptc.exportData();
    aptc.hideDetails =true;
    aptc.Trigg();
    Test.stopTest();
    }

}