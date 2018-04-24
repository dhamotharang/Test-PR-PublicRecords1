import doxie, GlobalWatchLists, ut, iesp;

export Search_Base_Function(GROUPED DATASET(patriot.Layout_batch_in) in_data, 
														boolean ofaconly_value,
														real threshold_value = Constants.DEF_THRESHOLD,
														boolean noFail=false,
														unsigned1 ofac_version=1,
														boolean include_ofac=FALSE,
														boolean include_Additional_watchlists=FALSE,
														dataset(iesp.share.t_StringArrayItem) watchlists_original=dataset([], iesp.share.t_StringArrayItem)) :=
FUNCTION

watchlists_requested := project (watchlists_original, transform (iesp.share.t_StringArrayItem,
                                                                 Self.value := StringLib.StringToUpperCase (Left.value))); 

// Index Definition
ind := GlobalWatchLists.Key_GlobalWatchLists_Seq;
// key 2
key_country := GlobalWatchLists.Key_GlobalWatchLists_Country;

// true search
bit_map := IF(ofaconly_value and ofac_version=1,1,3);


Layout_Base_Results.Layout_keys country2keys(key_country le) :=
TRANSFORM
	SELF := le;
	SELF.score := 1;
	SELF := [];
END;


// ******************************************************* OFAC Lib ********************************************
Layout_Base_Results.parent search(in_data le) := TRANSFORM
	// Person or "non-individual"
	search_string := 
									Stringlib.StringFilterOut(
										IF(le.name_unparsed<>'',
												le.name_unparsed,
												TRIM(le.name_first)+' '+TRIM(le.name_middle)+' '+TRIM(le.name_last)),'-');

	k := OfacLib.Search(search_string, threshold_value, translate_searchtype(le.search_type), bit_map);
	sd_fail := LIMIT(k,500,FAIL(203,doxie.ErrorCodes(203)));
	sd_nofail := CHOOSEN(k,500); 
	
	// Country	
	cl := LENGTH(TRIM(le.country));
	country_decoded := IF(cl=2 AND ut.Country_ISO2_To_Name(le.country)<>'',ut.Country_ISO2_To_Name(le.country),
												IF(cl=3 AND ut.Country_ISO3_To_Name(le.country)<>'',ut.Country_ISO3_To_Name(le.country),le.country));
		
	country_matches := IF(le.country<>'',DEDUP(LIMIT(key_country(country_decoded=country[1..20]),100,SKIP),all));
	SELF.pty_keys := PROJECT(country_matches,country2keys(LEFT));
		
	sd := sd_nofail; 
	SELF.keys := sd;
	SELF := le;
	SELF.pty_key := '';
END;

searched := PROJECT(in_data, search(LEFT));
res := IF(plugin_load,searched);

Layout_Base_Results.Layout_keys real_key(OfacSearchResultRecord le, ind ri) :=
TRANSFORM
	SELF :=le;
	SELF := ri;
	SELF.country := '';
	SELF.Search_type := '';
END;

// get back to pty keys
Layout_Base_Results.parent add_ptys(Layout_Base_Results.parent le) :=
TRANSFORM
	ptys := le.pty_keys+JOIN(le.keys,ind,keyed(LEFT.key=RIGHT.seq), real_key(LEFT,RIGHT), KEEP(1));	
	ptys_w_searchtype := Project(ptys,transform(recordof(ptys),self.search_type :=le.search_type,self:=left));
	SELF.pty_keys :=  ptys_w_searchtype;
	SELF := le;
END;

with_ptys_orig := PROJECT(res, add_ptys(LEFT));
// ************************************************ END OF CALL TO OFACLIB ****************************************




