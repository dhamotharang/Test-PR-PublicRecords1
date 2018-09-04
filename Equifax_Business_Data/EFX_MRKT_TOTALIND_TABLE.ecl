IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_MRKT_TOTALIND_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TOTALIND(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(	
       StringLib.StringToUppercase(code)='M' => 'Marketable',
       StringLib.StringToUppercase(code)='A' => 'Active',
			 StringLib.StringToUppercase(code)='OB' => 'Suspected Out Of Business',
			 'INVALID'));	 
	
END;	