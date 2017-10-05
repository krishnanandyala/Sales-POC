public class AccountTeamController {
public List<AccountTeamMember> teamsList{get;set;}
public List<Profile> proflist{get;set;}
Public boolean rend{get;set;}
public string abcd{get;set;}
public List<AccountTeamMember> getTeams()
{
    teamsList=[SELECT AccountAccessLevel,UserId,CaseAccessLevel,ContactAccessLevel,OpportunityAccessLevel,TeamMemberRole FROM AccountTeamMember];
    return teamsList;
}
public List<Profile> getprofiles()
{
    proflist=[SELECT Name,PermissionsManageUsers,UserType FROM Profile];
    return proflist;
}
public PageReference export() {
        rend = true;
         abcd = 'application/vnd.ms-excel#Demo.xls';
        return null;
    }  
}