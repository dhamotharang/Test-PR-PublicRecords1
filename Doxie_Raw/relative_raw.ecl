import doxie,doxie_raw;

export relative_raw(
  dataset(Doxie.layout_references) dids,
  doxie.IDataAccess modAccess,
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
	self.input.seq := 0;
	self := [];
end;


for_batch := group(sorted(project(dids, tra(left)), seq), seq);

results := ungroup(doxie_raw.Relative_Raw_batch(for_batch, modAccess, Relative_Depth, include_relatives_val,include_associates_val, max_relatives, max_associates));


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
