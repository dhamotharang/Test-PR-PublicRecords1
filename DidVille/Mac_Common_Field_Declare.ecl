export Mac_Common_Field_Declare := MACRO

STRING6 ssn_mask_val := 'NONE' : stored('SSNMask');
unsigned1 dl_mask_val := 0 : stored('DLMask');

ssn_mask_value := StringLib.StringToUpperCase(ssn_mask_val) : global;
dl_mask_value := dl_mask_val=1;


ENDMACRO;