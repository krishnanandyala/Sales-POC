@isTest
public class orgClassTest {
    static TestMethod void test(){
        Organization thisOrg = [Select Id, Phone, InstanceName, Name, OrganizationType, PrimaryContact FROM Organization Limit 1][0];
        orgClass newOrg = new orgClass(thisOrg);
        newOrg.setPhone(thisOrg.Phone);
        System.assertEquals(thisOrg.Phone, newOrg.getPhone());
        newOrg.setInstanceName(thisOrg.InstanceName);
        System.assertEquals(thisOrg.InstanceName, newOrg.getInstanceName());
        newOrg.setOrganizationType(thisOrg.OrganizationType);
        System.assertEquals(thisOrg.OrganizationType, newOrg.getOrganizationType());
        newOrg.setName(thisOrg.PrimaryContact);
        newOrg.setPrimaryFirstName('TestFirstName');
        newOrg.setPrimaryLastName('TestLastName');
        newOrg.setOrgName(thisOrg.Name);
        System.assertEquals('TestFirstName', newOrg.getPrimaryFirstName());
        System.assertEquals('TestLastName', newOrg.getPrimaryLastName());
    }
}