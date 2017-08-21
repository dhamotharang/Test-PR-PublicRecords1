EXPORT mac_append_provider_sanctions (Infile, Input_LNPID = '', Input_LIC_NBR = '', Input_LIC_STATE = '', in_prefix = 'idv') := FUNCTIONMACRO

	Health_Provider_Services.mac_provider_sanctions (Infile,Input_LNPID,Input_Lic_NBR,Input_Lic_State,Outfile);
	
	RETURN OutFile;
ENDMACRO;

	
