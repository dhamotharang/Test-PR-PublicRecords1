IMPORT ADDRESS, doxie, Inquiry_AccLogs, std, Inquiry_Services, Business_Risk_BIP, ut, RiskWise;
/*
  This service was designed to combine the results from 4 existing services and return the combined output.
  NO SOAPCALL()s are made.
		Address.AddressCleaningService
		Inquiry_AccLogs.CompanyID_IndustryLookup_Service
		Inquiry_AccLogs.Function_Description_Lookup_Service
		DidVille.Did_Service
*/

EXPORT Log_Records(Inquiry_Services.Log_IParam.params in_params, doxie.IDataAccess mod_access) := FUNCTION

//get the industry details, Inquiry_AccLogs.CompanyID_IndustryLookup_Service
//this has to be done prior to function description lookup because productID is needed.

industry_out := if (in_params.company_ID <> '', 
														project(choosen(Inquiry_AccLogs.Key_Inquiry_industry_use_vertical(FALSE)(keyed(s_company_id=in_params.company_id)), 1), 
														Inquiry_Services.Log_Layouts.temp_layout), dataset([], Inquiry_Services.Log_Layouts.temp_layout));

keyval_product_ID := if (trim(industry_out[1].Product_ID) <> '', std.Str.ToUpperCase(trim(industry_out[1].Product_ID)),'');
keyval_transaction_type := std.Str.ToUpperCase(trim(in_params.transaction_type));
keyval_function_name := std.Str.ToUpperCase(trim(in_params.Function_Name));
allkeyvals := (keyval_product_ID <> '') and (keyval_function_name <> '');
//get the function description Inquiry_AccLogs.Function_Description_Lookup_Service
function_out := if (allkeyvals, project(choosen(Inquiry_AccLogs.key_lookup_function_desc(
																											 keyed(s_product_id=keyval_product_ID and 
																											 s_transaction_type IN [keyval_transaction_type, ''] and 
																											 s_function_name=keyval_function_name)), 1),
																								Inquiry_Services.Log_Layouts.temp_layout), 
																				dataset([],Inquiry_Services.Log_Layouts.temp_layout));

// clean the addresses (auth rep 1/2/3, and company)
addr_in_batch := dataset([{1, in_params.address, '', in_params.city, in_params.state, in_params.zip},
                          {2, in_params.address_2, '', in_params.city_2, in_params.state_2, in_params.zip_2},
										      {3, in_params.address_3, '', in_params.city_3, in_params.state_3, in_params.zip_3},
										      {4, in_params.address_4, '', in_params.city_4, in_params.state_4, in_params.zip_4},
										      {5, in_params.address_5, '', in_params.city_5, in_params.state_5, in_params.zip_5},
										      {6, in_params.address_6, '', in_params.city_6, in_params.state_6, in_params.zip_6},
										      {7, in_params.address_7, '', in_params.city_7, in_params.state_7, in_params.zip_7},
										      {8, in_params.address_8, '', in_params.city_8, in_params.state_8, in_params.zip_8},
												  {9, in_params.company_address, '', in_params.company_city, in_params.company_state, in_params.company_zip}], 
												 Address.Layout_Batch_In);
cleaned := sort(Address.fn_AddressCleanBatch(addr_in_batch), uid);

