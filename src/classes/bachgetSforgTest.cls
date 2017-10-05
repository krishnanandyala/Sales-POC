@isTest
public class bachgetSforgTest {
    
    Static testMethod void test(){
        List<Organization> orgList = new List<Organization>();
        for (integer i = 0 ; i < 2 ; i++){
            Organization org = new Organization();
            orgList.add(org);
        }

        Test.startTest();
        
        testorgpulse top = new testorgpulse();
        top.testorgpulsemethod();
        Test.stopTest();
    }
}