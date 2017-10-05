@isTest
public class RetrieveFlowMetadataTest
{
    public class MockHttpResponseGenerator implements HttpCalloutMock 
    {
        RetrieveFlowMetadata.FlowItem fi1 = new RetrieveFlowMetadata.FlowItem('301c0000000GNKzAAz','Active',1);
        RetrieveFlowMetadata.FlowItem fi2 = new RetrieveFlowMetadata.FlowItem('301c0000000GNKzAAx','Obsolete',1);
        RetrieveFlowMetadata.FlowsMetaData fmd = new RetrieveFlowMetadata.FlowsMetaData(new List<RetrieveFlowMetadata.FlowItem>{fi1, fi2});
        
        String flowJsonString = System.Json.serialize(fmd);
        
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
    
    private class WebServiceMockImpl implements WebServiceMock 
    {
        public void doInvoke(
          Object stub, Object request, Map<String, Object> response,
          String endpoint, String soapAction, String requestName,
          String responseNS, String responseName, String responseType) 
        { 
            System.debug(request instanceof MetadataService.listMetadata_element);
            if(request instanceof MetadataService.listMetadata_element)
            {
                MetadataService.FileProperties fieldProp1 = new MetadataService.FileProperties();
                fieldProp1.type_x = 'Flow';
                fieldProp1.fullName = 'TestFlow';
                fieldProp1.id = '301c0000000GNKzAAz';
                
                MetadataService.FileProperties fieldProp2 = new MetadataService.FileProperties();
                fieldProp2.type_x = 'Flow';
                fieldProp2.fullName = 'TestFlowobsolete-1';
                fieldProp2.id = '301c0000000GNKzAAx';
                
                MetaDataService.listMetadataResponse_element limdres = new MetaDataService.listMetadataResponse_element();
                limdres.result = new List<MetadataService.FileProperties>{fieldProp1,fieldProp2};
                response.put('response_x', limdres); 
            }
            else if(request instanceof MetadataService.readMetadata_element)
            {
                MetaDataService.Flow cf1 = new MetaDataService.FLow();
                cf1.fullName = 'TestFlow-1';
                cf1.label = 'TestFlow';
                MetaDataService.Flow cf2 = new MetaDataService.FLow();
                cf2.fullName = 'TestFlowobsolete-1';
                cf2.label = 'TestFlow';
                MetaDataService.ReadFlowResult flowResult = new MetaDataService.ReadFlowResult();
                flowResult.records = new List<MetaDataService.Flow>{cf1, cf2};
                MetaDataService.readFlowResponse_element readFlowResult = new MetaDataService.readFlowResponse_element();
                readFlowResult.result = flowResult;
                response.put('response_x', readFlowResult);
            }
        }
    } 
   
    static testmethod void retrieveMetadataInfo()
    {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
 
        RetrieveFlowMetadata rfmd = new RetrieveFlowMetadata();
        System.assertEquals(rfmd.flowIdToStatus.isEmpty(), false);
        
        rfmd.targetSize = 1;
        rfmd.pageSize = 1;
        rfmd.getNextFlowCount();
        rfmd.getPreviousFlowCount();
        rfmd.exportFlows();
    }
}