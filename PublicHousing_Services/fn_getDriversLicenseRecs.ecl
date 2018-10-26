
IMPORT BatchDatasets, Doxie;

EXPORT fn_getDriversLicenseRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) := 
	FUNCTION

		#STORED('IncludeNonDMVSources', TRUE);

		UCase := StringLib.StringToUpperCase;
		
		ds_acctnos_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		// Fetch Drivers License records.
		BatchDatasets.Layouts.layout_drivers_license_raw
				ds_drivers_license_recs_raw := BatchDatasets.fetch_DL_recs(ds_acctnos_refs);

		// Join back to the batch_in to compare SSN, last name and first name to remove false 
		// positives. And, we want current records only.
		ds_dl_recs_filt := 
			JOIN(
				ds_batch_in, ds_drivers_license_recs_raw( UCase(history_name) = 'CURRENT' ), 
				LEFT.acctno = RIGHT.acctno AND
				LEFT.ssn = RIGHT.ssn AND
				(
					(
						UCase(LEFT.name_last) = UCase(RIGHT.lname) AND
						UCase(LEFT.name_first[1..3]) = UCase(RIGHT.fname[1..3])
					) OR
					UCase(LEFT.name_first) = UCase(RIGHT.fname)
				),
				TRANSFORM(RIGHT), 
				INNER, 
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);	

		ds_dl_recs_most_recent :=
			DEDUP( SORT( ds_dl_recs_filt, acctno, -lic_issue_date ), acctno );

		// Project into required layout.
		ds_drivers_license_recs :=
			PROJECT(
				ds_dl_recs_most_recent,
				TRANSFORM( Layouts.rec_driver_lic,
					SELF.acctno        := LEFT.acctno,
					SELF.dl_number     := LEFT.dl_number,
					SELF.dl_state      := LEFT.st,
					SELF.dl_issue_date := (STRING8)LEFT.lic_issue_date
				)
			);
	
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_drivers_license_recs_raw, NAMED('DriversLicense_results') ) );

		RETURN ds_drivers_license_recs;
	END;