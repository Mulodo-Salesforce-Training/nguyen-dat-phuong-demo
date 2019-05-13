public class PositionTriggerHandler {

    public PositionTriggerHandler(PositionServices positionServices) {
        this.positionServices = positionServices;
    }

    /**
     * Validation duplicate Position name insert
     */
    public void beforeInsert(List<Position__c> newPositions) {
        Integer count = positionServices.countByName(newPositions[0].Name);
        if (count > 0) {
            newPositions[0]
                .Name
                .addError('Position Name Already Exist');
        }
    }

    /**
     * Validation duplicate Position name update
     */
    public void beforeUpdate(
        List<Position__c> newPositions,
        List<Position__c> oldPositions
    ) {
        if (!newPositions[0].Name.equals(oldPositions[0].Name)) {
            beforeInsert(newPositions);
        }
    }

    private PositionServices positionServices;

}