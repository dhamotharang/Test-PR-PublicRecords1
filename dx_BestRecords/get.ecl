// NOTE: The use_distributed option will use a hash(did_field) on input records (not a hash32 or hash64).
// If the input is already distributed with a hash() on the did_field value, 
//  the operation should be suitably efficient
//
EXPORT get(did_ds, did_field, permission_type, out_layout = 'dx_BestRecords.layout_best', 
	use_distributed = 'false') := FUNCTIONMACRO

	IMPORT dx_BestRecords, Doxie;

  // RR-14697: Cast the did_field to unsigned to accomodate services outside of Roxie which can potentially 
  //   use a string for the did value
	LOCAL br_slim := PROJECT(did_ds, TRANSFORM(Doxie.layout_references, SELF.did := (unsigned)LEFT.did_field));
	LOCAL br_recs := dx_BestRecords.append(br_slim, did, permission_type, FALSE, use_distributed);

	RETURN PROJECT(br_recs, TRANSFORM(out_layout, SELF := LEFT._best));

ENDMACRO;
