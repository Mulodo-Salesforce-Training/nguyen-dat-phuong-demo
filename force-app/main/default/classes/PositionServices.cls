public class PositionServices {

    /**
     * Count Position by name
     */
    public Integer countByName(String name) {
        return [SELECT count()FROM Position__c WHERE Name = : name];
    }
}