EXPORT MAC_Profile(inFile,id_field='',src_field='') := MACRO
	SALT36.MOD_Profile(inFile,id_field,src_field).out;
ENDMACRO;
