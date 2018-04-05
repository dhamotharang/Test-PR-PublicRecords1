EXPORT MAC_Profile(inFile,id_field='',src_field='') := MACRO
	SALT39.MOD_Profile(inFile,id_field,src_field).out;
ENDMACRO;
