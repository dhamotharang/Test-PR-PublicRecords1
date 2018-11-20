EXPORT get(did_ds, did_field, permission_type, out_layout = 'dx_BestRecords.layout_best', 
	use_distributed = 'false') := FUNCTIONMACRO

	IMPORT dx_BestRecords, Doxie;

	LOCAL br_slim := PROJECT(did_ds, TRANSFORM(Doxie.layout_references, SELF.did := LEFT.did_field));
	LOCAL br_recs := dx_BestRecords.append(br_slim, did, permission_type, FALSE, use_distributed);

	RETURN PROJECT(br_recs, TRANSFORM(out_layout, SELF := LEFT._best));

ENDMACRO;
