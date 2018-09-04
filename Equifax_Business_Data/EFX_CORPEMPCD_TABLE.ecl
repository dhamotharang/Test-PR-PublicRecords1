IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_CORPEMPCD_TABLE := 
MODULE
	EXPORT VARSTRING CORPEMPCD(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       StringLib.StringToUppercase(code)='A' => '1-4',
       StringLib.StringToUppercase(code)='B' => '5-9',
       StringLib.StringToUppercase(code)='C' => '10-19',
       StringLib.StringToUppercase(code)='D' => '20-49',
       StringLib.StringToUppercase(code)='E' => '50-99',
       StringLib.StringToUppercase(code)='F' => '100-249',
       StringLib.StringToUppercase(code)='G' => '250-499',
       StringLib.StringToUppercase(code)='H' => '500-999',
       StringLib.StringToUppercase(code)='I' => '1000-4999',
       StringLib.StringToUppercase(code)='J' => '5000-9999',
       StringLib.StringToUppercase(code)='K' => '10000+',       
			 code='' => '',
			 'INVALID'));	 	 		 

END;	
