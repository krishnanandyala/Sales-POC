public class Metadata_Flows{
    private static List<records> coverlist = new List<records>();
    private static Jsondat jd = new Jsondat(); 
    Public List<records> wrapper {get;set;}
    List<Constructors> tempconstructors = new List<Constructors>();
    Public Map<String,String> className {get;set;}
    Public Metadata_Flows(){
        wrapper = new List<records>();
        
        basicAuthCallout();
        className  = new Map<String,String>();
    }
    public class Jsondat
    {
        Public List<records> records {get;set;}
        
        
    }
    Public class SymbolTable {
        Public List<Constructors> constructors{get;set;}
    
    }
    Public class Constructors {
        Public String Name {get;set;}
    
    }
    public class records
    {
        Public String Id {get;set;}
        Public String fullname{get;set;}
       
    }
    public void basicAuthCallout()
    {
       

 
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(URL.getSalesforceBaseURL().toExternalForm()+'/services/data/v37.0/tooling/query/?q=Select+DefinitionId,FullName,ProcessType,Status+from+Flow');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);      
        system.debug('/////////////////'+res.getBody());
        jd = (Jsondat) System.JSON.deserialize(res.getBody(),Jsondat.class); 
        
        for(records data : jd.records) {
           
            data.fullname= data.fullname; 
            
             wrapper.add(data );
        }
        system.debug('////////////'+wrapper);
        
    }
    
   
   
}