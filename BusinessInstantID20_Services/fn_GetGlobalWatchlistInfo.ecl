IMPORT BIPV2, Business_Risk_BIP, ut, Patriot, iesp, GlobalWatchLists, Risk_Indicators, STD;

EXPORT fn_GetGlobalWatchlistInfo( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                                  Business_Risk_BIP.LIB_Business_Shell_LIBIN Options
																) := 	FUNCTION
		UCase := STD.Str.ToUpperCase;
		
		ds_WatchlistsRequested := Options.Watchlists_Requested;		
		ofac_only := FALSE;

		patriot.Layout_batch_in PrepPatriot(ds_input le) :=
			TRANSFORM
				SELF.seq := le.seq;
				SELF.name_first := '';
				SELF.name_middle := '';
				SELF.name_last := '';
				SELF.name_unparsed := le.CompanyName;
				SELF.country := '';
				SELF.search_type := 'B';
				SELF.dob :=  '';
				SELF.acctNo := le.AcctNo;
			END;
		
		inForm_single := GROUP(PROJECT(ds_input, PrepPatriot(LEFT)),SEQ);

		//************************************************** ofac_version = 3 **************************************************
		// process
		patOut := Patriot.Search_Base_Function(inForm_single, ofac_only, Options.Global_Watchlist_Threshold, true, Options.ofac_version,Options.include_ofac,Options.include_additional_watchlists,Options.Watchlists_Requested);

		// Sort by best match
		Patriot.Layout_Base_Results.parent sorter(Patriot.Layout_Base_Results.parent le) :=
			TRANSFORM
				SELF.pty_keys := SORT(le.pty_keys,-score,pty_key);
				SELF := le;
			END;

		patPref := PROJECT(patOut, sorter(LEFT));

