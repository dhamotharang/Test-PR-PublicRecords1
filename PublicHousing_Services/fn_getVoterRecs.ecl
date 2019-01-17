
IMPORT Address, BatchDatasets;

EXPORT fn_getVoterRecs(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) :=
	FUNCTION
		
		UCase := StringLib.StringToUpperCase;
		
		// 1. Fetch records from the Voters Batch service.
		BatchDatasets.Layouts.layout_voters_raw
				ds_voter_recs_raw := BatchDatasets.fetch_Voter_recs(ds_batch_in, in_mod);
		
		ds_voter_recs_most_recent := DEDUP( SORT( ds_voter_recs_raw, acctno, -process_date ), acctno );
		ds_voter_recs_active      := ds_voter_recs_most_recent(active_status = 'A');
		
		// 2. Join back to the batch_in to compare SSN, last name and first name to remove false 
		// positives.
		ds_voter_recs_pre :=
			JOIN(
				ds_batch_in, ds_voter_recs_active,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.ssn = RIGHT.ssn AND
				(
					(
						UCase(LEFT.name_last) = UCase(RIGHT.name.lname) AND
						UCase(LEFT.name_first[1..3]) = UCase(RIGHT.name.fname[1..3])
					) OR
					UCase(LEFT.name_first) = UCase(RIGHT.name.fname)
				),
				TRANSFORM(RIGHT), 
				INNER, KEEP(1)
			);
	
		// 3. Transform and return. 
		ds_voter_recs := 
			PROJECT(
				ds_voter_recs_pre,
				TRANSFORM( Layouts.rec_voter,
					SELF.acctno := LEFT.acctno,
					SELF.voter_address := 
							Address.Addr1FromComponents( 
								LEFT.res.prim_range, LEFT.res.predir, LEFT.res.prim_name, LEFT.res.addr_suffix, 
								LEFT.res.postdir, LEFT.res.unit_desig, LEFT.res.sec_range
							),
					SELF.voter_city     := LEFT.res.p_city_name,
					SELF.voter_state    := LEFT.res.st,
					SELF.voter_zip      := LEFT.res.zip5,
					SELF.voter_reg_date := LEFT.regdate
				)
			);

		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_voter_recs_raw, NAMED('Voter_results') ) );

		RETURN ds_voter_recs;
	END;
