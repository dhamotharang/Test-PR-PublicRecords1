
IMPORT BatchDatasets, Doxie, Std;

EXPORT fn_getDriversLicenseRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) := 
	FUNCTION

		#STORED('IncludeNonDMVSources', TRUE);

		ds_acctnos_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		// Fetch Drivers License records.
		BatchDatasets.layouts.layout_drivers_license_raw
				ds_drivers_license_recs_raw := BatchDatasets.fetch_DL_recs(ds_acctnos_refs);

		// Join back to the batch_in to compare SSN, last name and first name to remove false 
		// positives. 
		ds_dl_recs_filt := 
			JOIN(
				ds_batch_in, ds_drivers_license_recs_raw, 
				LEFT.acctno = RIGHT.acctno AND
				(LEFT.ssn = RIGHT.ssn OR LEFT.ssn = '') AND
				(
					(
						STD.Str.ToUpperCase(LEFT.name_last) = STD.Str.ToUpperCase(RIGHT.lname) AND
						STD.Str.ToUpperCase(LEFT.name_first[1..3]) = STD.Str.ToUpperCase(RIGHT.fname[1..3])
					) OR
					STD.Str.ToUpperCase(LEFT.name_first) = STD.Str.ToUpperCase(RIGHT.fname)
				),
				TRANSFORM(RIGHT), 
				INNER, KEEP(1)
			);	

		// Apply business rules.
		ds_dl_recs_current := ds_dl_recs_filt( STD.Str.ToUpperCase(history_name) = 'CURRENT' );
		
		ds_dl_recs_most_recent :=
			DEDUP( SORT( ds_dl_recs_current, acctno, -lic_issue_date ), acctno );

		// Project into required layout.
		ds_drivers_license_recs :=
			PROJECT(
				ds_dl_recs_most_recent,
				TRANSFORM( Layouts.layout_temp_dl_recs,
					SELF.acctno             := LEFT.acctno,
					SELF.dl_state           := LEFT.st,
					SELF.dl_activation_date := IF( LEFT.lic_issue_date = 0, '', (STRING8)LEFT.lic_issue_date )
				)
			);
	
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_drivers_license_recs_raw, NAMED('DriversLicense_results') ) );

		RETURN ds_drivers_license_recs;
	END;