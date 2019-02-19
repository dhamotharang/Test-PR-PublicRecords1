
IMPORT Address, Doxie, Royalty, VehicleV2_Services, PublicHousing_Services;

EXPORT Raw := MODULE

	/*
	It is the responsibility of the calling attribute to set the following STORED values:

			#STORED('Operation',[ numeric value: 0,1,2 ]);

			The #STORED value above is read from global scope below. It cannot be passed as 
			a formal parameter.
	*/
	EXPORT fetch_RealTimeMVR2_recs( DATASET( PublicHousing_Services.Layouts.batch_in) ds_batch_in, DATASET( PublicHousing_Services.Layouts.rec_best_addr) ds_best_addr_recs, PublicHousing_Services.IParams.BatchParams in_mod ) :=
		FUNCTION
			// Transform both ds_batch_in and ds_best_addr_recs to input for Vehicles RT batch.
			
			// Transform batch_in recs...:
			RealTime_InLayout_V2_plus_seq := RECORD
				UNSIGNED seq;
				VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2;
			END;
			
			RealTime_InLayout_V2_plus_seq xfm_for_RT_MVR_batch_1( PublicHousing_Services.Layouts.batch_in le) :=
				TRANSFORM 
					SELF.seq         := 1;
					SELF.acctno      := le.acctno;
					SELF.name_first  := le.name_first;
					SELF.name_middle := le.name_middle;
					SELF.name_last   := le.name_last;
					SELF.name_suffix := le.name_suffix;
					SELF.addr1       := Address.Addr1FromComponents(le.prim_range, le.predir, 
							le.prim_name, le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);
					SELF.p_city_name := le.p_city_name;
					SELF.st          := le.st;
					SELF.z5          := le.z5;
					SELF             := le;	
					SELF             := [];
				END;
				
			inputdata_from_batch_in :=
					PROJECT( ds_batch_in, xfm_for_RT_MVR_batch_1(LEFT) );

			// ...and transform best address recs:
			RealTime_InLayout_V2_plus_seq xfm_for_RT_MVR_batch_2( PublicHousing_Services.Layouts.rec_best_addr le, INTEGER c) := 
				TRANSFORM
					SELF.seq         := c + 1; // '+ 1' accounts for the seq value of '1' assigned above
					SELF.acctno      := le.acctno;
					SELF.name_first  := IF( c = 1, le.name_first_1  , le.name_first_2 );
					SELF.name_last   := IF( c = 1, le.name_last_1   , le.name_last_2 );
					SELF.addr1       := IF( c = 1, le.best_address_1, le.best_address_2 );
					SELF.p_city_name := IF( c = 1, le.best_city_1   , le.best_city_2 );
					SELF.st          := IF( c = 1, le.best_state_1  , le.best_state_2 );
					SELF.z5          := IF( c = 1, le.best_zip_1    , le.best_zip_2 );
					SELF             := le;	
					SELF             := [];
				END;

			inputdata_from_best_address :=
					NORMALIZE( ds_best_addr_recs, 2, xfm_for_RT_MVR_batch_2(LEFT,COUNTER) );

			// Combine datasets and attach the sequence # to the acctno.
			inputdata_combined := 
				SORT(
					(inputdata_from_batch_in + inputdata_from_best_address),
					acctno, seq
				);

			inputdata_for_RT_batch := 
				PROJECT(
					inputdata_combined(TRIM(name_last) != ''),
					TRANSFORM( VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2,
						SELF.acctno := TRIM(LEFT.acctno) + '_' + (STRING)LEFT.seq,
						SELF := LEFT
					)
				);

			// Configure RT MVR params module.
			mod_RTMVR_params := module(VehicleV2_Services.IParam.RTBatch_V2_params)
				export UNSIGNED1 Operation         := 0     : stored('Operation');	
				export boolean   use_date          := false : stored('usedate');
				export boolean   select_years      := false : stored('selectyears');
				export unsigned  years             := 0     : stored('numberofyears');	
				export boolean   include_ssn       := false : stored('includeSSN');
				export boolean   include_dob       := false : stored('includeDOB');
				export boolean   include_addr      := false : stored('includeAddress');
				export boolean   include_phone     := false : stored('includePhone');
				export string120 append_l          := ''    : stored('Appends');
				export string120 verify_l          := ''    : stored('Verify');
				export string120 fuzzy_l           := ''    : stored('Fuzzies');
				export boolean   dedup_results_l   := true 	: stored('Deduped');
				export string3   thresh_val        := ''    : stored('AppendThreshold');
				export boolean   GLB_data          := false : stored('GLBData');
				export unsigned1 glb_purpose_value := 8     : stored('glbpurpose');
				export boolean   patriotproc       := false : stored('PatriotProcess');
				export boolean   include_minors    := false : stored('IncludeMinors');
				// 127542 - GatewayNameMatch option works only for gateways - It filters by person's name who owns the vehicle at input address.
				export boolean GatewayNameMatch    := false : stored('GatewayNameMatch');
				export BOOLEAN AlwaysHitGateway    := ~doxie.DataPermission.use_Polk;		
				export BOOLEAN ReturnCurrent			 := false : stored('ReturnCurrent');
				export BOOLEAN FullNameMatch 			 := false : stored('FullNameMatch');
				export boolean Is_UseDate					 := use_date; 
				export string32 ApplicationType 	 := in_mod.application_type;
			END;
			
			ds_mvr_recs_raw := 
					VehicleV2_Services.RealTime_Batch_Service_V2_records(inputdata_for_RT_batch, mod_RTMVR_params, true);		

			// --------------------------[ Royalties ]----------------------------

			recs := ds_mvr_recs_raw;		
			
			BOOLEAN returnDetailedRoyalties	:= TRUE;	
			Royalty.RoyaltyVehicles.MAC_Append(recs, results, vin, hit_flag, true);	
			Royalty.RoyaltyVehicles.MAC_BatchSet(results, royalties,,returnDetailedRoyalties);	
			
			OUTPUT( royalties, NAMED('RoyaltySet') );
	
			// --------------------------------------------------------------------

			// Project into a layout that is exportable:
			ds_mvr_recs := PROJECT( ds_mvr_recs_raw,  PublicHousing_Services.Layouts.layout_RT_mvr_raw );
			
			RETURN ds_mvr_recs;
		END;

END;