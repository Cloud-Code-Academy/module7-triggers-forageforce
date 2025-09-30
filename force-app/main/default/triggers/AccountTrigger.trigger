trigger AccountTrigger on Account (Before insert) {
    for(Account acc : Trigger.new)
        if (acc.Type == Null) {
        acc.Type = 'Prospect';
    }
}