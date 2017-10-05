@IsTest global with sharing class LightningSelfRegisterControllerTest {
    @IsTest(SeeAllData=true) global static void testLightningSelfRegisterController(){
        LightningSelfRegisterController controller = new LightningSelfRegisterController();
        LightningSelfRegisterController.selfRegister('testFirstName' ,'testLastName', 'testEmail', 'testPassword', 'testConfirmedPassword', 'testAccountId', 'www.test.com', null , 'www.test.com', True);
    	String result = LightningSelfRegisterController.selfRegister('testFirstName' ,'testLastName', 'testEmail', 'testConfirmedPassword', 'testConfirmedPassword', 'testAccountId', 'www.test.com', '' , 'www.test.com', True);
        System.assertEquals(result, 'no content to map to Object due to end of input');
        result = LightningSelfRegisterController.selfRegister('testFirstName' ,'testLastName', '', 'testConfirmedPassword', 'testConfirmedPassword', 'testAccountId', 'www.test.com', null , 'www.test.com', True);
        System.assertEquals(result, Label.Site.email_is_required);
        result = LightningSelfRegisterController.selfRegister('testFirstName' ,'', '', 'testConfirmedPassword', 'testConfirmedPassword', 'testAccountId', 'www.test.com', null , 'www.test.com', True);
        System.assertEquals(result, Label.Site.lastname_is_required);
        LightningSelfRegisterController.getExtraFields('test');
    }

}