@isTest
public class RetrieveApprovalProcessMetadataTest
{
    
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
                fieldProp1.type_x = 'ApprovalProcess';
                fieldProp1.fullName = 'TestApprovalProcess';
      
                MetaDataService.listMetadataResponse_element limdres = new MetaDataService.listMetadataResponse_element();
                limdres.result = new List<MetadataService.FileProperties>{fieldProp1};
                response.put('response_x', limdres); 
            }
            else if(request instanceof MetadataService.readMetadata_element)
            {
                MetaDataService.ApprovalProcess cf1 = new MetaDataService.ApprovalProcess();
                cf1.fullName = 'TestApprovalProcess-1';
                cf1.label = 'TestApprovalProcess';
                MetaDataService.ReadApprovalProcessResult processResult = new MetaDataService.ReadApprovalProcessResult();
                processResult.records = new List<MetaDataService.ApprovalProcess>{cf1};
                MetaDataService.readApprovalProcessResponse_element readProcessResult = new MetaDataService.readApprovalProcessResponse_element();
                readProcessResult.result = processResult;
                response.put('response_x', readProcessResult);
            }
        }
    } 
   
    static testmethod void retrieveMetadataInfo()
    {
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
 
        RetrieveApprovalProcessMetaData rfmd = new RetrieveApprovalProcessMetaData();
        
        rfmd.targetSize = 1;
        rfmd.pageSize = 1;
        rfmd.getNextCount();
        rfmd.getPreviousCount();
        rfmd.setNextAndPrevious();
        rfmd.exportApprovals();
    }
}