/*2016-09-13T22:58:22Z (Michele Walklin)
RR-10587
*/
import Address, GlobalWatchLists, GlobalWatchLists_Services, iesp, Patriot, Risk_Indicators, ut, OFAC_XG5, Gateway;

export getWatchLists2(GROUPED DATASET(Layout_Output) inl, boolean ofac_only = false, boolean From_BIID = false,
											unsigned1 ofac_version=1,boolean include_ofac=FALSE,boolean include_additional_watchlists=FALSE,
											real Global_WatchList_Threshold =0.00,
											dataset(iesp.share.t_StringArrayItem) watchlists_requested=dataset([], iesp.share.t_StringArrayItem),
											dataset(Gateway.Layouts.Config) gateways = dataset([], Gateway.Layouts.Config), dob_radius = -1) :=
FUNCTION

r_threshold_score := map(global_watchlist_threshold = 0.00 and ofac_version < 4 => OFAC_XG5.Constants.DEF_THRESHOLD_REAL, 
												global_watchlist_threshold = 0.00 and ofac_version  >= 4 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL, 
												global_watchlist_threshold < Patriot.Constants.MIN_THRESHOLD => Patriot.Constants.MIN_THRESHOLD,
												global_watchlist_threshold > Patriot.Constants.MAX_THRESHOLD => Patriot.Constants.MAX_THRESHOLD,
												global_watchlist_threshold);

// put in layout to process
patriot.Layout_batch_in form(inl le, INTEGER i) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.name_unparsed := IF(i=1,le.company_name,le.alt_company_name);
	self.country := le.country;
	// non-individual
	SELF.search_type := 'N';
	SELF := [];
END;
inForm_norm := NORMALIZE(inl, 2, form(LEFT, COUNTER));
inForm := inForm_norm(name_unparsed<>'');


//************************************************** ofac_version = 1,2,3 **************************************************
// process
patOut := Patriot.Search_Base_Function(inForm, ofac_only, r_threshold_score, true,ofac_version,include_ofac,include_additional_watchlists, watchlists_requested);


// Sort by best match
Patriot.Layout_Base_Results.parent sorter(Patriot.Layout_Base_Results.parent le) :=
TRANSFORM
	SELF.pty_keys := SORT(le.pty_keys,-score,pty_key);
	SELF := le;
END;
patPref := PROJECT(patOut, sorter(LEFT));

Patriot.Layout_Base_Results.parent roller(Patriot.Layout_Base_Results.parent  le, 
																					Patriot.Layout_Base_Results.parent  ri) :=
TRANSFORM
	SELF.pty_keys := le.pty_keys & ri.pty_keys;
	SELF := le;
END;
// prefer primary company name over alt_company_name (implicitly the former is first)
patRolled := ROLLUP(patPref,true,roller(LEFT,RIGHT));

