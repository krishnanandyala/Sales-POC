public class ddtestcon {
Public boolean rend{get;set;}
Public List<FieldDefinition> lst{get;set;}
public List<SelectOption> objects{get;set;}
public List<String> PgLayots{get;set;}
public List<Wrapper> Wrapperlst{get;set;}
public String sel{ get; set; }
public string abcd{get;set;}
String qa;
List<EntityDefinition> ed;
    public ddtestcon(){
        objects = new List<SelectOption>();
        ed =[SELECT QualifiedApiName,DurableId FROM EntityDefinition where IsApexTriggerable=true];

        ed.sort();
        objects.add(new SelectOption('--None--','--None--'));
            for(EntityDefinition sel: ed){
            objects.add(new SelectOption(sel.DurableId ,sel.QualifiedApiName));
            }
            readLayoutcont();
    }
    public void readLayoutcont(){
        Wrapperlst = new List<Wrapper>();
        PgLayots = new List<string>();  
       fetch();
    }

    public pagereference fetch(){
            system.debug(sel);
        for(EntityDefinition e:ed){
            if(sel== e.DurableId){
                qa= e.QualifiedApiName;
            }
        }
        system.debug(qa+'asdfghjk');
        lst = [SELECT EntityDefinitionId,Label,DeveloperName,DataType,QualifiedApiName,IsFieldHistoryTracked,ReferenceTargetField FROM FieldDefinition WHERE EntityDefinitionId =: sel];
        for(FieldDefinition fd:lst){Wrapperlst.add(new wrapper(fd));}
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        req.setEndpoint('https://ecrsdomain--mdd.cs14.my.salesforce.com/services/data/v40.0/tooling/query/?q=Select+name+from+layout+where+EntityDefinitionId+=+\''+sel+'\'');
        req.setMethod('GET');
   
        Http h = new Http();
        HttpResponse res = h.send(req);
        string json2 = res.getBody();
        system.debug(json2);
        system.debug(qa);
        system.debug(sel);
        JSONParser parser = JSON.createParser(json2);
        parser.nextToken();
        while (parser.nextToken() != null) {
            if(parser.getText() == 'Name'){
                parser.nextToken();
                String fieldValue = parser.getText();
                PgLayots.add(fieldValue);
                system.debug(fieldValue);
            }
        }
        
        Integer i = 0;
        try{
        for(string s:PgLayots){
        
        MetadataService.MetadataPort service = createService();
        MetadataService.Layout layout = (MetadataService.Layout) service.readMetadata('Layout', new String[] { qa+'-'+s }).getRecords()[0];
        List<MetadataService.LayoutSection> Sections =layout.LayoutSections;
        List<List<MetadataService.LayoutColumn>> Columns = new List<List<MetadataService.LayoutColumn>>();
        List<MetadataService.LayoutColumn> Column = new List<MetadataService.LayoutColumn>();
        List<List<MetadataService.LayoutItem>> items = new List<List<MetadataService.LayoutItem>>();
        List<MetadataService.LayoutItem> item = new List<MetadataService.LayoutItem>();
            for(MetadataService.LayoutSection cs:Sections){
                    columns.add(cs.LayoutColumns);
            }
            for(List<MetadataService.LayoutColumn> col:Columns){
                for(MetadataService.LayoutColumn co:col){
                    column.add(co);}
            }
            for(MetadataService.LayoutColumn colm:Column){
                    items.add(colm.LayoutItems);
            }
            for(List<MetadataService.LayoutItem> it:items){
            if(it!=null){
                for(MetadataService.LayoutItem itm:it){
                    item.add(itm);}
            }}
            for(MetadataService.LayoutItem lit:item){
                for(wrapper wr:Wrapperlst){
                    if(wr.fd.Qualifiedapiname == lit.field){
                        if(i == 0){
                        wr.isli = lit.field;
                        }
                        if(i == 1){
                        wr.isli1 = lit.field;
                        }
                        if(i == 2){
                        wr.isli2 = lit.field;
                        }
                        if(i == 3){
                        wr.isli3 = lit.field;
                        }
                        if(i == 4){
                        wr.isli4 = lit.field;
                        }
                        if(i == 5){
                        wr.isli5 = lit.field;
                        }
                        if(i == 6){
                        wr.isli6 = lit.field;
                        }
                        if(i == 7){
                        wr.isli7 = lit.field;
                        }
                        if(i == 8){
                        wr.isli8 = lit.field;
                        }
                        if(i == 9){
                        wr.isli9 = lit.field;
                        }
                        if(i == 10){
                        wr.isli10 = lit.field;
                        }
                        if(i == 11){
                        wr.isli11 = lit.field;
                        }
                        if(i == 12){
                        wr.isli12 = lit.field;
                        }
                        if(i == 13){
                        wr.isli13 = lit.field;
                        }
                        if(i == 14){
                        wr.isli14 = lit.field;
                        }
                        if(i == 15){
                        wr.isli15 = lit.field;
                        }
                        if(i == 16){
                        wr.isli16 = lit.field;
                        }
                        if(i == 17){
                        wr.isli17 = lit.field;
                        }
                        if(i == 18){
                        wr.isli18 = lit.field;
                        }
                        if(i == 19){
                        wr.isli19 = lit.field;
                        }
                        if(i == 20){
                        wr.isli20 = lit.field;
                        }
                        if(i == 21){
                        wr.isli21 = lit.field;
                        }
                        if(i == 22){
                        wr.isli22 = lit.field;
                        }
                        if(i == 23){
                        wr.isli23 = lit.field;
                        }
                    }
                }
            }i++;}}catch(exception e){}
        try{
       MetadataService.MetadataPort service = createService();
       MetadataService.Workflow Workflow= (MetadataService.Workflow) service.readMetadata('Workflow', new String[] { 'Contact' }).getRecords()[0];
       List<MetadataService.WorkflowFieldUpdate> fieldUpdates= Workflow.fieldUpdates;
       for(MetadataService.WorkflowFieldUpdate wf:fieldUpdates){
         for(wrapper wr:Wrapperlst){
        if(wr.fd.Qualifiedapiname == wf.field){
           wr.fieldUpdates = wf.fullname;
           }}}}catch(exception e){}
        /*try{
        MetadataService.MetadataPort service = createService();
        MetadataService.Workflow Workflow= (MetadataService.Workflow) service.readMetadata('Workflow', new String[] { 'Contact' }).getRecords()[0];
        List<MetadataService.WorkflowAlert> WorkflowAlerts = Workflow.alerts;
       List<List<MetadataService.WorkflowEmailRecipient>> Wfrecipient = new List<List<MetadataService.WorkflowEmailRecipient>>();
       List<MetadataService.WorkflowEmailRecipient> recipients = new List<MetadataService.WorkflowEmailRecipient>();
       List<String> s = new List<String>();
       for(MetadataService.WorkflowAlert wfa:WorkflowAlerts){
           Wfrecipient.add(wfa.recipients);
       }
       for(List<MetadataService.WorkflowEmailRecipient> lst:Wfrecipient ){
        for(MetadataService.WorkflowEmailRecipient r:lst){
            recipients.add(r);
        }
       }
       for(MetadataService.WorkflowEmailRecipient fld:recipients ){
          // system.debug(fld.field);
          for(wrapper wr:Wrapperlst){
        if(wr.fd.Qualifiedapiname == fld.field){
           wr.emailAlerts = 'True';
           }}
       }}catch(exception e){}*/
            return null;
        }
    
    public PageReference export() {
        rend = true;
         abcd = 'application/vnd.ms-excel#Demo excel sheet.xls';
        return null;
    }
    
    public static MetadataService.MetadataPort createService(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    @TestVisible
    public class wrapper{
        public FieldDefinition fd{get;set;}
        public String isli{get;set;}
        public String isli1{get;set;}
        public String isli2{get;set;}
        public String isli3{get;set;}
        public String isli4{get;set;}
        public String isli5{get;set;}
        public String isli6{get;set;}
        public String isli7{get;set;}
        public String isli8{get;set;}
        public String isli9{get;set;}
        public String isli10{get;set;}
        public String isli11{get;set;}
        public String isli12{get;set;}
        public String isli13{get;set;}
        public String isli14{get;set;}
        public String isli15{get;set;}
        public String isli16{get;set;}
        public String isli17{get;set;}
        public String isli18{get;set;}
        public String isli19{get;set;}
        public String isli20{get;set;}
        public String isli21{get;set;}
        public String isli22{get;set;}
        public String isli23{get;set;}
        public String isli24{get;set;}
        public String emailAlerts{get;set;}
        public String fieldUpdates{get;set;}
        public String recordTypes{get;set;}
        
        public wrapper(FieldDefinition fld){
            fd = fld;
        } 
    }
    
}