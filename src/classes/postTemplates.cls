public class postTemplates {
  //  public List<string> tempstr{get;set;}
    public MetadataService.PostTemplate [] postTemplates{get;set;}
    public List<PostTemplateJSON> lst_posttemp {get;set;}
    
 
    public PageReference postTemplatesVal(){
    try{
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
        queryWorkflow.type_x = 'PostTemplate';
        queries.add(queryWorkflow);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries,39);
        List<String> lst_names=new List<String>();
        for(MetadataService.FileProperties fileProperty : fileProperties){
        System.debug('-------------->'+fileProperty.fullName);
        lst_names.add(fileProperty.fullName);
        }
        system.debug('----lst_names------'+lst_names);
        postTemplates = new List<MetadataService.PostTemplate>();
        //postTemplates = (MetadataService.PostTemplate[])service.readMetadata('PostTemplate', new String[]{'Account.Account_Post_template'}).getRecords();
         postTemplates = (MetadataService.PostTemplate[])service.readMetadata('PostTemplate',lst_names).getRecords();
        System.debug('Listof postTemplates information ---->'+postTemplates );
           lst_posttemp= new List<PostTemplateJSON>();
             for(MetadataService.PostTemplate pt: postTemplates){
                 PostTemplateJSON rec = new PostTemplateJSON();
                 rec.fullName= pt.fullName;
                 rec.defaultval= pt.default_x;
                 rec.description= pt.description;
                 rec.label= pt.label;
                 rec.fields= pt.fields;
                 lst_posttemp.add(rec);
             } 
             }catch(Exception e){}
             return null; 
    }
    public pageReference ExportPostTemplates(){
         PageReference pr = new PageReference('/apex/posttemplatesexport');
         pr.setRedirect(false);
         return pr;
    }
    
}