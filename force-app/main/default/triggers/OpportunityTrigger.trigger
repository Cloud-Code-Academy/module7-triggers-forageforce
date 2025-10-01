trigger OpportunityTrigger on Opportunity (before update, before delete, after delete) {
    if(trigger.isBefore && trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
            if(opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    if(Trigger.isDelete && Trigger.isBefore) {
        List<Opportunity> myOpps = [SELECT Id, StageName,Account.industry FROM Opportunity WHERE Id IN :Trigger.old];
        for (Opportunity opp : myOpps) {
            //Store Account Id from Opportunity
            if(opp.StageName == 'Closed Won' && opp.Account.Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
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