IMPORT STD, DeathV2_Services, HomesteadExemption_Services, BatchShare;

EXPORT fn_getDeceasedRecs(DATASET(HomesteadExemption_Services.Layouts.batch_in) ds_batch_in, HomesteadExemption_Services.IParams.BatchParams in_mod) :=
	FUNCTION
		
		c := HomesteadExemption_Services.Constants.Death;
		
		// 1. Fetch records from the Deceased Batch service.
    mod_legacy := BatchShare.IParam.ConvertToLegacy(in_mod);
		deathInMod := MODULE(project(mod_legacy, DeathV2_Services.IParam.BatchParams, opt))							
			EXPORT BOOLEAN AddSupplemental 						:= TRUE;
			EXPORT BOOLEAN PartialNameMatchCodes			:= TRUE;
			EXPORT BOOLEAN ExtraMatchCodes 						:= TRUE;
			EXPORT BOOLEAN MatchCodeADLAppend 				:= TRUE;
			EXPORT BOOLEAN IncludeBlankDOD 						:= TRUE;
		END;			
		deathIn := PROJECT(ds_batch_in, DeathV2_Services.Layouts.BatchIn);		
		ds_deceased_recs_raw := DeathV2_Services.BatchRecords(deathIn, deathInMod);	
		
		// 2. Join back to batch_in (NOTE: it's possible for the input to resolve to  
		// more than one DID in Death_BatchService_Records, match on DID also)...
		layout_temp := RECORD
			Layouts.layout_temp_deceased_recs;
			UNSIGNED6 did;
			STRING deceased_match_code;
			STRING filedate;		
		END;
		
		// 3. Join back to batch_in. Set the owner_isDeceased flag = 'Y' when there is a 
		// matching Deceased record, even though we'll modify it based on matchcodes next.
		ds_death_recs :=
			JOIN(
				ds_batch_in(did != 0), ds_deceased_recs_raw,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.did = (UNSIGNED6)RIGHT.did,
				TRANSFORM( layout_temp,
					SELF.acctno              := LEFT.acctno,
					SELF.owner_isDeceased    := IF( (UNSIGNED6)RIGHT.did > 0, 'Y', '' ),
					SELF.owner_date_of_death := RIGHT.dod8,
					SELF.did                 := LEFT.did,
					SELF.deceased_match_code := RIGHT.matchcode,
					SELF.filedate            := RIGHT.filedate
				),
				LEFT OUTER,
				KEEP(1)
			);

		ds_death_recs_w_corrected_matchcode := 
			PROJECT(
				ds_death_recs,
				TRANSFORM( layout_temp,
					SELF.owner_isDeceased := 
						MAP(
							LEFT.owner_isDeceased = c.YES AND
								STD.Str.Find( LEFT.deceased_match_code, c.SSN_MATCH, 1 ) > 0 AND 
								STD.Str.Find( LEFT.deceased_match_code, c.NAME_MATCH, 1 ) > 0  => c.YES,
							LEFT.owner_isDeceased  = c.YES => c.CONDITIONAL,
							LEFT.owner_isDeceased != c.YES => c.NO,
							/* default ..................*/   ''
						),
					SELF := LEFT
				)
			);
		
		// 4. Sort, group and topn to return only one deceased record per acctno.
		ds_death_recs_grouped :=
			GROUP( 
				SORT( 
					ds_death_recs_w_corrected_matchcode, 
					acctno, 
					-((UNSIGNED)(TRIM(owner_date_of_death) != '')), 
					-((UNSIGNED)filedate) 
				), 
				acctno 
			);
		
		ds_death_recs_most_recent := TOPN( ds_death_recs_grouped, 1, acctno );

		// 5. Project to output layout and return. 
		ds_deceased_recs := 
			PROJECT( 
				UNGROUP(ds_death_recs_most_recent), 
				Layouts.layout_temp_deceased_recs 
			);
		
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_deceased_recs_raw, NAMED('Deceased_results') ) );
		
		RETURN ds_deceased_recs;
	END;