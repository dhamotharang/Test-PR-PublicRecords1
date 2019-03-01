
IMPORT Autokey_batch, BatchServices,DeathV2_Services,Govt_Collections_Services, BatchShare;

EXPORT fn_getDeceasedRecs(dataset(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                          Govt_Collections_Services.IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.15
		 dod_rec_layout := RECORD
		    STRING20	acctno;
		    STRING20  did := '';
		    STRING20  matchcode := '';
		    UNSIGNED1 matchcode_score := 99;
		    STRING8   dod8;
		    STRING1   deceased_indicator := 'Y';
		 END;
	
		// The dataset contains death match codes priority in the order from strongest to weakest provided in req.4.1.19.
	  // The strongest match code is the first in the set with pos=1
		 ds_matchcodes := DATASET([{'ANSZC',1},{'ANSZ',2},{'ANSC',3},{'ANS',4},{'SNZC',5},{'SNZ',6},{'SNC',7},{'SN',8},{'SAZC',9},{'SAZ',10},{'SAC',11},{'SZC',12},{'ANZC',13},{'SA',14},{'SZ',15},{'SC',16},{'ANZ',17},{'ANC',18},{'s',19},{'AN',20},{'AVSZC',21},{'AVSZ',22},{'AVSC',23},{'AVS',24},{'AVZC',25},{'AVz',26},{'AVC',27},{'AV',28},{'SVZC',29},{'SVVZ',30},{'SVC',31},{'SV',32},{'AWSZC',33},{'AWSZ',34},{'AWSC',35},{'AWS',36},{'AWZC',37}], 
		                           {STRING20 matchcode, UNSIGNED1 pos});


		// 1. Transform input to rec_inBatchMaster and get Deceased records.
		data_in := PROJECT(ds_batch_in, Govt_Collections_Services.Transforms.xfm_to_batchIn(LEFT) );
		deathIn := PROJECT(data_in, DeathV2_Services.Layouts.BatchIn);
		mod_batch := BatchShare.IParam.GetFromLegacy(in_mod);
		deathInMod := MODULE(project(mod_batch, DeathV2_Services.IParam.BatchParams, opt))
			EXPORT unsigned3 DidScoreThreshold        := in_mod.DidScoreThreshold; 

			EXPORT BOOLEAN AddSupplemental 						:= TRUE;
			EXPORT BOOLEAN PartialNameMatchCodes			:= TRUE;
			EXPORT BOOLEAN ExtraMatchCodes 						:= TRUE;
			EXPORT BOOLEAN MatchCodeADLAppend 				:= TRUE;			
		END;			
		ds_death_recs_raw := DeathV2_Services.BatchRecords(deathIn, deathInMod);	
								
		// 2. To satisfy changed requirements (4.1.19) we calculate match code scores according with the matchcodes order provided
		ds_death_recs_calc := JOIN(ds_death_recs_raw(dod8 != ''),ds_matchcodes,
		                            LEFT.matchcode = RIGHT.matchcode,
															  TRANSFORM(dod_rec_layout,
		                                     SELF.matchcode_score := RIGHT.pos,
		                                     SELF := LEFT),
															  LEFT OUTER, LOOKUP, FEW
						                   );
						
		// 3. There may be several records per did, we need to keep a record with strongest match code per req.4.1.19
		ds_death_recs_pre := DEDUP(SORT(ds_death_recs_calc(matchcode_score!=0), acctno,did,matchcode_score),acctno,did);
		
			
		// 4. Join back to batch_in and return. NOTE: in the case that the input to Death_
		// BatchService_Records resolves to more than one DID (can happen!), match on DID also.
		ds_death_recs :=
			JOIN(
				ds_batch_in, ds_death_recs_pre,
				LEFT.acctno = RIGHT.acctno AND
				(UNSIGNED)LEFT.lex_id = (UNSIGNED)RIGHT.did,
				TRANSFORM( Govt_Collections_Services.Layouts.batch_working,
					SELF.deceased_indicator := IF( RIGHT.dod8 != '', 'Y', '' ),
					SELF.dod                := IF( RIGHT.dod8 != '', RIGHT.dod8, '' ),
					SELF.deceased_matchcode := IF( RIGHT.dod8 != '', RIGHT.matchcode, '' ),
					SELF := LEFT
				),
				LEFT OUTER,
				KEEP(1)
			);

		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_death_recs_calc, NAMED('ds_death_intm_recs') ) );
		
		RETURN ds_death_recs;
		
	END;