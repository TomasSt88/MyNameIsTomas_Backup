public class AccountHandler {
    
    public static void insertAccount(Integer numberOfAccounts){
        Integer accCounter = 1;
        List<Account> addAccounts = new List<Account>();
        while(accCounter <= numberOfAccounts){
            Account acc = new Account();
            acc.name = 'Acme Inc' + accCounter.toString() ;
            acc.AccountNumber = 'A000'+accCounter.toString();
            addAccounts.add(acc);
            accCounter++;
            System.debug(addAccounts);
        }
        insert addAccounts;
    }
    
     public static void orderTea(){
        Map <String, String> teaTypes = new Map <String, String>();
        teaTypes.put('Black', 'Earthy');
        teaTypes.put('White', 'Sweet');
        teaTypes.put('Herbal', 'Sweet');
        system.debug(teaTypes);
    }
    
    public static String orderTeaGet(){
        Map <String, String> teaTypes = new Map <String, String>();
        teaTypes.put('Black', 'Earthy');
        teaTypes.put('White', 'Sweet');
        teaTypes.put('Herbal', 'Sweet');
        String flavorProfile = teaTypes.get('Herbal');
        System.debug('The flavorProfile of Herbal is: ' + flavorProfile);
        return flavorProfile;
	}
}