public class RetrieveWorkFLowMetaData {
    public List<RetrieveWorkFLowMetaData.WorkFlowItems> workFlowList;
    public List<RetrieveWorkFLowMetaData.WorkFlowItems> workFlowMetaResult {get; set;}
    public Integer pageSize = 10;
    public Integer targetSize = 10;
    public Integer count = 0;
    public Boolean hasNext {get; set;}
    public Boolean hasPrevious {get; set;}
   
    public RetrieveWorkFLowMetaData(){ 
        workFlowList = new List<RetrieveWorkFLowMetaData.WorkFlowItems>();
        if(workFlowList.isEmpty()){
            getRetrieveWorkFLowMetaData();
        }
        getworkFlows();
        hasPrevious = false;
    }
    
    public void getworkFlows()
    {
        workFlowMetaResult = new List<RetrieveWorkFLowMetaData.WorkFlowItems>();
        for(Integer i = count ; i < targetSize ; i++)
        {   
            if(i < workFlowList.size())
            {
                workFlowMetaResult.add(workFlowList[i]);
            }
        }
        setNextAndPrevious();
    }
    
    public void getRetrieveWorkFLowMetaData(){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v34.0/tooling/query/?q=Select+name,fullname,metadata+from+WorkflowRule');
        req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        string json2 = res.getBody(); 
        WorkFlowMeta lst_workflow = (WorkFlowMeta) Json.deserialize(json2, WorkFlowMeta.class);
        workFlowList = lst_workflow.records;
        if(workFlowList != null && !workFlowList.isEmpty()){
            for(RetrieveWorkFLowMetaData.WorkFlowItems worlFlowItem : workFlowList){
                worlFlowItem.objectName = worlFlowItem.FullName.subStringBefore('.');
            }
        }
        workFlowList.sort();
    } 
    
    public pageReference exportworkflow(){
        
        PageReference pr = new PageReference('/apex/Workflowsexport');
         pr.setRedirect(true);
         return pr;
    }
       
    public class WorkFlowMeta{
       public WorkFlowItems[] records{get; set;}
       public WorkFlowMeta(WorkFlowItems[] records){
           this.records = records;
       }
    }
   
    public class WorkFlowItems implements Comparable{ 
        public String Name{get; set;}
        public String FullName{get; set;}
        public WorkFlowItemInfo metadata{get; set;}
        public String objectName {get; set; }
        
        public WorkFlowItems(String Name, String FullName, WorkFlowItemInfo metadata, String objectName){
            this.name = name;
            this.fullName = fullName;
            this.metadata = metadata;
            this.objectName = objectName;       
        }
        
        public Integer compareTo(Object fieldCompareTo){
            WorkFlowItems compareFieldTo =(WorkFlowItems) fieldCompareTo;
            if(Name<compareFieldTo.Name){
                return -1;
            }
            else if(Name>compareFieldTo.Name){
                return 1;
            }
            else{
                return 0;
            }
        }
    }
    
    public class WorkFlowItemInfo {
        public String formula{get; set;}
        public boolean active{get; set;}
        public String description{get; set;}
        public String triggerType{get; set;}
        public List<RuleCriteriaItem> criteriaItems {get; set;}
        public List<WorkFlowAction> actions {get; set;}
        public List<WorkFlowTimeTrigger> workflowTimeTriggers {get; set;}
        public WorkFlowItemInfo(String formula, boolean active, String description, String triggerType){
            this.formula = formula;
            this.active = active;
            this.description = description;
            this.triggerType = triggerType;
        }
    }
    
    public virtual void getNextCount()
    {
        count = targetSize;
        targetSize = targetSize+ pageSize; 
        getworkFlows();
    }
    
    public virtual void getPreviousCount()
    {
        targetSize = targetSize - pageSize;
        count = targetSize - pageSize;
    }
    
    public  virtual void setNextAndPrevious()
    {
        if(targetSize >= workFlowList.size())
        {   
            hasNext = false;
            hasPrevious = true;
        }
        else if(count == 0)
        {
            hasPrevious = false;
            hasNext = true;
        }
        else if(targetSize < workFlowList.size())
        {
            hasNext = true;
            hasPrevious = true;
        }
    }

    
    public class WorkFlowTimeTrigger 
    {
        public List<WorkFlowAction> actions {get; set;}
    }
    
    public class WorkFlowAction
    {
        public String name {get; set;}
        public String type {get; set;}
    }
    
    public class RuleCriteriaItem
    {
        public String field {get; set;}
        public String operation {get; set;}
        public String value {get; set;}
    }
}