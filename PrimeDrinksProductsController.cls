public with sharing class PrimeDrinksProductsController {
    public PrimeDrinksProductsController() {

    }

    @AuraEnabled
    public static string getAllProducts() {
        PrimeDrinksProductService service = new PrimeDrinksProductService();

        Wrappers.GetProductsWrapper products = service.getAllActiveProducts(1, 0, '', null);

        return JSON.serialize(products);
    }

    @AuraEnabled
    public static string getOpportunityProducts(string opportunityId) {
        PrimeDrinksProductService service = new PrimeDrinksProductService();

        Wrappers.GetProductsWrapper products = service.getOpportunityProducts(1, 0, null, opportunityId);

        return JSON.serialize(products);
    }
}