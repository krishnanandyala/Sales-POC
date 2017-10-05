public class ApprovalProcess {
    public List<ProcessDefinition> approvaltemp {get;set;}
    Public boolean rend{get;set;}
    public string abcd{get;set;}
    public List<pdwrapper> pdWrapperList{get;set;}
    public List<String> ls{get;set;}
    public ApprovalProcess(){
    pdWrapperList = new List<pdwrapper>(); 
        try{
        approvaltemp = [SELECT CreatedById,CreatedDate,Description,DeveloperName,Id,LastModifiedById,LastModifiedDate,LockType,Name,State,SystemModstamp,TableEnumOrId,Type FROM ProcessDefinition WHERE Type = 'approval' ORDER BY Name ASC NULLS FIRST];
        for(ProcessDefinition pd:approvaltemp){
            pdWrapperList.add(new pdwrapper(pd));
        }
        system.debug(pdWrapperList.size());
        MetadataService.MetadataPort service1 = createService();
        MetadataService.ListMetadataQuery listMetaQuery = new MetadataService.ListMetadataQuery();
        listMetaQuery.type_x = 'ApprovalProcess';
        MetadataService.ListMetadataQuery[] listMeatArr = new MetadataService.ListMetadataQuery[]{};
        listMeatArr.add(listMetaQuery);
        MetadataService.FileProperties[] fieldProp = (MetadataService.FileProperties[]) service1.listMetadata(listMeatArr, 40);
        List<String> flowNamesList = new List<String>();
        for(MetadataService.FileProperties flp : fieldProp)
        {
            flowNamesList.add(flp.fullName);
        }
        List<MetadataService.ApprovalProcess> flowDetailList = (MetadataService.ApprovalProcess[]) service1.readMetadata('ApprovalProcess', flowNamesList).getRecords();
        for(MetadataService.ApprovalProcess app : flowDetailList)
        {
            for(pdwrapper pdw : pdWrapperList)
            {
                String fieldsUsedInCriteria;
                if(pdw.pd.name == app.label)
                {
                    for(MetadataService.FilterItem appro : app.entryCriteria.criteriaItems)
                    {
                        if(fieldsUsedInCriteria != null){
                                fieldsUsedInCriteria += ', ' + appro.field ;
                        }
                        else{
                            fieldsUsedInCriteria = appro.field;
                        } 
                    }
                    pdw.fi = fieldsUsedInCriteria;
                } 
            }
        }
     }
      catch(Exception e){}
       
    }
     
    public pageReference Export(){
        rend=false;
        PageReference pr = new PageReference('/apex/ExportApprovalprocess');
        pr.setRedirect(false);
        return pr;


    }
    public static MetadataService.MetadataPort createService(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
     public class pdwrapper{
        public ProcessDefinition pd{get;set;}
        public String fi{get;set;}
        public pdwrapper(ProcessDefinition prodef){
            pd = prodef;

        } 
        }
}