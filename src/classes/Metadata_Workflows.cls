public class Metadata_Workflows{
   public MetadataService.WorkFlow[] WorkFlows{get;set;}  
   public List<Metadata_Workflows.cls_records> workFlowList {get;set;}
   
    public Metadata_Workflows(){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        req.setEndpoint('https://ecrsdomain--mdd.cs14.my.salesforce.com/services/data/v34.0/tooling/query/?q=Select+name,fullname,metadata+from+WorkflowRule');
        req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        string json2 = res.getBody(); 
        WorkFlowMeta lst_workflow = (WorkFlowMeta) Json.deserialize(json2, WorkFlowMeta.class);
        workFlowList = lst_workflow.records;
        if(workFlowList != null && !workFlowList.isEmpty()){
            for(Metadata_Workflows.cls_records worlFlowItem : workFlowList){
                worlFlowItem.objectName = worlFlowItem.FullName.subStringBefore('.');
            }
        }
        workFlowList.sort();
   }  
   public pageReference Exportworkflow(){
        PageReference pr = new PageReference('/apex/Workflowsexport');
         pr.setRedirect(false);
         return pr;
   }
       
   public class WorkFlowMeta
   {
       public cls_records[] records{get; set;}

   }
   
   public class cls_records implements Comparable{ 
        public String Name{get; set;}
        public String FullName{get; set;}
        public cls_Metadata metadata{get; set;}
        public String objectName {get; set; }
        public Integer compareTo(Object fieldCompareTo){
        cls_records compareFieldTo =(cls_records) fieldCompareTo;
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

    
    public class cls_Metadata {
        public String formula{get; set;}
        public boolean active{get; set;}
        public String description{get; set;}
        public String triggerType{get; set;}
    }
}