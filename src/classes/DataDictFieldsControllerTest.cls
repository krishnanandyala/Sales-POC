@IsTest
public class DataDictFieldsControllerTest {
    private static  testMethod void DataDic1(){
        Test.setmock(HttpCalloutMock.class,new CalloutMock());
        Test.startTest();
        pagereference pageref=page.DataDictFields;
        Test.setcurrentpage(pageref);
        
       DataDictFieldsController DDFS=new DataDictFieldsController();
        DDFS.rend=true;
        DDFS.export();
        FieldDefinition fd=new FieldDefinition();
        DataDictFieldsController.wrapper cmp = new DataDictFieldsController.wrapper(fd);
        cmp.description='sample';
        cmp.inlineHelpText='sample1';
        cmp.stdOrCust='sample3'; 
        MetadataService Mcs =new MetadataService();
        Test.stopTest();
    }
	  private static  testMethod void DataDic2(){
          
        Test.startTest();
        pagereference pageref=page.DataDictFields;
        Test.setcurrentpage(pageref);
          
       DataDictFieldsController DDFS=new DataDictFieldsController();
        DDFS.rend=false;
        DDFS.export();
        FieldDefinition fd=new FieldDefinition();
        DataDictFieldsController.wrapper cmp = new DataDictFieldsController.wrapper(fd);
        cmp.description='sampl22';
        cmp.inlineHelpText='sample1';
        cmp.stdOrCust='sample3';        
        Test.stopTest();
    }
    
    public class CalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HttpRequest hReq){
            HttpResponse hRes = new HttpResponse();
            hRes.setBody('{"status":"OK"}');
            return hRes;
        }
        
    }
}