IMPORT InsuranceHeader_Salt_T46,IDL_HEADER;
EXPORT proc_specificity_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	spc_mod := InsuranceHeader_Salt_T46.specificities(idl_header.Files.DS_IDL_POLICY_HEADER_BASE);
  buildSpecificityKey := SEQUENTIAL(spc_mod.Backup(ThorLib.group()), spc_mod.Build)  : 
																								SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader', , 'SpecificitiesKeys')), 
																								FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'SpecificitiesKeys'));
	
	RETURN SEQUENTIAL(buildSpecificityKey);
	
END;;