IMPORT Address_Rank, DidVille;
EXPORT  fn_appendDids(DATASET(Address_Rank.Layouts.Batch_in) ds_in, Address_Rank.IParams.BatchParams in_mod) := FUNCTION

	DidVille.Layout_Did_OutBatch getDIDs(ds_in l) := TRANSFORM
		 SELF.seq 		:= (UNSIGNED)l.acctno;
		 SELF.phone10 := '';
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

	inputRecs := PROJECT(ds_in,getDIDs(LEFT));
	
	glb_ok  := in_mod.isValidGlb();
	recs := didville.did_service_common_function(inputRecs,
																							 glb_flag := glb_ok, 
																							 glb_purpose_value := in_mod.glb, 
																							 appType := in_mod.application_type,
																							 IndustryClass_val := in_mod.industry_class);	
																							 
	RETURN recs;
END;
