EXPORT get(did_ds, did_field, permission_type, out_layout = 'dx_BestRecords.layout_best', 
	on_thor = 'false') := FUNCTIONMACRO

	IMPORT dx_BestRecords, Doxie;

	LOCAL out_rec := RECORD(out_layout)
	END;

	LOCAL br_slim := project(did_ds, TRANSFORM(Doxie.layout_references, SELF.did := LEFT.did_field));
	LOCAL br_recs := dx_BestRecords.append(br_slim, did, permission_type, FALSE, on_thor);

	RETURN project(br_recs, TRANSFORM(out_rec, SELF := LEFT._best));

ENDMACRO;
