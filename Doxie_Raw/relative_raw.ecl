import doxie,doxie_raw;

export relative_raw(
  dataset(Doxie.layout_references) dids,
  doxie.IDataAccess modAccess,
  //   unsigned3 dateVal = 0,
  //   unsigned1 dppa_purpose = 0,
  //   unsigned1 glb_purpose = 0,
	// string6 ssn_mask_value = 'NONE',
	// boolean ln_branded_value = false,
	// boolean probation_override_value = false,
	boolean include_relatives_val = true,
	boolean include_associates_val = true,
	unsigned1 Relative_Depth = 0,
	unsigned3 max_relatives = 0,
//	boolean isCRS = false,
	unsigned3 max_associates = 0
	) := 
FUNCTION

doxie_raw.Layout_RelativeRawBatchInput tra(dids l) := transform
	self.input.did := l.did;
	self.input.dateVal := modAccess.date_threshold;
	self.input.dppa_purpose := modAccess.dppa;
	self.input.glb_purpose := modAccess.glb;
	self.input.seq := 0;
	self.input.ln_branded_value := modAccess.ln_branded;
	self.input.include_relatives_val := include_relatives_val;
	self.input.include_associates_val := include_associates_val;
	self.input.Relative_Depth := Relative_Depth;
	self := [];
end;


for_batch := group(sorted(project(dids, tra(left)), seq), seq);

results := group(doxie_raw.Relative_Raw_batch(for_batch, false, max_relatives, max_associates));


results_max := 
	IF(
		max_relatives=0, 
		results(isRelative),
		choosen(results(isRelative), max_relatives)
	);

associates_max := 
	IF(max_associates=0, 
		results(~isRelative),
		choosen(results(~isRelative), max_associates)
	);

results_slim := project(results_max + associates_max, transform(doxie_Raw.Layout_RelativeRawOutput, self := left));

return results_slim;

END;