// ******************************************************* BRIDGER Lib ********************************************
Layout_Base_Results.parent search_bridger(in_data le) := TRANSFORM
	// Person or "non-individual"
	search_string := 
									Stringlib.StringFilterOut(
										IF(le.name_unparsed<>'',
												le.name_unparsed,
												TRIM(le.name_first)+' '+TRIM(le.name_middle)+' '+TRIM(le.name_last)),'-');


	k := bridgerscorelib.Search(search_string, threshold_value, translate_searchtype(le.search_type), bit_map);

	sd_fail := LIMIT(k,500,FAIL(203,doxie.ErrorCodes(203)));
	sd_nofail := CHOOSEN(k,500); 
		
	// Country	
	cl := LENGTH(TRIM(le.country));
	country_decoded := IF(cl=2 AND ut.Country_ISO2_To_Name(le.country)<>'',ut.Country_ISO2_To_Name(le.country),
												IF(cl=3 AND ut.Country_ISO3_To_Name(le.country)<>'',ut.Country_ISO3_To_Name(le.country),le.country));
		
	country_matches := IF(le.country<>'',DEDUP(LIMIT(key_country(country_decoded[1]=country[1]),100,SKIP),all));
	
	SELF.pty_keys := PROJECT(country_matches,TRANSFORM(Patriot.Layout_Base_Results.Layout_keys,
					countryscore := bridgerscorelib.countryScore(le.country,LEFT.COUNTRY);
					self.score := if(countryscore >= threshold_value, countryscore, skip);
					SELF := LEFT,
					SELF := []));
					
		
	sd := sd_nofail; 
	SELF.keys := sd;
	SELF := le;
	SELF.pty_key := '';
END;

searched_bridger := PROJECT(in_data, search_bridger(LEFT));
res_bridger := IF(plugin_load_bridger,searched_bridger);

Layout_Base_Results.Layout_keys real_key_bridger(WLSearchResultRecord le, ind ri) :=
TRANSFORM
	SELF :=le;
	SELF := ri;
	SELF.country := '';
	SELF.Search_type := '';
END;

// get back to pty keys
Layout_Base_Results.parent add_ptys_bridger(Layout_Base_Results.parent le) :=
TRANSFORM
	ptys := le.pty_keys+JOIN(le.keys,ind,keyed(LEFT.key=RIGHT.seq), real_key_bridger(LEFT,RIGHT), KEEP(1));	
	ptys_w_searchtype := Project(ptys,transform(recordof(ptys),self.search_type :=le.search_type,self:=left));
	SELF.pty_keys :=  ptys_w_searchtype;
	SELF := le;
END;

with_ptys_bridger := PROJECT(res_bridger, add_ptys_bridger(LEFT));
// ************************************************ END OF CALL TO BRIDGERLIB ****************************************


// if the ofac_version is 2 or less, use the original plugin (with_ptys_orig) otherwise use bridger plugin
with_ptys := if(ofac_version > 2, with_ptys_bridger, with_ptys_orig);
												
custom_set := Patriot.WL_Include_Keys().getIncludeKeys(SET(watchlists_requested,value)); 										
include_keys := map(include_ofac=false and include_additional_watchlists=false and ofaconly_value=false => custom_set,
										include_ofac and include_additional_watchlists => custom_set + Patriot.WL_Include_Keys().OFAC_SET + Patriot.WL_Include_Keys().ADDITIONAL_WATCHLISTS_SET,
										include_ofac and include_additional_watchlists=false => custom_set + Patriot.WL_Include_Keys().OFAC_SET,
										include_ofac=false and include_additional_watchlists => custom_set + Patriot.WL_Include_Keys().ADDITIONAL_WATCHLISTS_SET,
										ofaconly_value=true => Patriot.WL_Include_Keys().OFAC_SET + custom_set,
										['']);										

Layout_Base_Results.parent filter_keys(Layout_Base_Results.parent le):= TRANSFORM
	self.pty_keys := le.pty_keys(trim(pty_key[1..3]) IN include_keys);
	self :=le;
end;

with_ptys_filtered := 	PROJECT(with_ptys, filter_keys(LEFT));

// output(in_data, named('in_data'));
// output(threshold_value, named('threshold_value'));
// output(ofac_version, named('ofac_version'));
// output(ofaconly_value, named('ofaconly_value'));
// output(include_ofac, named('include_ofac'));
// output(include_additional_watchlists, named('include_addl_watchlists'));
// output(with_ptys, named('with_ptys'));
// output(custom_set, named('custom_set'));
// output(watchlists_requested, named('watchlists_requested'));
// output(include_keys, named('include_keys'));
// output(with_ptys_filtered, named('with_ptys_filtered'));

RETURN if(ofac_version=1,with_ptys,with_ptys_filtered);
END;