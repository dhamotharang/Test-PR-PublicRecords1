/*2015-11-02T23:55:11Z (Janielle Goolgar)
RR192379: Govt AddrBest Project Phase2 - Ranking implementation
*/
IMPORT AddrBest, Govt_Collections_Services;

EXPORT fn_getBestAddressRecs( dataset(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                              Govt_Collections_Services.IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.9
		
		// --------------------[ LOCAL FUNCTIONS ]--------------------
		
		// The following function concatenates the atomic address data into a full, street address.
		fn_format_StreetAddress(AddrBest.Layout_BestAddr.batch_out_final rec) := 
			if( TRIM(rec.prim_range) != '',       TRIM(rec.prim_range), '' ) + 
			if( TRIM(rec.predir)     != '', ' ' + TRIM(rec.predir), '' ) + 
			if( TRIM(rec.prim_name)  != '', ' ' + TRIM(rec.prim_name), '' ) + 
			if( TRIM(rec.suffix)     != '', ' ' + TRIM(rec.suffix), '' ) + 
			if( TRIM(rec.postdir)    != '', ' ' + TRIM(rec.postdir), '' ) +
			if( TRIM(rec.unit_desig) != '', ' ' + TRIM(rec.unit_desig), '' ) + 
			if( TRIM(rec.sec_range)  != '', ' ' + TRIM(rec.sec_range), '' );
			
		// --------------------[ END LOCAL FUNCTIONS ]--------------------
		
		// 1. Transform for input to AddrBest.
		data_in := PROJECT( ds_batch_in, Govt_Collections_Services.Transforms.xfm_to_BestAddr_batchIn(LEFT) );
		
		// 2. Get Best Address records from AddrBest, along with other, historical addresses
		// (see above--'IncludeHistoricRecords := TRUE'). NOTE! This will get the most recent 
		// address, not the Best ('Best' = the address having the most prevalence during the 
		// last file update period).
		input_mod := MODULE(AddrBest.Iparams.SearchParams) 
			EXPORT BOOLEAN 	Include_Military_Address  := FALSE;
			EXPORT BOOLEAN 	ReturnOverLimitIndicator  := FALSE;
			EXPORT BOOLEAN 	ReturnAddrPhone		  			:= FALSE;
			EXPORT BOOLEAN 	ReturnLatLong 						:= FALSE;
			EXPORT BOOLEAN 	ReturnCountyName  				:= FALSE;
			EXPORT BOOLEAN 	ReturnConfidenceFlag  		:= FALSE;
			EXPORT BOOLEAN 	ReturnUnServAddrIndicator	:= FALSE;
			EXPORT BOOLEAN 	UnServAddrDedup						:= FALSE;
			EXPORT BOOLEAN 	ReturnMultiADLIndicator		:= FALSE;
			EXPORT BOOLEAN 	ReturnConfirmedMatchCode	:= FALSE;
			EXPORT BOOLEAN 	ReturnFlipFlopIndicator		:= FALSE;
			EXPORT BOOLEAN 	HistoricMatchCodes				:= TRUE; 
			EXPORT UNSIGNED1 minNameScore 						:= 0; 		
			EXPORT UNSIGNED1 maxNameScore 						:= 255; 	
			EXPORT BOOLEAN isV2Score                  := TRUE; // to include some of the new enhancements (e.g. name score) and preserve whatever is common to other services		
			EXPORT BOOLEAN IncludeHistoricRecords     := TRUE; 
			EXPORT UNSIGNED1 MaxRecordsToReturn				:= 20;
			EXPORT BOOLEAN IncludeBlankDateLastSeen		:= TRUE;
			EXPORT BOOLEAN OnlyReturnSuccessfullyCleanedAddresses := TRUE;
			EXPORT BOOLEAN IncludeRanking		 					:= TRUE; //automatically applied to GOV applications to always get best ranked addr
		END;
		
		ds_addr_history := AddrBest.Records(data_in,input_mod).best_records;
		
		// 3. Get the best address (i.e. the most recent address) for each acctno and add to our working
		//  batch layout. Note: we must resort as best_records returns a dataset sorted only by acctno.
		ds_best_addr :=
			DEDUP( SORT( ds_addr_history, acctno, address_history_seq ), acctno );

		ds_batch_in_having_best_addr :=
			JOIN(
				ds_batch_in, ds_best_addr,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Govt_Collections_Services.Layouts.batch_working,
					SELF.acctno               := LEFT.acctno,
					SELF.best_addr1           := fn_format_StreetAddress(RIGHT),
					SELF.best_prim_range      := RIGHT.prim_range;
					SELF.best_predir          := RIGHT.predir;
					SELF.best_prim_name       := RIGHT.prim_name;
					SELF.best_addr_suffix     := RIGHT.suffix;
					SELF.best_postdir         := RIGHT.postdir;
					SELF.best_unit_desig      := RIGHT.unit_desig;
					SELF.best_sec_range       := RIGHT.sec_range;
					SELF.best_p_city_name     := RIGHT.p_city_name;
					SELF.best_st              := RIGHT.st;
					SELF.best_z5      		    := RIGHT.z5;
					SELF.best_zip4            := RIGHT.zip4;
					SELF.best_county_name     := RIGHT.county_name;
					SELF.best_city            := RIGHT.p_city_name,
					SELF.best_state           := RIGHT.st,
					SELF.best_zip             := RIGHT.z5,
					SELF.date_last_seen       := RIGHT.addr_dt_last_seen,
					SELF.input_is_best_addr   := RIGHT.is_input,
					SELF.addr_in_out_of_home_state := MAP (  RIGHT.st != '' AND
							 RIGHT.st != in_mod.input_state AND in_mod.input_state != '' => 'OS', 
							 RIGHT.st  = in_mod.input_state AND in_mod.input_state != '' => 'IS', 
							                                                                 '' );	
					SELF := LEFT
				),
				LEFT OUTER,
				KEEP(1)
			);

		// 4. For those records whose input address is not the Best address, join to the
		// address history dataset to find a match to the input and grab the dt_last_seen.
		ds_addr_history_deduped :=
			DEDUP(
				SORT(
					ds_addr_history,
					acctno, prim_range, prim_name, z5, sec_range, -addr_dt_last_seen
				),
				acctno, prim_range, prim_name, z5, sec_range
			);
			
		Govt_Collections_Services.Layouts.batch_working xfm_find_hist_addr (Govt_Collections_Services.Layouts.batch_working le, AddrBest.Layout_BestAddr.batch_out_final ri):=
		TRANSFORM
		    is_hist_addr := le.prim_range = ri.prim_range AND 
				                le.prim_name = ri.prim_name AND
				                le.z5 = ri.z5 AND
				                (le.sec_range = ri.sec_range OR le.sec_range = '') AND 
				                NOT le.input_is_best_addr;
				
				SELF.input_addr_date := IF(is_hist_addr,ri.addr_dt_last_seen,le.input_addr_date);
				SELF.input_is_hist_addr := le.input_is_hist_addr OR is_hist_addr;
				SELF := le;
		END;

		ds_results := DENORMALIZE(ds_batch_in_having_best_addr, ds_addr_history_deduped,
				                      LEFT.acctno = RIGHT.acctno,
				                      xfm_find_hist_addr(LEFT,RIGHT),
				                      LEFT OUTER
			                       );
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_addr_history, NAMED('ds_bestaddr_intm_recs') ) );
						
		RETURN ds_results;
		
	END;