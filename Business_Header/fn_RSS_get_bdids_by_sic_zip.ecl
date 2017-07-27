import business_header, doxie, ut;

export fn_RSS_get_bdids_by_sic_zip := FUNCTION

	doxie.MAC_Header_Field_Declare();

  // Trim the input SIC and calculate the length
  SIC_trimmed := trim(SIC_value,left,right);
  SIC_length  :=length(SIC_trimmed);

  // Turn the input zip or city/state (and optional MileRadius) into a set of zips.
	// For a Zip only search or a city/state search with a radius, use the same 
	// function as used in AutoStandardI.InterfaceTranslator to create a set of zips.
	// For a City&State only search with no radius, use a different function to get 
	// the zips.
	// Note: zip_val0 is the raw input zip value.
	set of integer4 set_of_zips := if(zip_val0<>'' OR zipradius_value<>0,
	                                  ut.fn_GetZipSet(city_value,state_value,
																										zip_val,
																										county_value,
																								    city_zip_value,
																										zipradius_value,
																								    zip_value_cleaned,
																								    any_addr_error_value),
																		ut.ZipsWithinCity(state_value,city_value));
  
	// Get bdids from Business_Header.key_commercial_SIC_Zip matching on input SIC 
	// and a set of zips either from input zip or generated from input city & state.
  bdids_from_key := Business_Header.key_commercial_SIC_Zip(
                            sic_code[1.. SIC_length] = SIC_trimmed[1..SIC_length] AND
                            zip in set_of_zips);

  // Sort/dedup the resulting bdids
  bdids_deduped := dedup(sort(bdids_from_key,bdid),bdid);

	// Project into same layout as comes out of Business_Header.doxie_get_bdids_plus
	// which actually is the layout that comes out of AutoHeaderI.LIB_FetchI_Hdr_Biz.do_plus
	bdids_projected := project(bdids_deduped,transform(
	                           {unsigned6 BDID,
														  unsigned4 seq,
															unsigned1 score},
															  self.BDID  := left.BDID,
															  self.seq   := 0,
																self.score := 100)); //For checking fn_RSS_getBestRecords

  // Uncomment lines below as needed for debugging
  //output(SIC_value,            named('SIC_value'));
  //output(SIC_trimmed,          named('SIC_trimmed'));
  //output(SIC_length,           named('SIC_length'));
	//output(city_value,           named('city_value'));
	//output(state_value,          named('state_value'));
	//output(zip_val0,             named('zip_val0'));
	//output(zip_val,              named('zip_val'));
	//output(city_zip_value,       named('city_zip_val'));
	//output(zipradius_value,      named('zipradius_value'));	
	//output(zip_value_cleaned,    named('zip_value_cleaned'));
	//output(any_addr_error_value, named('any_addr_error_value'));
	//output(set_of_zips,          named('set_of_zips'));
  //output(bdids_from_key,       named('bdids_from_key'));
  //output(bdids_deduped,        named('bdids_deduped'));
  //output(bdids_projected,      named('bdids_by_sic_zip'));
	
  return bdids_projected;
	
END;
