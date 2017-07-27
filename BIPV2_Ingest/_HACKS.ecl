Generally, we don't need any HACKS now.  However, when the data team makes a change to 
a field that we ordinarly expect to hold constant, it can be very useful to minimize
the scope of when that field is omitted from Ingest's comparison.  For example,
source_record_id should never change.  However, if the data team decides to change it
in LiensV2 we would mark it as DERIVED in the Spec file, regenerate the SALT attrs, then
HACK the Ingest attribute as follows...

	// AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
	// HACK - source_record_id should be DERIVED for LiensV2 only
	import MDR;
  AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,source_record_id,__Tpe,rcid), left.source_record_id=right.source_record_id OR MDR.sourceTools.SourceIsLiens_v2(left.source), MergeData(LEFT,RIGHT)));

This reduces the possibility of merging two distinct (but extraordinarily similar) records.

turned BIPV2_Ingest.Ingest into a function to allow for testing ingest on specific sources.  this really helps with source rewrites since we can identify possible issues with mapping of fields
or source record id persistence issues.