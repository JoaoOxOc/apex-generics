public with sharing class ProductService  extends GenericSelector {
    public class ProductServiceException extends Exception{}
    public ProductService() {
        super('Product2');
    }

    public Product2 getProductById(String productId) {
        Product2 getById = null;
        try {
            List<Product2> products = (Product2[])this.selectById(productId,null);
            if (!products.isEmpty()) {
                if (products.size() == 1) {
                    getById = products[0];
                }
                else {
                    throw new ProductServiceException('getProductById Error: ' + 'more than 1 product found for Id ' + productId);
                }
            }
            else {
                throw new ProductServiceException('getProductById Error: ' + 'no product found for Id ' + productId);
            }
        }
        catch (Exception ex) {
            throw ex;
        }

        return getById;
    }

    public Wrappers.GetProductsWrapper getAllActiveProducts(Integer pageNumber, Integer pageSize, String productName, Id productOwnerId) {
        Wrappers.GetProductsWrapper productsData = new Wrappers.GetProductsWrapper();
        try {
            List<String> selectableFields = new List<String>{'Id','Name', 'Description'};
            List<String> orderBy = new List<String>{'Name'};
            List<String> whereClauses = new List<String>{'IsActive=true'};
            if (!string.isBlank(productOwnerId)) {
                whereClauses.add('AND CreatedById=\'' + productOwnerId + '\'');
            }
            List<Product2> products = (Product2[])this.selectRecords(pageNumber, pageSize, productName, null, selectableFields,whereClauses, orderBy, null);
            if (products.isEmpty()) {
                throw new ProductServiceException('getAllActiveProducts Error: ' + 'no active products found');
            }
            productsData.Products = products;
            productsData.TotalData = this.count(whereClauses,null);
        }
        catch (Exception ex) {
            throw ex;
        }

        return productsData;
    }

    public Wrappers.GetProductsWrapper getOpportunityProducts(Integer pageNumber, Integer pageSize, String productName, Id opportunityId) {
        Wrappers.GetProductsWrapper productsData = new Wrappers.GetProductsWrapper();
        try {
            Set<String> productIds = new OppProductsService().getOppProductIds(opportunityId);
            String dataIn = 'Id In (';
            integer i = 0;
            integer size = productIds.size();
            for (String productId : productIds) {
                dataIn += ('\'' + productId + '\'');
                if (i < size-1) {
                    dataIn += ',';
                }
                i++;
            }
            dataIn += ')';
            List<String> selectableFields = new List<String>{'Id','Name', 'Description'};
            List<String> orderBy = new List<String>{'Name'};
            List<String> whereClauses = new List<String>{dataIn};
            List<Product2> products = (Product2[])this.selectRecords(pageNumber, pageSize, productName, null, selectableFields,whereClauses, orderBy, null);
            if (products.isEmpty()) {
                throw new ProductServiceException('getOpportunityProducts Error: ' + 'no active products found');
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
