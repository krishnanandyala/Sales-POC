@isTest
private class RetrieveWorkFLowMetaDataTest {
    public class MockHttpResponseGenerator implements HttpCalloutMock 
    {
        RetrieveWorkFLowMetaData.WorkFlowItemInfo wfItemInfo = new RetrieveWorkFLowMetaData.WorkFlowItemInfo('Account.name <> null',
                                                               true, 'workflow description', 'onAllChnages');
        RetrieveWorkFLowMetaData.WorkFlowItems wfItem = new RetrieveWorkFLowMetaData.WorkFlowItems(
                                                        'TestWorkFLow', 'TestWorkFLow', null, 'Account');
        
        List<RetrieveWorkFLowMetaData.WorkFlowItems> wfs = new List<RetrieveWorkFLowMetaData.WorkFlowItems>{wfItem};
        RetrieveWorkFLowMetaData.WorkFlowMeta wf = new RetrieveWorkFLowMetaData.WorkFlowMeta(wfs);
        
        String flowJsonString = System.Json.serialize(wf);
        
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            System.debug(req.getEndPoint());
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(flowJsonString);
            res.setStatusCode(200);
            return res;
        }
    }
    
    static testmethod void testWorkFlowData()
    {
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        RetrieveWorkFLowMetaData workFlowInfo = new RetrieveWorkFLowMetaData();
        workFlowInfo.getNextCount();
        workFlowInfo.getPreviousCount();
        workFlowInfo.setNextAndPrevious();
        workFlowInfo.exportworkflow();
    }
}