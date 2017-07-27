//This Function Macro accepts a batch with PII and fetches a scored DID for ALL the input
//records that don't already have one. It then returns the DID's that scored >= Threshold (from in_mod).
//You also need to pass in a standard restriction interface including the score threshold.
//This Macro expects the input acctno to be an integer, so run MAC_SequenceInput before this macro
EXPORT MAC_Get_Scored_DIDs(ds_in_batch,in_mod,usePhone=false,phone_Field='phoneno') := FUNCTIONMACRO
	IMPORT DidVille,AutoStandardI,BatchDatasets,ut;
	
	DidVille.Layout_Did_OutBatch prepare_layout(RECORDOF(ds_in_batch) l) := TRANSFORM
		 SELF.seq 		:= (UNSIGNED)l.acctno;
		 SELF.phone10 := IF(usePhone,l.phone_Field,'');
		 SELF.title 	:= '';
		 SELF.fname 	:= l.name_first;
		 SELF.mname 	:= l.name_middle;
		 SELF.lname 	:= l.name_last;
		 SELF.suffix 	:= l.name_suffix;
		 SELF.ssn 		:= stringlib.stringfilter(l.ssn,'0123456789');
		 SELF.did 		:= l.did;
		 SELF := l;
		 SELF := [];
	END;

	//prepare the layout for ADL_BEST DID call
	ds_didless := ds_in_batch(did=0);//only get DIDs for records that don't already have one
	ds_with_ADL_Layout := PROJECT(ds_didless,prepare_layout(LEFT));
	
	// NO_GM - no global mod hits
  NO_GM := AutoStandardI.PermissionI_Tools.val(ut.PopulateDRI_Mod(in_mod));//prevents global mod hits
	glb   := NO_GM.glb.ok(in_mod.GLBPurpose);
	//we call ADL_BEST just to get the scored dids....not to get the best data
	recsWithScoredDIDs := didville.did_service_common_function(ds_with_ADL_Layout
	                                                          ,glb_flag:=glb
	                                                          ,glb_purpose_value:=in_mod.GLBPurpose
																														,appType:=in_mod.ApplicationType
																														,IndustryClass_val := in_mod.industry_class);
	 //we only keep the did's that were found via PII if the did score > 80
	recsWithScoredDIDs_filtered := recsWithScoredDIDs(score >= in_mod.DIDScoreThreshold);

	all_with_dids := JOIN(ds_in_batch,recsWithScoredDIDs_filtered
											,(UNSIGNED)LEFT.acctno = RIGHT.seq
											,TRANSFORM(RECORDOF(ds_in_batch)
											,SELF.did := IF(LEFT.did=0,RIGHT.did,LEFT.did)
											,SELF := LEFT)
											,LIMIT(0),KEEP(BatchDatasets.Constants.Defaults.MaxResultsPerAcctno)
											,LEFT OUTER);

	RETURN all_with_dids;
ENDMACRO;