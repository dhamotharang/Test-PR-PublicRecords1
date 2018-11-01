import insuranceheader_postprocess, idl_header;

// Preprocess
export proc_postProcess(string iter) := module

		shared files := InsuranceHeader_PostProcess.files;
		
		// Create insurance header file
		export post0 := InsuranceHeader_PostProcess.CreateHeaderFiles(iter).DoAll;

		// Mapping between idl vs boca_dids
		idlVSBocaDID := InsuranceHeader_PostProcess.mod_get_bocadid_from_idl(idl_header.Files.DS_IDL_POLICY_HEADER_BASE, iter).result;
		export mapping1 := output(idlVSBocaDID,, files.FILE_MAP_IDL_BOCADID + iter);
		export mapping2 := files.updateMappingSuperFiles(files.FILE_MAP_IDL_BOCADID + iter);
		
		export run := sequential(post0, mapping1, mapping2)  : SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'Best')), 
																											FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'Best'));
end;