# apex-generics
Generic class for Apex CRUD operations - the operations are developed with the best practices in mind for SObject operations (for example, deal with the limit of 2000 records per query, apply a set of ids for a IN clause instead of using nested for cycle, correct list of SObjects to create or delete, SOSL best practices and when it should be used instead of SOQL, etc.)

# how to use this
the class that inherits the genericSelector class implements the specific logic for the SObject operations:
- ###PrimeDrinksProductService### is the class for Products2 SObject operations specific to the business logic, extending GenericSelector class
- ###PrimeDrinksProductsController### is the controller for the lightning component and it invokes the PrimeDrinksProductService class methods
- ###PrimeDrinksProductServiceTest### is the test class that covers both PrimeDrinksProductService and GenericSelector methods invoked at the first one, the implementation class

