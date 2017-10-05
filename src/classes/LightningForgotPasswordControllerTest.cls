@IsTest global with sharing class LightningForgotPasswordControllerTest {
    @IsTest(SeeAllData=true) global static void testLightningForgotPasswordController(){
        LightningForgotPasswordController controller = new LightningForgotPasswordController();
        LightningForgotPasswordController.forgotPassowrd('testUser', 'test.salesforce.com');
    }
    
}