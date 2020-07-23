public with sharing class PrimeDrinksOppProductsService extends GenericSelector {
    public class OppProductServiceException extends Exception{}

    public PrimeDrinksOppProductsService() {
        super('OpportunityLineItem');
    }

    public Set<String> getOppProductIds(Id opptyId) {
        List<String> whereClauses = new List<String>{'OpportunityId=\'' + opptyId + '\''};
        return this.buildSelectableData('Product2Id', '', false, whereClauses, null, true);
    }

    public Wrappers.GetOppProductsWrapper getOpportunityProducts(Integer pageNumber, Integer pageSize, String productName, Id opportunityId) {
        Wrappers.GetOppProductsWrapper productsData = new Wrappers.GetOppProductsWrapper();
        try {
            //List<OpportunityLineItem> products = [Select Id, Quantity, UnitPrice, Product2.Name from OpportunityLineItem where OpportunityId = :opportunityId];
            List<String> selectableFields = new List<String>{'Id','Quantity', 'UnitPrice', 'Product2.Name'};
            List<String> orderBy = new List<String>{'UnitPrice'};
            List<String> whereClauses = new List<String>{'OpportunityId=\'' + opportunityId +'\''};
            List<OpportunityLineItem> products = (OpportunityLineItem[])this.selectRecords(pageNumber, pageSize, productName, null, selectableFields,whereClauses, orderBy, null);
            if (products.isEmpty()) {
                 throw new OppProductServiceException('getOpportunityProducts Error: ' + 'no active products found');
            }
            productsData.Products = products;
            productsData.TotalData = this.count(whereClauses,null);
        }
        catch (Exception ex) {
            throw ex;
        }

        return productsData;
    }
}