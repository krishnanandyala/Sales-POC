public class RetrieveApprovalProcessMetaData
{
    public Integer pageSize = 10;
    public Integer targetSize = 10;
    public Integer count = 0;
    public Boolean hasNext {get; set;}
    public Boolean hasPrevious {get; set;}
    public List<String> approvalProcessNamesList {get; set;}
    public List<MetadataService.ApprovalProcess> approvalProcessList {get; set;}
    
    public MetadataService.MetadataPort metadataService
    {
        get
        {
            if(metadataService == null)
            {
                metadataService = MetaDataComponentPageController.createService();
            }
            return metadataService;
        }
        set;
    }
    
    public RetrieveApprovalProcessMetaData()
    {
        approvalProcessNamesList = new List<String>();
        retrieveApprovalProcessNamesList();
        retrieveApprovalProcessMetaData();
        hasPrevious = false;
    }
    
    public void retrieveApprovalProcessMetaData()
    {   
        approvalProcessList = new List<MetadataService.ApprovalProcess>();
        List<String> approvalNamesList = new List<String>();
        for(Integer i = count ; i < targetSize ; i++)
        {   
            if(i < approvalProcessNamesList.size())
            {
                approvalNamesList.add(approvalProcessNamesList[i]);
            }
        }
        System.debug(approvalNamesList);
        if(!approvalNamesList.isEmpty())
        {
            approvalProcessList = (MetadataService.ApprovalProcess[]) metadataService.readMetadata('ApprovalProcess', approvalNamesList).getRecords();
        }
        setNextAndPrevious();
    }
    
    public void retrieveApprovalProcessNamesList()
    { 
        MetadataService.MetadataPort service = metadataService;
        
        MetadataService.ListMetadataQuery listMetaQuery = new MetadataService.ListMetadataQuery();
        listMetaQuery.type_x = 'ApprovalProcess';
        MetadataService.ListMetadataQuery[] listMeatArr = new MetadataService.ListMetadataQuery[]{};
        listMeatArr.add(listMetaQuery);
        MetadataService.FileProperties[] fieldProp = (MetadataService.FileProperties[]) metadataService.listMetadata(listMeatArr, 40);
        if(fieldProp != null && !fieldProp.isEmpty()){
            for(MetadataService.FileProperties flp : fieldProp)
            {
                approvalProcessNamesList.add(flp.fullName);
            }
        }
    }
    
    public pageReference exportApprovals(){
      PageReference pageRef = new PageReference('/apex/exportApprovalTemplates');
      pageRef.setRedirect(false);
      return pageRef;        
    }
    
    public void getNextCount()
    {
        count = targetSize;
        targetSize = targetSize+ pageSize; 
        retrieveApprovalProcessMetaData();
    }
    
    public void getPreviousCount()
    {
        targetSize = targetSize - pageSize;
        count = targetSize - pageSize;
        retrieveApprovalProcessMetaData();
    }
    
    public void setNextAndPrevious()
    {
        if(targetSize >= approvalProcessNamesList.size())
        {   
            hasNext = false;
            hasPrevious = true;
        }
        else if(count == 0)
        {
            hasPrevious = false;
            hasNext = true;
        }
        else if(targetSize < approvalProcessNamesList.size())
        {
            hasNext = true;
            hasPrevious = true;
        }
    }
}