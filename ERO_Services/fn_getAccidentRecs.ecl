
import Accident_Services, BatchShare, Codes, FLAccidents_eCrash, ut;

export fn_getAccidentRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
	function
		/*
			Requirement 4.1-26:
			Search Accident data by the best subject being returned to ERO and output address 1 
			and address 2 (ones being returned after dedupe process) and DL address (if different).  
			The two most current accidents based on Accident Date will be returned in order of most 
			current to least current.

			A match code will be returned for each accident record stating how the record’s LexID, 
			name and address matches the best subject’s LexID or name and which address it matched on.
				o   Full Name Match – Exact First Name and Exact Last Name (partial or multiple when 
						there are multi-word first or last names. A match can be on both last names or 
						either last name and/or both first names or either first names).
				o   Last Name Match – Exact Last Name (partial or multiple meaning it can match on both 
						last name or either last name)
				o   Address Match - House number, primary street name and zip code

			The following fields will be returned.
				o   Accident Driver Name, Address, City, State, and Zip
				o   Accident Driver DL# and DL State
				o   Accident Driver Insurance Company and Insurance Policy #
				o   State issued Accident Number
				o   Accident Date, State, City, County
				o   Accident License Plate, Plate State, VIN, Vehicle Type
				o   Owner Name, Address, DL#, DOB
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
			Engineering notes (2/6/2013): 
			The logic below was taken primarily from Accident_Services.Report_Records( ), with 
			modifications to (a) not include as many sections as are required for the report (we
			need only three joins here, for the information concerning the accident itself, the 
			driver info, and the vehicle owner info), and (b) transform the results into what's
			required for ERO.
		*/
	
		layout_input_plus_accident_nbrs := record
			BatchShare.Layouts.ShareAcct; // acctno
			BatchShare.Layouts.ShareDID;  // did
			string40 accident_nbr;
		end;

		// Get Accident Numbers by did; sort and dedup.
		ds_accident_nbrs_undeduped := 
			join(
				ids,FLAccidents_eCrash.Key_eCrashV2_did,
				keyed(left.did = right.l_did),
				transform(layout_input_plus_accident_nbrs,
					self.acctno       := left.acctno,
					self.did          := left.did,
					self.accident_nbr := right.accident_nbr
				),
				inner,
				limit(Accident_Services.Constants.MAX_RECS_ON_JOIN,skip)
			);

		ds_accident_nbrs := DEDUP(SORT(ds_accident_nbrs_undeduped,RECORD),RECORD);

		// Aliases to avoid name collisions.
		aConstants  := Accident_Services.Constants;
		aLayouts    := Accident_Services.Layouts;
		aFunctions  := Accident_Services.Functions;
		aTransforms := Accident_Services.Transforms;

		layout_base := record
			layout_input_plus_accident_nbrs or
			aLayouts.report; // i.e. accident_nbr, report_code, and vehicle_incident_st
		end;
		
		// Get accident report code and vehicle incident state
		ds_accident_slim := 
			JOIN( 
				ds_accident_nbrs,
				FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
				KEYED(LEFT.accident_nbr = RIGHT.l_accnbr) and left.did = (integer)right.did,
				TRANSFORM( layout_base,
					SELF.acctno              := LEFT.acctno,
					SELF.did                 := LEFT.did,
					SELF.accident_nbr        := LEFT.accident_nbr,
					SELF.report_code         := RIGHT.report_code,
					SELF.vehicle_incident_st := RIGHT.vehicle_incident_st),
				LEFT OUTER,KEEP(1),LIMIT(0)); 

		// Filter records where states require a DPPA permissible purpose
		ds_accident_slim_filt := 
				IF(NOT aFunctions.allowDPPA(),
					ds_accident_slim(vehicle_incident_st NOT IN aConstants.DPPA_States),
					ds_accident_slim)(accident_nbr != '0');

		allowableStates := 
			SET(Accident_Services.StateRestrictionsFunctions.getRestrictions(''),accidentState);

		// Validate accident number
		ds_eCrashAccNbrs := 
					ds_accident_slim_filt(report_code IN aConstants.eCrashAccident_source);
		
		ds_acctno_did_accNbrs := 
				ds_accident_slim_filt(report_code IN aConstants.FLAccident_source) + ds_eCrashAccNbrs;
		
		
		// 1. Now that we have accident_nbrs we can use, get basic Accident information.
		layout_accident_rpt := record
			string40 accident_nbr;
			unsigned6 subject_did;
			string8  accident_date_yyyymmdd;
			string2  vehicle_incident_st;
			string30 city;   
			string50 county; 
		end;
		

		rptCodeSet := Accident_Services.constants.rptCodeSet+Accident_Services.constants.eCrashAccident_source;
		vStatusSet := Accident_Services.constants.vStatusSet; // VIN has been validated
		FLAccident_source := Accident_Services.constants.FLAccident_source;
		
		layout_accident_rpt  fillAccident(ds_acctno_did_accNbrs l,FLAccidents_eCrash.Key_eCrashV2_accnbrV1 r) := transform
					self.accident_nbr           := l.accident_nbr;
					self.subject_did            := l.did;
					self.accident_date_yyyymmdd := r.accident_date;
					self.vehicle_incident_st    := l.vehicle_incident_st;
					self.city                   := r.vehicle_incident_city;
					self.county                 := ERO_Services.fn_getCounty(r.vehicle_incident_city, r.vehicle_incident_st);
    end;					
  	ds_pre :=  join(ds_acctno_did_accNbrs,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
	         									keyed((string)left.accident_nbr=right.l_accnbr and 
														      left.report_code=right.report_code) and
																	left.did = (integer)right.did,  
														      fillAccident(left,right),
        										      limit(10000, SKIP));

		ds_accident_info_dups := limit (ds_pre, Accident_Services.Constants.MAX_RECS_ON_JOIN, skip);

		ds_accident_info := dedup(sort(ds_accident_info_dups,record),record);
		// 2. Add Owner info.
		layout_owner := record
			string2  section_nbr; // apparently the Nth vehicle involved in the accident
			string8  lic_plate_nbr;
			string2  lic_plate_st;
			string22 vin;
			string100  veh_type;  
			string41 ins_company_name;
	    string25 ins_policy_nbr;
			unsigned6 owner_did;
			string60 owner_name; 
			string64 owner_address;
			string25 owner_city;
			string2  owner_state;
			string5  owner_zip;
			string15 owner_dl_nbr;
			string8  dob;
			string43 owner_temp_address; // prim_name + prim_range + zip
			string20 owner_temp_lname;
			string20 owner_temp_fname;
		end;
		
		fn_get_vehicle_desc(FLAccidents_eCrash.Key_eCrash2v vehicle) :=
			function
				make_desc := 
					trim(
						if( 
							vehicle.make_description != '' AND vehicle.make_description != vehicle.model_description, 
							vehicle.make_description,
							codes.KeyCodes('FLCRASH2_VEHICLE','MAKE_DESCRIPTION','',vehicle.vehicle_make)
						),
						left,right
					);
				
				year_model_make := 
					trim(
						if( trim(vehicle.vehicle_year) != '', trim(vehicle.vehicle_year), '' ) +
						if( trim(vehicle.model_description) != '', ' ' + trim(vehicle.model_description), '' ) +
						if( make_desc != '', ' ' + make_desc, '' ),
						left,right
					);
				
				vehicle_type := 
					trim(
						if(
							vehicle.vehicle_type != '' ,
							codes.KeyCodes('FLCRASH2_VEHICLE','VEHICLE_TYPE','',vehicle.vehicle_type),
							vehicle.vehicle_type_desc
						),
						left,right
					);
				
				year_model_make_type := year_model_make + ' - ' + vehicle_type;
				
				vehicle_desc := 
					map( 
						year_model_make != '' and vehicle_type != '' => year_model_make_type,
						year_model_make != ''                        => year_model_make,
						vehicle_type    != ''                        => vehicle_type,
						/* default................................. */  ''
					);
				
				return vehicle_desc;
			end;
		
		layout_accident_plus_owner_info := record
			layout_accident_rpt;
			layout_owner;
		end;
		
		layout_accident_plus_owner_info xfm_add_owner_info(layout_accident_rpt le, FLAccidents_eCrash.Key_eCrash2v ri) :=
			transform
				self.section_nbr      := ri.section_nbr;
				self.lic_plate_nbr    := ri.vehicle_tag_nbr;
				self.lic_plate_st     := ri.vehicle_reg_state;
				self.vin              := ri.vehicle_id_nbr;         
				SELF.ins_company_name := ri.ins_company_name;
				SELF.ins_policy_nbr   := ri.ins_policy_nbr;
				self.veh_type         := fn_get_vehicle_desc(ri);
				self.owner_did        := (unsigned6)ri.did;
				self.owner_name       := if (ri.lname + ri.fname + ri.mname <> '',
				                             Functions.fn_format_name(trim(ri.lname),trim(ri.fname),trim(ri.mname)),
																		 ri.vehicle_owner_name);
				self.owner_address    := Functions.fn_format_street_address(trim(ri.prim_name),trim(ri.prim_range),trim(ri.predir),trim(ri.postdir),trim(ri.addr_suffix),trim(ri.unit_desig),trim(ri.sec_range));
				self.owner_city       := ri.p_city_name;
				self.owner_state      := ri.st;
				self.owner_zip        := ri.zip;
				self.owner_dl_nbr     := ri.vehicle_owner_dl_nbr;
				self.dob              := ri.vehicle_owner_dob;
					// The following are temp names and addresses to be used later for matchcoding.
				self.owner_temp_lname   := ri.lname;
				self.owner_temp_fname   := ri.fname;
				self.owner_temp_address := 
						StringLib.StringFilter(
							StringLib.StringToUpperCase(trim(ri.prim_range) + trim(ri.prim_name) + trim(ri.zip)), 
							'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' );
				self := le;
			end;
			
		ds_accidents_with_owner_info_dups := 
			join(
				ds_accident_info, FLAccidents_eCrash.Key_eCrash2v,
				keyed(left.accident_nbr = right.l_acc_nbr) 
				and 
				(
					(left.vehicle_incident_st = right.vehicle_incident_st and left.city = right.vehicle_incident_city) 
					or 
					(left.subject_did = (integer)right.did)
				), 
			//	and 
			//	(unsigned6)right.did <> 0,  //bug 121403requiring a DID was too restrictive (if car involved was owned by company)
				xfm_add_owner_info(left,right),
				left outer,
				limit(aConstants.MAX_RECS_ON_JOIN,SKIP));
    //limit 		
		ds_accidents_with_owner_info := dedup(sort(ds_accidents_with_owner_info_dups,except veh_type),except veh_type);
		// 3. Add Driver info.
		layout_driver := record  
			unsigned6 driver_did;
			string60 driver_name; 
			string64 driver_address;
			string25 driver_city;
			string2  driver_state;
			string5  driver_zip;
			string15 driver_dl_nbr;
			string2  driver_dl_state;
			string41 driver_ins_co;
			string25 driver_policy_nbr;
			string43 driver_temp_address; // prim_name + prim_range + zip
			string20 driver_temp_lname;
			string20 driver_temp_fname;		
		end;	
		
		ds_accidents_with_driver_info := 
			join(
				ds_accidents_with_owner_info , FLAccidents_eCrash.Key_eCrash4,
				keyed(left.accident_nbr = right.l_acc_nbr) and 
				(left.vehicle_incident_st = right.vehicle_incident_st  and	left.city = right.vehicle_incident_city and left.section_nbr = right.section_nbr),
				transform( {layout_accident_rpt, layout_owner, layout_driver},
					self.driver_did        := (unsigned6)right.did,
					self.driver_name       := if (right.lname + right.fname + right.mname <> '',
					                          Functions.fn_format_name(trim(right.lname),trim(right.fname),trim(right.mname)),
																		right.driver_full_name
																		  ),
					self.driver_address    := Functions.fn_format_street_address(trim(right.prim_name),trim(right.prim_range),trim(right.predir),trim(right.postdir),trim(right.addr_suffix),trim(right.unit_desig),trim(right.sec_range)),
					self.driver_city       := right.p_city_name,
					self.driver_state      := right.st,
					self.driver_zip        := right.zip,
					self.driver_dl_nbr     := right.driver_dl_nbr,	
					self.driver_dl_state   := right.driver_lic_st,
					self.driver_ins_co     := IF(trim(right.ins_company_name)='' and (unsigned6)right.did=left.owner_did, left.ins_company_name,right.ins_company_name),
					self.driver_policy_nbr := IF(trim(right.ins_policy_nbr)='' and (unsigned6)right.did=left.owner_did, left.ins_policy_nbr,right.ins_policy_nbr),
						// The following are temp names and addresses to be used later for matchcoding.
					self.driver_temp_lname := right.lname,
					self.driver_temp_fname := right.fname,
					self.driver_temp_address := 
							StringLib.StringFilter(
								StringLib.StringToUpperCase(trim(right.prim_range) + trim(right.prim_name) + trim(right.zip)), 
								'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890' ),
					self := left
				),
				left outer,
				limit(aConstants.MAX_RECS_ON_JOIN,skip)
			);
		
		// 4. Join accumulated accident record back to acctno, did, etc.
		layout_accident_record_raw := record
			layout_base or
			layout_accident_rpt or 
			layout_owner or 
			layout_driver;		
		end;
		
		ds_results_raw := 
			join(
				ds_accident_nbrs, ds_accidents_with_driver_info, 
				left.accident_nbr = right.accident_nbr and
				left.did = right.subject_did,
				transform( layout_accident_record_raw,
					self := right,
					self := left,
					self.report_code := '';
				),
				inner,
				limit(aConstants.MAX_RECS_ON_JOIN,skip)
			);
		
		// 5. Dedup, and then filter out any accident records if neither the driver nor the owner match 
		// the search 
		//dedup by :ACCTNO, DID, ACCIDENT_NBR,Accident_Date_YYYYMMDD, veh_incident_state, veh_type ,vin
		ds_results_deduped := dedup(group(sort(ds_results_raw, ACCTNO, DID, ACCIDENT_NBR,Accident_Date_YYYYMMDD, vehicle_incident_st, veh_type ,vin), 
		                                  acctno), 
																ACCTNO, DID, ACCIDENT_NBR,Accident_Date_YYYYMMDD, vehicle_incident_st, veh_type ,vin);
		ds_results_filt    := ds_results_deduped(did in [driver_did, owner_did]);
		
		// 6. Retain the top 2 most recent accidents and group them.
		ds_results_top_2   := topn(ds_results_filt, 2, acctno, -(unsigned)accident_date_yyyymmdd);
		ds_results_grouped := group(ds_results_top_2, acctno);

		// 7. Group-rollup the two most recent accidents into the final layout. Match-coding to follow.
		Accidents_out_plus_addresses := record
			ERO_Services.Layouts.Accidents_out;
			STRING ACC_driver_temp_lname_1;   // first driver
			STRING ACC_driver_temp_fname_1;
			STRING ACC_driver_temp_address_1;
			STRING ACC_owner_temp_lname_1;    // first owner
			STRING ACC_owner_temp_fname_1;
			STRING ACC_owner_temp_address_1;
			STRING ACC_driver_temp_lname_2;   // second driver
			STRING ACC_driver_temp_fname_2;
			STRING ACC_driver_temp_address_2;
			STRING ACC_owner_temp_lname_2;    // second owner
			STRING ACC_owner_temp_fname_2;
			STRING ACC_owner_temp_address_2;
		end;
	
		Accidents_out_plus_addresses xfm_denorm_accidents(layout_accident_record_raw le, dataset(layout_accident_record_raw) allRows) := 
				transform
					self.acctno := le.acctno;
					self.did    := le.did;
					self.ACC_Driver_Name_1     := allRows[1].driver_name;
					self.ACC_Driver_Address_1  := allRows[1].driver_address;
					self.ACC_Driver_City_1     := allRows[1].driver_city;
					self.ACC_Driver_State_1    := allRows[1].driver_state;
					self.ACC_Driver_Zip_1      := allRows[1].driver_zip;
					self.ACC_Driver_DL_1       := allRows[1].driver_dl_nbr;
					self.ACC_Driver_DL_State_1 := allRows[1].driver_dl_state;
					self.ACC_Driver_Insurance_Company_1       := if (trim(allRows[1].driver_ins_co) <> '',allRows[1].driver_ins_co , allRows[1].ins_company_name);
					self.ACC_Driver_Insurance_Policy_Number_1 := if (trim(allRows[1].driver_policy_nbr) <> '', allRows[1].driver_policy_nbr, allRows[1].ins_policy_nbr);
					self.ACC_State_issued_Accident_Number_1   := allRows[1].accident_nbr;
					self.ACC_Date_1          := Functions.fn_format_date( allRows[1].accident_date_yyyymmdd );
					self.ACC_State_1         := allRows[1].vehicle_incident_st;
					self.ACC_City_1          := allRows[1].city;
					self.ACC_County_1        := allRows[1].county;
					self.ACC_veh_Plate_1     := allRows[1].lic_plate_nbr;
					self.ACC_veh_State_1     := allRows[1].lic_plate_st;
					self.ACC_veh_VIN_1       := allRows[1].vin;
					self.ACC_Veh_Type_1      := allRows[1].veh_type;
					self.ACC_Owner_Name_1    := allRows[1].owner_name;
					self.ACC_Owner_Address_1 := allRows[1].owner_address;
					self.ACC_Owner_City_1    := allRows[1].owner_city;
					self.ACC_Owner_State_1   := allRows[1].owner_state;
					self.ACC_Owner_Zip_1     := allRows[1].owner_zip;
					self.ACC_Owner_DL_1      := allRows[1].owner_dl_nbr;
					self.ACC_Owner_DOB_1     := Functions.fn_format_date( allRows[1].dob );
					self.ACC_Match_1         := '';
					
					self.ACC_Driver_Name_2     := allRows[2].driver_name;
					self.ACC_Driver_Address_2  := allRows[2].driver_address;
					self.ACC_Driver_City_2     := allRows[2].driver_city;
					self.ACC_Driver_State_2    := allRows[2].driver_state;
					self.ACC_Driver_Zip_2      := allRows[2].driver_zip;
					self.ACC_Driver_DL_2       := allRows[2].driver_dl_nbr;
					self.ACC_Driver_DL_State_2 := allRows[2].driver_dl_state;
					self.ACC_Driver_Insurance_Company_2       := if (trim(allRows[2].driver_ins_co) <> '',allRows[2].driver_ins_co , allRows[2].ins_company_name);
					self.ACC_Driver_Insurance_Policy_Number_2 := if (trim(allRows[2].driver_policy_nbr) <> '', allRows[2].driver_policy_nbr, allRows[2].ins_policy_nbr);
					self.ACC_State_issued_Accident_Number_2   := allRows[2].accident_nbr;
					self.ACC_Date_2          := Functions.fn_format_date( allRows[2].accident_date_yyyymmdd );
					self.ACC_State_2         := allRows[2].vehicle_incident_st;
					self.ACC_City_2          := allRows[2].city;
					self.ACC_County_2        := allRows[2].county;
					self.ACC_veh_Plate_2     := allRows[2].lic_plate_nbr;
					self.ACC_veh_State_2     := allRows[2].lic_plate_st;
					self.ACC_veh_VIN_2       := allRows[2].vin;
					self.ACC_Veh_Type_2      := allRows[2].veh_type;
					self.ACC_Owner_Name_2    := allRows[2].owner_name;
					self.ACC_Owner_Address_2 := allRows[2].owner_address;
					self.ACC_Owner_City_2    := allRows[2].owner_city;
					self.ACC_Owner_State_2   := allRows[2].owner_state;
					self.ACC_Owner_Zip_2     := allRows[2].owner_zip;
					self.ACC_Owner_DL_2      := allRows[2].owner_dl_nbr;
					self.ACC_Owner_DOB_2     := Functions.fn_format_date( allRows[2].dob );
					self.ACC_Match_2         := '';
					
						// For match-coding.
					self.ACC_driver_temp_lname_1   := allRows[1].driver_temp_lname;   // first record driver
					self.ACC_driver_temp_fname_1   := allRows[1].driver_temp_fname;
					self.ACC_driver_temp_address_1 := allRows[1].driver_temp_address;
					self.ACC_owner_temp_lname_1    := allRows[1].owner_temp_lname;    // first record owner
					self.ACC_owner_temp_fname_1    := allRows[1].owner_temp_fname;
					self.ACC_owner_temp_address_1  := allRows[1].owner_temp_address;
					self.ACC_driver_temp_lname_2   := allRows[2].driver_temp_lname;   // second record driver
					self.ACC_driver_temp_fname_2   := allRows[2].driver_temp_fname;
					self.ACC_driver_temp_address_2 := allRows[2].driver_temp_address;
					self.ACC_owner_temp_lname_2    := allRows[2].owner_temp_lname;    // second record owner
					self.ACC_owner_temp_fname_2    := allRows[2].owner_temp_fname;
					self.ACC_owner_temp_address_2  := allRows[2].owner_temp_address;
				end;
		
		ds_accident_recs :=
			rollup(
				ds_results_grouped,
				group,
				xfm_denorm_accidents(left, rows(left))
			);
		
		// 8. Perform match-coding and return.

		// .. 8a. Inflate the 'ids' dataset passed into this function with some temporary addresses to be 
		// used in match-coding. These addresses will be composed of prim_range + prim_name + zipcode,
		// cast to upper-case, and then all non-alpha-numeric characters removed.
		//
		// e.g. "3140 Brook-On-Seine St., Dayton, OH, 45420" ---> "3140BROOKONSEINE45420"
		ids_with_standardized_addrs := Functions.fn_inflate_ids_with_standardized_addrs(ids);

		// The following function takes a comma-delimited string of matchcodes, which may have
		// duplicate codes, and dedupes the string. Return value is a deduplicated, comma-
		// delimited string of matchcodes.
		dedup_matchcodes(string matchcodes) := 
			function
				string s1         := matchcodes;
				set of string ss2 := ut.StringSplit(s1,',');
				
				ds_3 := dataset([ss2],{string matchcode});
				ds_4 := dedup((ds_3),all);
				ds_5 := rollup( ds_4, true, transform( {string matchcode}, self.matchcode := left.matchcode + ',' + right.matchcode ) );

				return ds_5[1].matchcode;
			end;
		
		// .. 8b. Add match-codes to final accident records and return.
		ERO_Services.Layouts.Accidents_out xfm_add_matchcodes(ERO_Services.Layouts.layout_LookupId_plus_standardized_addrs le, Accidents_out_plus_addresses ri) :=
			transform
					// -----[ Functions and attributes local to this join transform ]-----
					accident2_did := if ( ri.ACC_State_2 + ri.ACC_Owner_Name_2 + ri.ACC_driver_temp_address_2+ ri.ACC_driver_temp_lname_2+ri.ACC_driver_temp_fname_2 ='' ,0,(unsigned6)ri.did);
					driver_1_matchcodes := Functions.fn_getMatchcode( le, (unsigned6)ri.did, ri.ACC_driver_temp_address_1, ri.ACC_driver_temp_lname_1, ri.ACC_driver_temp_fname_1 );
					owner_1_matchcodes  := Functions.fn_getMatchcode( le, (unsigned6)ri.did, ri.ACC_owner_temp_address_1,  ri.ACC_owner_temp_lname_1,  ri.ACC_owner_temp_fname_1 );
					driver_2_matchcodes := Functions.fn_getMatchcode( le, accident2_did, ri.ACC_driver_temp_address_2, ri.ACC_driver_temp_lname_2, ri.ACC_driver_temp_fname_2 );
					owner_2_matchcodes  := Functions.fn_getMatchcode( le, accident2_did, ri.ACC_owner_temp_address_2,  ri.ACC_owner_temp_lname_2,  ri.ACC_owner_temp_fname_2 );
					
					driver_1_and_owner_1_matchcodes := 
							map( // avoid a comma in the first or last position of the matchcode list
								trim(driver_1_matchcodes) != '' and trim(owner_1_matchcodes) != '' 
								                                  => driver_1_matchcodes + ',' + owner_1_matchcodes,
								trim(driver_1_matchcodes) != ''   => trim(driver_1_matchcodes),
								trim(owner_1_matchcodes)  != ''   => trim(owner_1_matchcodes),
								/* default..................... */   ''
							);

					driver_2_and_owner_2_matchcodes := 
							map( // avoid a comma in the first or last position of the matchcode list
								trim(driver_2_matchcodes) != '' and trim(owner_2_matchcodes) != '' 
								                                  => driver_2_matchcodes + ',' + owner_2_matchcodes,
								trim(driver_2_matchcodes) != ''   => trim(driver_2_matchcodes),
								trim(owner_2_matchcodes)  != ''   => trim(owner_2_matchcodes),
								/* default..................... */   ''
							);
				// ----------[ End local functions and attributes ]----------
				
				self.ACC_Match_1 := dedup_matchcodes( driver_1_and_owner_1_matchcodes );
				self.ACC_Match_2 := dedup_matchcodes( driver_2_and_owner_2_matchcodes );
				self             := ri;		
			end;
		
		ds_accident_recs_with_matchcodes := 
			join(
				ids_with_standardized_addrs, ds_accident_recs, 
				left.acctno = right.acctno and 
				left.did = right.did,
				xfm_add_matchcodes(left,right),
				limit(aConstants.MAX_RECS_ON_JOIN,skip)
			);		
		
		   
		  // output( ds_acctno_did_accNbrs, named('ds_acctno_did_accNbrs') );
		//output( ds_accident_nbrs,named('ds_accident_nbrs'));
		  //output( ds_accNbrs, named('ds_accNbrs') );
		  // output( ds_accident_info, named('ds_accident_info') );
		  // output( count(ds_accident_info), named('count1') );
		 //  output( ds_accidents_with_owner_info, named('ds_accidents_with_owner_info') );
		 // output( count(ds_accidents_with_owner_info), named('count2') );
		 //  output( ds_accidents_with_driver_info, named('ds_accidents_with_driver_info') );
		  // output( count(ds_accidents_with_driver_info), named('count3') );
		  // output( ds_results_raw, named('ds_results_raw') );
		 //  output( ds_results_deduped , named('ds_results_deduped') );
		 
		// output( ids_with_standardized_addrs, named('ids_with_standardized_addrs') );
		// output( ds_accident_recs, named('ds_accident_recs') );
		 // output( ds_accident_recs_with_matchcodes, named('ds_accident_recs_with_matchcodes') );
		//output(sort(ds_results_filt,acctno, -(unsigned)accident_date_yyyymmdd));
		return ds_accident_recs_with_matchcodes;
	end;
