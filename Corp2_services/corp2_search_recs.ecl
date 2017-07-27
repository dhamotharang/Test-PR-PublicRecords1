import AutoStandardI, codes, corp2, ut;

export corp2_search_recs := module

	// corps_raw_search is a module rather than a function because it is responsible for exporting
	// both the corp_hist children and the corp base fields (corp base fields are what get joined
	// to the children) for the search service
	//
	// Keys used: corp2.Key_Corp_corpkey

	SHARED AutoTranslator := AutoStandardI.InterfaceTranslator;
	SHARED PenaltyIBase := AutoStandardI.LIBIN.PenaltyI.base;

	SHARED PENALTY_VALUE_FOR_NO_INPUT := 1000;
	SHARED PENALTY_VALUE_FOR_NO_DATA  := 1000;

	SHARED combined_penalty_values() := MACRO
		IF(
			TwoPartySearch,
			MIN(
				penalt_1 + penalt_phone_1 + penalt_company_1 + penalt_addr_1,
				penalt_2 + penalt_phone_2 + penalt_company_2 + penalt_addr_2),
			penalt_1 + penalt_phone_1 + penalt_company_1 + penalt_addr_1)
			
			
	ENDMACRO;

	SHARED BOOLEAN noBlank(STRING input) := TRIM(input) != '';

	EXPORT corps_raw_search(dataset(corp2_services.layout_corpkey) in_corpkeys,
													BOOLEAN TwoPartySearch,
													PenaltyIBase params1,
													PenaltyIBase params2) := MODULE
		
		shared layout_search_raw := record
			// Core info.
			string30  corp_key;  
			string32  corp_orig_sos_charter_nbr;
			string32  corp_sos_charter_nbr;
			string2	  corp_state_origin;
			string25  corp_state_origin_decoded;
			
			// Penalties to float best record to top of group.
			unsigned2 penalt_1;
			unsigned2 penalt_phone_1;
			unsigned2 penalt_company_1;
			unsigned2 penalt_addr_1;
			unsigned2 penalt_2;
			unsigned2 penalt_phone_2;
			unsigned2 penalt_company_2;
			unsigned2 penalt_addr_2;
			
			// Penalties to assist app to display correct information.
			UNSIGNED2 corp_penalt_bdid_1      := 0;
			UNSIGNED2 corp_penalt_phone_1     := 0;
			UNSIGNED2 corp_penalt_company_1   := 0;
			UNSIGNED2 corp_penalt_addr_1      := 0;
			UNSIGNED2 ra_penalt_company_1     := 0;
			UNSIGNED2 ra_penalt_indv_1        := 0;
			UNSIGNED2 ra_penalt_addr_1        := 0;
			UNSIGNED2 corp_penalt_bdid_2      := 0;
			UNSIGNED2 corp_penalt_phone_2     := 0;
			UNSIGNED2 corp_penalt_company_2   := 0;
			UNSIGNED2 corp_penalt_addr_2      := 0;
			UNSIGNED2 ra_penalt_company_2     := 0;
			UNSIGNED2 ra_penalt_indv_2        := 0;
			UNSIGNED2 ra_penalt_addr_2        := 0;
			
			// Record body.
			Corp2_services.layout_corp_search;
		end;				

		SHARED layout_search_raw_seq := RECORD
			INTEGER seq := 0;
			layout_search_raw;
		END;		
		
		shared layout_search_out := record
			layout_search_raw;			
			DATASET(layout_corp_search) corp_hist {maxcount(50)};			
		end;				

		SHARED serviceParams := Corp2_services.IParams.getServiceParams();
		
		SHARED Latest_for_MAs        		:= serviceParams.LatestForMAs;
		SHARED Simplified_Contact    		:= serviceParams.simplifiedcontactreturn;
		SHARED Search_RAs               := serviceParams.SearchRegisteredAgents;
		SHARED FilingJurisdiction_value := AutoTranslator.FilingJurisdiction_value.val(PROJECT(AutoStandardI.GlobalModule(), AutoTranslator.FilingJurisdiction_value.params));


		// ***** Shared Functions *****
		
		// ms == 'Most Similar'.
		shared ms(string70 a, string70 b, string70 c) := FUNCTION
			RETURN MAP( a = ''                                         => b,
			            b = ''                                         => a,
									ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,
									/* ELSE .....................................*/   b
								 );
		END;
		
		shared ms2(string70 a, string70 b, string70 c, string70 d) := FUNCTION
			RETURN MAP( ms(a, b, d) = '' => ms(a, c, d), 
			            ms(a, c, d) = '' => ms(a, b, d),
									/* ELSE .......*/   ms( ms(a, c, d), ms(a, b, d), d) 
								 );
		END;
		
		SHARED fill_blank_addr1(RECORDOF(corp2.Key_Corp_corpkey) r) := FUNCTION
			RETURN ~Latest_for_MAs and 
						 r.corp_address1_line1 = '' and r.corp_address1_line2 = '' and r.corp_address1_line3 = '' and 
						 r.corp_address1_line4 = '' and r.corp_address1_line5 = '' and r.corp_address1_line6 = '' and 
						 r.corp_ra_zip5 <> ''       and r.corp_ra_prim_name <> '';						 
		END;
		
		SHARED variable_params(PenaltyIBase params) := MODULE
		
			// ***** Shared Variables, Constants, Layouts *****
			SHARED bdid_value := AutoTranslator.bdid_val.val(PROJECT(params, AutoTranslator.bdid_val.params));
			SHARED did_value := AutoTranslator.did_value.val(PROJECT(params, AutoTranslator.did_value.params));
			SHARED phone_value := AutoTranslator.phone_value.val(PROJECT(params, AutoTranslator.phone_value.params));
			SHARED comp_name_value := AutoTranslator.comp_name_value.val(PROJECT(params, AutoTranslator.comp_name_value.params));
			SHARED lname_value := AutoTranslator.lname_value.val(PROJECT(params, AutoTranslator.lname_value.params));
			SHARED pname_value := AutoTranslator.pname_value.val(PROJECT(params, AutoTranslator.pname_value.params));
			SHARED city_value := AutoTranslator.city_value.val(PROJECT(params, AutoTranslator.city_value.params));
			SHARED postdir_value := AutoTranslator.postdir_value.val(PROJECT(params, AutoTranslator.postdir_value.params));
			SHARED prange_value := AutoTranslator.prange_value.val(PROJECT(params, AutoTranslator.prange_value.params));
			SHARED predir_value := AutoTranslator.predir_value.val(PROJECT(params, AutoTranslator.predir_value.params));
			SHARED state_value := AutoTranslator.state_value.val(PROJECT(params, AutoTranslator.state_value.params));
			SHARED addr_suffix_value := AutoTranslator.addr_suffix_value.val(PROJECT(params, AutoTranslator.addr_suffix_value.params));
			SHARED zip_val := AutoTranslator.zip_val.val(PROJECT(params, AutoTranslator.zip_val.params));

			EXPORT input_bdid := noBlank(bdid_value);
			SHARED input_did := noBlank(did_value);
			SHARED input_phone := noBlank(phone_value);
			EXPORT input_bizname := noBlank(comp_name_value);
			SHARED input_indv := noBlank(lname_value);
			SHARED input_address := noBlank(pname_value);


			// ............ penalty functions...:
			//
			// For all penalties, the system returns a zero for both a perfect match and the case where there is no
			// data on which to perform a penalty. Because the app must read the penalty value and determine whether
			// it is indeed a good enough match to the input data, the system must return an unambiguous value. So,
			// all perfect matches will continue to return a zero, but where there is no input to penalize, the system
			// shall return a penalty value of PENALTY_VALUE_FOR_NO_INPUT (see constant above).
			
			// ***************************************   FUNCTION   ***************************************
			
			EXPORT get_bdid_penalty_for_whole_row(RECORDOF(corp2.Key_Corp_corpkey) r) := FUNCTION
				
				tempmodbdid := module(project(params, AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
					export string bdid_field := (string)r.bdid;
				end;

				RETURN IF( NOT TRIM(params.bdid) != '',
									 0,
									 AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodbdid)
									);
			END;
			
			// ***************************************   FUNCTION   ***************************************
			
			EXPORT get_address_penalty_for_whole_row(RECORDOF(corp2.Key_Corp_corpkey) r) := FUNCTION
					
				tempmodaddr := module(project(params, AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
					export boolean allow_wildcard := false;

					// Obtain the best address data by determining which datum is most similar 
					// to its respective input address part.
					export string city_field      := ms(ms2(r.corp_addr1_p_city_name, 
																									r.corp_addr1_v_city_name,
																									r.corp_addr2_p_city_name,
																									city_value),
																							ms2(r.corp_addr2_v_city_name,
																									r.corp_ra_p_city_name,
																									r.corp_ra_v_city_name,
																									city_value),
																							city_value);
					export string city2_field     := '';
					export string pname_field     := ms2(r.corp_addr1_prim_name,
																							 r.corp_addr2_prim_name,
																							 r.corp_ra_prim_name,
																							 pname_value);
					export string postdir_field   := ms2(r.corp_addr1_postdir,
																							 r.corp_addr2_postdir,
																							 r.corp_ra_postdir,
																							 postdir_value);
					export string prange_field    := ms2(r.corp_addr1_prim_range,
																							 r.corp_addr2_prim_range,
																							 r.corp_ra_prim_range,
																							 prange_value);
					export string predir_field    := ms2(r.corp_addr1_predir,
																							 r.corp_addr2_predir,
																							 r.corp_ra_predir,
																							 predir_value);
					export string state_field     := ms(ms(r.corp_addr1_state,
																								 r.corp_addr2_state,
																								 state_value),
																							ms(r.corp_ra_state,
																								 r.corp_state_origin,
																								 state_value),
																							state_value);
					export string suffix_field    := ms2(r.corp_addr1_addr_suffix,
																							 r.corp_addr2_addr_suffix,
																							 r.corp_ra_addr_suffix,
																							 addr_suffix_value);
					export string zip_field       := ms2(r.corp_addr1_zip5,
																							 r.corp_addr2_zip5,
																							 r.corp_ra_zip5,
																							 zip_val);
				end;
				
				RETURN IF( NOT input_address,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									);
			END;
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_corp_address_penalty(layout_search_raw r) := FUNCTION
					
				tempmodaddr := module(project(params, AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
					export boolean allow_wildcard := false;
					export string city_field      := ms(ms(r.corp_addr1_p_city_name, 
																								 r.corp_addr1_v_city_name,
																								 city_value),
																							ms(r.corp_addr2_v_city_name,
																								 r.corp_addr2_p_city_name,
																								 city_value),
																							city_value);																						
					export string city2_field     := '';
					export string pname_field     := ms(r.corp_addr1_prim_name,
																							r.corp_addr2_prim_name,
																							pname_value);
					export string postdir_field   := ms(r.corp_addr1_postdir,
																							r.corp_addr2_postdir,
																							postdir_value);
					export string prange_field    := ms(r.corp_addr1_prim_range,
																							r.corp_addr2_prim_range,
																							prange_value);
					export string predir_field    := ms(r.corp_addr1_predir,
																							r.corp_addr2_predir,
																							predir_value);
					export string state_field     := ms2(r.corp_addr1_state,
																							 r.corp_addr2_state,
																							 r.corp_state_origin,
																							 state_value);
					export string suffix_field    := ms(r.corp_addr1_addr_suffix,
																							r.corp_addr2_addr_suffix,
																							addr_suffix_value);
					export string zip_field       := ms(r.corp_addr1_zip5,
																							r.corp_addr2_zip5,
																							zip_val);
				end;
				
				RETURN IF( NOT input_address,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									);
			END;		
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_ra_address_penalty(layout_search_raw r) := FUNCTION
					
				tempmodaddr := module(project(params, AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
					export boolean allow_wildcard := false;

					// Obtain the best address data by determining which datum is most similar 
					// to its respective input address part.
					export string city_field      := ms(r.corp_ra_p_city_name, r.corp_ra_v_city_name, city_value);
					export string city2_field     := '';
					export string pname_field     := r.corp_ra_prim_name;
					export string postdir_field   := r.corp_ra_postdir;
					export string prange_field    := r.corp_ra_prim_range;
					export string predir_field    := r.corp_ra_predir;
					export string state_field     := r.corp_ra_state;
					export string suffix_field    := r.corp_ra_addr_suffix;
					export string zip_field       := r.corp_ra_zip5;
				end;
				
				RETURN IF( NOT input_address,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									);
			END;		
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_phone_penalty_for_whole_row(RECORDOF(corp2.Key_Corp_corpkey) r) := FUNCTION
				
				tempmodphone := module(project(params, AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
					export string phone_field := ms(r.corp_ra_phone10, r.corp_phone10, phone_value);
				end;
				
				RETURN IF( NOT input_phone,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone)
									);
			END;

			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_corp_phone_penalty(layout_search_raw r) := FUNCTION
				
				tempmodphone := module(project(params, AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
					export string phone_field := r.corp_phone10;
				end;
				
				RETURN IF( NOT input_phone,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone)
									);
			END;		
			
			// ***************************************   FUNCTION   ***************************************
			
			// Simplified_Contact, it turns out, pulls double-duty, as it also forbids assigning any penalty
			// value to Registered Agents when set to true.
			EXPORT get_bizname_penalty_for_whole_row(RECORDOF(corp2.Key_Corp_corpkey) r) := FUNCTION
				
				tempmodbizname := module(project(params, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
					export string cname_field := IF(Simplified_Contact OR NOT Search_RAs,
																					r.corp_legal_name,
																					TRIM( ms2(r.corp_legal_name,r.corp_ra_cname1,r.corp_ra_cname2,comp_name_value) ));
				end;
				
				RETURN IF( NOT input_bizname,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
									);
			END;
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_corp_bizname_penalty(layout_search_raw r) := FUNCTION
				
				tempmodbizname := module(project(params, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
					export string cname_field := r.corp_legal_name;
				end;
				
				RETURN IF( NOT input_bizname,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
									);
			END;
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_ra_bizname_penalty(layout_search_raw r) := FUNCTION
				
				tempmodbizname := module(project(params, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
					export string cname_field := r.corp_ra_name;
				end;
				
				RETURN IF( NOT input_bizname,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
									);
			END;
			
			// ***************************************   FUNCTION   ***************************************
					
			EXPORT get_ra_indv_penalty(layout_search_raw r) := FUNCTION
							
				tempmodindvname1 := module(project(params, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
					export boolean allow_wildcard := false;
					export string fname_field := r.corp_ra_fname1;
					export string lname_field := r.corp_ra_lname1;
					export string mname_field := r.corp_ra_mname1;
				end;

				tempmodindvname2 := module(project(params, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
					export boolean allow_wildcard := false;
					export string fname_field := r.corp_ra_fname2;
					export string lname_field := r.corp_ra_lname2;
					export string mname_field := r.corp_ra_mname2;
				end;
				
				penalty1 := IF( TRIM(r.corp_ra_lname1) = '', 
												PENALTY_VALUE_FOR_NO_DATA,
												AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname1)											
											 );
												
				penalty2 := IF( TRIM(r.corp_ra_lname2) = '', 
												PENALTY_VALUE_FOR_NO_DATA,
												AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname2)											
											 );
				
				RETURN IF( NOT input_indv,
									 PENALTY_VALUE_FOR_NO_INPUT,
									 IF( penalty1 < penalty2, penalty1, penalty2 )
									);
			END;
		
		END;

		SHARED STRING CURRENT    := 'C';
		STRING HISTORICAL := 'H';

		// **************************** BEGIN WORK ****************************
		// | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | 
		// V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V 
		// ********************************************************************
		
		// 1. Obtain matching keyed records.
		grouped_in_corpkeys := GROUP(SORT(in_corpkeys, corp_key), corp_key);
		
		corp_recs := JOIN( grouped_in_corpkeys, corp2.Key_Corp_corpkey, 
		                          KEYED(RIGHT.corp_key = LEFT.corp_key),
		                          TRANSFORM(RIGHT),
		                          INNER, LIMIT(10000) );
		
		// 2. Assign penalties to matching records to identify the best overall matching record, whether the
		// corporation itself is the best match, or the registered agent (ra) (both are contained on the same row.
		
		// .. In the following transform, separate penalties are assigned for different fields because addr, 
		// phone, and company also exist in the contacts file, and the final penalty for a corporation 
		// must be the minimum of the penalty of each of these types in both the corp hist and contact 
		// child datasets.  The final penalty is calculated in the last join, in get_corp_corpkeys.search().
		layout_search_raw get_corp_recs_abbrev(recordof(corp2.Key_Corp_corpkey) r) := transform
			self.penalt_1                  := variable_params(params1).get_bdid_penalty_for_whole_row( r );
			self.penalt_addr_1             := variable_params(params1).get_address_penalty_for_whole_row( r );
			self.penalt_phone_1            := variable_params(params1).get_phone_penalty_for_whole_row( r );
			self.penalt_company_1          := variable_params(params1).get_bizname_penalty_for_whole_row( r );
			self.penalt_2                  := variable_params(params2).get_bdid_penalty_for_whole_row( r );
			self.penalt_addr_2             := variable_params(params2).get_address_penalty_for_whole_row( r );
			self.penalt_phone_2            := variable_params(params2).get_phone_penalty_for_whole_row( r );
			self.penalt_company_2          := variable_params(params2).get_bizname_penalty_for_whole_row( r );
			self.corp_state_origin_decoded := codes.general.state_long(r.corp_state_origin);	
			self.corp_addr1_prim_range     := if(fill_blank_addr1( r ), r.corp_ra_prim_range       , r.corp_addr1_prim_range);
			self.corp_addr1_predir         := if(fill_blank_addr1( r ), r.corp_ra_predir           , r.corp_addr1_predir);
			self.corp_addr1_prim_name      := if(fill_blank_addr1( r ), r.corp_ra_prim_name        , r.corp_addr1_prim_name);
			self.corp_addr1_postdir        := if(fill_blank_addr1( r ), r.corp_ra_postdir          , r.corp_addr1_postdir);
			self.corp_addr1_unit_desig     := if(fill_blank_addr1( r ), r.corp_ra_unit_desig       , r.corp_addr1_unit_desig);
			self.corp_addr1_addr_suffix    := if(fill_blank_addr1( r ), r.corp_ra_addr_suffix      , r.corp_addr1_addr_suffix);
			self.corp_addr1_sec_range      := if(fill_blank_addr1( r ), r.corp_ra_sec_range        , r.corp_addr1_sec_range);
			self.corp_addr1_p_city_name    := if(fill_blank_addr1( r ), r.corp_ra_p_city_name      , r.corp_addr1_p_city_name);
			self.corp_addr1_v_city_name    := if(fill_blank_addr1( r ), r.corp_ra_v_city_name      , r.corp_addr1_v_city_name);
			self.corp_addr1_state          := if(fill_blank_addr1( r ), r.corp_ra_state            , r.corp_addr1_state);
			self.corp_addr1_zip5           := if(fill_blank_addr1( r ), r.corp_ra_zip5             , r.corp_addr1_zip5);
			self.corp_addr1_zip4           := if(fill_blank_addr1( r ), r.corp_ra_zip4             , r.corp_addr1_zip4);
			self.corp_address1_type_desc   := if(fill_blank_addr1( r ), r.corp_ra_address_type_desc, r.corp_address1_type_desc);
			self.bdid                      := IF (r.bdid = 0, '', INTFORMAT (r.bdid, 12, 1));
			self                           := r;
			self.record_date               := [];
		end;

		pre_corp_search_recs := PROJECT(corp_recs, get_corp_recs_abbrev(LEFT));
	
		// 3. Filter by jurisdiction if provided. Then sort and optionally reduce to a single record if LatestForMAs.
		pre_corp_search_recs_jur := if(FilingJurisdiction_value <> '', 
																					pre_corp_search_recs(corp_state_origin = FilingJurisdiction_value),
																					pre_corp_search_recs);
		
		grouped_recs := sort(pre_corp_search_recs_jur, -corp_process_date); // grouped by corp_key, above
		
		grouped_corp_search_recs :=if( Latest_for_MAs, 
		                                       // use dedup to preserve only most recent corp_process_date
		                                      dedup(grouped_recs, left.corp_process_date <> right.corp_process_date),
																		      grouped_recs);
		
		
		// 4. Dedup and roll up all corp records.
		
		// Use Template Language to save repeated listings of many field names in our SORTs and DEDUPs, below.
		LOADXML('<xml/>')
		
		#DECLARE(corp_addr1_fields);
		#SET(corp_addr1_fields, 'corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name, corp_addr1_addr_suffix,	corp_addr1_postdir, corp_addr1_sec_range,	corp_addr1_v_city_name, corp_addr1_state, corp_addr1_zip5, corp_addr1_zip4, corp_address1_type_desc');

		#DECLARE(registered_agent_name_fields);
		#SET(registered_agent_name_fields, 'corp_ra_name, corp_ra_fname1, corp_ra_mname1, corp_ra_lname1');
		
		#DECLARE(registered_agent_addr_fields);
		#SET(registered_agent_addr_fields, 'corp_ra_prim_range, corp_ra_predir, corp_ra_prim_name, corp_ra_addr_suffix, corp_ra_postdir, corp_ra_sec_range, corp_ra_v_city_name, corp_ra_state, corp_ra_zip5[1..5], corp_ra_zip4');

		ds_corp_recs_deduped_for_simplified_contact := // SORT-DEDUP on corp history fields only
			DEDUP(
				SORT(
					grouped_corp_search_recs, 
					combined_penalty_values(), corp_legal_name, 
					%corp_addr1_fields%, corp_fed_tax_id, record_type, 
					corp_status_desc, corp_ln_name_type_desc, dt_last_seen, corp_process_date
				),
				combined_penalty_values(), corp_legal_name, 
				%corp_addr1_fields%, corp_fed_tax_id, record_type, 
				corp_status_desc, corp_ln_name_type_desc, dt_last_seen, corp_process_date
			);
		
		ds_corp_recs_deduped := // SORT-DEDUP on both corp history and registered agent fields
			DEDUP(
				SORT(
					grouped_corp_search_recs, 
					combined_penalty_values(), corp_legal_name, corp_fed_tax_id, 
					%corp_addr1_fields%, %registered_agent_name_fields%, %registered_agent_addr_fields%,
					corp_status_desc, record_type, corp_ln_name_type_desc, dt_last_seen, corp_process_date
				),
				combined_penalty_values(), corp_legal_name, corp_fed_tax_id,
				%corp_addr1_fields%, %registered_agent_name_fields%, %registered_agent_addr_fields%,
				corp_status_desc, record_type, corp_ln_name_type_desc, dt_last_seen, corp_process_date
			);
			
		ds_deduped_corp_recs := IF( Simplified_Contact, ds_corp_recs_deduped_for_simplified_contact, ds_corp_recs_deduped );
		
		// 5. At this point, we'll penalize all of the records differently for the benefit of the application.
		// Denote also which records are CURRENT and LEGAL, too.
		layout_search_raw_seq xfm_penalize_recs_differently(layout_search_raw l) := TRANSFORM
			SELF.corp_penalt_bdid_1    := IF( NOT variable_params(params1).input_bdid, PENALTY_VALUE_FOR_NO_INPUT, l.penalt_1 );
			SELF.corp_penalt_phone_1   := variable_params(params1).get_corp_phone_penalty( l );
			SELF.corp_penalt_company_1 := variable_params(params1).get_corp_bizname_penalty( l );
			SELF.corp_penalt_addr_1    := variable_params(params1).get_corp_address_penalty( l );
			SELF.ra_penalt_company_1   := variable_params(params1).get_ra_bizname_penalty( l );
			SELF.ra_penalt_indv_1      := variable_params(params1).get_ra_indv_penalty( l );
			SELF.ra_penalt_addr_1      := variable_params(params1).get_ra_address_penalty( l );
			SELF.corp_penalt_bdid_2    := IF( NOT variable_params(params2).input_bdid, PENALTY_VALUE_FOR_NO_INPUT, l.penalt_2 );
			SELF.corp_penalt_phone_2   := variable_params(params2).get_corp_phone_penalty( l );
			SELF.corp_penalt_company_2 := variable_params(params2).get_corp_bizname_penalty( l );
			SELF.corp_penalt_addr_2    := variable_params(params2).get_corp_address_penalty( l );
			SELF.ra_penalt_company_2   := variable_params(params2).get_ra_bizname_penalty( l );
			SELF.ra_penalt_indv_2      := variable_params(params2).get_ra_indv_penalty( l );
			SELF.ra_penalt_addr_2      := variable_params(params2).get_ra_address_penalty( l );
			SELF.corp_is_current_legal := (l.record_type = CURRENT AND l.corp_ln_name_type_desc = 'LEGAL');	
			SELF                       := l;
		END;

		ds_corp_recs_penalized := PROJECT(ds_deduped_corp_recs, xfm_penalize_recs_differently(LEFT));

		// 6. Now that we've penalized both corp and ra data, determine whether corp and ra are likely matches.		
		layout_search_raw xfm_match_all_recs(layout_search_raw_seq l) := TRANSFORM	
			SELF.corp_is_likely_match  := l.corp_penalt_bdid_1     = 0 OR 
			                              l.corp_penalt_phone_1    = 0 OR 
																		l.corp_penalt_company_1 <= 5 OR 
																		l.corp_penalt_addr_1    <= 5 OR
																		( TwoPartySearch AND (
																			l.corp_penalt_bdid_2     = 0 OR 
																			l.corp_penalt_phone_2    = 0 OR 
																			l.corp_penalt_company_2 <= 5 OR 
																			l.corp_penalt_addr_2    <= 5 ));
			SELF.ra_is_likely_match    := l.ra_penalt_company_1   <= 5 OR
			                              l.ra_penalt_indv_1      <= 5 OR
																		l.ra_penalt_addr_1      <= 5 OR
																		( TwoPartySearch AND (
																			l.ra_penalt_company_2   <= 5 OR
																			l.ra_penalt_indv_2      <= 5 OR
																			l.ra_penalt_addr_2      <= 5 ));						
			SELF                       := l;
		END;
		
		ds_corp_recs_matched := PROJECT(ds_corp_recs_penalized, xfm_match_all_recs(LEFT));		
		
		ds_ungrouped_matched_corp_recs := UNGROUP(ds_corp_recs_matched);

		// 7. Filter according to input criteria. Per the product consultants, the only time we are truly
		// interested in displaying Current/Legal and/or is_likely_match is when a company name is input.
		// In the other cases where only a phone number or only an address or only a person's name is input,
		// we are interested in pretty much any Corp match to those data.
		
		ds_corp_recs_filtered := IF( variable_params(params1).input_bizname OR (TwoPartySearch AND variable_params(params2).input_bizname),
		                                    ds_ungrouped_matched_corp_recs(corp_is_current_legal OR corp_is_likely_match),
		                                    ds_ungrouped_matched_corp_recs
		                                   );
		
		ds_corp_recs_regrouped := GROUP(SORT(ds_corp_recs_filtered, corp_key), corp_key);

		// 8. Resort, throwing to the top of the stack the result that matches best the input (i.e. has
		// the lowest penalty score. This will be used to determine the penalty for the matching record. 
		// However, this isn't the final sort order for the history records, which obey slightly different 
		// rules (see #11, below).
		SHARED ds_corp_recs_sorted := SORT(ds_corp_recs_regrouped, /* by */
		                                   IF(TwoPartySearch,
																				MIN(corp_penalt_company_1,corp_penalt_company_2),
																				corp_penalt_company_1),
		                                   -corp_is_current_legal,
																			 record_type = CURRENT, // but possibly not Legal
                                       corp_legal_name,
		                                   corp_inc_date, 
		                                   corp_forgn_date);
																			 
		// 9. Roll up the filtered records and project into the 'base' layout for export. The following transform 
		// assigns fields that should be common for any corporation.
		layout_search_raw rollcorps(layout_search_raw le, layout_search_raw ri) := TRANSFORM
			self.bdid                      := IF( (UNSIGNED6)le.bdid <> 0           , le.bdid                     , ri.bdid );
			self.corp_state_origin         := IF( le.corp_state_origin <> ''        , le.corp_state_origin        , ri.corp_state_origin );
			self.corp_state_origin_decoded := IF( le.corp_state_origin_decoded <> '', le.corp_state_origin_decoded, ri.corp_state_origin_decoded);
			self.corp_sos_charter_nbr      := IF( le.corp_sos_charter_nbr <> ''     , le.corp_sos_charter_nbr     , ri.corp_sos_charter_nbr);
			self                           := le;
		end;

		// The attribute 'base' contains common fields per corpkey.  This will later be joined with the corp_hist
		// and contacts child datasets in Corp2_services.get_corp_corpkeys.
		SHARED res_return_base := PROJECT(ROLLUP(ds_corp_recs_sorted, LEFT.corp_key = RIGHT.corp_key,
		                                         rollcorps(LEFT,RIGHT)),
																		  TRANSFORM(Corp2_services.Layout_Corp2_search_rollup_Penalty, SELF := LEFT, SELF := []));
		

		// 10. Ignoring res_return_base until export, create now the corp_hist child dataset; roll up history 
		// records and resort.
		Corp2_services.layout_corp_search xfm_build_corphist_child(layout_search_raw l) := TRANSFORM
			SELF.record_date := codes.corp2.corp_record_date(l.record_type);
			
			// Debug fields for analyzing penalty values.
//			SELF._corp_penalt_bdid      := l.corp_penalt_bdid;
//			SELF._corp_penalt_phone     := l.corp_penalt_phone;
//			SELF._corp_penalt_company   := l.corp_penalt_company;
//			SELF._corp_penalt_addr      := l.corp_penalt_addr;
//			SELF._ra_penalt_company     := l.ra_penalt_company;
//			SELF._ra_penalt_indv        := l.ra_penalt_indv;
//			SELF._ra_penalt_addr        := l.ra_penalt_addr;			
		  
			SELF             := l;
		END;
			
		layout_search_out xfm_add_corphist_child(layout_search_raw l) := TRANSFORM
			SELF.corp_hist := PROJECT(l, xfm_build_corphist_child(LEFT));
			SELF           := l;
		END;
		
		dedup_res_wChild := PROJECT(ds_corp_recs_sorted, xfm_add_corphist_child(LEFT));
		
		// Rollup, taking the top 50 corp history records in the child dataset.
		layout_search_out rollcorpshist(layout_search_out le, layout_search_out ri) := transform
			self.corp_hist := CHOOSEN(le.corp_hist & ri.corp_hist,50);
			self           := le;
		end;
		
		res_hist := ROLLUP(dedup_res_wChild, left.corp_key = right.corp_key, 
		                          rollcorpshist(left,right));

		// 11. Resort the corp_hist child dataset. Business Rule: We want at the very top any records  
		// that are CURRENT and LEGAL, followed by any that aren't CURRENT and LEGAL if they are yet a 
		// 'good enough' match to the input. And, we want the very best company name match pushed to 
		// the top of the stack of good-enough matches.
		SHARED res_hist_rerolled :=
			PROJECT(
				res_hist,
				TRANSFORM(layout_search_out,
					SELF.corp_hist := 
						SORT(
							LEFT.corp_hist, /* by */
							-corp_is_current_legal,
							-corp_is_likely_match,
							record_type = CURRENT,
							corp_legal_name,
							corp_inc_date, 
							corp_forgn_date
						),
					SELF := LEFT
					)
				);
				
		
		// 12. Exportable attributes.	
		EXPORT base := UNGROUP(res_return_base);		
		EXPORT hist := UNGROUP(res_hist_rerolled);

	END; // module corps_raw_search


	// Retrieve contact records for use in the search service
	export retrieve_cont_recs_search(dataset(corp2_services.layout_corpkey) in_corpkeys,
																	 BOOLEAN TwoPartySearch,
																	 PenaltyIBase params1,
																	 PenaltyIBase params2) := FUNCTION
	
		// Records retrieved from the contact file are stored in several layouts from the
		// assorted_layouts module as they get passed through transforms in this function
			
		key := corp2.Key_Cont_corpkey;

		ms(string70 a, string70 b, string70 c) := map(a=''=>b,b=''=>a,ut.StringSimilar(a,c)<=ut.StringSimilar(b,c)=>a,b);	

		variable_params(PenaltyIBase params) := MODULE
			shared bdid_value := AutoTranslator.bdid_val.val(PROJECT(params, AutoTranslator.bdid_val.params));
			shared did_value := AutoTranslator.did_value.val(PROJECT(params, AutoTranslator.did_value.params));
			shared phone_value := AutoTranslator.phone_value.val(PROJECT(params, AutoTranslator.phone_value.params));
			shared comp_name_value := AutoTranslator.comp_name_value.val(PROJECT(params, AutoTranslator.comp_name_value.params));
			shared lname_value := AutoTranslator.lname_value.val(PROJECT(params, AutoTranslator.lname_value.params));
			shared pname_value := AutoTranslator.pname_value.val(PROJECT(params, AutoTranslator.pname_value.params));
			shared city_value := AutoTranslator.city_value.val(PROJECT(params, AutoTranslator.city_value.params));
			shared postdir_value := AutoTranslator.postdir_value.val(PROJECT(params, AutoTranslator.postdir_value.params));
			shared prange_value := AutoTranslator.prange_value.val(PROJECT(params, AutoTranslator.prange_value.params));
			shared predir_value := AutoTranslator.predir_value.val(PROJECT(params, AutoTranslator.predir_value.params));
			shared state_value := AutoTranslator.state_value.val(PROJECT(params, AutoTranslator.state_value.params));
			shared addr_suffix_value := AutoTranslator.addr_suffix_value.val(PROJECT(params, AutoTranslator.addr_suffix_value.params));
			shared zip_val := AutoTranslator.zip_val.val(PROJECT(params, AutoTranslator.zip_val.params));

			shared input_bdid := noBlank(bdid_value);
			shared input_did := noBlank(did_value);
			shared input_phone := noBlank(phone_value);
			shared input_bizname := noBlank(comp_name_value);
			shared input_indv := noBlank(lname_value);
			shared input_address := noBlank(pname_value);

			// Separate penalties are assigned for addr, phone, company, and then all other penalty worthy
			// fields, because addr, phone, and company exist in the corp hist file as well so the penalties
			// from each file must be compared to each other, and the minimum taken, for the overall penalty.
			// This is accomplished in mac_pickPenalty (now defunct--ca), called from get_corp_corpkeys.
			//
			// We are using PENALTY_VALUE_FOR_NO_INPUT = 1000 to distinguish between penalties applied to 
			// exact matches and matches where the input is null. Penalties in both cases are zero for DIDs
			// and SSNs. Simply put, we want to prevent the system from mistaking a match made on a null input
			// for one that was exact.
			tempmoddid(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
				export string did_field := (string)r.did;
			end;
					
			tempmodssn(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
				export string ssn_field := r.cont_ssn;
			end;
					
			tempmodindvname(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
				export boolean allow_wildcard := false;
				export string fname_field := r.cont_fname;
				export string lname_field := r.cont_lname;
				export string mname_field := r.cont_mname;
			end;
			
			person_penalt(recordof(key) r) := IF( NOT input_did AND NOT input_indv, 
													 PENALTY_VALUE_FOR_NO_INPUT,
													 AutoStandardI.LIBCALL_PenaltyI_DID.val(tempmoddid(r)) 
														 + AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn(r)) // SSN isn't a valid input, so it will always be '0'.
														 + AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname(r))
													);

			export penalt(recordof(key) r) := person_penalt(r); // if(~simplified_contact or person_penalt < 6, person_penalt, skip);
	
			tempmodaddr(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
				export boolean allow_wildcard := false;
				export string city_field      := ms(r.cont_p_city_name,r.cont_v_city_name,city_value);
				export string city2_field     := '';
				export string pname_field     := r.cont_prim_name;
				export string postdir_field   := r.cont_postdir;
				export string prange_field    := r.cont_prim_range;
				export string predir_field    := r.cont_predir;
				export string state_field     := r.cont_state;
				export string suffix_field    := r.cont_addr_suffix;
				export string zip_field       := r.cont_zip5;
			end;
			export penalt_addr(recordof(key) r) := IF( NOT input_address, PENALTY_VALUE_FOR_NO_INPUT, AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr(r)) );
	
			tempmodphone(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
				export string phone_field := r.cont_phone10;
			end;
			export penalt_phone(recordof(key) r) := IF( NOT input_phone, PENALTY_VALUE_FOR_NO_INPUT, AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone(r)) );
	
			tempmodbizname(recordof(key) r) := module(project(params, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export string cname_field := trim(ms(r.cont_cname,r.corp_legal_name,comp_name_value));
			end;
			export penalt_company(recordof(key) r) := IF( NOT input_bizname, PENALTY_VALUE_FOR_NO_INPUT, AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname(r)) );
		end;

		// Calculate penalties for each matching Contacts record.
		assorted_layouts.cont_search_parent get_cont_recs_abbrev(recordof(key) r) := transform
			self.penalt_1 := variable_params(params1).penalt(r);
			self.penalt_addr_1 := variable_params(params1).penalt_addr(r);
			self.penalt_phone_1 := variable_params(params1).penalt_phone(r);
			self.penalt_company_1 := variable_params(params1).penalt_company(r);
			self.penalt_2 := variable_params(params2).penalt(r);
			self.penalt_addr_2 := variable_params(params2).penalt_addr(r);
			self.penalt_phone_2 := variable_params(params2).penalt_phone(r);
			self.penalt_company_2 := variable_params(params2).penalt_company(r);
			self.did := if(self.penalt_1 < 6 or (TwoPartySearch and self.penalt_2 < 6), IF (r.did = 0, '', INTFORMAT (r.did, 12, 1)), skip);
			self := r;
			self.record_date := [];
		end;
		
		prepre_cont_search_recs :=join(group(SORTED(in_corpkeys, corp_key), corp_key), key, 
		                               keyed(left.corp_key = right.corp_key) and 
																	 right.corp_supp_key = '', 
																	 get_cont_recs_abbrev(right),
																	 limit(10000,skip),
																	 keep(10000));

		// Move data for each matching record into appropriate (single-row) child dataset.
		assorted_layouts.cont_search_children contact_children(assorted_layouts.cont_search_parent le) := transform
			self.names             := project(le,transform(layout_search_names,self:=left));
			self.addresses         := project(le,transform(layout_search_addresses,self:=left));
			self.title_description := project(le,transform(layout_search_title,self:=left));
			self.record_date       := codes.corp2.corp_record_date(le.record_type);
			self                   := le;
		end;

		pre_cont_search_recs :=project(prepre_cont_search_recs, contact_children(left)); 

		// Move data for each record into the child dataset.
		assorted_layouts.cont_search_match make_contacts(assorted_layouts.cont_search_children le):=transform
			self.contact := project(le, transform(assorted_layouts.cont_search_vitals, self := left));  // ([{le.cont_fname,le.cont_lname,le.cont_mname,le.penalt,le.penalt_phone,le.dt_last_seen,le.did,le.names,le.parties,le.addresses}],layout_contact_search_vitals);
			self := le;
		end;	
		
		cont_search_recs := project(pre_cont_search_recs,make_contacts(left));
		
		// Sort and dedup.
		dedup_res := dedup(sort(cont_search_recs,
		                        IF(TwoPartySearch,
															MIN(penalt_1,penalt_2), // + if(not simplified_contact, penalt_phone + penalt_company + penalt_addr, 0),
															penalt_1),
		                        -dt_last_seen,
														-(unsigned1)(record_type='C'),
														cont_lname,
														cont_fname,
														cont_mname), 
											 record, except record_type
											 );
		
		match  := dataset([],assorted_layouts.cont_search_match);
		vitals := dataset([],assorted_layouts.cont_search_vitals);
		
		// Macro to combine contact records that are the same person.
		mac_make_contacts_search(vitals, match, dedup_res, roll_people_res)

		// Put the least penalized contact at the top, so the app can find it easily. This is a 'good
		// enough' solution, and it should work all right, since it's likely that only one contact will
		// match any personal data input.
		assorted_layouts.cont_formatted format_contacts(assorted_layouts.cont_search_match le):=transform
			self.contact :=project(sort(le.contact, if(TwoPartySearch,
																								min(
																									penalt_1 + penalt_phone_1 + penalt_company_1 + penalt_addr_1,
																									penalt_2 + penalt_phone_2 + penalt_company_2 + penalt_addr_2),
																								penalt_1 + penalt_phone_1 + penalt_company_1 + penalt_addr_1),
			                                        -dt_last_seen, 
			                                        corp_legal_name, 
																							cont_lname,
																							cont_fname,
																							cont_mname
																	),
															transform(layout_contact_search, self := left)
														 );
			self := le;
		end;
		
		// Format contact records-get rid of the top level fields such as names		
		res_return := project(roll_people_res,format_contacts(left));
		
		return ungroup(res_return);
				
	end; // function retrieve_cont_recs_search

end;