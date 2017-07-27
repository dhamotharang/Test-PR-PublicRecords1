import didville, ut, risk_indicators;

export DID_append_function(dataset(didville.Layout_Did_OutBatch) didprep, integer glb, integer dppa, boolean isFCRA, integer bsversion) := function

	glb_ok := risk_indicators.iid_constants.glb_ok(glb, isFCRA);
	dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);
	fz := '4GZ';
	dedup_these := if(BSversion > 2, false, true);	// allow multiple DID's for bsVersion > 2
	allscores := false;

	didville.Mac_DIDAppend(didprep,resu,dedup_these,fz,allscores) ;

	return resu;
	
END;