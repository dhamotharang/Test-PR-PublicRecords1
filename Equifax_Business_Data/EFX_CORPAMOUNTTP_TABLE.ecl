IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_CORPAMOUNTTP_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTTP(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
			 StringLib.StringToUppercase(code)='LOCATION SALES' => 'Location Sales',	
       StringLib.StringToUppercase(code)='CORPORATE SALES' => 'Corporate Sales',	
       StringLib.StringToUppercase(code)='CORPORATE ASSETS' => 'Corporate Assets',	
       StringLib.StringToUppercase(code)='BUDGET' => 'Budget',	
       StringLib.StringToUppercase(code)='EXPENSE' => 'Expense',	
       StringLib.StringToUppercase(code)='OTHERS' => 'Others',	
       StringLib.StringToUppercase(code)='CORPORATE REVENUE' => 'Corporate Revenue',	
       StringLib.StringToUppercase(code)='LOCATION REVENUE' => 'Location Revenue',  
			 code='' => '',
			 'INVALID'));	 
						 			 			
END;	