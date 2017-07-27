
IMPORT AddrBest, Address, ut, PublicHousing_Services, lib_stringlib;

EXPORT fn_getBestAddressRecs(DATASET(PublicHousing_Services.Layouts.batch_in) ds_batch_in, PublicHousing_Services.IParams.BatchParams in_mod) := 
	FUNCTION
		
		today := (UNSIGNED4)StringLib.getDateYYYYMMDD() : GLOBAL;
		
		// 1. Fetch Best Address records		
		data_in := PROJECT(ds_batch_in, 
			TRANSFORM(AddrBest.Layout_BestAddr.Batch_in, 
				SELF.zip4	:= '',
				SELF 			:= LEFT, 
				SELF			:= []));
				
		mod_bestAddr_params := module(AddrBest.IParams.SearchParams) 
			EXPORT boolean 		ReturnConfidenceFlag  									:= TRUE;
			EXPORT boolean 		HistoricMatchCodes											:= TRUE; 
			EXPORT boolean 		isV2Score                  							:= TRUE;
			EXPORT boolean 		IncludeHistoricRecords     							:= TRUE; 
			EXPORT unsigned1 	MaxRecordsToReturn											:= 20;
			EXPORT boolean 		InputAddressDedup 											:= FALSE; // per requirements, set to TRUE
			EXPORT boolean 		ReturnDedupFlag													:= TRUE;	// maybe use this to "dedup" manually
			EXPORT boolean 		IncludeBlankDateLastSeen								:= TRUE;
			EXPORT boolean 		OnlyReturnSuccessfullyCleanedAddresses	:= TRUE;
			EXPORT boolean 		IncludeRanking													:= TRUE;  //automatically applied to GOV applications to always get best ranked addr
		end;		
		ds_best_addrs_raw := AddrBest.Records(data_in, mod_bestAddr_params).best_records;

		// 2. Get the best address (i.e. the highest ranked address) within the last 90 days for each acctno and add to our working batch layout.
		ds_best_addrs_filt1 := ds_best_addrs_raw(NOT is_input);
		ds_best_addrs_filt2 := ds_best_addrs_filt1((UNSIGNED4)(ut.date_math(addr_dt_last_seen, 90)) >= today);
				
		ds_best_addrs_grpd := GROUP( ds_best_addrs_filt2, acctno );

		// 3. Denormalize to get up to two Best Addresses. Then return.
		PublicHousing_Services.Layouts.rec_best_addr 
				xfm_denorm(PublicHousing_Services.Layouts.batch_in le, DATASET(AddrBest.Layout_BestAddr.batch_out_final) allRows) :=
					TRANSFORM
						SELF.acctno := le.acctno,
						SELF.address_1_outside_Home_state_flag := 
								IF( 
									COUNT(allRows) >= 1 AND 
										allRows[1].st != in_mod.InputState AND 
										in_mod.InputState != '', 
									'A', 
									'' 
								);
						SELF.name_first_1   := allRows[1].name_first;
						SELF.name_last_1    := allRows[1].name_last;
						SELF.best_address_1 := 
								Address.Addr1FromComponents( 
								  allRows[1].prim_range, allRows[1].predir, allRows[1].prim_name, allRows[1].suffix, 
								  allRows[1].postdir, allRows[1].unit_desig, allRows[1].sec_range
								);
						SELF.best_city_1          := allRows[1].p_city_name;
						SELF.best_state_1         := allRows[1].st;
						SELF.best_zip_1           := allRows[1].z5;
						SELF.date_first_seen_1    := allRows[1].addr_dt_first_seen;
						SELF.date_last_seen_1     := allRows[1].addr_dt_last_seen;
						SELF.address_confidence_1 := allRows[1].conf_flag;                  
						SELF.ncoa_addr            := ''; // for KTR
						SELF.prop_owner_addr_1    := ''; // fill in at fn_getPropertyRecs()
						SELF.address_2_outside_home_state_flag := 
								IF( 
									COUNT(allRows) >= 2 AND 
										allRows[2].st != in_mod.InputState AND 
										in_mod.InputState != '', 
									'A', 
									'' 
								);
						SELF.name_first_2   := allRows[2].name_first;
						SELF.name_last_2    := allRows[2].name_last;
						SELF.best_address_2 := 
								Address.Addr1FromComponents( 
								  allRows[2].prim_range, allRows[2].predir, allRows[2].prim_name, allRows[2].suffix, 
								  allRows[2].postdir, allRows[2].unit_desig, allRows[2].sec_range
								);
						SELF.best_city_2          := allRows[2].p_city_name;
						SELF.best_state_2         := allRows[2].st;
						SELF.best_zip_2           := allRows[2].z5;
						SELF.date_first_seen_2    := allRows[2].addr_dt_first_seen;
						SELF.date_last_seen_2     := allRows[2].addr_dt_last_seen;
						SELF.address_confidence_2 := allRows[2].conf_flag;                  
						SELF.prop_owner_addr_2    := ''; // fill in at fn_getPropertyRecs()
					END;
		
		ds_bestaddr_recs := 
			DENORMALIZE(
				ds_batch_in, ds_best_addrs_grpd,
				LEFT.acctno = RIGHT.acctno,
				GROUP,
				xfm_denorm(LEFT,ROWS(RIGHT))
			);
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_best_addrs_raw, NAMED('BestAddr_results') ) );

		RETURN ds_bestaddr_recs;
		
	END;