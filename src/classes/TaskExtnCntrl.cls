public with sharing class TaskExtnCntrl {

List<Task> tasklist {get;set;}
 public String exportExcel{get;set;} 
 public boolean isExport{get;set;}
    

    public TaskExtnCntrl (){
         tasklist=[ SELECT id,Status,Priority,IsHighPriority,ActivityDate, Description, Subject,What.Type ,who.name FROM Task];
    //return tasklist; 
    }
    
     
    
    public List<Task> getTasklist() {

     tasklist=[ SELECT id,Status,Priority,IsHighPriority,ActivityDate, Description, Subject,What.Type ,who.name FROM Task];
    return tasklist;
    } 
    public PageReference exportData()
      {
          isExport = true;
          exportExcel = 'application/vnd.ms-excel#DataDictionary.xls';
          return null;
      }
    public pageReference fetchTasks(){
        
        return null;
    }


    
}