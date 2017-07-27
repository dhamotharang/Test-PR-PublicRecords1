import ut, Alerts;
	
export alert_hashes(DATASET(Layout_report.KeyRec) rpt_records) := MODULE
  // may need to add these hashes to the input set if they are being accumulated
	// for versioning, need to be able to pass version number to alert_calcs module

	// when versioning is needed, need to calculate hashes based on the input version of each 
	// section; then need to separately calculate output hashes based on current version
  EXPORT output_hashes := PROJECT(rpt_records, alert_calcs(true).calcHashes(LEFT));

	// for now, just use output_hashes for comparison
	shared cmp_hashes := output_hashes;
	
	shared in_hashes := alerts.inputs.input_loc_hashes;
	
	alerts.layouts.layout_report_hash getRes(alerts.layouts.layout_report_hash l, alerts.layouts.layout_report_hash r) := TRANSFORM
		SELF.version := IF(l.version <> 0, l.version, r.version);
		SELF.hashval := IF(l.hashval <> '', l.hashval, r.hashval);
	END;
	
	shared boolean compareHashes(DATASET(alerts.layouts.layout_report_hash) in_h, 
															 DATASET(alerts.layouts.layout_report_hash) cmp_h) := FUNCTION
	  // return TRUE any time there is a difference between input and calculated hashvals
		diffs := join(in_h, cmp_h, LEFT.hashval = RIGHT.hashval, getRes(LEFT, RIGHT), full only);
		RETURN (exists(diffs));
	END;

	shared alerts.layouts.layout_report_hash newRec(alerts.layouts.layout_report_hash r) := TRANSFORM
		SELF := R;
	END;
	
	shared in_prop_h := NORMALIZE(in_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared in_assoc_h := NORMALIZE(in_hashes, LEFT.assoc_hashes, newRec(RIGHT));
	
	shared cmp_prop_h := NORMALIZE(cmp_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared cmp_assoc_h := NORMALIZE(cmp_hashes, LEFT.assoc_hashes, newRec(RIGHT));
			
	shared boolean propChanges := alerts.inputs.trackProperty and compareHashes(in_prop_h, cmp_prop_h);
	shared boolean assocChanges := alerts.inputs.trackAssociate and compareHashes(in_assoc_h, cmp_assoc_h);

  Layout_report.KeyRec pruneUnchanged(Layout_report.KeyRec l) := TRANSFORM
		SELF.propInfo := IF(propChanges, l.propInfo);
   	SELF.associates := IF(assocChanges, l.associates);
		SELF := l;
	END;

  EXPORT changed_sections := PROJECT(rpt_records, pruneUnchanged(LEFT));

  // create a bitmap value so that clients can know which sections changed
  EXPORT hashmap := IF(propChanges,ut.bit_set(0,0),0) +
                    IF(assocChanges,ut.bit_set(0,1),0);
	
	//recommendation from Gavin in an attempt to prevent hashmap from being evaluated if return_hashes not requested
	//if (a, nofold(if (b, x, y)), y)
	
	// formerly    EXPORT sendResults := ~return_hashes OR hashmap <> 0;
	EXPORT sendResults := IF(~alerts.inputs.return_hashes, true, nofold(IF(hashmap <> 0, true,false)));
	
	// formerly    EXPORT sendHashes := return_hashes and hashmap <> 0;
	EXPORT sendHashes := IF(alerts.inputs.return_hashes, nofold(IF(hashmap <> 0, true, false)), false);
END;
