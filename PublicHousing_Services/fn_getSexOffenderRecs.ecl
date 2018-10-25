
IMPORT BatchDatasets, Doxie, NID, SexOffender_Services;

EXPORT fn_getSexOffenderRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) := 
	FUNCTION													
		
		ds_acctno_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		// Fetch Sex Offender records.
		SexOffender_Services.Layouts.rec_offender_plus_acctno
				ds_sexOffender_raw := BatchDatasets.fetch_SexOffender_recs(ds_acctno_refs)(did != 0);

		// Join back to the batch_in to compare SSN, name and DOB data to remove false positives.
		// For this ECL service, all we want is enough information to know whether someone
		// is a sex offender. We are not interested in any of the data. So we'll just 
		// return those batch_in records that found matching sex offender records, and 
		// which survived the join to remove false positives, below.
		ds_batch_in_having_sexOffender_recs := 
			JOIN(
				ds_batch_in, ds_sexOffender_raw, 
				LEFT.acctno = RIGHT.acctno AND
				LEFT.ssn = RIGHT.ssn_appended AND
				StringLib.StringToUpperCase(LEFT.name_last) = StringLib.StringToUpperCase(RIGHT.lname) AND
				(
					StringLib.StringToUpperCase(LEFT.name_first[1..3]) = RIGHT.fname[1..3] OR
					NID.PreferredFirstNew(LEFT.name_first) = RIGHT.fname
				),
				TRANSFORM(LEFT), 
				INNER, LIMIT(0), KEEP(1)
			);	
		
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_sexOffender_raw, NAMED('SexOffender_results') ) );

		RETURN DEDUP(ds_batch_in_having_sexOffender_recs, acctno, ALL);
	END;