IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_GOV1057_TABLE := 
MODULE
	EXPORT VARSTRING GOV1057(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       StringLib.StringToUppercase(code)='U' => 'US Federal Government',
       StringLib.StringToUppercase(code)='S' => 'State/Local',       
			 code='' => '',
			 'INVALID'));	 
	
END;	