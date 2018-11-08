
IMPORT DeathV2_Services, PublicHousing_Services;

EXPORT fn_getDeceasedRecs(DATASET(PublicHousing_Services.Layouts.batch_in) ds_batch_in, PublicHousing_Services.IParams.BatchParams in_mod) :=
	FUNCTION

		// 1. Fetch records from the Deceased Batch service.		
		deathInMod := MODULE(project(in_mod, DeathV2_Services.IParam.BatchParams, opt))							
			EXPORT BOOLEAN AddSupplemental 						:= TRUE; // for joining on DID
			EXPORT BOOLEAN PartialNameMatchCodes			:= TRUE;
			EXPORT BOOLEAN ExtraMatchCodes 						:= TRUE;
			EXPORT BOOLEAN MatchCodeADLAppend 				:= FALSE;
			EXPORT BOOLEAN IncludeBlankDOD 						:= TRUE;
		END;			
		deathIn := PROJECT(ds_batch_in, DeathV2_Services.Layouts.BatchIn);		
		ds_deceased_recs_raw := DeathV2_Services.BatchRecords(deathIn, deathInMod);					
		
		// 2. Join back to batch_in (NOTE: it's possible for the input to 
		// resolve to more than one DID in Death_BatchService_Records, match
		// on DID also)...
		ds_death_recs :=
			JOIN(
				ds_batch_in, ds_deceased_recs_raw,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.did = (UNSIGNED)RIGHT.did,
				TRANSFORM( { PublicHousing_Services.Layouts.rec_deceased, STRING8 filedate },
					SELF.acctno                    := LEFT.acctno,
					SELF.deceased_date_of_death_SN := RIGHT.dod8,
					SELF.deceased_DOB_SN           := RIGHT.dob8,
					SELF.deceased_match_code_SN    := RIGHT.matchcode,
					SELF.deceased_first_name_SN    := RIGHT.fname,
					SELF.deceased_last_name_SN     := RIGHT.lname,
					SELF.filedate                  := RIGHT.filedate
				),
				LEFT OUTER,
				KEEP(1)
			);

		ds_death_recs_filtered := 
				ds_death_recs( 
					StringLib.StringFind( deceased_match_code_SN, 'S', 1 ) > 0 AND 
					StringLib.StringFind( deceased_match_code_SN, 'N', 1 ) > 0 );
					
		ds_death_recs_grouped :=
			GROUP( SORT( ds_death_recs_filtered, acctno, -((UNSIGNED)filedate) ), acctno );
		
		ds_death_recs_most_recent := TOPN( ds_death_recs_grouped, 1, acctno );

		// 3. Apply business rules and return. 
		ds_deceased_recs := PROJECT( UNGROUP(ds_death_recs_most_recent), PublicHousing_Services.Layouts.rec_deceased );
		
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_deceased_recs_raw, NAMED('Deceased_results') ) );

		RETURN ds_deceased_recs;
	END;