import Data_Services, doxie, vault, _control;	
export segmentation_keys := module

	coreCheckLayout := RECORD
  unsigned8 did;
  string10 ind;
	string3	LexId_Type;
  unsigned8 cnt;
  string9 ssn;
  unsigned4 dob;
	END;

	segmentation := dataset([],coreCheckLayout) ;
	
	sfile_key_did_ind := Data_Services.Data_Location.Prefix('SEGMENTATION') + 'thor_data400::key::insuranceheader_segmentation::did_ind_' + doxie.Version_SuperKey;

#IF(_Control.Environment.onVault) 
	// export key_did_ind := vault.InsuranceHeader.segmentation_keys.key_did_ind;  // flat version
	export key_did_ind := vault.InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;  // key version
#ELSE
	export key_did_ind := INDEX(segmentation, {did}, {segmentation}, sfile_key_did_ind	);	
#END;

end;
