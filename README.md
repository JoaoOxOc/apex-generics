# apex-generics
Generic class for Apex CRUD operations - the operations are developed with the best practices in mind for SObject operations (for example, deal with the limit of 2000 records per query, apply a set of ids for a IN clause instead of using nested for cycle, correct list of SObjects to create or delete, SOSL best practices and when it should be used instead of SOQL, etc.)

# how to use this
the class that inherits the genericSelector class implements the specific logic for the SObject operations:
- **PrimeDrinksProductService** is the class for Products2 SObject operations specific to the business logic, extending GenericSelector class
- **PrimeDrinksProductsController** is the controller for the lightning component and it invokes the PrimeDrinksProductService class methods
- **PrimeDrinksProductServiceTest** is the test class that covers both PrimeDrinksProductService (the implementation class) and GenericSelector methods invoked from the first one

# example method
```
public Wrappers.GetProductsWrapper getOpportunityProducts(Integer pageNumber, Integer pageSize, String productName, Id opportunityId) {
        Wrappers.GetProductsWrapper productsData = new Wrappers.GetProductsWrapper();
        try {
            Set<String> productIds = new PrimeDrinksOppProductsService().getOppProductIds(opportunityId);
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
