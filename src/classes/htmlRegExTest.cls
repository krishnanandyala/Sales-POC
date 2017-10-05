@isTest
public class htmlRegExTest {
    static TestMethod void test(){
        htmlRegEx scrapedData = new htmlRegEx();
        Organization org = [SELECT IsSandbox FROM Organization LIMIT 1][0];
        System.assertEquals(scrapedData.getUsedDataPercent(),0);
        System.assertEquals(scrapedData.getUsedDataSpaceNum(),30);
        System.assertEquals(scrapedData.getusedDataSpaceUnit(),'KB');
        System.assertEquals(scrapedData.getUsedFilePercent(),0);
        System.assertEquals(scrapedData.getUsedFileSpaceNum(), 688);
        System.assertEquals(scrapedData.getusedFileSpaceUnit(), 'KB');
        System.assertEquals(scrapedData.getDevSndbxAvailable(), 92);
        System.assertEquals(scrapedData.getDevSndbxInUse(), 8);
        System.assertEquals(scrapedData.getProSndbxAvailable(), 1);
        System.assertEquals(scrapedData.getProSndbxInUse(), 4);
        System.assertEquals(scrapedData.getPartialSndbxAvailable(), 1);
        System.assertEquals(scrapedData.getPartialSndbxInUse(), 0);
        System.assertEquals(scrapedData.getFullSndbxAvailable(), 0);
        System.assertEquals(scrapedData.getFullSndbxInUse(), 1);
        
        
        
        
    }
}