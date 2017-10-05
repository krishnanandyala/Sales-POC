@IsTest
public class ddtestconTest {
    private class WebServiceMockImpl implements WebServiceMock 
  {
    public void doInvoke(
      Object stub, Object request, Map<String, Object> response,
      String endpoint, String soapAction, String requestName,
      String responseNS, String responseName, String responseType) 
    {
        MetaDataService.WorkflowFieldUpdate wfu = new MetaDataService.WorkflowFieldUpdate();
        wfu.fullname='workflowsample';
        wfu.field='fieldsample';
        MetaDataService.Workflow wf = new MetaDataService.Workflow();
        wf.fieldUpdates = new List<MetaDataService.WorkflowFieldUpdate>{wfu};
        MetaDataService.ReadWorkflowResult  rwfr = new MetaDataService.ReadWorkflowResult();
        rwfr.records = new List<MetaDataService.Workflow>{wf};        
        MetaDataService.readWorkflowResponse_element rwfre = new MetaDataService.readWorkflowResponse_element();
        rwfre.result = rwfr;
        response.put('response_x', rwfre); 
    }
  }
        static testmethod void checkObjectMetaData()
    {
        PageReference pageRef = Page.ddtest;
        Test.setCurrentPage(pageRef);
        
        ddtestcon metaController = new ddtestcon();
        metaController.sel = 'Account';
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        try{
        metaController.readLayoutcont();
        }catch(Exception ex)
        {
            ex.getStackTraceString();
        }
        metaController.export();
        metaController.fetch();
    }
    
    static testmethod void testFailedObjectMetaData()
    {
        PageReference pageRef = Page.ddtest;
        Test.setCurrentPage(pageRef);
        
        ddtestcon metaController = new ddtestcon();
        metaController.sel = 'Account';
        
        metaController.readLayoutcont();
    }
    private static testMethod void Layout1(){
        ddtestcon dc=new ddtestcon();
        dc.rend=true;
        dc.abcd='';
        dc.export();
        FieldDefinition fd=new FieldDefinition();
        ddtestcon.wrapper cmp = new ddtestcon.wrapper(fd);
        cmp.isli='s';
        cmp.isli1='s1';
        cmp.isli2='s2';
        cmp.isli3='s3';
        cmp.isli4='s4';
        cmp.isli5='s5';
        cmp.isli6='s6';
        cmp.isli7='s7';
        cmp.isli8='s8';
        cmp.isli9='s9';
        cmp.isli10='s10';
        cmp.isli11='s11';
        cmp.isli12='s12';
        cmp.isli13='s13';
        cmp.isli14='s14';
        cmp.isli15='s15';
        cmp.isli16='s16';
        cmp.isli17='s17';
        cmp.isli18='s18';
        cmp.isli19='s19';
        cmp.isli20='s20';
        cmp.isli21='s21';
        cmp.isli22='s22';
        cmp.isli23='s23';
        cmp.isli24='s24';
        MetadataService Mcs =new MetadataService();
        Test.stopTest();    
        
        }
    private static  testMethod void Layout2(){
          
        Test.startTest();
        pagereference pageref=page.ddtest;
        Test.setcurrentpage(pageref);
          
       ddtestcon DDFS=new ddtestcon();
        DDFS.rend=false;
        DDFS.export();
        FieldDefinition fd=new FieldDefinition();
        ddtestcon.wrapper cmp = new ddtestcon.wrapper(fd);
        cmp.isli='s';
        cmp.isli1='s1';
        cmp.isli2='s2';
        cmp.isli3='s3';
        cmp.isli4='s4';
        cmp.isli5='s5';
        cmp.isli6='s6';
        cmp.isli7='s7';
        cmp.isli8='s8';
        cmp.isli9='s9';
        cmp.isli10='s10';
        cmp.isli11='s11';
        cmp.isli12='s12';
        cmp.isli13='s13';
        cmp.isli14='s14';
        cmp.isli15='s15';
        cmp.isli16='s16';
        cmp.isli17='s17';
        cmp.isli18='s18';
        cmp.isli19='s19';
        cmp.isli20='s20';
        cmp.isli21='s21';
        cmp.isli22='s22';
        cmp.isli23='s23';
        cmp.isli24='s24';       
        Test.stopTest();
    }
    public class CalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HttpRequest hReq){
            HttpResponse hRes = new HttpResponse();
            hRes.setBody('{"status":"OK"}');
            return hRes;
        }
        
    }}