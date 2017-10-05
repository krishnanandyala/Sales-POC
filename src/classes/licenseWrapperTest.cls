@isTest
public with sharing class licenseWrapperTest {
    static testMethod void testLicenseWrapper(){
         List<AggregateResult> userList = [SELECT COUNT(id) licenseCount, profile.usertype, isactive 
                       			      FROM user 
                       				  GROUP BY profile.usertype, isactive 
                       				  ORDER BY profile.usertype, isactive
                       				  Limit 1];
        List<licenseWrapper> licenseList = licenseWrapper.licenseList(userList);
        String expectedUserType = String.valueOf(userList[0].get('UserType'));   
        String actualUserType = licenseList[0].getLicenseType();
        System.assertEquals(expectedUserType, actualUserType);
    }

}