layout_output rejoin(inl le, patOut ri) := transform

		// search type in pty_keys child allows people match preference over employer
	top_matches := choosen(sort(ri.pty_keys,-(unsigned)(pty_key[1..4]='OFAC'),-search_type,-score, pty_key), 7);

	pat_recs_all := join(top_matches, GlobalWatchLists.Key_GlobalWatchLists_Key, 
										left.pty_key<>'' and
										keyed(right.pty_key=left.pty_key),
										transform(recordof(GlobalWatchLists.Key_GlobalWatchLists_Key), 
											name_matches := right.first_name=left.first_name AND ut.NBEQ(right.last_name,left.last_name);
											cmpy_matches := ut.NBEQ(right.cname,left.cname);
											country_matches := stringlib.stringtouppercase(right.name_type)='COUNTRY' AND ut.NBEQ(right.address_country, left.country);
											something_matched := name_matches or cmpy_matches or country_matches;
											self.first_name := if(something_matched, right.first_name, skip);
											self := right), atmost(5000), keep(1));
											
	watchlists_temp := project(pat_recs_all, 	
											transform(risk_indicators.layouts.layout_watchlists, 
																self.watchlist_table := left.source;
																self.watchlist_program := GlobalWatchLists.program_lookup(left.sanctions_program_1);
																SELF.watchlist_record_number := left.pty_key;
																SELF.watchlist_contry := left.address_country;
																SELF.watchlist_entity_name := left.orig_pty_name;
																SELF.watchlist_fname := left.fname;
																SELF.watchlist_lname := left.lname;
																nocleanaddr := left.prim_range = '' and left.prim_name = '' and left.zip = '';
																SELF.watchlist_address := if(nocleanaddr,
																															trim(left.address_line_1) + ' ' + trim(left.address_line_2) + ' ' + trim(left.address_line_3),
																															Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name,
																																																							left.suffix, left.postdir, left.unit_desig, left.sec_range));
																// parsed watchlist address
																SELF.WatchlistPrimRange := if(nocleanaddr, '', left.prim_range);	
																SELF.WatchlistPreDir := if(nocleanaddr, '', left.predir);
																SELF.WatchlistPrimName := if(nocleanaddr, '', left.prim_name);
																SELF.WatchlistAddrSuffix := if(nocleanaddr, '', left.suffix);
																SELF.WatchlistPostDir := if(nocleanaddr, '', left.postdir);
																SELF.WatchlistUnitDesignation := if(nocleanaddr, '', left.unit_desig);
																SELF.WatchlistSecRange := if(nocleanaddr, '', left.sec_range);																
																SELF.watchlist_city := if(nocleanaddr,left.address_city,left.v_city_name);
																SELF.watchlist_state := if(nocleanaddr,left.address_state_province , left.st);
																SELF.watchlist_zip := if(nocleanaddr,left.address_postal_code , left.zip);
																));
	
	
	// keep these fields here for all of our legacy products still using them
	SELF.watchlist_table := watchlists_temp[1].watchlist_table;
	SELF.watchlist_program := watchlists_temp[1].watchlist_program;
	SELF.watchlist_record_number := watchlists_temp[1].watchlist_record_number;
	SELF.watchlist_country := watchlists_temp[1].watchlist_contry;
	SELF.watchlist_fname := watchlists_temp[1].watchlist_fname;
	SELF.watchlist_lname := watchlists_temp[1].watchlist_lname;
	SELF.watchlist_address := watchlists_temp[1].watchlist_address;
	SELF.watchlist_city := watchlists_temp[1].watchlist_city;
	SELF.watchlist_state := watchlists_temp[1].watchlist_state;
	SELF.watchlist_zip := watchlists_temp[1].watchlist_zip;
	SELF.watchlist_cmpy := watchlists_temp[1].watchlist_entity_name;
		
	SELF.watchlist_table_2 := watchlists_temp[2].watchlist_table;
	SELF.watchlist_program_2 := watchlists_temp[2].watchlist_program;
	SELF.watchlist_record_number_2 := watchlists_temp[2].watchlist_record_number;
	SELF.watchlist_country_2 := watchlists_temp[2].watchlist_contry;
	SELF.watchlist_fname_2 := watchlists_temp[2].watchlist_fname;
	SELF.watchlist_lname_2 := watchlists_temp[2].watchlist_lname;
	SELF.watchlist_address_2 := watchlists_temp[2].watchlist_address;
	SELF.watchlist_city_2 := watchlists_temp[2].watchlist_city;
	SELF.watchlist_state_2 := watchlists_temp[2].watchlist_state;
	SELF.watchlist_zip_2 := watchlists_temp[2].watchlist_zip;
	SELF.watchlist_cmpy_2 := watchlists_temp[2].watchlist_entity_name;
	
	SELF.watchlist_table_3 := watchlists_temp[3].watchlist_table;
	SELF.watchlist_program_3 := watchlists_temp[3].watchlist_program;
	SELF.watchlist_record_number_3 := watchlists_temp[3].watchlist_record_number;
	SELF.watchlist_country_3 := watchlists_temp[3].watchlist_contry;
	SELF.watchlist_fname_3 := watchlists_temp[3].watchlist_fname;
	SELF.watchlist_lname_3 := watchlists_temp[3].watchlist_lname;
	SELF.watchlist_address_3 := watchlists_temp[3].watchlist_address;
	SELF.watchlist_city_3 := watchlists_temp[3].watchlist_city;
	SELF.watchlist_state_3 := watchlists_temp[3].watchlist_state;
	SELF.watchlist_zip_3 := watchlists_temp[3].watchlist_zip;
	SELF.watchlist_cmpy_3 := watchlists_temp[3].watchlist_entity_name;
	
	SELF.watchlist_table_4 := watchlists_temp[4].watchlist_table;
	SELF.watchlist_program_4 := watchlists_temp[4].watchlist_program;
	SELF.watchlist_record_number_4 := watchlists_temp[4].watchlist_record_number;
	SELF.watchlist_country_4 := watchlists_temp[4].watchlist_contry;
	SELF.watchlist_fname_4 := watchlists_temp[4].watchlist_fname;
	SELF.watchlist_lname_4 := watchlists_temp[4].watchlist_lname;
	SELF.watchlist_address_4 := watchlists_temp[4].watchlist_address;
	SELF.watchlist_city_4 := watchlists_temp[4].watchlist_city;
	SELF.watchlist_state_4 := watchlists_temp[4].watchlist_state;
	SELF.watchlist_zip_4 := watchlists_temp[4].watchlist_zip;
	SELF.watchlist_cmpy_4 := watchlists_temp[4].watchlist_entity_name;
	
	SELF.watchlist_table_5 := watchlists_temp[5].watchlist_table;
	SELF.watchlist_program_5 := watchlists_temp[5].watchlist_program;
	SELF.watchlist_record_number_5 := watchlists_temp[5].watchlist_record_number;
	SELF.watchlist_country_5 := watchlists_temp[5].watchlist_contry;
	SELF.watchlist_fname_5 := watchlists_temp[5].watchlist_fname;
	SELF.watchlist_lname_5 := watchlists_temp[5].watchlist_lname;
	SELF.watchlist_address_5 := watchlists_temp[5].watchlist_address;
	SELF.watchlist_city_5 := watchlists_temp[5].watchlist_city;
	SELF.watchlist_state_5 := watchlists_temp[5].watchlist_state;
	SELF.watchlist_zip_5 := watchlists_temp[5].watchlist_zip;
	SELF.watchlist_cmpy_5 := watchlists_temp[5].watchlist_entity_name;
	
	SELF.watchlist_table_6 := watchlists_temp[6].watchlist_table;
	SELF.watchlist_program_6 := watchlists_temp[6].watchlist_program;
	SELF.watchlist_record_number_6 := watchlists_temp[6].watchlist_record_number;
	SELF.watchlist_country_6 := watchlists_temp[6].watchlist_contry;
	SELF.watchlist_fname_6 := watchlists_temp[6].watchlist_fname;
	SELF.watchlist_lname_6 := watchlists_temp[6].watchlist_lname;
	SELF.watchlist_address_6 := watchlists_temp[6].watchlist_address;
	SELF.watchlist_city_6 := watchlists_temp[6].watchlist_city;
	SELF.watchlist_state_6 := watchlists_temp[6].watchlist_state;
	SELF.watchlist_zip_6 := watchlists_temp[6].watchlist_zip;
	SELF.watchlist_cmpy_6 := watchlists_temp[6].watchlist_entity_name;
	
	SELF.watchlist_table_7 := watchlists_temp[7].watchlist_table;
	SELF.watchlist_program_7 := watchlists_temp[7].watchlist_program;
	SELF.watchlist_record_number_7 := watchlists_temp[7].watchlist_record_number;
	SELF.watchlist_country_7 := watchlists_temp[7].watchlist_contry;
	SELF.watchlist_fname_7 := watchlists_temp[7].watchlist_fname;
	SELF.watchlist_lname_7 := watchlists_temp[7].watchlist_lname;
	SELF.watchlist_address_7 := watchlists_temp[7].watchlist_address;
	SELF.watchlist_city_7 := watchlists_temp[7].watchlist_city;
	SELF.watchlist_state_7 := watchlists_temp[7].watchlist_state;
	SELF.watchlist_zip_7 := watchlists_temp[7].watchlist_zip;
	SELF.watchlist_cmpy_7 := watchlists_temp[7].watchlist_entity_name;
	
	self := le;
