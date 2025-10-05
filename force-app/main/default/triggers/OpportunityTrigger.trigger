trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
            if(opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : Trigger.new) {
            if(opp != null && opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        
        Map<Id,Account> myIdsToAccounts = new Map<Id,Account>([SELECT Id, Name, (SELECT Id, FirstName FROM Contacts WHERE Title = 'CEO') FROM Account WHERE Id IN :accountIds]);
        for (Opportunity opp : Trigger.new) {
        Account acc = myIdsToAccounts.get(opp.AccountId);
            if (acc != null && acc.Contacts != null) {
                Contact ceoContact = acc.Contacts[0];
                opp.Primary_Contact__c = ceoContact.Id;
            }
        }
    }
    
    if(Trigger.isBefore && Trigger.isDelete) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : Trigger.old) {
            if (opp.StageName == 'Closed Won' && opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        Map<Id,Account> myIdsToAccounts = new Map<Id,Account>([SELECT Id,Industry FROM Account WHERE Id IN :accountIds]);
        for (Opportunity opp : Trigger.old) {
            if(opp.StageName == 'Closed Won') {
                Account acc = myIdsToAccounts.get(opp.AccountId);
                if(acc.Industry == 'Banking') {
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }
}