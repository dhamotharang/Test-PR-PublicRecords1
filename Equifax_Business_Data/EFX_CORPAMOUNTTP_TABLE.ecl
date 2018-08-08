IMPORT Codes;

EXPORT EFX_CORPAMOUNTTP_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTTP(STRING code) :=
	  MAP(		
       code='Location Sales' => 'Location Sales',	
       code='Corporate Sales' => 'Corporate Sales',	
       code='Corporate Assets' => 'Corporate Assets',	
       code='Budget' => 'Budget',	
       code='Expense' => 'Expense',	
       code='Others' => 'Others',	
       code='Corporate Revenue' => 'Corporate Revenue',	
       code='Location Revenue' => 'Location Revenue',  
			 code='LOCATION SALES' => 'Location Sales',	
       code='CORPORATE SALES' => 'Corporate Sales',	
       code='CORPORATE ASSETS' => 'Corporate Assets',	
       code='BUDGET' => 'Budget',	
       code='EXPENSE' => 'Expense',	
       code='OTHERS' => 'Others',	
       code='CORPORATE REVENUE' => 'Corporate Revenue',	
       code='LOCATION REVENUE' => 'Location Revenue',  
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORPAMOUNTTP' =>	CORPAMOUNTTP(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CORPAMOUNTTP',field_name in ['CORPAMOUNTTP']
	),trans(LEFT));
	RETURN p;
		
	END;					 		 

END;	