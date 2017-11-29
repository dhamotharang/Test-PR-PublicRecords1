import Data_Services;	
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
	
	import _Control,doxie;
	KeySuperFile := if(_Control.mod_xADLversion.QA_version, doxie.version_superkey, 'built');

	sfile_key_did_ind := Data_Services.Data_Location.Prefix('LAB_xLink') + 'key::insuranceheader_segmentation::did_ind_'+KeySuperFile;
	
	export key_did_ind := INDEX(segmentation, {did}, {segmentation}, sfile_key_did_ind	);	
end;

