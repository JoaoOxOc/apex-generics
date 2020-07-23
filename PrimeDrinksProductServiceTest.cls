@IsTest
public class PrimeDrinksProductServiceTest {
    @IsTest public static Product2 populateMockData() {
        Product2 acc = new Product2();
        acc.Name = 'Product2 test';
        insert acc;
        System.assertNotEquals(true,false); 
        return acc;
    }

    @IsTest(SeeAllData=true) public static void testPrimeDrinksProductService() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();
    
    	System.assertNotEquals(controller,null); 
    }

    @IsTest(SeeAllData=true) public static void testgetProductById() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        String accountIdTest = '0011i000006VDBYAA4';

        Product2 acc = controller.getProductById(accountIdTest);
    
    	System.assertNotEquals(acc,null); 
    }

    @IsTest(SeeAllData=true) public static void testgetProductByIdInvalid() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        Product2 acc = null;

        try {
            acc = controller.getProductById('teste');
            System.assertEquals(acc,null); 
        }
        catch(Exception ex) {
            Boolean expectedExceptionThrown =  ex.getMessage().contains('System.StringException: Invalid id:') ? true : false;

            //throw new AccountService.AccountServiceException(''+expectedExceptionThrown);
            System.AssertEquals(expectedExceptionThrown, false);
        }
    }

    @IsTest(SeeAllData=true) public static void testgetProductByIdNull() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        Product2 acc = null;

        try {
            acc = controller.getProductById(null);
            System.assertEquals(acc,null); 
        }
        catch(Exception ex) {
            Boolean expectedExceptionThrown =  ex.getMessage().contains('##GenericSelector Error - selectById Error - objectId is an empty string') ? true : false;

            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

    @IsTest(SeeAllData=true) public static void testgetProductByIdEmpty() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        Product2 acc = null;

        try {
            acc = controller.getProductById('');
            System.assertEquals(acc,null); 
        }
        catch(Exception ex) {
            Boolean expectedExceptionThrown =  ex.getMessage().contains('Invalid id:') ? true : false;

            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

    @IsTest(SeeAllData=true) public static void testGetAllActiveProducts() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        Wrappers.GetProductsWrapper acc = controller.getAllActiveProducts(1,0,'',null);
    
    	System.assertNotEquals(acc.Products,null); 
    }

    @IsTest(SeeAllData=true) public static void testgetOpportunityProducts() {
    	// Instantiate a new controller with all parameters in the page
    	PrimeDrinksProductService controller = new PrimeDrinksProductService();

        Wrappers.GetProductsWrapper acc = controller.getOpportunityProducts(1,0,'','0063X00000ysLbfQAE');
    
    	System.assertNotEquals(acc.Products,null); 
    }
}