public with sharing class  apexClassesTriggerNamecntrl{

    public PageReference exprtexcel() {
  PageReference nextpage = new PageReference('/apex/ExcelReportPage');
return nextpage;
    }

public String cquery;
public string header{get;set;}
public Contact cloneContact{get;set;}
public String Selobj{get;set;}
public List<ApexClass> classNames{set;get;}
public List<Schema.SObjectField> strng{get;set;}
public List<ApexClass> apexclassList{get;set;}
public List<ApexTrigger> triglist {get;set;}
public string Filetype{get;set;}
public boolean isExcel {get;set;}
public boolean isCsv {get;set;} 
public String exportExcel{get;set;} 
public boolean hideDetails{get;set;} 
List<String> sobj{get;set;}

 public apexClassesTriggerNamecntrl(){
Selobj=null;
            Filetype = '';
            header = ' \r\n';
            hideDetails=true;                   
            Apexclssc();
           
}
    public List<SelectOption> getObjects(){ 
 
      
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('--Select Object--','--Select Object--'));           
            for ( Schema.SObjectType o : Schema.getGlobalDescribe().values() )
        {
            Schema.DescribeSObjectResult objResult = o.getDescribe();
            system.debug( 'Sobject: ' + objResult );
            system.debug( 'Sobject API Name: ' + objResult.getName() );
            system.debug( 'Sobject Label Name: ' + objResult.getLabel() );  
            options.add(new SelectOption(objResult.getName(),objResult.getLabel()));
        }
        return options;        
    } 
   public List<String> getsobj(){ 
    sobj = new List<String>();
            for ( Schema.SObjectType o : Schema.getGlobalDescribe().values() )
        { 
        Schema.DescribeSObjectResult objResult = o.getDescribe();
            sobj.add(objResult.getName());
        }
        return sobj;          
    } 
   
   
    public void  Apexclssc(){ 
        apexclassList = new List<ApexClass>();
        apexclassList = [SELECT ID,Name,NamespacePrefix,Status,IsValid  from ApexClass];
        
          
    }
    
    
      public void exportData()
      {
          hideDetails = false;
          exportExcel = 'application/vnd.ms-excel#DataDictionary.xls';
      }     
      
   }