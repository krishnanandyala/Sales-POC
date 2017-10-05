public class DataDictFieldsController{
Public boolean rend{get;set;}
public Boolean CheckIns { get; set; }
Public List<FieldDefinition> lst{get;set;}
public List<SelectOption> objects{get;set;}
public List<Wrapper> Wrapperlst{get;set;}
public String sel{ get; set; }
public string abcd{get;set;}
    public DataDictFieldsController(){
     objects = new List<SelectOption>();
    List<EntityDefinition> ed =[SELECT DeveloperName,QualifiedApiName FROM EntityDefinition];
    ed.sort();
    objects.add(new SelectOption('--None--','--None--'));
        for(EntityDefinition sel: ed)
        {
        objects.add(new SelectOption(sel.QualifiedApiName,sel.QualifiedApiName));
        }
        readContentFields();
    }
    public void readContentFields(){
        Wrapperlst = new List<Wrapper>();
        fetch();
    }
    public pagereference fetch(){
        lst = [SELECT EntityDefinitionId,IsIndexed,NamespacePrefix,Label,DeveloperName,DataType,MasterLabel,ControllingFieldDefinitionId,QualifiedApiName,IsFieldHistoryTracked,ReferenceTargetField FROM FieldDefinition WHERE EntityDefinitionId =: sel];
        for(FieldDefinition fd:lst){            
            Wrapperlst.add(new wrapper(fd));
            }   
            try{
            MetadataService.MetadataPort service = createService();
            MetadataService.CustomObject custobj=(MetadataService.CustomObject) service.readMetadata('CustomObject', new String[] {sel}).getRecords()[0];
            List<MetadataService.CustomField> flds =custobj.fields;         
            for(MetadataService.CustomField fld:flds)
            { 
            for(wrapper lwr:Wrapperlst)
            {
                if(lwr.fd.QualifiedApiName==fld.fullname)
                    {
                        lwr.description=fld.description;
                        lwr.inlineHelpText=fld.inlineHelpText;
                    }
                    
                }
            }
             
            }
            Catch(Exception e){ system.debug('fail'+e.getMessage());}            
            
            for(wrapper lwr:Wrapperlst)
             {
            if((lwr.fd.QualifiedApiName.contains('__c'))||(lwr.fd.QualifiedApiName.contains('__pc')))
                    {
                    lwr.stdOrCust='Custom';
                    System.debug('@@@'+lwr.fd.QualifiedApiName);
                    }
                    else
                    {
                      lwr.stdOrCust='Standard';
                    }
                    system.debug('@@@+'+lwr.fd.QualifiedApiName);
                    }
                    return null;
           }    
    public PageReference export() {
        rend = true;
         abcd = 'application/vnd.ms-excel#Demo.xls';
        return null;
    }    
    public static MetadataService.MetadataPort createService(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    public class wrapper{
        public FieldDefinition fd{get;set;}
        public String description{get;set;}
        public String inlineHelpText{get;set;}
        public String stdOrCust{get;set;}
        public wrapper(FieldDefinition fld){
            fd = fld;
        } 
    }
    /*public Boolean getCheckIns()
    {
        CheckIns=true;
        return CheckIns;
    }*/
    
}