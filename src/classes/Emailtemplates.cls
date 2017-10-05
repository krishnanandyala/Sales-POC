public class Emailtemplates {
   // public string emailTemp {set;get;}
      public List<EmailTemplate> etem {set;get;}
      public List<EmailTemplate> emailTemp {set;get;} 
    public  Emailtemplates(){
        emailTemp = [SELECT ApiVersion,Body,BrandTemplateId,CreatedById,CreatedDate,Description,DeveloperName,Encoding,FolderId,HtmlValue,Id,IsActive,LastModifiedById,LastModifiedDate,LastUsedDate,Markup,Name,NamespacePrefix,OwnerId,RelatedEntityType,Subject,SystemModstamp,TemplateStyle,TemplateType,TimesUsed,UiType FROM EmailTemplate];   
    }
   
    public pageReference ExportTemplates(){
        PageReference pageRef = new PageReference('/apex/exportEmailTemplates');
        pageRef.setRedirect(false);
        Return pageRef;
        
    }
}