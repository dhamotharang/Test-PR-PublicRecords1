
import BatchShare, ut, VehicleV2, VehicleV2_Services;

export ERO_Services.Layouts.Vehicles_out fn_getVehicleRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
	function
		/*
			Requirement 4.1-25:
			Search in-house MVR by the best subject being returned to ERO and output address 1 and 
			address 2 (ones being returned after dedupe process) and DL address (if different).  The 
			3 most current vehicle registrations based on expiration date will be returned in order 
			of most current to least current registration.  Only include records where the expiration 
			date is less than 5 years from the date the batch was processed.

			A match code will be returned for each vehicle registration stating how the record’s LexID, 
			name and address matches the best subject’s LexID or name and which address it matched on.
				o   Full Name Match – Exact First Name and Exact Last Name (partial or multiple when 
						there are multi-word first or last names. A match can be on both last names or either 
						last name and/or both first names or either first names)
				o   Last Name Match – Exact Last Name (partial or multiple meaning it can match on both 
						last name or either last name)
				o   Address Match - House number, primary street name and zip code

			Return the following output fields: 
				o   The full name of the (last, first, middle) subject found in the Vehicle Data 
				o   Vehicle VIN
				o   Plate Number
				o   Plate State
				o   Color/Year/Make/Model/Series (return in one field having data in this order)
				o   Registration Date
				o   Expiration Date (only output records where the exp. date is < 5 years from 'today')
				o   Match code:
						-  LexId related Match (L)
						-  Full Name, Address 1 match (F1)
						-  Full Name, Address 2 match (F2)
						-  Full Name, DL Address match (FDL)
						-  Last Name, Address 1 match (L1)
						-  Last Name, Address 2 match (L2)
						-  Last Name, DL Address match (LDL)
		*/
		/*
			Engineering notes (1/31/2013):
			The VehicleV2_Services.LicPlate_Batch_Service calls the _Records attribute and obtains Vehicle
			key values (i.e. Vehicle_Key, Iteration_Key, Sequence_Key) only after an Autokey search, a
			License Plate search and a DID lookup. The _Records attribute then calls Batch_transforms
			.get_flatLayout( ),	which then calls Functions.Get_VehicleSearch( ). Thoughout all of this, the
			service performs only two keyjoins that we care about, and these take place in Functions
			.Get_VehicleSearch( ). 

			In this function, we take the dids provided by the formal parameter 'ids' and project them into 
			a different layout, and then we call Functions.Get_VehicleSearch( ). The results of this function
			are then tranformed into the output layout needed for this product, while implementing the rules
			specified by the product requirements.
		*/

		// 1.  Get Vehicle key lookup values by did: Vehicle_Key, Iteration_Key, Sequence_Key. Dedup.
		layout_acctno_plus_veh_key := record
			BatchShare.Layouts.ShareAcct;
			VehicleV2_Services.Layout_Vehicle_Key;
		end;
			
		vehicle_keys_by_did := 
			join(
				ids, VehicleV2.Key_Vehicle_DID, 
				KEYED(LEFT.did = RIGHT.Append_DID), 
				transform(layout_acctno_plus_veh_key,
					self := right,
					self := left,
					self := []
				), 
				inner,
				limit(VehicleV2_Services.Constant.VEHICLE_PER_DID, skip)
			);

		vehicle_keys_by_did_dedup := 
			dedup(
				sort(
					vehicle_keys_by_did, 
					acctno, Vehicle_Key, Iteration_Key, Sequence_Key
				),
				acctno, Vehicle_Key, Iteration_Key, Sequence_Key
			);

		// 2.  Join back to 'ids' and project into the layout needed to call Functions.Get_VehicleSearch( ).
		ds_vehicle_search_input := 
			join(
				ids, vehicle_keys_by_did_dedup, 
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( VehicleV2_Services.Layout_VKeysWithInput, 
					self.Vehicle_Key   := right.Vehicle_Key,
					self.Iteration_Key := right.Iteration_Key,
					self.Sequence_Key  := right.Sequence_Key,
					self.state_origin  := right.state_origin, // needed for dppa stuff
					self.is_deep_dive  := false;
					self.acctno        := left.acctno;
					self.DID           := left.did;
					self               := []
				), 
				KEEP(ERO_Services.Constants.Limits.MAX_VEH_JOIN_KEEP)
			);

			// 2.a. Resort and group.
			ds_search_input := 
				group(
					sort(
						ds_vehicle_search_input, 
						Vehicle_Key, Iteration_Key, Sequence_Key
					),
					Vehicle_Key, Iteration_Key, Sequence_Key
				);
			
			// 2.b. Get IParam.getSearchModule--needed as the first param for unctions.Get_VehicleSearch( ).
			in_mod := VehicleV2_Services.IParam.getSearchModule();
			
			// 3.  Get Vehicle records.
			veh_recs_raw := VehicleV2_Services.Functions.Get_VehicleSearch(in_mod, ds_search_input, false);
			
			// 4.  Implement rules per the product requirements.
			
			// 4.a.  Remove any vehicle records that have no registrants. Project into a slimmer layout  
			// while we're at it.
			layout_vehicle_registrants_temp := record
				string20 acctno;
				string15 DataSource := VehicleV2_Services.Constant.local_val;
				VehicleV2_Services.Layout_Report_Vehicle;
				VehicleV2_Services.Layout_Vehicle_Key.Sequence_Key;
				dataset(VehicleV2_Services.assorted_layouts.Layout_registrant) registrants {maxcount(VehicleV2_Services.Constant.max_child_count)};	
			end;
			
			layout_vehicle_registrants_temp xfm_remove_zero_registrants(VehicleV2_Services.Layouts.Layout_Report_Batch_New le) :=
				transform, skip( count(le.registrants) = 0 )
					self := le;
				end;
				
			veh_recs_nonblank_registrants := project(ungroup(veh_recs_raw),xfm_remove_zero_registrants(left));
			
			// 4.b.  Get rid of any duplicate vehicle records.
			veh_recs_deduped := 
			dedup(
				sort(
					veh_recs_nonblank_registrants, 
					acctno, Vehicle_Key, Iteration_Key, Sequence_Key, -(max(registrants(Sequence_Key <> ''), date_vendor_last_reported))
				),
				acctno, Vehicle_Key, Iteration_Key, Sequence_Key, max(registrants(Sequence_Key <> ''), date_vendor_last_reported)
			);
			
			// 4.c.  Remove any registrants whose did doesn't match that of the search subject.
			veh_recs_did_nomatches_removed :=
				join(
					ids, veh_recs_deduped,
					left.acctno = right.acctno,
					transform( layout_vehicle_registrants_temp,
						self.registrants := CHOOSEN(right.registrants( (unsigned6)append_did = left.did ),VehicleV2_Services.Constant.max_child_count),
						self := right
					),
					inner
				);
			
			// 4.d.  Remove any vehicle records whose latst expiration date is older than five years. 
			//
			// .. The following function is called from xfm_remove_old_registrations(), below.
			if_five_years_or_older(layout_vehicle_registrants_temp le) := 
				function
						// Dates to compare.
					string today := StringLib.getdateYYYYMMDD();
					unsigned exp_date := max(le.registrants, (unsigned)reg_latest_expiration_date);
					
						// Temp variables.
					integer length_exp_date := length((string)exp_date);
					string4 five_yrs_ago_yyyy := (string4)(((unsigned)today[1..4]) - 5);
					
						// Calculate the date five years ago for dates having lengths of 8 (yyyymmdd), 6, or 4
					five_yrs_ago :=
						case( length_exp_date,
							8 => five_yrs_ago_yyyy + today[5..8],
							6 => five_yrs_ago_yyyy + today[5..6],
							4 => five_yrs_ago_yyyy,
							'20000101'
						);
					
					return /* whether */ exp_date < (unsigned)five_yrs_ago or exp_date = 0;
				end;
				
			layout_vehicle_registrants_temp xfm_remove_old_registrations(layout_vehicle_registrants_temp le) :=
				transform, skip( if_five_years_or_older(le) )
					self := le;
				end;
				
			veh_recs_recent_only := project(veh_recs_did_nomatches_removed,xfm_remove_old_registrations(left));

			// 4.e.  Also, remove any vehicle records whose registrants.latest_vehicle_flag is 'N'.
			layout_vehicle_registrants_temp xfm_remove_non_latest_vehicles(layout_vehicle_registrants_temp le) :=
				transform, skip( le.registrants[1].latest_vehicle_flag = 'N' )
					self := le;
				end;
				
			veh_recs_latest_vehicles_only := project(veh_recs_recent_only,xfm_remove_non_latest_vehicles(left));
			
			// 5.  Sort, group, and rollup; return.
			veh_recs := 
				group(
					sort(
						veh_recs_latest_vehicles_only,
						acctno, 
						-(max(registrants, (unsigned)reg_latest_expiration_date)),
						-(max(registrants, (unsigned)reg_earliest_effective_date))
					),
					acctno
				);
			
			fn_format_name( layout_vehicle_registrants_temp le ) :=
				function
						lname_trimmed := trim(le.registrants[1].lname);
						fname_trimmed := trim(le.registrants[1].fname);
						mname_trimmed := trim(le.registrants[1].mname);
						
						return Functions.fn_format_name( lname_trimmed, fname_trimmed, mname_trimmed );
				end;
							
			fn_format_ColorYearMakeModelSeries( layout_vehicle_registrants_temp le ) :=
				function
						desc := 
							if( trim(le.major_color_desc) != '', trim(le.major_color_desc) + ' ', '' ) +
							if( trim(le.model_year) != '', trim(le.model_year) + ' ', '' ) +
							if( trim(le.make_desc) != '', trim(le.make_desc) + ' ', '' ) +
							if( trim(le.model_desc) != '', trim(le.model_desc) + ' ', '' ) +
							if( trim(le.series_desc) != '', trim(le.series_desc) + ' ', '' );
						return desc;
				end;
			
			// Define a local layout. We need to inflate the MVR records with standardized (i.e. having 
			// only alphanumeric characters) names and addresses to prepare for matching-coding.
			Vehicles_out_plus_names_and_addresses := record(ERO_Services.Layouts.Vehicles_out) // 3 records
				string VEH_temp_lname_1;
				string VEH_temp_lname_2;
				string VEH_temp_lname_3;
				string VEH_temp_fname_1;
				string VEH_temp_fname_2;
				string VEH_temp_fname_3;
				string VEH_temp_address_1;
				string VEH_temp_address_2;
				string VEH_temp_address_3;	
			end;
	
			veh_recs_rolled_up := 
				rollup(
					veh_recs,
					group,
					transform( Vehicles_out_plus_names_and_addresses,
						self.acctno                             := rows(left)[1].acctno,
						self.did                                := (unsigned)rows(left)[1].registrants[1].append_did,
						self.VEH_Vehicle_Name_1                 := fn_format_name(rows(left)[1]),
						self.VEH_VIN_1                          := rows(left)[1].vin,
						self.VEH_Plate_Number_1                 := rows(left)[1].registrants[1].reg_true_license_plate,
						self.VEH_Plate_State_1                  := rows(left)[1].state_origin, // cheating
						self.VEH_Color_Year_Make_Model_Series_1 := fn_format_ColorYearMakeModelSeries(rows(left)[1]),
						self.VEH_Registration_Date_1            := Functions.fn_format_date( rows(left)[1].registrants[1].reg_latest_effective_date ),
						self.VEH_Expiration_Date_1              := Functions.fn_format_date( rows(left)[1].registrants[1].reg_latest_expiration_date ),
						self.VEH_Match_Code_1                   := '',
						self.VEH_Vehicle_Name_2                 := fn_format_name(rows(left)[2]),
						self.VEH_VIN_2                          := rows(left)[2].vin,
						self.VEH_Plate_Number_2                 := rows(left)[2].registrants[1].reg_true_license_plate,
						self.VEH_Plate_State_2                  := rows(left)[2].state_origin, // cheating
						self.VEH_Color_Year_Make_Model_Series_2 := fn_format_ColorYearMakeModelSeries(rows(left)[2]),
						self.VEH_Registration_Date_2            := Functions.fn_format_date( rows(left)[2].registrants[1].reg_latest_effective_date ),
						self.VEH_Expiration_Date_2              := Functions.fn_format_date( rows(left)[2].registrants[1].reg_latest_expiration_date ),
						self.VEH_Match_Code_2                   := '',
						self.VEH_Vehicle_Name_3                 := fn_format_name(rows(left)[3]),
						self.VEH_VIN_3                          := rows(left)[3].vin,
						self.VEH_Plate_Number_3                 := rows(left)[3].registrants[1].reg_true_license_plate,
						self.VEH_Plate_State_3                  := rows(left)[3].state_origin, // cheating
						self.VEH_Color_Year_Make_Model_Series_3 := fn_format_ColorYearMakeModelSeries(rows(left)[3]),
						self.VEH_Registration_Date_3            := Functions.fn_format_date( rows(left)[3].registrants[1].reg_latest_effective_date ),
						self.VEH_Expiration_Date_3              := Functions.fn_format_date( rows(left)[3].registrants[1].reg_latest_expiration_date ),
						self.VEH_Match_Code_3                   := '',
							// The following are temp names and addresses to be used later for matchcoding.
						self.VEH_temp_lname_1 := rows(left)[1].registrants[1].lname;
						self.VEH_temp_lname_2 := rows(left)[2].registrants[1].lname;
						self.VEH_temp_lname_3 := rows(left)[3].registrants[1].lname;
						self.VEH_temp_fname_1 := rows(left)[1].registrants[1].fname;
						self.VEH_temp_fname_2 := rows(left)[2].registrants[1].fname;
						self.VEH_temp_fname_3 := rows(left)[3].registrants[1].fname;
						self.VEH_temp_address_1 := 
								StringLib.StringFilter(
												StringLib.StringToUpperCase(
													trim(rows(left)[1].registrants[1].prim_range) + 
													trim(rows(left)[1].registrants[1].prim_name) + 
													trim(rows(left)[1].registrants[1].zip5)
												), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	),
						self.VEH_temp_address_2 := 
								StringLib.StringFilter(
												StringLib.StringToUpperCase(
													trim(rows(left)[2].registrants[1].prim_range) + 
													trim(rows(left)[2].registrants[1].prim_name) + 
													trim(rows(left)[2].registrants[1].zip5)
												), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	),
						self.VEH_temp_address_3 := 
								StringLib.StringFilter(
												StringLib.StringToUpperCase(
													trim(rows(left)[3].registrants[1].prim_range) + 
													trim(rows(left)[3].registrants[1].prim_name) + 
													trim(rows(left)[3].registrants[1].zip5)
												), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	)
					)
				);			
		
		// Perform match-coding and project into output layout.
		ids_with_standardized_addrs := Functions.fn_inflate_ids_with_standardized_addrs(ids);
		
		veh_recs_with_matchcodes := 
			join(
				ids_with_standardized_addrs, veh_recs_rolled_up, 
				left.acctno = right.acctno and 
				left.did = right.did,
				transform( ERO_Services.Layouts.Vehicles_out,
					self.VEH_Match_Code_1 := if (right.VEH_temp_address_1 + right.VEH_temp_lname_1 + right.VEH_temp_fname_1 <> '',
						Functions.fn_getMatchcode( left, (unsigned6)right.did, right.VEH_temp_address_1, right.VEH_temp_lname_1, right.VEH_temp_fname_1 ),''),
					self.VEH_Match_Code_2 := if (right.VEH_temp_address_2 + right.VEH_temp_lname_2 + right.VEH_temp_fname_2 <> '',
						Functions.fn_getMatchcode( left, (unsigned6)right.did, right.VEH_temp_address_2, right.VEH_temp_lname_2, right.VEH_temp_fname_2 ),''),
					self.VEH_Match_Code_3 := if (right.VEH_temp_address_3 + right.VEH_temp_lname_3 + right.VEH_temp_fname_3 <> '',
						Functions.fn_getMatchcode( left, (unsigned6)right.did, right.VEH_temp_address_3, right.VEH_temp_lname_3, right.VEH_temp_fname_3 ),''),
					self := right
				)
			);
		
		return veh_recs_with_matchcodes;
	end;
