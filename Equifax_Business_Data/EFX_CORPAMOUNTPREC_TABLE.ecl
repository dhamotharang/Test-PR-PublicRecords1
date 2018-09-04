IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_CORPAMOUNTPREC_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTPREC(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       StringLib.StringToUppercase(code)='ACTUAL' => 'Actual',
       StringLib.StringToUppercase(code)='EST' => 'Estimated',
       StringLib.StringToUppercase(code)='MDL' => 'Modeled',
       StringLib.StringToUppercase(code)='OTH' => 'Other',          
			 code='' => '',
			 'INVALID'));	 

END;	