end;

pj3 := join(inl, patRolled, left.seq = right.seq,
			rejoin(LEFT,RIGHT), lookup, left outer);
//*************OFAC VERSION 4 = XG5 BRIDGER SEARCH LOGIC *****************************
OFAC_XG5.Layout.InputLayout XG5prep(inForm le) := TRANSFORM											
	SELF.seq := le.seq;
	self.acctno := le.acctno;
	self.firstName := trim(le.name_first);
	self.middleName := trim(le.name_middle);
	self.lastName := trim(le.name_last);
	SELF.FullName := IF( le.name_first != '' OR le.name_last != '', '', TRIM(le.name_unparsed,LEFT,RIGHT) );
		dobTemp := if(le.dob = '', '', le.dob[5..6] + '/' + le.dob[7..8] + '/' + le.dob[1..4]);
	SELF.DOB := dobTemp;
	SELF.country := le.country;
	SELF.searchType := le.search_type;
	SELF := [];
	
END;
 
 DOBRadiusXG5 := If(dob_radius = -1, 0, dob_radius * 12);  // Ver 1-3 has Dob Radius in Years, XG5 is in months
 prep_XG5 := project(ungroup(inForm), XG5prep(left));  

 XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5, 
																	ofac_only ,
																	(r_threshold_score * 100) , 
																	include_ofac,
																	include_Additional_watchlists,
																	DOBRadiusXG5 ,
																	watchlists_requested,
																	gateways);

 // want is to fail immediately as we don't want customers to think there was no hit on OFAC
 if(exists(XG5_ptys(errorMessage <> '')), FAIL('Bridger Gateway Error'));
																	 
 XG5Parsed := OFAC_XG5.OFACXG5_Watchlist2_Response(XG5_ptys);
 
 XG5Formatted	:= OFAC_XG5.FormatXG5_BIIDWatchlist2(XG5Parsed);
 
 XG5AddInData := join(inl, XG5Formatted, left.seq = right.seq,
			transform(Business_Risk.Layout_Output, 

				SELF.watchlist_table := RIGHT.watchlist_table;
				SELF.watchlist_program := RIGHT.watchlist_program;
				SELF.watchlist_record_number := RIGHT.watchlist_record_number;
				SELF.watchlist_country := RIGHT.watchlist_country;
				SELF.watchlist_fname := RIGHT.watchlist_fname;
				SELF.watchlist_lname := RIGHT.watchlist_lname;
				SELF.watchlist_address := RIGHT.watchlist_address;
				SELF.watchlist_city := RIGHT.watchlist_city;
				SELF.watchlist_state := RIGHT.watchlist_state;
				SELF.watchlist_zip := RIGHT.watchlist_zip;
				SELF.watchlist_cmpy := RIGHT.watchlist_cmpy;
				
				SELF.watchlist_table_2 := RIGHT.watchlist_table_2;
				SELF.watchlist_program_2 := RIGHT.watchlist_program_2;
				SELF.watchlist_record_number_2 := RIGHT.watchlist_record_number_2;
				SELF.watchlist_country_2 := RIGHT.watchlist_country_2;
				SELF.watchlist_fname_2 := RIGHT.watchlist_fname_2;
				SELF.watchlist_lname_2 := RIGHT.watchlist_lname_2;
				SELF.watchlist_address_2 := RIGHT.watchlist_address_2;
				SELF.watchlist_city_2 := RIGHT.watchlist_city_2;
				SELF.watchlist_state_2 := RIGHT.watchlist_state_2;
				SELF.watchlist_zip_2 := RIGHT.watchlist_zip_2;
				SELF.watchlist_cmpy_2 := RIGHT.watchlist_cmpy_2;

				SELF.watchlist_table_3 := RIGHT.watchlist_table_3;
				SELF.watchlist_program_3 := RIGHT.watchlist_program_3;
				SELF.watchlist_record_number_3 := RIGHT.watchlist_record_number_3;
				SELF.watchlist_country_3 := RIGHT.watchlist_country_3;
				SELF.watchlist_fname_3 := RIGHT.watchlist_fname_3;
				SELF.watchlist_lname_3 := RIGHT.watchlist_lname_3;
				SELF.watchlist_address_3 := RIGHT.watchlist_address_3;
				SELF.watchlist_city_3 := RIGHT.watchlist_city_3;
				SELF.watchlist_state_3 := RIGHT.watchlist_state_3;
				SELF.watchlist_zip_3 := RIGHT.watchlist_zip_3;
				SELF.watchlist_cmpy_3 := RIGHT.watchlist_cmpy_3;

				SELF.watchlist_table_4 := RIGHT.watchlist_table_4;
				SELF.watchlist_program_4 := RIGHT.watchlist_program_4;
				SELF.watchlist_record_number_4 := RIGHT.watchlist_record_number_4;
				SELF.watchlist_country_4 := RIGHT.watchlist_country_4;
				SELF.watchlist_fname_4 := RIGHT.watchlist_fname_4;
				SELF.watchlist_lname_4 := RIGHT.watchlist_lname_4;
				SELF.watchlist_address_4 := RIGHT.watchlist_address_4;
				SELF.watchlist_city_4 := RIGHT.watchlist_city_4;
				SELF.watchlist_state_4 := RIGHT.watchlist_state_4;
				SELF.watchlist_zip_4 := RIGHT.watchlist_zip_4;
				SELF.watchlist_cmpy_4 := RIGHT.watchlist_cmpy_4;

				SELF.watchlist_table_5 := RIGHT.watchlist_table_5;
				SELF.watchlist_program_5 := RIGHT.watchlist_program_5;
				SELF.watchlist_record_number_5 := RIGHT.watchlist_record_number_5;
				SELF.watchlist_country_5 := RIGHT.watchlist_country_5;
				SELF.watchlist_fname_5 := RIGHT.watchlist_fname_5;
				SELF.watchlist_lname_5 := RIGHT.watchlist_lname_5;
				SELF.watchlist_address_5 := RIGHT.watchlist_address_5;
				SELF.watchlist_city_5 := RIGHT.watchlist_city_5;
				SELF.watchlist_state_5 := RIGHT.watchlist_state_5;
				SELF.watchlist_zip_5 := RIGHT.watchlist_zip_5;
				SELF.watchlist_cmpy_5 := RIGHT.watchlist_cmpy_5;

				SELF.watchlist_table_6 := RIGHT.watchlist_table_6;
				SELF.watchlist_program_6 := RIGHT.watchlist_program_6;
				SELF.watchlist_record_number_6 := RIGHT.watchlist_record_number_6;
				SELF.watchlist_country_6 := RIGHT.watchlist_country_6;
				SELF.watchlist_fname_6 := RIGHT.watchlist_fname_6;
				SELF.watchlist_lname_6 := RIGHT.watchlist_lname_6;
				SELF.watchlist_address_6 := RIGHT.watchlist_address_6;
				SELF.watchlist_city_6 := RIGHT.watchlist_city_6;
				SELF.watchlist_state_6 := RIGHT.watchlist_state_6;
				SELF.watchlist_zip_6 := RIGHT.watchlist_zip_6;
				SELF.watchlist_cmpy_6 := RIGHT.watchlist_cmpy_6;

				SELF.watchlist_table_7 := RIGHT.watchlist_table_7;
				SELF.watchlist_program_7 := RIGHT.watchlist_program_7;
				SELF.watchlist_record_number_7 := RIGHT.watchlist_record_number_7;
				SELF.watchlist_country_7 := RIGHT.watchlist_country_7;
				SELF.watchlist_fname_7 := RIGHT.watchlist_fname_7;
				SELF.watchlist_lname_7 := RIGHT.watchlist_lname_7;
				SELF.watchlist_address_7 := RIGHT.watchlist_address_7;
				SELF.watchlist_city_7 := RIGHT.watchlist_city_7;
				SELF.watchlist_state_7 := RIGHT.watchlist_state_7;
				SELF.watchlist_zip_7 := RIGHT.watchlist_zip_7;
				SELF.watchlist_cmpy_7 := RIGHT.watchlist_cmpy_7;			
				self := LEFT , 
				self := RIGHT ;//do we need this still????? 
				), left outer);

 // *****************XG5 END
 
 WLResults := if(ofac_version = 4, group(XG5AddInData,seq), pj3);

// output(inForm, named('informBIID'),overwrite);
// output(inl, named('inlBIID'), overwrite);
// output(XG5AddInData, named('XG5AddInData'), overwrite);
// output(XG5Parsed, named('XG5Parsed'), overwrite);
// output(WLResults);
// output(inl);
// output(patOut, named('patOut'), overwrite);
// output(gateways, named('gatewaysBRWatch'), overwrite);
// output(ofac_only, named('ofac_only'));
// output(Global_WatchList_Threshold, named('globabl_watchList_threshold'));
// output(ofac_version, named('ofac_version'));
// output(include_ofac,named('include_OFAC'));
// OUTPUT(include_additional_watchlists, named('include_additional_watchlists'));
// output(patout, named('patout'));
// output(patrolled, named('patrolled'));

RETURN WLResults;



END;