trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if(Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
            if(opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
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

/*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */