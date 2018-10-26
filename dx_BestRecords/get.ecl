EXPORT get(did_ds, did_field, permission_type, on_thor = 'false') := FUNCTIONMACRO;

	IMPORT dx_BestRecords, Doxie;

	LOCAL br_slim := project(did_ds, transform(Doxie.layout_references, SELF.did := LEFT.did_field));
	
	RETURN dx_BestRecords.append(br_slim, did, permission_type, FALSE, on_thor);

endmacro;