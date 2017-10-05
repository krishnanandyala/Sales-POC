/**
* Flow medata details will be retrieved using below logic.
* Here Tooling amd metadata apis' are being used.
*
*/
public class RetrieveFlowMetadata
{   
    public List<MetadataService.Flow> flowList {get; set;}
    public  Map<String, String> flowNameToStatusMap = new Map<String, String>();
    public  Map<String, Integer> flowNameToVersionMap = new Map<String, Integer>();
    public  Map<String, Integer> flowIdToVersionMap = new Map<String, Integer>();
    public Integer pageSize = 10;
    public Integer targetSize = 10;
    public Integer count = 0;
    public Boolean hasNext {get; set;}
    public Boolean hasPrevious {get; set;}

    public RetrieveFlowMetadata()
    {
        getRetrieveFlowMetadata();
        hasPrevious = false;
    }
    
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
    
    /*
    * To retrieve the names of flows(which includes processes which are created using process builder)
    */
    public List<String> flowNamesList
    {
        get
        {
            if(flowNamesList == null)
            {
                flowNamesList = new List<String>();
                MetadataService.ListMetadataQuery listMetaQuery = new MetadataService.ListMetadataQuery();
                listMetaQuery.type_x = 'Flow';
                
                MetadataService.FileProperties[] fieldProp = (MetadataService.FileProperties[]) metadataService.listMetadata(new List<MetadataService.ListMetadataQuery>{listMetaQuery}, 40);
                
                if(fieldProp != null && !fieldProp.isEmpty())
                {
                    for(MetadataService.FileProperties flp : fieldProp)
                    {   
                        if(flowIdToStatus != null && flowIdToStatus.containsKey(flp.id))
                        {
                            flowNameToStatusMap.put(flp.fullName, flowIdToStatus.get(flp.id));
                            if(!flp.fullName.substringAfterLast('-').isNumeric())
                            {
                                flp.fullName = flp.fullName + '-' + flowIdToVersionMap.get(flp.id);                          
                            }
                        }
                        flowNamesList.add(flp.fullName);
                    }
                }
                
                if(!flowNamesList.isEmpty())
                {
                    flowNamesList.sort();
                }
            }
            return flowNamesList;
        }
        set;
    }
    
    /*
    * For getting the status of flow or process ,Tooling api is used.
    *
    * Status is not returned by the Meta data api(that may be the drawback of meta data api).
    * It may not be the best practice to use tooling api for sttaus information,But there is no choice.
    * This issue can be fixed in future.
    */
    public Map<id, String> flowIdToStatus
    {
        get
        {
            if(flowIdToStatus == null)
            {
                flowIdToStatus = new Map<id, String>();
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
                req.setHeader('Content-Type', 'application/json');
                
                req.setEndpoint(Url.getSalesforceBaseUrl().toExternalForm()+'/services/data/v40.0/tooling/query/?q=Select+ID,Status,VersionNumber+FROM+Flow');
                req.setMethod('GET');
                
                Http h = new Http();
                HttpResponse res = h.send(req);
                RetrieveFlowMetadata.FlowsMetaData fmd = (RetrieveFlowMetadata.FlowsMetaData)System.Json.deserialize(res.getBody(), FlowsMetaData.class);
                if(fmd != null && fmd.records != null)
                {
                    for(RetrieveFlowMetadata.FlowItem fi: fmd.records)
                    {
                        flowIdToStatus.put(fi.Id, fi.Status);
                        flowIdToVersionMap.put(fi.Id, fi.VersionNumber);
                    }
                }
            }
            return flowIdToStatus;
        }
        set;
    }
    
    
    public void getRetrieveFlowMetadata()
    {
        flowList = new List<MetadataService.Flow>();
        List<MetadataService.Flow> metadataResponseOfFlows;
        List<String> flowNamesToDisplay = new List<String>();
        
        for(Integer i = count ; i < targetSize ; i++)
        {   
            if(i < flowNamesList.size())
            {
                flowNamesToDisplay.add(flowNamesList[i]);
            }
        }
        
        if(flowNamesToDisplay!= null && !flowNamesToDisplay.isEmpty())
        {
            metadataResponseOfFlows = (MetadataService.Flow[]) metadataService.readMetadata('Flow', flowNamesToDisplay).getRecords();
        }
        
        if(metadataResponseOfFlows != null){
            for(MetadataService.Flow flowItem : metadataResponseOfFlows)
            {
                if(flowNameToStatusMap.containsKey(flowItem.fullName))
                {
                    flowItem.Status = flowNameToStatusMap.get(flowItem.fullName);
                }
                else if(flowNameToStatusMap.containsKey(flowItem.fullName.substringBeforeLast('-')))
                {   
                    flowItem.status = flowNameToStatusMap.get(flowItem.fullName.substringBeforeLast('-'));
                }
                flowList.add(flowItem);
            }
        }
        setNextAndPrevious();
    }
    
    public class FlowsMetaData
    {
        public List<FlowItem> records;
        public FlowsMetaData(List<FlowItem> records)
        {
            this.records = records;
        }
    }
    
    public class FlowItem
    {
        public String id ;
        public String status;
        public Integer versionNumber;
        public FlowItem(String id, String status, Integer versionNumber)
        {
            this.id = id;
            this.status = status;
            this.versionNumber = versionNumber;
        }
    }
    
    public void getNextFlowCount()
    {
        count = targetSize;
        targetSize = targetSize+ pageSize; 
        getRetrieveFlowMetadata();
    }
    
    public void getPreviousFlowCount()
    {
        targetSize = targetSize - pageSize;
        count = targetSize - pageSize;
        getRetrieveFlowMetadata();
    }
    
    public void setNextAndPrevious()
    {
        if(targetSize >= flowNamesList.size())
        {   
            hasNext = false;
            hasPrevious = true;
        }
        else if(count == 0)
        {
            hasPrevious = false;
            hasNext = true;
        }
        else if(targetSize < flowNamesList.size())
        {
            hasNext = true;
            hasPrevious = true;
        }
    }
    
    public PageReference exportFlows()
    {
        PageReference pageRef = new PageReference('/apex/FlowsExport');
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    public PageReference metaPageReturns()
    {
        PageReference pageRef = new PageReference('/apex/MetaDataComponentPage');
        //pageRef.setRedirect(false);
        return pageRef;
    }
}