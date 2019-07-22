import Data_Services, doxie;	
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
	export key_did_ind := INDEX(segmentation, {did}, {segmentation}, sfile_key_did_ind	);	
end;
