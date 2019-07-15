IMPORT Codes, ut;

EXPORT EFX_PUBLIC_TABLE := 
MODULE
	EXPORT VARSTRING PUBLIC(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       code='' => 'Unknown',	
			 code=' ' => 'Unknown',
       code='0' => 'Unknown',	
       code='1' => 'Public Company',	
       code='2' => 'Private Company',	
			 'INVALID'));	 
	
END;	