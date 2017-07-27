
IMPORT Address, BatchDatasets, Std, VotersV2_Services;

EXPORT fn_getVoterRecs(DATASET(Layouts.batch_in) ds_batch_in = dataset([],Layouts.batch_in),
                          IParams.BatchParams in_mod) :=
	FUNCTION		
		// 1. Fetch records from the Voters Batch service.
		BatchDatasets.Layouts.layout_voters_raw
				ds_voter_recs_raw := BatchDatasets.fetch_Voter_recs(ds_batch_in, in_mod);
		
		ds_voter_recs_most_recent := DEDUP( SORT( ds_voter_recs_raw, acctno, -process_date ), acctno );
		
		// 2. Join back to the batch_in to compare SSN, last name and first name to remove false 
		// positives.
		ds_voter_recs_pre :=
			JOIN(
				ds_batch_in, ds_voter_recs_most_recent, 
				LEFT.acctno = RIGHT.acctno AND
				(LEFT.ssn = RIGHT.ssn OR LEFT.ssn = '') AND
				(
					(
						STD.Str.ToUpperCase(LEFT.name_last) = STD.Str.ToUpperCase(RIGHT.name.lname) AND
						STD.Str.ToUpperCase(LEFT.name_first[1..3]) = STD.Str.ToUpperCase(RIGHT.name.fname[1..3])
					) OR
					STD.Str.ToUpperCase(LEFT.name_first) = STD.Str.ToUpperCase(RIGHT.name.fname)
				),
				TRANSFORM(RIGHT), 
				INNER, KEEP(1)
			);
		
		// 3. Transform and return. 
		ds_voter_recs := 
			PROJECT(
				ds_voter_recs_pre,
				TRANSFORM( Layouts.layout_temp_voter_recs,
					SELF.acctno            := LEFT.acctno,
					SELF.res_st            := LEFT.res.st,
					SELF.voter_status_exp  := LEFT.voter_status_exp,
					SELF.active_status_exp := LEFT.active_status_exp
				)
			);

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_voter_recs_raw, NAMED('Voter_results') ) );

		RETURN ds_voter_recs;
	END;
