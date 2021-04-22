import STD, ut, Watchdog, Header, PromoteSupers;

#OPTION ('multiplePersistInstances',FALSE);

wdog := distribute(Watchdog.File_Best, hash(did));
seg  := distribute(pull(Header.key_ADL_segmentation), hash(did));

allowed_recs := join(distribute($.AllowedRecs, hash(did)), $.AllowedLexids, left.did=right.lexid, local);
non_glb := allowed_recs(Allowed_for_nonGLB = true);  
glb 	:= allowed_recs(Allowed_for_GLB = true); 

determine_best_dobs(dataset(recordof(allowed_recs)) ds) := FUNCTION

	w_wdog := join(ds, wdog, left.did=right.did and left.dob=right.dob
			,transform({$.AllowedRecs, boolean best_dob}
				,self.best_dob := if(left.did=right.did and left.dob=right.dob, true, false)
				,self := left;
				)
			,left outer
			,local);
	
	bestdob     := w_wdog(best_dob = true);
	not_bestdob := w_wdog(best_dob = false);

	uniq_bestdob := dedup(bestdob, did, dob, all);
	not_bestdob_lexids := dedup(join(not_bestdob, uniq_bestdob, left.did=right.did, left only, local), did, local);

	allowed_dobs := table(ds(jflag1 in ['C', 'L', 'U', 'T'] and dob <> 0), {did, dob, priority := case(jflag1, 'C'=>1,'L'=>2,'U'=>3,'T'=>4,5)});
	allowed_dobs_d := dedup(sort(distribute(allowed_dobs, hash(did)), did, priority, dob, local), did, local);

	w_allowed_dob := join(allowed_dobs_d, not_bestdob_lexids, left.did=right.did
		,transform({not_bestdob}
			,self.best_dob := if(left.did=right.did, true, false)
			,self.dob := left.dob
			,self := right;)
		,right outer
		,local);

  RETURN uniq_bestdob + w_allowed_dob;
END;

glb_w_dob := determine_best_dobs(glb);
nonglb_w_dob := determine_best_dobs(non_glb);

$.layouts.rMetaData to_glb(glb_w_dob L, seg R) := TRANSFORM
	SELF.LexID     := L.did;
	SELF.lexid_ind := case(R.ind1, 'CORE' =>  'C', 'C_MERGE' => 'E', 'DEAD' => 'D', 'INACTIVE' => 'I', 'SUSPECT' => 'S', 'CORENOVSSN' => 'A', '');
	SELF.Best_DOB_GLB := L.dob;
	SELF.Best_DOB_nonGLB := 0;
END;

ds_glb := join(distribute(glb_w_dob, hash(did))
	,seg
	,left.did = right.did
	,to_glb(LEFT, RIGHT)
	,local);

$.layouts.rMetaData to_non_glb(ds_glb L, nonglb_w_dob R) := TRANSFORM
	SELF.Best_DOB_nonGLB := R.dob;
	SELF := L;
END;

EXPORT Metadata := join(distribute(ds_glb, hash(lexid))
	,distribute(nonglb_w_dob, hash(did))
	,left.lexid = right.did
	,to_non_glb(LEFT, RIGHT)
	,LEFT OUTER
	,local);
