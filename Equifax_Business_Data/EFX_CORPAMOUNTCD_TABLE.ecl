IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_CORPAMOUNTCD_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTCD(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       StringLib.StringToUppercase(code)='A' => '1-499',
       StringLib.StringToUppercase(code)='B' => '500-999',
       StringLib.StringToUppercase(code)='C' => '1,000-2,499',
       StringLib.StringToUppercase(code)='D' => '2,500-4,999',
       StringLib.StringToUppercase(code)='E' => '5000-9999',
       StringLib.StringToUppercase(code)='F' => '10000-19999',
       StringLib.StringToUppercase(code)='G' => '20000-49999',
       StringLib.StringToUppercase(code)='H' => '50000-99999',
       StringLib.StringToUppercase(code)='I' => '100000-499999',
       StringLib.StringToUppercase(code)='J' => '500000-999999',
       StringLib.StringToUppercase(code)='K' => '1000000+',       
			 code='' => '',
			 'INVALID'));	 
			 			 			
END;	