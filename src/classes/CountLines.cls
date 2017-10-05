global class CountLines {
	Private Integer classLines = 0;
	Private Integer triggerLines = 0;
	
    global CountLines(){
        for(ApexClass a : [Select Body From ApexClass]){
        List<String> lines = a.Body.split('\n');
        this.classLines += lines.size();
    	}
        
        for(ApexTrigger a : [Select Body From ApexTrigger]){
		List<String> lines = a.Body.split('\n');
		this.triggerLines += lines.size();
		}
    }

    public Integer getApexClassLines(){
        return this.classLines;
    }
    
    public Integer getApexTriggerLines(){
        return this.triggerLines;
    }

}