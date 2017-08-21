EXPORT MAC_Profile(inFile,id_field='',src_field='') := MACRO
	SALT38.MOD_Profile(inFile,id_field,src_field).out;
ENDMACRO;
