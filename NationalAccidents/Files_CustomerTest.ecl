EXPORT Files_CustomerTest := MODULE
	
	SHARED CUSTOMER_TEST_PREFIX          := Files_Prefix.NAI_PREFIX + '_CustTest';
	
	EXPORT SPRAY_NAI_PREFIX    			     := Files_Prefix.SPRAY_PREFIX + CUSTOMER_TEST_PREFIX;																												
	EXPORT BASE_NAI_PREFIX               := Files_Prefix.BASE_PREFIX + CUSTOMER_TEST_PREFIX;
	
	END;