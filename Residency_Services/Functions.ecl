IMPORT Address, Census_data, Models, Residency_Services, STD, ut;

EXPORT Functions  := MODULE

  // Some aliased items
	SHARED rec_layout_intermed     := Residency_Services.Layouts.IntermediateData;
  SHARED rec_layout_intermed_ext := Residency_Services.Layouts.IntermediateData_ext;

  //--------Get County name using state postal code abbrev and 3 digit county FIPS code------- //
	EXPORT get_county_name(STRING2 st_in, STRING3 county_fips_in) := FUNCTION
	
		RETURN Census_data.Key_Fips2County(KEYED(st_in          = state_code AND 
		                                         county_fips_in = county_fips)
		                                  )[1].county_name;
	END;
	
	
  //---------------------Dedup all addresses--------------------------------------------------- //		
	EXPORT DedupeAddrs(DATASET(rec_layout_intermed_ext) ds_Bestaddr,
	                   DATASET(rec_layout_intermed_ext) ds_Top4addrs,
								     DATASET(Residency_Services.Layouts.Batch_in) ds_BatchIn
										):= FUNCTION

    // First Join best addr to top4 addrs to pull county name for the best addr from the 
		// matching top4 addr rec which came from the header where it has the county_name populated
		rec_layout_intermed_ext tf_append_BestCountyName(ds_Bestaddr l,
																										 ds_Top4Addrs r) := TRANSFORM
			SELF.county_name := r.county_name;
			SELF := l;
		END;

		ds_BestAddr_wcounty := JOIN(ds_BestAddr, ds_Top4Addrs,
												          LEFT.acctno      = RIGHT.acctno          AND
												          LEFT.prim_range  = RIGHT.prim_range      AND 
												          LEFT.predir      = RIGHT.predir          AND
												          LEFT.prim_name   = RIGHT.prim_name       AND 
												          LEFT.addr_suffix = RIGHT.addr_suffix     AND 
												          LEFT.postdir     = RIGHT.postdir         AND
												          ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
												          LEFT.z5          = RIGHT.z5
												        , 
												        tf_append_BestCountyName(LEFT, RIGHT), 
												        INNER);

		ds_all_addrs := ds_Bestaddr_wcounty + ds_Top4addrs;
		
    // Sort/dedup best addr and the top4 addrs for each acctno.
		ds_all_addrs_dd := DEDUP(SORT(ds_all_addrs,acctno, prim_range, predir, prim_name, addr_suffix,
		                                           postdir, sec_range, p_city_name, st, z5
																							 ,-isBestAddress
																							 ,-dt_last_seen
															   ),
														 acctno,prim_range,predir, prim_name, addr_suffix, postdir, 
														 sec_range, p_city_name, st, z5);

    // Join all dd addrs to input to set IsInputAddress
		rec_layout_intermed_ext tf_append_IsInpAddr (ds_all_addrs_dd l,ds_BatchIn r) := TRANSFORM
			SELF.IsInputAddress := IF(l.prim_range  = r.prim_range      AND
																l.predir      = r.predir          AND
																l.prim_name   = r.prim_name       AND 
																l.addr_suffix = r.addr_suffix     AND
																l.postdir     = r.postdir         AND
																ut.NNEQ(l.sec_range, r.sec_range) AND
																l.z5          = r.z5              
																,
																'Y','N');
			SELF := l;
		END;
		
		ds_IIA_appended_recs := JOIN(ds_all_addrs_dd, ds_BatchIn,
												       LEFT.acctno      = RIGHT.acctno          AND
												       LEFT.prim_range  = RIGHT.prim_range      AND 
												       LEFT.predir      = RIGHT.predir          AND
												       LEFT.prim_name   = RIGHT.prim_name       AND 
												       LEFT.addr_suffix = RIGHT.addr_suffix     AND 
												       LEFT.postdir     = RIGHT.postdir         AND
												       ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
												       LEFT.z5          = RIGHT.z5
												     , 
												     tf_append_IsInpAddr(LEFT, RIGHT), 
												     LEFT OUTER);

    // Put addrs in most to least recent order for debugging assistance
		ds_recs_acctno_date_order := SORT(ds_IIA_appended_recs,
		                                  acctno, 
														          -IsBestAddress // probably not needed, but just to be safe
		                                  ,-dt_last_seen // not really needed but will put the rest of  
														                         // the addrs for each acctno in most recent 
																										 // to least recent order
         		                         );
																			 
    // After addresses for each acctno are deduped, sequence all records in the batch
		// and create the address1/2 fields; projecting onto intermediate layout to strip 
		// off the interim dt_last_seen field.
		ds_recs_seqd := PROJECT(ds_recs_acctno_date_order,
		                        TRANSFORM(Residency_Services.Layouts.IntermediateData, 
														  // 2 special fields for matching property data fields
														  SELF.address1 := Address.Addr1FromComponents(
																							   LEFT.prim_range,  LEFT.predir, LEFT.prim_name, 
																								 LEFT.addr_suffix, LEFT.postdir,'',''),
															SELF.address2 := TRIM(LEFT.unit_desig) + 
																							   IF(TRIM(LEFT.sec_range) != '', 
		                                                ' ' + TRIM(LEFT.sec_range), ''),
		                          SELF.seq := counter, 
															SELF := LEFT ));

	
	  // OUTPUT(ds_Bestaddr,         NAMED('fndda_ds_BestAddr'));
	  // OUTPUT(ds_Top4addrs,        NAMED('fndda_ds_Top4Addrs'));
		// OUTPUT(ds_BatchIn,          NAMED('fndda_ds_BatchIn'));
	  // OUTPUT(ds_Bestaddr_wcounty, NAMED('fndda_ds_BestAddr_wcounty'));
		// OUTPUT(ds_all_addrs,        NAMED('fndda_ds_all_addrs'));
    // OUTPUT(ds_all_addrs_dd,     NAMED('fndda_ds_all_addrs_dd'));
		// OUTPUT(ds_IIA_appended_recs,      NAMED('fndda_ds_IIA_appended_recs'));
		// OUTPUT(ds_recs_acctno_date_order, NAMED('fndda_ds_recs_acctno_date_order'));
		// OUTPUT(ds_recs_seqd,              NAMED('fndda_ds_recs_seqd'));

		RETURN ds_recs_seqd;

	END;


  //-----------------Macro to get counts------------------------------------------------------ //	
	EXPORT mac_getCounts(ds_In, ds_out, Batch_In, fieldname_in_cnt, fieldname_out_cnt) := MACRO 
	
		#uniquename(tableName)
		#uniquename(outRecs)
		
		%tableName% := Residency_Services.fn_getCounts(ds_In,Batch_In);
		
		%outRecs% := JOIN(Batch_In,%tableName%,
										    LEFT.acctno      = RIGHT.acctno      AND 
										    LEFT.county_name = RIGHT.county_name AND
										    LEFT.st = RIGHT.st,
										  TRANSFORM( Residency_Services.Layouts.IntermediateData,
												SELF.fieldname_in_cnt  := RIGHT.in_cnt,
												SELF.fieldname_out_cnt := RIGHT.out_cnt,
												SELF := LEFT),
											LEFT outer);

		ds_out := %outRecs%;
		
	ENDMACRO;
	
  //--------------------Macro to get counts along with expired flag info and dates------------- //
	EXPORT mac_getCountsExpired(ds_In, 
															ds_out, 
															Batch_In, 
															fieldname_in_cnt, 
															fieldname_out_cnt, 
															inExpireFlag, 
															outExpireFlag,  
															indtlastseen,
															outdtlastseen) := MACRO 
		#uniquename(tableName)
		#uniquename(outRecs)
		%tableName% := Residency_Services.fn_getCounts(ds_In,Batch_In);
			
		%outRecs% := JOIN(Batch_In,%tableName%,
										    LEFT.acctno      = RIGHT.acctno      AND 
										    LEFT.county_name = RIGHT.county_name AND
										    LEFT.st          = RIGHT.st,
										  TRANSFORM( Residency_Services.Layouts.IntermediateData,
											  SELF.fieldname_in_cnt  := RIGHT.in_cnt,
												SELF.fieldname_out_cnt := RIGHT.out_cnt,
												SELF.inExpireFlag      := RIGHT.in_expire_flag,
												SELF.outExpireFlag     := RIGHT.out_expire_flag,
												SELF.indtlastseen      := RIGHT.in_dt_last_seen,
												SELF.outdtlastseen     := RIGHT.out_dt_last_seen,
												SELF := LEFT),
										  LEFT OUTER);

		ds_out := %outRecs%;
	ENDMACRO;


  //--------------------FUNCTION to prepare output to batch------------------------------------ //	
	EXPORT preptobatch(DATASET(Models.Layout_Residency_Batch.Layout_Debug) ds_input) := FUNCTION

	  Residency_Services.Layouts.Batch_out  tf_prepbatch(ds_input L) := TRANSFORM
      // orig batch input acctno, name, ssn, dob, residency_county/state & phone will be 
			//    assigned at bottom with self :=l
      // But will need to restore input address info into the original field names
			SELF.prim_range  := L.batch_in_prim_range;
		  SELF.predir      := L.batch_in_predir;
		  SELF.prim_name   := L.batch_in_prim_name;
		  SELF.addr_suffix := L.batch_in_addr_suffix;
		  SELF.postdir     := L.batch_in_postdir;
		  SELF.unit_desig  := L.batch_in_unit_desig;
		  SELF.sec_range   := L.batch_in_sec_range;
		  SELF.p_city_name := L.batch_in_p_city_name;
		  SELF.st          := L.batch_in_st;
		  SELF.z5          := L.batch_in_z5;
		  SELF.zip4        := L.batch_in_zip4;
		  SELF.county_name := L.batch_in_county_name;

		  SELF.Input_Identity_NotFound := L.Entity_NotFound;  // Y or N
	      BOOLEAN PersonFound := L.Entity_NotFound = 'N';
			SELF.Residency_County_Found := IF(PersonFound AND 
			                                  (STD.STR.ToUpperCase(L.county_name) = 
			                                   STD.STR.ToUpperCase(L.residency_county)),
			                                  'Y','N');
			SELF.Residency_State_Found  := IF(PersonFound AND
			                                  (STD.STR.ToUpperCase(L.st) = 
			                                   STD.STR.ToUpperCase(L.residency_State)),
			                                  'Y','N');
      SELF.Confidence_Score  := IF(PersonFound AND L.RB_score > 0, L.RB_score, 0); // RB_score = the "score" out of the model
			SELF.Confidence_State  := IF(PersonFound,L.st,'');
			SELF.Confidence_County := IF(PersonFound,L.county_name,'');

				AssetsY := IF(l.Veh_in_cnt >0        OR l.ProfLic_in_cnt >0  OR l.Property_in_cnt >0 OR
										  l.Watercraft_in_cnt >0 OR l.Aircraft_in_cnt >0 OR l.Business_in_cnt >0,
											'Y','');
				AssetsN := IF(l.Veh_out_cnt >0        OR l.ProfLic_out_cnt >0 OR l.Property_out_cnt >0 OR
										  l.Watercraft_out_cnt >0 OR l.Aircraft_out_cnt>0 OR l.Business_out_cnt >0,
										  'N','');
			SELF.Assets := MAP(
											AssetsY = 'Y' => 'Y',
											AssetsN = 'N' => 'N',
												'');
			
			SELF.Driver_Lic :=  MAP(
														l.DL_in_cnt >0 => 'Y',
														l.DL_out_cnt >0 => 'N',
														'');
											
			SELF.Hunt_Fish_Lic :=  MAP(
															l.HuntFish_in_cnt >0 => 'Y',
															l.HuntFish_out_cnt >0 => 'N',
															'');
											
				UtilitiesY := IF(l.Phone_in_cnt >0 OR l.Utility_in_cnt >0,'Y',''); 
				UtilitiesN := IF(l.Phone_out_cnt >0 OR l.Utility_out_cnt >0,'N',''); 
			SELF.Utilities := MAP(
													UtilitiesY = 'Y' => 'Y',
													UtilitiesN = 'N' => 'N',
												'');									

			SELF.Header_DID := IF(L.did=0, '',(STRING) L.did);
											
			SELF.Homestead := l.Property_homestead;

				Public_RecordsY := IF(l.Bankruptcy_in_cnt >0  OR l.LienJudg_in_cnt >0 OR 
											        l.Foreclosure_in_cnt >0 OR l.PAW_in_cnt >0,'Y','');
				Public_RecordsN := IF(l.Bankruptcy_out_cnt >0  OR l.LienJudg_out_cnt >0 OR 
											        l.Foreclosure_out_cnt >0 OR l.PAW_out_cnt >0,'N','');
			SELF.Public_Records := MAP(
															Public_RecordsY = 'Y' => 'Y',
															Public_RecordsN = 'N' => 'N',
															'');

			SELF.Voter := MAP(
											l.Voter_in_cnt >0 => 'Y',
											l.Voter_out_cnt >0 => 'N',
											'');
			
      // the next 3 output fields were not asked for in the 2016 product requirements, 
			// but were included for future use.
			// However the address cleaning coding will be commented out for now since there is 
			// overhead involved in re-cleaning the address.
			// If needed in the future, maybe those 3 fields could be carried forward from the 
			// top 4 address records retreived from the person header file.
			//  addr1	:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,l.addr_suffix, 
			//	                                     l.postdir, l.unit_desig, l.sec_range);
			// addr2 := Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
			//  clean_addr 	:= address.GetCleanAddress(addr1,addr2,address.Components.country.US);
			//  car         := clean_addr.results;
			SELF.Lat_Conf_Addr     := ''; //car.latitude;  
			SELF.Long_Conf_Addr    := ''; //car.longitude;
			SELF.Geocode_Conf_Addr := ''; //car.county;
			
			SELF := L;  // restores orig input fields: name, ssn, dob, residency_county/state, phone
			            // and assigned acctno
		END;
		
		ds_batch_out_layout := PROJECT(ds_input, tf_prepbatch(LEFT));

		RETURN ds_batch_out_layout;
	END;

END;