//		top_matchesTEMP := choosen(patPref[1].pty_keys(pty_key[1..4]= 'OFAC'), 7);
//		top_WLmatchesTEMP := choosen(patPref[1].pty_keys(pty_key[1..4]<> 'OFAC'), 7);

	
		temp_OFACLayout := RECORD // OFAC
			STRING60 bus_watchlist_table ;
			STRING120 bus_watchlist_program ;
			STRING10 bus_watchlist_record_number ;
			STRING120 bus_watchlist_companyname ;
			STRING20 bus_watchlist_firstname;
			STRING20 bus_watchlist_lastname;
			STRING50 bus_watchlist_address ;
			STRING30 bus_watchlist_city ;
			STRING2 bus_watchlist_state ;
			STRING9 bus_watchlist_zip ;
			STRING30 bus_watchlist_country ;
			STRING200 bus_watchlist_entity_name ;
			STRING4 bus_watchlist_sequence ;
		END;
		
		temp_OFACLayoutDS := RECORD // OFAC
			 UNSIGNED4 Seq;
			 DATASET(temp_OFACLayout) OFAC;
			 DATASET(temp_OFACLayout) Watchlists;
		END;
	
		temp_OFACLayoutDS rejoin(ds_input le, patPref ri) := transform

			// search type in pty_keys child allows people match preference over employer
			top_matches := choosen(sort(ri.pty_keys(pty_key[1..4]='OFAC'),-score, pty_key), 7);

			pat_recs_OFAC := join(top_matches, GlobalWatchLists.Key_GlobalWatchLists_Key, 
												left.pty_key<>'' and
												keyed(right.pty_key=left.pty_key),
												transform(recordof(GlobalWatchLists.Key_GlobalWatchLists_Key), 
													name_matches := right.first_name=left.first_name AND ut.NBEQ(right.last_name,left.last_name);
													cmpy_matches := ut.NBEQ(right.cname,left.cname);
													country_matches := UCase(right.name_type)='COUNTRY' AND ut.NBEQ(right.address_country, left.country);
													something_matched := name_matches or cmpy_matches or country_matches;
													self.first_name := if(something_matched, right.first_name, skip);
													self := right), atmost(5000), keep(1));
													
			ofac_temp := project(pat_recs_OFAC, 	
													transform(temp_OFACLayout,
																		SELF.bus_watchlist_sequence := '';
																		SELF.bus_watchlist_table := left.source;
																		SELF.bus_watchlist_program := GlobalWatchLists.program_lookup(left.sanctions_program_1);
																		SELF.bus_watchlist_record_number := left.pty_key;
																		SELF.bus_watchlist_country := left.address_country;
																		SELF.bus_watchlist_entity_name := left.orig_pty_name;
																		SELF.bus_watchlist_companyname := left.cname; 
																		SELF.bus_watchlist_firstname := left.fname;
																		SELF.bus_watchlist_lastname := left.lname;
																		nocleanaddr := left.prim_range = '' and left.prim_name = '' and left.zip = '';
																		SELF.bus_watchlist_address := if(nocleanaddr,
																																	trim(left.address_line_1) + ' ' + trim(left.address_line_2) + ' ' + trim(left.address_line_3),
																																	Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name,
																																																									left.suffix, left.postdir, left.unit_desig, left.sec_range));
																		// parsed watchlist address
																		SELF.bus_watchlist_city := if(nocleanaddr,left.address_city,left.v_city_name);
																		SELF.bus_watchlist_state := if(nocleanaddr,left.address_state_province , left.st);
																		SELF.bus_watchlist_zip := if(nocleanaddr,left.address_postal_code , left.zip);
																		));
			self.ofac := ofac_temp;	
			
			top_WLmatches := choosen(sort(ri.pty_keys(pty_key[1..4]<>'OFAC'),-score, pty_key), 7);

			pat_recs_WL := join(top_WLmatches, GlobalWatchLists.Key_GlobalWatchLists_Key, 
												left.pty_key<>'' and
												keyed(right.pty_key=left.pty_key),
												transform(recordof(GlobalWatchLists.Key_GlobalWatchLists_Key), 
													name_matches := right.first_name=left.first_name AND ut.NBEQ(right.last_name,left.last_name);
													cmpy_matches := ut.NBEQ(right.cname,left.cname);
													country_matches := UCase(right.name_type)='COUNTRY' AND ut.NBEQ(right.address_country, left.country);
													something_matched := name_matches or cmpy_matches or country_matches;
													self.first_name := if(something_matched, right.first_name, skip);
													self := right), atmost(5000), keep(1));
			watchlists_temp := project(pat_recs_WL, 	
													transform(temp_OFACLayout, 
																		SELF.bus_watchlist_sequence := '';
																		SELF.bus_watchlist_table := left.source;
																		SELF.bus_watchlist_program := GlobalWatchLists.program_lookup(left.sanctions_program_1);
																		SELF.bus_watchlist_record_number := left.pty_key;
																		SELF.bus_watchlist_country := left.address_country;
																		SELF.bus_watchlist_entity_name := left.orig_pty_name;
																		SELF.bus_watchlist_companyname := left.cname; 
																		SELF.bus_watchlist_firstname := left.fname;
																		SELF.bus_watchlist_lastname := left.lname;
																		nocleanaddr := left.prim_range = '' and left.prim_name = '' and left.zip = '';
																		SELF.bus_watchlist_address := if(nocleanaddr,
																																	trim(left.address_line_1) + ' ' + trim(left.address_line_2) + ' ' + trim(left.address_line_3),
																																	Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name,
																																																									left.suffix, left.postdir, left.unit_desig, left.sec_range));
																		// parsed watchlist address
																		SELF.bus_watchlist_city := if(nocleanaddr,left.address_city,left.v_city_name);
																		SELF.bus_watchlist_state := if(nocleanaddr,left.address_state_province , left.st);
																		SELF.bus_watchlist_zip := if(nocleanaddr,left.address_postal_code , left.zip);
																		));
			self.watchlists := watchlists_temp;	
			
			self.seq := le.seq;
		end;

		SearchOut := JOIN(ds_input, patPref, LEFT.seq = RIGHT.seq,
					rejoin(LEFT,RIGHT), LOOKUP, LEFT OUTER);	

		// Use COMBINE( ) function to transform from normalized records to denormalized, 
		// repeating fields in a single record.
		layout_seq := {UNSIGNED4 seq};

		ds_seq_grpd := GROUP(DEDUP(SORT(PROJECT(SearchOut, layout_seq), seq), seq), seq);			

		SearchOut_grpd := GROUP(SORT(SearchOut, seq), seq);			
					
		BusinessInstantID20_Services.Layouts.OFACAndWatchlistLayoutFlat xfm_ToCombineBusinessByWL(ds_seq_grpd le, DATASET(temp_OFACLayoutDS) allRows ) := 
				TRANSFORM
					SELF.seq 													:= le.seq;
					//1
					SELF.bus_ofac_table_1    					:= allRows[1].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_1 					:= allRows[1].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_1     := allRows[1].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_1  			:= allRows[1].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_1  			  := allRows[1].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_1  			  := allRows[1].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_1     			:= allRows[1].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_1    					:= allRows[1].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_1 						:= allRows[1].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_1  							:= allRows[1].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_1       		:= allRows[1].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_1       := allRows[1].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_1       		:= allRows[1].OFAC[1].bus_watchlist_sequence;
					//2	
					SELF.bus_ofac_table_2    					:= allRows[2].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_2 					:= allRows[2].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_2     := allRows[2].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_2  			:= allRows[2].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_2  			  := allRows[2].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_2  			  := allRows[2].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_2     			:= allRows[2].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_2    					:= allRows[2].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_2 						:= allRows[2].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_2  							:= allRows[2].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_2       		:= allRows[2].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_2       := allRows[2].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_2       		:= allRows[2].OFAC[1].bus_watchlist_sequence;
					//3
					SELF.bus_ofac_table_3    					:= allRows[3].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_3 					:= allRows[3].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_3     := allRows[3].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_3  			:= allRows[3].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_3  			  := allRows[3].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_3  			  := allRows[3].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_3     			:= allRows[3].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_3    					:= allRows[3].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_3 						:= allRows[3].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_3  							:= allRows[3].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_3       		:= allRows[3].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_3       := allRows[3].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_3       		:= allRows[3].OFAC[1].bus_watchlist_sequence;
					//4
					SELF.bus_ofac_table_4    					:= allRows[4].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_4 					:= allRows[4].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_4     := allRows[4].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_4  			:= allRows[4].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_4  			  := allRows[4].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_4  			  := allRows[4].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_4     			:= allRows[4].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_4    					:= allRows[4].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_4 						:= allRows[4].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_4  							:= allRows[4].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_4       		:= allRows[4].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_4       := allRows[4].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_4       		:= allRows[4].OFAC[1].bus_watchlist_sequence;
					//5
					SELF.bus_ofac_table_5    					:= allRows[5].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_5 					:= allRows[5].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_5     := allRows[5].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_5  			:= allRows[5].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_5  			  := allRows[5].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_5  			  := allRows[5].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_5     			:= allRows[5].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_5    					:= allRows[5].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_5 						:= allRows[5].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_5  							:= allRows[5].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_5       		:= allRows[5].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_5       := allRows[5].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_5       		:= allRows[5].OFAC[1].bus_watchlist_sequence;
					//6
					SELF.bus_ofac_table_6    					:= allRows[6].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_6 					:= allRows[6].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_6     := allRows[6].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_6  			:= allRows[6].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_6  			  := allRows[6].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_6  			  := allRows[6].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_6     			:= allRows[6].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_6    					:= allRows[6].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_6 						:= allRows[6].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_6  							:= allRows[6].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_6       		:= allRows[6].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_6       := allRows[6].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_6       		:= allRows[6].OFAC[1].bus_watchlist_sequence;
					//7
					SELF.bus_ofac_table_7    					:= allRows[7].OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_7 					:= allRows[7].OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_7     := allRows[7].OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_7  			:= allRows[7].OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_7  			  := allRows[7].OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_7  			  := allRows[7].OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_7     			:= allRows[7].OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_7    					:= allRows[7].OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_7 						:= allRows[7].OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_7  							:= allRows[7].OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_7       		:= allRows[7].OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_7       := allRows[7].OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_7       		:= allRows[7].OFAC[1].bus_watchlist_sequence;
					//1
					SELF.bus_watchlist_table_1    		:= allRows[1].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_1 			:= allRows[1].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_1:= allRows[1].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_1  := allRows[1].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_1    := allRows[1].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_1     := allRows[1].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_1     	:= allRows[1].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_1    			:= allRows[1].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_1 				:= allRows[1].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_1  				:= allRows[1].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_1      := allRows[1].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_1  := allRows[1].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_1     := allRows[1].Watchlists[1].bus_watchlist_sequence;
					//2
					SELF.bus_watchlist_table_2    		:= allRows[2].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_2 			:= allRows[2].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_2:= allRows[2].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_2  := allRows[2].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_2    := allRows[2].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_2     := allRows[2].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_2     	:= allRows[2].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_2    			:= allRows[2].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_2 				:= allRows[2].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_2  				:= allRows[2].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_2      := allRows[2].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_2  := allRows[2].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_2     := allRows[2].Watchlists[1].bus_watchlist_sequence;
					//3
					SELF.bus_watchlist_table_3    		:= allRows[3].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_3 			:= allRows[3].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_3:= allRows[3].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_3  := allRows[3].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_3    := allRows[3].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_3     := allRows[3].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_3     	:= allRows[3].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_3    			:= allRows[3].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_3 				:= allRows[3].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_3  				:= allRows[3].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_3      := allRows[3].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_3  := allRows[3].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_3     := allRows[3].Watchlists[1].bus_watchlist_sequence;
					//4
					SELF.bus_watchlist_table_4    		:= allRows[4].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_4 			:= allRows[4].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_4:= allRows[4].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_4  := allRows[4].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_4    := allRows[4].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_4     := allRows[4].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_4     	:= allRows[4].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_4    			:= allRows[4].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_4 				:= allRows[4].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_4  				:= allRows[4].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_4      := allRows[4].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_4  := allRows[4].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_4     := allRows[4].Watchlists[1].bus_watchlist_sequence;
					//5
					SELF.bus_watchlist_table_5    		:= allRows[5].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_5 			:= allRows[5].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_5:= allRows[5].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_5  := allRows[5].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_5    := allRows[5].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_5     := allRows[5].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_5     	:= allRows[5].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_5    			:= allRows[5].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_5 				:= allRows[5].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_5  				:= allRows[5].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_5      := allRows[5].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_5  := allRows[5].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_5     := allRows[5].Watchlists[1].bus_watchlist_sequence;
					//6
					SELF.bus_watchlist_table_6    		:= allRows[6].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_6 			:= allRows[6].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_6:= allRows[6].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_6  := allRows[6].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_6    := allRows[6].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_6     := allRows[6].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_6     	:= allRows[6].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_6    			:= allRows[6].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_6 				:= allRows[6].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_6  				:= allRows[6].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_6      := allRows[6].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_6  := allRows[6].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_6     := allRows[6].Watchlists[1].bus_watchlist_sequence;
					//7
					SELF.bus_watchlist_table_7    		:= allRows[7].Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_7 			:= allRows[7].Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_7:= allRows[7].Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_7  := allRows[7].Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_7    := allRows[7].Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_7     := allRows[7].Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_7     	:= allRows[7].Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_7    			:= allRows[7].Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_7 				:= allRows[7].Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_7  				:= allRows[7].Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_7      := allRows[7].Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_7  := allRows[7].Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_7     := allRows[7].Watchlists[1].bus_watchlist_sequence;

					SELF := [];
				END;

		ds_businesses_watchlist := 
			COMBINE( 
				ds_seq_grpd, SearchOut_grpd, 
				GROUP, 
				xfm_ToCombineBusinessByWL(LEFT,ROWS(RIGHT)) 
			);
		
		// OUTPUT( ds_input, NAMED('CompanyAndAuthRepInfoInput_ofac') );
		// OUTPUT( inForm_single, NAMED('inForm_single_ofac') );
		// OUTPUT( patOut, NAMED('patOut_ofac') );
		// OUTPUT( patPref, NAMED('patPrefy_ofac') );
		// OUTPUT( top_matchesTEMP, NAMED('top_matchesTEMP_ofac') );
		// OUTPUT( top_WLmatchesTEMP, NAMED('top_WLmatchesTEMP_ofac') );
		// OUTPUT( SearchOut, NAMED('SearchOut_ofac') );
		// OUTPUT( ds_businesses_watchlist, NAMED('ds_businesses_watchlist_ofac') );
		
		RETURN ds_businesses_watchlist;
	END;
		
