IMPORT Codes, ut, lib_stringlib; 

EXPORT EFX_MERCTYPE_TABLE := 
MODULE
	EXPORT VARSTRING MERCTYPE(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       StringLib.StringToUppercase(code)='F' => 'For Profit',
       StringLib.StringToUppercase(code)='N' => 'NonProfit',	
       StringLib.StringToUppercase(code)='U' => 'Federal Government',
       StringLib.StringToUppercase(code)='S' => 'State/Local Government',
       StringLib.StringToUppercase(code)='O' => 'Other/Foreign',
       'INVALID'));       

END;	