public with sharing class ProductsController {
    public ProductsController() {

    }

    @AuraEnabled
    public static string getAllProducts() {
        ProductService service = new ProductService();

        Wrappers.GetProductsWrapper products = service.getAllActiveProducts(1, 0, '', null);

        return JSON.serialize(products);
    }

    @AuraEnabled
    public static string getOpportunityProducts(string opportunityId) {
        ProductService service = new ProductService();

        Wrappers.GetProductsWrapper products = service.getOpportunityProducts(1, 0, null, opportunityId);

        return JSON.serialize(products);
    }
}
