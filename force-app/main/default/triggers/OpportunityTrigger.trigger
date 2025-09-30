trigger OpportunityTrigger on Opportunity (before update) {
    for (Opportunity opp : trigger.new) {
        if(opp.Amount < 5000) {
            opp.addError('Opportunity amount must be greater than 5000');
        } 
    }
}

/*
    * Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */