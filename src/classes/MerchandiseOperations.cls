public class MerchandiseOperations {

    public static ID invoice(String pName, Integer pSold, String pDesc) {

        Merchandise__c m = [SELECT Price__c, Total_Inventory__c
            FROM Merchandise__c WHERE Name = :pName LIMIT 1];

        System.assertNotEquals(null, m);

        Invoice_Statement__c i = new Invoice_Statement__c(
            Description__c = pDesc);

        insert i;

        Line_Item__c li = new Line_Item__c(
            Name = '1', Invoice_Statement__c = i.id,
            Merchandise__c = m.id, Unit_Price__c = m.Price__c,
            Units_Sold__c = pSold);

        m.Total_Inventory__c -= pSold;
        update m;
        return i.Id;

    }
}