// add on clean address to input request row
Inquiry_Services.Log_Layouts.in_layout_w_cleanAddr loadCleanAddr(address.Layout_Batch_Out le) := transform
	self.seq := le.uid;
	self.cleanAddr := row(le, address.Layout_AddressCleaning_Out);
	self.input.company_ID        := in_params.company_id;
	self.input.Transaction_Type  := in_params.transaction_type; 
	self.input.Function_Name     := in_params.function_name; 
	self.input.FirstName         := choose(le.uid, in_params.firstname, in_params.firstname_2, in_params.firstname_3, in_params.firstname_4, 
																								 in_params.firstname_5, in_params.firstname_6, in_params.firstname_7, in_params.firstname_8); 
	self.input.LastName          := choose(le.uid, in_params.lastname, in_params.lastname_2, in_params.lastname_3, in_params.lastname_4, 
																								 in_params.lastname_5, in_params.lastname_6, in_params.lastname_7, in_params.lastname_8); 
	self.input.SSN               := choose(le.uid, in_params.ssn, in_params.ssn_2, in_params.ssn_3, in_params.ssn_4, 
																								 in_params.ssn_5, in_params.ssn_6, in_params.ssn_7, in_params.ssn_8); 
	self.input.Phone             := choose(le.uid, in_params.phone, in_params.phone_2, in_params.phone_3, in_params.phone_4, 
																								 in_params.phone_5, in_params.phone_6, in_params.phone_7, in_params.phone_8); 
	self.input.Email             := choose(le.uid, in_params.email, in_params.email_2, in_params.email_3, in_params.email_4,
																								 in_params.email_5, in_params.email_6, in_params.email_7, in_params.email_8);
	self.input.DOB               := choose(le.uid, in_params.dob, in_params.dob_2, in_params.dob_3, in_params.dob_4, 
																								 in_params.dob_5, in_params.dob_6, in_params.dob_7, in_params.dob_8);
	self.input.address           := choose(le.uid, in_params.address, in_params.address_2, in_params.address_3, in_params.address_4,
																								 in_params.address_5, in_params.address_6, in_params.address_7, in_params.address_8);
	self.input.city              := choose(le.uid, in_params.city, in_params.city_2, in_params.city_3, in_params.city_4, 
																								 in_params.city_5, in_params.city_6, in_params.city_7, in_params.city_8);  
	self.input.state             := choose(le.uid, in_params.state, in_params.state_2, in_params.state_3, in_params.state_4, 
																								 in_params.state_5, in_params.state_6, in_params.state_7, in_params.state_8); 
	self.input.zip               := choose(le.uid, in_params.zip, in_params.zip_2, in_params.zip_3, in_params.zip_4, 
																								 in_params.zip_5, in_params.zip_6, in_params.zip_7, in_params.zip_8);
end;
ds_in_cleanAddrs := project(cleaned(uid < 9), loadCleanAddr(left));

// get the did, DidVille.Did_Service
did_out := Inquiry_Services.Log_Functions.fn_getDidVille(ds_in_cleanAddrs, mod_access,
																												 ''/*append_l*/, 
																												 ''/*verify_l*/);
did_out_sort := sort(did_out, seq);

Business_Risk_BIP.Layouts.Input prepForBIPAppend(address.Layout_Batch_Out le) := transform
	self.CompanyName := ut.CleanCompany(in_params.company_name);
	self.Prim_Range := le.prim_range;
	self.Prim_Name := le.prim_name;
	self.Zip5 := le.zip;
	self.Sec_Range := le.sec_range;
	self.City := le.v_city_name;
	self.State := le.st;
	self.Phone10 := RiskWise.CleanPhone(in_params.company_phone);
	filteredFEIN := std.Str.filter(in_params.company_fein, '0123456789');
	self.FEIN := if(length(filteredFEIN) != 9 or (integer)filteredFEIN <= 0, '', filteredFEIN);
	self.Rep_Email := std.Str.ToUpperCase(TRIM(in_params.email, LEFT, RIGHT));
	self.Rep_FirstName := TRIM(std.Str.ToUpperCase(in_params.firstname), LEFT, RIGHT);
	self.Rep_LastName := TRIM(std.Str.ToUpperCase(in_params.lastname), LEFT, RIGHT);
	filteredSSN := StringLib.StringFilter(in_params.ssn, '0123456789');
	self.Rep_SSN := IF(LENGTH(filteredSSN) != 9 OR (INTEGER)filteredSSN <= 0, '', filteredSSN);
	self.Rep_LexID := did_out_sort[1].did;
  
  // require that something in one of these company fields needs to be populated before trying to append BIP ids
  self.seq := if( (trim(self.companyname)='' and
  trim(self.Prim_Name)='' and
  trim(self.Zip5)='' and
  trim(self.City)='' and
  trim(self.State)='' and
  trim(self.Phone10)='' and
  trim(self.FEIN)=''), skip, 1);

	self := [];
end;
prepBIPAppend := project(cleaned(uid = 9), prepForBIPAppend(left));
BIPAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend);
	
