public class AccountUtility {
    public static void viewAnnualRevenue(){
        List<Account> accountsList = [SELECT Name, AnnualRevenue FROM Account];
        System.debug(accountsList);
        for(Account acc: accountsList){
            String acctRev = (acc.Name + ' : ' + acc.AnnualRevenue);
            System.debug('acctRev' + acctRev);
        }
    }
}