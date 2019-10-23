
IMPORT AccountMonitoring, Phonesplus_v2, gong, ut, watchdog, header, utilfile, 
       header_quick, NID, Paw, Risk_Indicators;

EXPORT DATASET(layouts.history) fn_cgm_phone(
		 DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		 DATASET(AccountMonitoring.layouts.documents.phone.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.phone.base),
		 AccountMonitoring.i_Job_Config job_config ) := 
	
	FUNCTION

		timestamp := thorlib.WUID()[2..9];
		
		in_portfolio_did_dist := DISTRIBUTE(in_portfolio(did <> 0),HASH64(did)) : INDEPENDENT;
		
		in_portfolio_nm_addr_dist := 
			DISTRIBUTE(in_portfolio(prim_name <> '', prim_range <> '', st <> '', z5 <> '', name_last <> '', name_first <> ''),
				         HASH64(name_last,prim_range,prim_name,z5));
			
		// Phone Layout
		base_Phone_layout := 
		   RECORD
				Phonesplus_v2.Layout_Phonesplus_Base.fname;
				Phonesplus_v2.Layout_Phonesplus_Base.mname;
				Phonesplus_v2.Layout_Phonesplus_Base.lname;			
				Phonesplus_v2.Layout_Phonesplus_Base.prim_range;
				Phonesplus_v2.Layout_Phonesplus_Base.prim_name;
				Phonesplus_v2.Layout_Phonesplus_Base.sec_range;
				Phonesplus_v2.Layout_Phonesplus_Base.v_city_name;
				Phonesplus_v2.Layout_Phonesplus_Base.state;
				Phonesplus_v2.Layout_Phonesplus_Base.zip5;
				Phonesplus_v2.Layout_Phonesplus_Base.did;
				STRING10  Phone := '';	
				STRING2   src := '';
				UNSIGNED3 dt_vendor_last_reported := 0;
		END;																			
		
		// Temporary Join Layout

		temp_layout := 
		   RECORD
			   in_documents.pid;
			   in_documents.rid;
			   in_documents.hid;
			   base_phone_layout;
			   STRING8 date_last_seen;
			   STRING1 phone_type_code;
				END;
		
		/////////////////
		// type TA -- ES
		/////////////////
		
		file_history_address := 
			DISTRIBUTED(
				product_files.phone.file_history_address, 
				HASH64(name_last,prim_range,prim_name,z5)
			);

		// Pivot on prim_name, prim_range, z5, sec_range for land lines
		
		temp_base_dist_A := file_history_address(prim_range <> '', st <> '', name_last <> '', name_first <> '') : INDEPENDENT;

     // Note: this join does check for the first name and last name flip flopped.				
		 //
		 // temp_join_A_undist is distributed on HASH64(lname,prim_range,prim_name,zip5)
		 //
		temp_join_A_undist := JOIN(temp_base_dist_A,
                                 in_portfolio_nm_addr_dist, 			 
                                 LEFT.prim_name  = RIGHT.prim_name AND
                                 LEFT.z5         = RIGHT.z5 AND
                                 LEFT.prim_range = RIGHT.prim_range AND 
                                 LEFT.st         = RIGHT.st AND 
                                 ((metaphonelib.DMetaPhone1(LEFT.name_last) = metaphonelib.DMetaPhone1(RIGHT.name_last) AND
                                 ((RIGHT.sec_range = '' AND (RIGHT.name_first[1] = LEFT.name_first[1])) OR
                                 (RIGHT.sec_range <> '' AND NID.PreferredFirstNew(RIGHT.name_first) = NID.PreferredFirstNew(LEFT.name_first)))) 
                                 OR 
                                 (metaphonelib.DMetaPhone1(RIGHT.name_first) = metaphonelib.DMetaPhone1(LEFT.name_last) AND
                                 (RIGHT.sec_range = '' AND (RIGHT.name_last[1] = RIGHT.name_first[1])))) AND
																 LEFT.phone10 <> '',
                                 TRANSFORM(temp_layout,
                                           SELF.pid            := RIGHT.pid,
                                           SELF.rid            := RIGHT.rid,
                                           SELF.did            := RIGHT.did;
                                           // match up field cause used phones plus layout for temp layout and gong history file has different names
                                           SELF.fname          := LEFT.name_first;
                                           SELF.mname          := LEFT.name_middle;
                                           SELF.lname          := LEFT.name_last;
                                           SELF.zip5           := LEFT.z5;
                                           SELF.state          := LEFT.st;
                                           SELF.Phone          := LEFT.phone10;
                                           SELF.date_last_seen := (STRING8) LEFT.dt_last_seen;
                                           SELF                := LEFT,
                                           SELF                := []),
                                 LOCAL);
		
		temp_join_A := DISTRIBUTE(temp_join_A_undist, HASH64(did));
		
		///////////////////////////////
		// TYPE TB -- SE / TYPE TF -- SX
		///////////////////////////////

    dist_header := DISTRIBUTED(AccountMonitoring.product_files.header_files.doxie_key_header_slim, HASH64(did));
		
		// temp_join_B1_inter is distributed on HASH64(did) (time to run--56:23)
		temp_join_B1_inter := JOIN(dist_header,
		                           in_portfolio_did_dist, 
			                        LEFT.did = RIGHT.did,
				                     TRANSFORM(temp_layout,
                                           SELF.pid            := RIGHT.pid,
                                           SELF.rid            := RIGHT.rid, 
                                           SELF.hid            := 0,
                                           SELF.did            := RIGHT.did,				
                                           SELF.fname          := LEFT.fname;
                                           SELF.mname          := LEFT.mname;
                                           SELF.lname          := LEFT.lname;
                                           SELF.v_city_name    := LEFT.city_name;
                                           SELF.zip5           := LEFT.zip;
                                           SELF.state          := LEFT.st;
                                           SELF.Phone          := LEFT.phone;
                                           SELF.date_last_seen := (STRING8) LEFT.dt_last_seen;
                                           SELF                := LEFT,
                                           SELF                := []),
                                 LOCAL);

		
    dist_quick_header := DISTRIBUTED(AccountMonitoring.product_files.header_files.quick_header_key_DID_slim, HASH64(did)); 
		
		// temp_join_B2_inter is distributed on HASH64(did)
		temp_join_B2_inter := JOIN(dist_quick_header,
                                 in_portfolio_did_dist, 
                                 LEFT.did = RIGHT.did,
                                 TRANSFORM(temp_layout,
                                           SELF.pid            := RIGHT.pid,
                                           SELF.rid            := RIGHT.rid, 
                                           SELF.hid            := 0,
                                           SELF.did            := RIGHT.did,				
                                           SELF.fname          := LEFT.fname;
                                           SELF.mname          := LEFT.mname;
                                           SELF.lname          := LEFT.lname;
                                           SELF.v_city_name    := LEFT.city_name;
                                           SELF.zip5           := LEFT.zip;
                                           SELF.state          := LEFT.st;
                                           SELF.Phone          := LEFT.phone;					
                                           SELF.date_last_seen := (STRING8) LEFT.dt_last_seen;
                                           SELF                := LEFT,
                                           SELF                := []),
                                 LOCAL);


		dist_util_daily := DISTRIBUTED(AccountMonitoring.product_files.header_files.daily_utility_key_DID_slim, HASH64((UNSIGNED6)did));

		// temp_join_B3_inter is distributed on HASH64(did)
		temp_join_B3_inter := JOIN(dist_util_daily, 
                                 in_portfolio_did_dist, 
                                 (UNSIGNED6) LEFT.did = RIGHT.did,
                                 TRANSFORM(temp_layout,
                                           SELF.pid            := RIGHT.pid,
                                           SELF.rid            := RIGHT.rid, 
                                           SELF.hid            := 0,
                                           SELF.did            := RIGHT.did,					
                                           SELF.fname          := LEFT.fname;
                                           SELF.mname          := LEFT.mname;
                                           SELF.lname          := LEFT.lname;
                                           SELF.v_city_name    := LEFT.Address_city;
                                           SELF.zip5           := LEFT.zip;
                                           SELF.state          := LEFT.st;
                                           SELF.Phone          := LEFT.phone;				
                                           SELF.date_last_seen := (STRING8) LEFT.record_date;
                                           SELF                := LEFT,
                                           SELF                := []),
                                 LOCAL);
		
		//
		// BDidset is distributed on HASH64(did)
		//
		BDidset := DEDUP(SORT((temp_join_B1_inter + temp_join_B2_inter + temp_join_B3_inter), 
													pid, rid, did, fname, lname, prim_range, prim_name, state, zip5, phone, -date_last_seen, LOCAL),
									    pid, rid, did, fname, lname, prim_range, prim_name, state, zip5, phone, LOCAL) : INDEPENDENT;												  

		BDidset_redist_nm_addr := DISTRIBUTE(BDidset(prim_name <> '', prim_range <> '', state <> '', zip5 <> '', lname <> '', fname <> ''), 
		                                     HASH64(lname,prim_range,prim_name,zip5));
		
		// For every address whose date last seen is newer than 5 years, perform a DA lookup on last name
		// and address.							
		temp_join_B3 :=  JOIN( temp_base_dist_A, 
                             BDidset_redist_nm_addr,
                             LEFT.prim_name  = RIGHT.prim_name AND
														 LEFT.prim_range = RIGHT.prim_range AND
                             LEFT.z5         = RIGHT.zip5 AND
                             ((LEFT.name_last = RIGHT.lname) OR
														 (LENGTH(TRIM(RIGHT.lname))>1 AND stringlib.StringFind(TRIM(LEFT.listed_name), TRIM(RIGHT.lname), 1)>0) OR
                             (LENGTH(TRIM(RIGHT.fname))>1 AND TRIM(RIGHT.fname)=TRIM(LEFT.name_last))) AND
														 LEFT.phone10 <> '',
                             TRANSFORM(temp_layout,
                                       SELF.pid := RIGHT.pid,
                                       SELF.rid := RIGHT.rid, 
                                       SELF.hid := 0,
                                       SELF.did := RIGHT.did,
                                       SELF.fname := LEFT.name_first,
                                       SELF.mname := LEFT.name_middle,
                                       SELF.lname := LEFT.name_last,
                                       SELF.zip5 := LEFT.z5,
                                       SELF.state := LEFT.st,
                                       SELF.Phone := LEFT.phone10,
                                       SELF.date_last_seen := LEFT.dt_last_seen,
                                       SELF  := LEFT,
                                       SELF := []),
                             LOCAL);

		// file_history_phone is distributed on HASH64(name_last, name_first, phone7, area_code)
		file_history_phone := DISTRIBUTED(product_files.phone.file_history_phone, HASH64(name_last, name_first, phone7, area_code));
												 
		BDidset_redist_nm_phone := DISTRIBUTE(BDidset(phone <> '', fname <> '', lname <> ''), 
		                                      HASH64(lname, fname, phone[4..10], phone[1..3]));
		
		temp_join_B4 := JOIN(file_history_phone,
                           BDidset_redist_nm_phone,
                           LEFT.phone7    = RIGHT.phone[4..10] AND 
                           LEFT.area_code = RIGHT.phone[1..3] AND
                           (RIGHT.fname   = LEFT.name_first OR 
                           length(trim(RIGHT.fname))     = 1 AND RIGHT.fname = LEFT.name_first[1] OR 
                           length(trim(LEFT.name_first)) = 1 AND RIGHT.fname[1] = LEFT.name_first) AND
                           LEFT.name_last = RIGHT.lname AND
													 LEFT.phone10 <> '',
                           TRANSFORM(temp_layout,
                                     SELF.pid            := RIGHT.pid,
                                     SELF.rid            := RIGHT.rid, 
                                     SELF.hid            := 0,				
                                     SELF.did            := RIGHT.did,								
                                     SELF.fname          := LEFT.name_first,
                                     SELF.mname          := LEFT.name_middle,
                                     SELF.lname          := LEFT.name_last,
                                     SELF.phone          := LEFT.phone10,
                                     SELF.zip5           := LEFT.z5,
                                     SELF.state          := LEFT.st,
                                     SELF.date_last_seen := LEFT.dt_last_seen,
                                     SELF                := LEFT,
                                     SELF                := []), 
                           LOCAL);

		// ***** Pivot on city name, state, lname, fname ***** - WAS part of TYPE TF -- SX which was dealing with records that had a phone
		file_history_name_city_st := DISTRIBUTED(product_files.phone.file_history_name_city_st, HASH64(city_code,st,dph_name_last,name_last,p_name_first,name_first));
		
		BDidset_redist_nm_city_st := DISTRIBUTE(BDidset(phone <> '', v_city_name <> '', state <> '', lname <> '', fname <> ''), 
																						HASH64((QSTRING25)v_city_name, state, metaphonelib.DMetaPhone1(lname)[1..6], lname, NID.PreferredFirstNew(fname), fname));
		
		temp_join_B5 := JOIN(BDidset_redist_nm_city_st,	
                           file_history_name_city_st,																		
                           HASH((QSTRING25)LEFT.v_city_name) = RIGHT.city_code AND             
                           LEFT.state = RIGHT.st AND       
                           metaphonelib.DMetaPhone1(LEFT.lname)[1..6] = RIGHT.dph_name_last AND
                           LEFT.lname <> '' AND 
													 LEFT.lname = RIGHT.name_last AND
                           ((NID.PreferredFirstNew(LEFT.fname) = RIGHT.p_name_first) OR
                           ((LEFT.fname[1]=RIGHT.name_first OR LEFT.fname = RIGHT.name_first) AND	RIGHT.prim_name='')) AND
													 RIGHT.phone10 <> '', 
                           TRANSFORM(temp_layout,
                                     SELF.pid            := LEFT.pid,
                                     SELF.rid            := LEFT.rid,
                                     SELF.did            := LEFT.did,
                                     SELF.fname          := RIGHT.name_first,
                                     SELF.mname          := RIGHT.name_middle,
                                     SELF.lname          := RIGHT.name_last,
                                     SELF.zip5           := RIGHT.z5,
                                     SELF.state          := RIGHT.st,
                                     SELF.Phone          := RIGHT.phone10,					
                                     SELF.date_last_seen := RIGHT.dt_last_seen;
                                     SELF                := RIGHT,
                                     SELF                := []),
                           LOCAL);

		// temp_join_B3 is distributed on HASH64(lname,prim_range,prim_name,zip5)
		// temp_join_B4 is distributed on HASH64(name_last, name_first, phone7, area_code)
		temp_join_B3_redist := DISTRIBUTE(temp_join_B3, HASH64(did));
		temp_join_B4_redist := DISTRIBUTE(temp_join_B4, HASH64(did));
		temp_join_B5_redist := DISTRIBUTE(temp_join_B5, HASH64(did));
		
		temp_join_B := temp_join_B3_redist + temp_join_B4_redist + temp_join_B5_redist;
		
		
		///////////////////////////////
	  // type TC -- AP
		///////////////////////////////
		//
		// temp_join_C is distributed on HASH64(did)
		//
		temp_join_C := BDidset(phone <> '');
		
					 
		////////////////////
		// TYPE TG - PP
		////////////////////
		
		// pivot on did for cell phones
		
		temp_base_dist_cell := DISTRIBUTED(product_files.phone.base_file_cell, HASH64(did));	
												
		temp_join_G := JOIN(temp_base_dist_cell,
                          in_portfolio_did_dist,
                          LEFT.did = RIGHT.did AND
													LEFT.cellPhone <> '',
                          TRANSFORM(temp_layout,			  
                                    SELF.pid := RIGHT.pid,
                                    SELF.rid := RIGHT.rid, 
                                    SELF.hid := 0,								
                                    SELF.did := RIGHT.did,
                                    SELF.Phone := LEFT.cellPhone;
                                    SELF.date_last_seen := (STRING8) LEFT.DateLastSeen;
                                    // self := right takes care of setting all the phone field fields cause
                                    // temp_layout is same as right.
                                    SELF := LEFT,
                                    SELF := []),
                          LOCAL);					
			
		////////////////////
		// TYPE TH - NE
		////////////////////
		
		// best file.  logic in phones type H does filtering on this key.  Taking wide view here.
		temp_base_dist_neighbor := DISTRIBUTED(product_files.phone.base_file_neighbor, HASH64(did));
		
		temp_join_H := JOIN(temp_base_dist_neighbor,
                          in_portfolio_did_dist,
                          LEFT.did = RIGHT.did AND
													LEFT.phone <> '',
                          TRANSFORM(temp_layout,
                                    SELF.did := RIGHT.did,
                                    SELF.pid := RIGHT.pid,
                                    SELF.rid := RIGHT.rid, 
                                    SELF.hid := 0,								
                                    SELF.v_city_name := LEFT.city_name,
                                    SELF.zip5 := LEFT.zip,
                                    SELF.state :=  LEFT.st,
                                    SELF.Phone := LEFT.phone;
                                    SELF.date_last_seen := (STRING8) LEFT.addr_dt_last_seen;
                                    // self := left takes care of setting all the phone field fields cause
                                    // temp_layout is same as right.
                                    SELF := LEFT,
                                    SELF := []),
                          LOCAL);

		///////////////////
		//TYPE W
		///////////////////
		
		base_file_paw_did := DISTRIBUTED(product_files.phone.base_file_paw_did, HASH64(did));
						
		temp_join_W := JOIN(base_file_paw_did,
                          in_portfolio_did_dist,
                          LEFT.did =  RIGHT.did AND
													LEFT.phone <> '',
                          TRANSFORM(temp_layout,
                                    SELF.pid            := RIGHT.pid,
                                    SELF.rid            := RIGHT.rid, 
                                    SELF.hid            := 0,
                                    SELF.did            := RIGHT.did,				
                                    SELF.fname          := LEFT.fname;
                                    SELF.mname          := LEFT.mname;
                                    SELF.lname          := LEFT.lname;
                                    SELF.v_city_name    := LEFT.City;
                                    SELF.zip5           := LEFT.zip;
                                    SELF.state          := LEFT.state;
                                    SELF.Phone          := LEFT.phone;
                                    SELF.date_last_seen := '';
                                    SELF                := LEFT;
                                    SELF                := []),
                          LOCAL);
		
		///////////////////////
		// DOCUMENT MONITORING
		///////////////////////
		
		temp_project_documents := PROJECT(in_documents,
		                                  TRANSFORM(temp_layout,
		                                            SELF.did := 0,
		                                            SELF     := LEFT,
		                                            SELF     := []))(phone <> '');
		
		///////////////////////
		// PHONE ONLY MONITORING (For Switch / Phone Type)
		///////////////////////
		temp_project_portfolio_phone_only := PROJECT(in_portfolio(phone <> ''),
																								 TRANSFORM(temp_layout,
																													 SELF.pid         := LEFT.pid;
																													 SELF.rid         := LEFT.rid; 
																													 SELF.hid         := 0;
																													 SELF.did         := LEFT.did;
																													 SELF.fname       := LEFT.name_first;
																													 SELF.mname       := LEFT.name_middle;
																													 SELF.lname       := LEFT.name_last;
																													 SELF.v_city_name := LEFT.p_city_name;
																													 SELF.state       := LEFT.st;
																													 SELF.zip5        := LEFT.z5;
																													 SELF.Phone := Stringlib.StringFilterOut(LEFT.phone, '( .)-');
																													 SELF       := LEFT;
																													 SELF       := [];));
																													 
		// ============== Union all Join results. ==============
		
		 temp_phone_joins :=
				temp_join_A  + 		                    
				temp_join_B  + 	                    
				temp_join_C  +    
				// temp_join_F  +    // removed - rolled into temp_join_B
				temp_join_G  + 
				temp_join_H  + 
				temp_join_W  +
				temp_project_documents +
				temp_project_portfolio_phone_only
				;																		
		
		temp_all_deduped := DEDUP(SORT(DISTRIBUTE(temp_phone_joins,HASH64(pid,rid,hid)),
		                             pid,rid,hid,did,phone,-date_last_seen,RECORD,LOCAL),
													 pid,rid,hid,did,phone,LOCAL) : INDEPENDENT;													


		// SWITCH TYPE / PHONE TYPE
		temp_add_phone_type_non_10  := temp_all_deduped(LENGTH(TRIM(phone)) != 10);
		temp_add_phone_type_non_10_U := PROJECT(temp_add_phone_type_non_10,
																						TRANSFORM(temp_layout,
																											SELF.phone_type_code := product_files.phone.UNKNOWN_TYPE;
																											SELF := LEFT;));
		
		key_Telcordia_tds 					:= DISTRIBUTED(product_files.phone.telcordia_tds, HASH64(npa, nxx, tb));
		temp_add_phone_type_full_10 := DISTRIBUTE(temp_all_deduped(LENGTH(TRIM(phone)) = 10), HASH64(phone[1..3], phone[4..6], phone[7]));

		ds_Telecordia_SSCs := JOIN(temp_add_phone_type_full_10, key_Telcordia_tds,
															 RIGHT.npa = LEFT.phone[1..3] AND
															 RIGHT.nxx = LEFT.phone[4..6] AND
															 RIGHT.tb = LEFT.phone[7],
															 TRANSFORM(temp_layout,
																				 SELF.phone_type_code := product_files.phone.fn_GetPhoneTypeCode(LEFT.phone[1..3], RIGHT.COCType, RIGHT.SSC);
																				 SELF                 := LEFT;),
															 LEFT OUTER, KEEP(1), LOCAL);
		
		// Since the neustar file has only the cellphone as its unique identifier (i.e. no
		// did or personal information) we need to get the conv_to_cell flag in a secondary join:
		base_file_neustar := DISTRIBUTED(product_files.phone.base_file_neustar, HASH64(CellPhone));
		ds_Telecordia_SSCs_redist := DISTRIBUTE(ds_Telecordia_SSCs, HASH64(phone));
		
		temp_add_conv_to_cell_flag :=
			JOIN(
				ds_Telecordia_SSCs_redist, 
				base_file_neustar,
				LEFT.phone = RIGHT.cellphone,
				TRANSFORM(
					temp_layout,
					SELF.phone_type_code := IF(LEFT.phone = RIGHT.cellphone,
																		 product_files.phone.CELL_PHONE,
																		 LEFT.phone_type_code),
					SELF                    := LEFT),
				LEFT OUTER, LOCAL);	
				
						
		temp_all_recombine := temp_add_conv_to_cell_flag + temp_add_phone_type_non_10_U;
		
		// Now, create a hash value from only those fields we're interested in (these 
		// are the ones in the temporary layout).
		temp_redist_again := SORT(DISTRIBUTE(temp_all_recombine,HASH64(pid,rid,hid)),pid,rid,hid,LOCAL);
		temp_unrolled_hashes := PROJECT(temp_redist_again,
			TRANSFORM( AccountMonitoring.layouts.history,
				        SELF.pid          := LEFT.pid,
				        SELF.rid          := LEFT.rid, 
				        SELF.hid          := LEFT.hid,
				        SELF.did          := LEFT.did,
				        SELF.bdid         := 0,
				        SELF.timestamp    := '',
				        SELF.product_mask := AccountMonitoring.Constants.pm_phone,
				        SELF.hash_value   := HASH64(LEFT.phone,
                                            LEFT.phone_type_code																					
																						),
                    SELF := LEFT));
		
		temp_rolled_hashes := 
			ROLLUP(
				SORT(
					DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid))
					,pid,rid,hid,RECORD, 
					LOCAL
				),
			 // ...rolling up the hashes for all records for a particular pid/rid/hid.
				TRANSFORM(AccountMonitoring.layouts.history,
					SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
					SELF := LEFT
				),
			pid,rid,hid,
			LOCAL
		);

		// output(choosen(temp_project_portfolio_phone_only,5000),named('temp_project_portfolio_phone_only'));
		// output(choosen(temp_redist_again,5000),named('temp_redist_again'));
	
		RETURN temp_rolled_hashes;

	END;