// fill the output response
inquiry_services.Log_Layouts.response fillFinalOut(address.Layout_Batch_Out le) := transform
	// function description output
	self.description := function_out[1].description;
  //company 
	self.Industry :=  industry_out[1].industry ;
	self.sub_Market := industry_out[1].sub_market;
	self.Use :=  industry_out[1].use ;
	self.Vertical :=  industry_out[1].vertical ;
	self.gc_id :=  industry_out[1].gc_id ;
	self.Product_Id :=  industry_out[1].product_id ;
	self.powid := if(BIPAppend[1].PowID.LinkID <> 0, (string)BIPAppend[1].PowID.LinkID, '');
	self.proxid := if(BIPAppend[1].ProxID.LinkID <> 0, (string)BIPAppend[1].ProxID.LinkID, '');
	self.seleid := if(BIPAppend[1].SeleID.LinkID <> 0, (string)BIPAppend[1].SeleID.LinkID, '');
	self.orgid := if(BIPAppend[1].OrgID.LinkID <> 0, (string)BIPAppend[1].OrgID.LinkID, '');
	self.ultid := if(BIPAppend[1].UltID.LinkID <> 0, (string)BIPAppend[1].UltID.LinkID, '');
  self.bus_prim_range := le.prim_range;
	self.bus_predir := le.predir;
	self.bus_prim_name := le.prim_name;
	self.bus_addr_suffix := le.addr_suffix;
	self.bus_postdir := le.postdir;
	self.bus_unit_desig := le.unit_desig;
	self.bus_sec_range := le.sec_range;
	self.bus_v_city_name := le.v_city_name;
	self.bus_st := le.st;
	self.bus_zip := le.zip;
	self.bus_zip4 := le.zip4;
	self.bus_rec_type := le.rec_type;
	self.bus_fips_state := le.county[1..2];
	self.bus_fips_county := le.county[3..5];
	self.bus_geo_lat := le.geo_lat;
	self.bus_geo_long := le.geo_long;
	self.bus_msa := le.msa;
	self.bus_geo_blk := le.geo_blk;
	self.bus_geo_match := le.geo_match;
	self.bus_err_stat := le.err_stat ;
	//auth rep 1
  self.did := INTFORMAT(did_out_sort[1].did,12,1);
  self.prim_range := cleaned[1].prim_range;
	self.predir := cleaned[1].predir;
	self.prim_name := cleaned[1].prim_name;
	self.addr_suffix := cleaned[1].addr_suffix;
	self.postdir := cleaned[1].postdir;
	self.unit_desig := cleaned[1].unit_desig;
	self.sec_range := cleaned[1].sec_range;
	self.v_city_name := cleaned[1].v_city_name;
	self.st := cleaned[1].st;
	self.zip := cleaned[1].zip;
	self.zip4 := cleaned[1].zip4;
	self.rec_type := cleaned[1].rec_type;
	self.fips_state := cleaned[1].county[1..2];
	self.fips_county := cleaned[1].county[3..5];
	self.geo_lat := cleaned[1].geo_lat;
	self.geo_long := cleaned[1].geo_long;
	self.msa := cleaned[1].msa;
	self.geo_blk := cleaned[1].geo_blk;
	self.geo_match := cleaned[1].geo_match;
	self.err_stat := cleaned[1].err_stat ;
	//auth rep 2
  self.did_2 := INTFORMAT(did_out_sort[2].did,12,1);
  self.prim_range_2 := cleaned[2].prim_range;
	self.predir_2 := cleaned[2].predir;
	self.prim_name_2 := cleaned[2].prim_name;
	self.addr_suffix_2 := cleaned[2].addr_suffix;
	self.postdir_2 := cleaned[2].postdir;
	self.unit_desig_2 := cleaned[2].unit_desig;
	self.sec_range_2 := cleaned[2].sec_range;
	self.v_city_name_2 := cleaned[2].v_city_name;
	self.st_2 := cleaned[2].st;
	self.zip_2 := cleaned[2].zip;
	self.zip4_2 := cleaned[2].zip4;
	self.rec_type_2 := cleaned[2].rec_type;
	self.fips_state_2 := cleaned[2].county[1..2];
	self.fips_county_2 := cleaned[2].county[3..5];
	self.geo_lat_2 := cleaned[2].geo_lat;
	self.geo_long_2 := cleaned[2].geo_long;
	self.msa_2 := cleaned[2].msa;
	self.geo_blk_2 := cleaned[2].geo_blk;
	self.geo_match_2 := cleaned[2].geo_match;
	self.err_stat_2 := cleaned[2].err_stat ;
	//auth rep 3
  self.did_3 := INTFORMAT(did_out_sort[3].did,12,1);
  self.prim_range_3 := cleaned[3].prim_range;
	self.predir_3 := cleaned[3].predir;
	self.prim_name_3 := cleaned[3].prim_name;
	self.addr_suffix_3 := cleaned[3].addr_suffix;
	self.postdir_3 := cleaned[3].postdir;
	self.unit_desig_3 := cleaned[3].unit_desig;
	self.sec_range_3 := cleaned[3].sec_range;
	self.v_city_name_3 := cleaned[3].v_city_name;
	self.st_3 := cleaned[3].st;
	self.zip_3 := cleaned[3].zip;
	self.zip4_3 := cleaned[3].zip4;
	self.rec_type_3 := cleaned[3].rec_type;
	self.fips_state_3 := cleaned[3].county[1..2];
	self.fips_county_3 := cleaned[3].county[3..5];
	self.geo_lat_3 := cleaned[3].geo_lat;
	self.geo_long_3 := cleaned[3].geo_long;
	self.msa_3 := cleaned[3].msa;
	self.geo_blk_3 := cleaned[3].geo_blk;
	self.geo_match_3 := cleaned[3].geo_match;
	self.err_stat_3 := cleaned[3].err_stat ;
	//auth rep 4
  self.did_4 := INTFORMAT(did_out_sort[4].did,12,1);
  self.prim_range_4 := cleaned[4].prim_range;
	self.predir_4 := cleaned[4].predir;
	self.prim_name_4 := cleaned[4].prim_name;
	self.addr_suffix_4 := cleaned[4].addr_suffix;
	self.postdir_4 := cleaned[4].postdir;
	self.unit_desig_4 := cleaned[4].unit_desig;
	self.sec_range_4 := cleaned[4].sec_range;
	self.v_city_name_4 := cleaned[4].v_city_name;
	self.st_4 := cleaned[4].st;
	self.zip_4 := cleaned[4].zip;
	self.zip4_4 := cleaned[4].zip4;
	self.rec_type_4 := cleaned[4].rec_type;
	self.fips_state_4 := cleaned[4].county[1..2];
	self.fips_county_4 := cleaned[4].county[3..5];
	self.geo_lat_4 := cleaned[4].geo_lat;
	self.geo_long_4 := cleaned[4].geo_long;
	self.msa_4 := cleaned[4].msa;
	self.geo_blk_4 := cleaned[4].geo_blk;
	self.geo_match_4 := cleaned[4].geo_match;
	self.err_stat_4 := cleaned[4].err_stat ;	
	//auth rep 5
  self.did_5 := INTFORMAT(did_out_sort[5].did,12,1);
  self.prim_range_5 := cleaned[5].prim_range;
	self.predir_5 := cleaned[5].predir;
	self.prim_name_5 := cleaned[5].prim_name;
	self.addr_suffix_5 := cleaned[5].addr_suffix;
	self.postdir_5 := cleaned[5].postdir;
	self.unit_desig_5 := cleaned[5].unit_desig;
	self.sec_range_5 := cleaned[5].sec_range;
	self.v_city_name_5 := cleaned[5].v_city_name;
	self.st_5 := cleaned[5].st;
	self.zip_5 := cleaned[5].zip;
	self.zip4_5 := cleaned[5].zip4;
	self.rec_type_5 := cleaned[5].rec_type;
	self.fips_state_5 := cleaned[5].county[1..2];
	self.fips_county_5 := cleaned[5].county[3..5];
	self.geo_lat_5 := cleaned[5].geo_lat;
	self.geo_long_5 := cleaned[5].geo_long;
	self.msa_5 := cleaned[5].msa;
	self.geo_blk_5 := cleaned[5].geo_blk;
	self.geo_match_5 := cleaned[5].geo_match;
	self.err_stat_5 := cleaned[5].err_stat ;	
	//auth rep 6
  self.did_6 := INTFORMAT(did_out_sort[6].did,12,1);
  self.prim_range_6 := cleaned[6].prim_range;
	self.predir_6 := cleaned[6].predir;
	self.prim_name_6 := cleaned[6].prim_name;
	self.addr_suffix_6 := cleaned[6].addr_suffix;
	self.postdir_6 := cleaned[6].postdir;
	self.unit_desig_6 := cleaned[6].unit_desig;
	self.sec_range_6 := cleaned[6].sec_range;
	self.v_city_name_6 := cleaned[6].v_city_name;
	self.st_6 := cleaned[6].st;
	self.zip_6 := cleaned[6].zip;
	self.zip4_6 := cleaned[6].zip4;
	self.rec_type_6 := cleaned[6].rec_type;
	self.fips_state_6 := cleaned[6].county[1..2];
	self.fips_county_6 := cleaned[6].county[3..5];
	self.geo_lat_6 := cleaned[6].geo_lat;
	self.geo_long_6 := cleaned[6].geo_long;
	self.msa_6 := cleaned[6].msa;
	self.geo_blk_6 := cleaned[6].geo_blk;
	self.geo_match_6 := cleaned[6].geo_match;
	self.err_stat_6 := cleaned[6].err_stat ;	
	//auth rep 7
  self.did_7 := INTFORMAT(did_out_sort[7].did,12,1);
  self.prim_range_7 := cleaned[7].prim_range;
	self.predir_7 := cleaned[7].predir;
	self.prim_name_7 := cleaned[7].prim_name;
	self.addr_suffix_7 := cleaned[7].addr_suffix;
	self.postdir_7 := cleaned[7].postdir;
	self.unit_desig_7 := cleaned[7].unit_desig;
	self.sec_range_7 := cleaned[7].sec_range;
	self.v_city_name_7 := cleaned[7].v_city_name;
	self.st_7 := cleaned[7].st;
	self.zip_7 := cleaned[7].zip;
	self.zip4_7 := cleaned[7].zip4;
	self.rec_type_7 := cleaned[7].rec_type;
	self.fips_state_7 := cleaned[7].county[1..2];
	self.fips_county_7 := cleaned[7].county[3..5];
	self.geo_lat_7 := cleaned[7].geo_lat;
	self.geo_long_7 := cleaned[7].geo_long;
	self.msa_7 := cleaned[7].msa;
	self.geo_blk_7 := cleaned[7].geo_blk;
	self.geo_match_7 := cleaned[7].geo_match;
	self.err_stat_7 := cleaned[7].err_stat ;	
	//auth rep 8
  self.did_8 := INTFORMAT(did_out_sort[8].did,12,1);
  self.prim_range_8 := cleaned[8].prim_range;
	self.predir_8 := cleaned[8].predir;
	self.prim_name_8 := cleaned[8].prim_name;
	self.addr_suffix_8 := cleaned[8].addr_suffix;
	self.postdir_8 := cleaned[8].postdir;
	self.unit_desig_8 := cleaned[8].unit_desig;
	self.sec_range_8 := cleaned[8].sec_range;
	self.v_city_name_8 := cleaned[8].v_city_name;
	self.st_8 := cleaned[8].st;
	self.zip_8 := cleaned[8].zip;
	self.zip4_8 := cleaned[8].zip4;
	self.rec_type_8 := cleaned[8].rec_type;
	self.fips_state_8 := cleaned[8].county[1..2];
	self.fips_county_8 := cleaned[8].county[3..5];
	self.geo_lat_8 := cleaned[8].geo_lat;
	self.geo_long_8 := cleaned[8].geo_long;
	self.msa_8 := cleaned[8].msa;
	self.geo_blk_8 := cleaned[8].geo_blk;
	self.geo_match_8 := cleaned[8].geo_match;
	self.err_stat_8 := cleaned[8].err_stat ;	
	self := [];
end;

final_out := project(cleaned(uid = 9), fillFinalOut(left));
// output(in_params);
// output(ds_in_cleanAddrs,named('ds_in_cleanAddrs'));
// output(did_out,named('did_out'));
RETURN final_out;		
END;
