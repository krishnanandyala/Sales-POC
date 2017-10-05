@isTest
public class installedApplicationTest {
    static testMethod void testInstalledApplication(){
        List<PackageLicense> plList = [SELECT Id, NamespacePrefix, AllowedLicenses, UsedLicenses, 
                             ExpirationDate,Status FROM PackageLicense Limit 1];
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        PackageLicense pl = plList[0];
        Schema.DescribeTabSetResult tabSet = tabSetDesc[0];
        List<InstalledApplication> appList = PackageNamespace.getAppInfo();
        installedApplication app = new installedApplication(tabSet, pl);
        System.assertEquals(app.getLabel(), tabSet.getLabel());
        System.assertEquals(app.getDescription(), tabSet.getDescription());
        System.assertEquals(app.getLogoUrl(), tabSet.getLogoUrl());
        System.assertEquals(app.getNamespace(), tabSet.getNamespace());
        System.assertEquals(app.getSelected(), tabSet.isSelected());
        System.assertEquals(app.getPackageId(), pl.id);
        System.assertEquals(app.getAllowedLicenses(), pl.AllowedLicenses);
        System.assertEquals(app.getUsedLicenses(), pl.UsedLicenses);
        System.assertEquals(app.getExpirationDate(), pl.ExpirationDate);
        System.assertEquals(app.getStatus(), pl.Status);
        

    }
    
    static testMethod void orgPulseTest(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = 'https://something.com';
        req.httpMethod = 'Post';
        RestContext.request = req;
        RestContext.response = res;
        List<installedApplication> appList = new List<installedApplication>();
        List<PackageLicense> plList = [SELECT Id, NamespacePrefix, AllowedLicenses, UsedLicenses, 
                             ExpirationDate,Status FROM PackageLicense Limit 1];
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        PackageLicense pl = plList[0];
        Schema.DescribeTabSetResult tabSet = tabSetDesc[0];
        installedApplication app = new installedApplication(tabSet, pl);
        appList.add(app);
        CountLines lines = new CountLines();
        htmlRegEx scrapedInfo = new htmlRegEx();
        Integer x = lines.getApexClassLines();
        Integer y = lines.getApexTriggerLines();
        
        Integer dataPercent = scrapedInfo.getUsedDataPercent();
        System.assertEquals(0, dataPercent);
        Integer filePercent = scrapedInfo.getUsedFilePercent();
        System.assertEquals(0,filePercent);
        Decimal dataNum = scrapedInfo.getUsedDataSpaceNum();
        System.assertEquals(30,dataNum);
        String dataUnit = scrapedInfo.getusedDataSpaceUnit();
        System.assertEquals('KB', dataUnit);
        Decimal fileNum = scrapedInfo.getUsedFileSpaceNum();
        System.assertEquals(688, fileNum);
        String fileUnit = scrapedInfo.getusedFileSpaceUnit();
        System.assertEquals('KB',fileUnit);
        
    }
    
   
}