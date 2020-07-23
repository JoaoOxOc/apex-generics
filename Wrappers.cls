public with sharing class Wrappers {
    public class GetProductsWrapper
	{
		public List<Product2> Products;
		public Integer TotalData;
	
 	}

	public class GetOppProductsWrapper
	{
		public List<OpportunityLineItem> Products;
		public Integer TotalData;
	
 	}

	 

     public class GetAggregatedAccountsWrapper
	{
		public List<AggregateResult> Accounts;
		public Integer TotalData;
	
 	}
}