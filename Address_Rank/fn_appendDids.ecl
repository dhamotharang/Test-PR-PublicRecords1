IMPORT Address_Rank, AutoStandardI, DidVille;
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
	
	p := MODULE(AutoStandardI.PermissionI_Tools.params)
								EXPORT BOOLEAN 		AllowAll 			:= FALSE;
								EXPORT BOOLEAN 		AllowGLB 			:= FALSE;
								EXPORT BOOLEAN 		AllowDPPA 		:= FALSE;
								EXPORT UNSIGNED1 	DPPAPurpose 	:= in_mod.DPPAPurpose;
								EXPORT UNSIGNED1 	GLBPurpose 		:= in_mod.GLBPurpose;
								EXPORT BOOLEAN 		IncludeMinors := FALSE;
				END;
	glb  := AutoStandardI.PermissionI_Tools.val(p).glb.ok(in_mod.GLBPurpose);
	recs := didville.did_service_common_function(inputRecs,
																							 glb_flag := glb, 
																							 glb_purpose_value := in_mod.GLBPurpose, 
																							 appType := in_mod.ApplicationType,
																							 IndustryClass_val := in_mod.IndustryClass);	
																							 
	RETURN recs;
END;