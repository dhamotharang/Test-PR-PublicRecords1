IMPORT IDL_Header,InsuranceHeader_PostProcess;
EXPORT proc_chi_master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	hdr := IDL_Header.Files.DS_IDL_POLICY_HEADER_BASE;
	chi := InsuranceHeader_PostProcess.fn_chi(hdr,version_use);
	
	RETURN SEQUENTIAL(chi);
	
END;