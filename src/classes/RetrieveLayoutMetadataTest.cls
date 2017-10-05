@IsTest
public class RetrieveLayoutMetadataTest {
    private class WebServiceMockImplForLayout implements WebServiceMock 
    {
        public void doInvoke(
          Object stub, Object request, Map<String, Object> response,
          String endpoint, String soapAction, String requestName,
          String responseNS, String responseName, String responseType) 
        {
            if(request instanceof MetadataService.listMetadata_element)
            {
                MetadataService.FileProperties fieldProp1 = new MetadataService.FileProperties();
                fieldProp1.type_x = 'Layout';
                fieldProp1.fullName = 'TestLayout';
      
                MetaDataService.listMetadataResponse_element limdres = new MetaDataService.listMetadataResponse_element();
                limdres.result = new List<MetadataService.FileProperties>{fieldProp1};
                response.put('response_x', limdres); 
            }
            else if(request instanceof MetadataService.readMetadata_element)
            {
                MetaDataService.Layout cf1 = new MetaDataService.Layout();
                cf1.fullName = 'TestLayoutAccount';
                MetaDataService.ReadLayoutResult layoutResult = new MetaDataService.ReadLayoutResult();
                layoutResult.records = new List<MetaDataService.Layout>{cf1};
                MetaDataService.readLayoutResponse_element readLayoutResult = new MetaDataService.readLayoutResponse_element();
                readlayoutResult.result = layoutResult;
                response.put('response_x', readLayoutResult);
            }
        }
    }     
    static testmethod void testLayoutData()
    {
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImplForLayout());
        PageReference pageRef = Page.LayoutsMetaDataInfo;
        Test.setCurrentPage(pageRef);
        ApexPages.CurrentPage().getParameters().put('layoutObjectName','Account');
        RetrieveLayoutMetadata metaController = new RetrieveLayoutMetadata();
        test.starttest();
        metaController.getRetrieveLayoutMetadata();
        metaController.getNextCount();
        metaController.getPreviousCount();
        metaController.exportLayouts();
        test.stoptest();
    }   
}