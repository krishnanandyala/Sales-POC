public with sharing class orgClass {
    private String instanceName;
    private String organizationType;
    private String orgId;
    private String orgName; 
    private String primaryLastName;
    private String primaryFirstName;
    private String phone; 
    
    public void setPhone(String phone){
    	this.phone = phone;
    } 
    public String getPhone(){
    	return this.phone;
    }
    
    public void setInstanceName(String instanceName){
    	this.instanceName = instanceName;
    }
    public String getInstanceName(){
    	return this.instanceName;
    }
    public void setOrganizationType(string organizationType){
    	this.organizationType = organizationType;
    }
    public String getOrganizationType(){
    	return this.organizationType;
    }
    public void setOrgId(String orgId){
    	this.orgId = orgId;
    }
    public String getOrgId(){
    	return this.orgId;
    }
    public void setOrgName(String orgName){
    	this.orgName = orgName;
    }
    public String getOrgName(){
    	return this.orgName;
    }
    public void setPrimaryLastName(String primaryLastName){
    	this.primaryLastName = primaryLastName;
    }
    public String getPrimarylastName(){
    	return this.primaryLastName;
    }
    public void setPrimaryFirstName(String primaryFirstName){
    	this.primaryFirstName = primaryFirstName;
    }
    public String getPrimaryFirstName(){
    	return this.primaryFirstName;
    }
    public void setName(String fullName){
    	if (fullName != null){
    		String[] nameSplit = fullName.split(' ');
    		this.primaryFirstName = nameSplit[0];
    		this.primaryLastName = nameSplit[nameSplit.size() -1]; 
    	}
    }
    
    public orgClass(Organization newOrg){
    	this.instanceName = newOrg.InstanceName;
	    this.organizationType = newOrg.OrganizationType;
	    this.orgId = newOrg.Id;
	    this.orgName = newOrg.Name; 
	    if (newOrg.PrimaryContact != null){
    		String[] nameSplit = newOrg.PrimaryContact.split(' ');
    		this.primaryFirstName = nameSplit[0];
    		this.primaryLastName = nameSplit[nameSplit.size() -1]; 
    	}
	    this.phone = newOrg.Phone;
    }
    
}