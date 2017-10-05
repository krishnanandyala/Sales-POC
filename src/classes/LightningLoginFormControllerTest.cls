@IsTest global with sharing class LightningLoginFormControllerTest {
    @IsTest(SeeAllData=true) global static void testLightningLoginController () {
        LightningLoginFormController controller = new LightningLoginFormController();
        LightningLoginFormController.login('test', 'test$', 'www.test.salesforce.com');
        LightningLoginFormController.getIsUsernamePasswordEnabled();
        LightningLoginFormController.getIsSelfRegistrationEnabled();
        LightningLoginFormController.getSelfRegistrationUrl();
        LightningLoginFormController.getForgotPasswordUrl();
    }
}