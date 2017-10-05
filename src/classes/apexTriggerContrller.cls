public with sharing class  apexTriggerContrller{
public List<ApexTrigger> triglist {get;set;}
public String exportExcel{get;set;} 
public boolean hideDetails{get;set;} 
 public apexTriggerContrller(){
            hideDetails=true;                   
            Trigg();
}       
      public void exportData()
      {
          hideDetails = false;
          exportExcel = 'application/vnd.ms-excel#DataDictionary.xls';
      }
      public void Trigg(){
      triglist=[SELECT Name, TableEnumOrId, NamespacePrefix, ApiVersion, Status, IsValid FROM ApexTrigger];
System.debug('$$$Triglist'+triglist);      
      }
}