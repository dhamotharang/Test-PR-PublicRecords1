import address, addrfraud, advo, BankruptcyV2, doxie, LiensV2, LN_PropertyV2, property, Risk_Indicators, ut, std, data_services;

//Constants
mygetdate := (STRING8)Std.Date.Today();
isFCRA := false;
historydate := 999999;

//Data Declarations
ADVO_BASE_GEOLINK := project(advo.Files('',false).Base.built(active_flag = 'Y'), transform(advo.Layouts.Layout_Common_Out_k, self := left));
Foreclosure_Address := property.file_Foreclosure;
Prop_Address_V4 := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);

//Intermediate lien layouts
Layout_Liens_Info := RECORD
	unsigned1 count;
	unsigned4 earliest_filing_date;
	unsigned4 most_recent_filing_date;
	unsigned total_amount;
END;

layout_liens_party := RECORD
address.Layout_Clean182;
string12 geo_link;
end;
liens_slimmerrec := RECORD
	layout_liens_party;
	unsigned6	did;
	
	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_unreleased_count30 := 0;
	UNSIGNED1 liens_unreleased_count90 := 0;
	UNSIGNED1 liens_unreleased_count180 := 0;
	UNSIGNED1 liens_unreleased_count12 := 0;
	UNSIGNED1 liens_unreleased_count24 := 0;
	UNSIGNED1 liens_unreleased_count36 := 0;
	UNSIGNED1 liens_unreleased_count60 := 0;
	string8 last_liens_unreleased_date := '';
	
	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 liens_released_count30 := 0;
	UNSIGNED1 liens_released_count90 := 0;
	UNSIGNED1 liens_released_count180 := 0;
	UNSIGNED1 liens_released_count12 := 0;
	UNSIGNED1 liens_released_count24 := 0;
	UNSIGNED1 liens_released_count36 := 0;
	UNSIGNED1 liens_released_count60 := 0;
	UNSIGNED4 last_liens_released_date := 0;
		
	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
	UNSIGNED1 eviction_count;
	UNSIGNED1 eviction_count30 := 0;
	UNSIGNED1 eviction_count90 := 0;
	UNSIGNED1 eviction_count180 := 0;
	UNSIGNED1 eviction_count12 := 0;
	UNSIGNED1 eviction_count24 := 0;
	UNSIGNED1 eviction_count36 := 0;
	UNSIGNED1 eviction_count60 := 0;
	UNSIGNED4 last_eviction_date := 0;

	Layout_Liens_Info liens_unreleased_civil_judgment;
	Layout_Liens_Info liens_released_civil_judgment;
	Layout_Liens_Info liens_unreleased_federal_tax;
	Layout_Liens_Info liens_released_federal_tax;
	Layout_Liens_Info liens_unreleased_foreclosure;
	Layout_Liens_Info liens_released_foreclosure;
	Layout_Liens_Info liens_unreleased_landlord_tenant;
	Layout_Liens_Info liens_released_landlord_tenant;
	Layout_Liens_Info liens_unreleased_lispendens;
	Layout_Liens_Info liens_released_lispendens;
	Layout_Liens_Info liens_unreleased_other_lj;
	Layout_Liens_Info liens_released_other_lj;
	Layout_Liens_Info liens_unreleased_other_tax;
	Layout_Liens_Info liens_released_other_tax;
	Layout_Liens_Info liens_unreleased_small_claims;
	Layout_Liens_Info liens_released_small_claims;	
END;
liens_slimrec := RECORD
	liens_slimmerrec;
	// liens extras
	string50 tmsid;
	STRING50 rmsid;
END;
bk_slimmerrec := RECORD
	address.Layout_Clean182;
	string12 	geolink;
	unsigned6 did;
	unsigned6 bdid;
	BOOLEAN 	bankrupt := false;
	UNSIGNED4	date_last_seen := 0;
	STRING1 	filing_type := '';
	STRING35 	disposition := '';	
	UNSIGNED1 filing_count := 0;
	UNSIGNED1 bk_recent_count := 0;
	UNSIGNED1 bk_disposed_recent_count := 0;
	UNSIGNED1 bk_disposed_historical_count := 0;
	UNSIGNED1 bk_count30 := 0;
	UNSIGNED1 bk_count90 := 0;
	UNSIGNED1 bk_count180 := 0;
	UNSIGNED1 bk_count12 := 0;
	UNSIGNED1 bk_count24 := 0;
	UNSIGNED1 bk_count36 := 0;
	UNSIGNED1 bk_count48 := 0;
	UNSIGNED1 bk_count60 := 0;	
	UNSIGNED1	bk_ch7_cnt := 0;
	UNSIGNED1	bk_ch11_cnt := 0;
	UNSIGNED1	bk_ch12_cnt := 0;
	UNSIGNED1	bk_ch13_cnt := 0;
	UNSIGNED1	bk_discharged_cnt := 0;
	UNSIGNED1 bk_dismissed_cnt := 0;
	UNSIGNED1	bk_pro_se_cnt := 0;
	UNSIGNED1	bk_business_flag_cnt := 0;
	UNSIGNED1	bk_corp_flag_cnt := 0;
END;
bk_slimrec := record
	bk_slimmerrec;
	string5    court_code;
	string7    case_num; 
END;
//
//Layouts
layout_geolink := record
	string12 geolink;
end;
layout_ADVO := record
	unsigned2 Neighborhood_Vacant_Properties;
	unsigned2	Neighborhood_Business_Count;
	unsigned2 Neighborhood_SFD_Count;
	unsigned2 Neighborhood_MFD_Count;
	unsigned2	Neighborhood_CollegeAddr_Count;
	unsigned2	Neighborhood_SeasonalAddr_Count;
	unsigned4	Neighborhood_POBox_Count;
End;
layout_ADVO_geolink := record
	layout_geolink;
	layout_ADVO;
End;
layout_Foreclosures := record
	unsigned2 NOD;
	unsigned2 NOD_1yr;
	unsigned2 NOD_2yr;
	unsigned2 NOD_3yr;
	unsigned2 NOD_4yr;
	unsigned2 NOD_5yr;
	unsigned2 foreclosures;
	unsigned2 foreclosures_1yr;
	unsigned2 foreclosures_2yr;
	unsigned2 foreclosures_3yr;
	unsigned2 foreclosures_4yr;
	unsigned2 foreclosures_5yr;
	unsigned2 Deed_transfers;
	unsigned2 Deed_transfers_1yr;
	unsigned2 Deed_transfers_2yr;
	unsigned2 Deed_transfers_3yr;
	unsigned2 Deed_transfers_4yr;
	unsigned2 Deed_transfers_5yr;
	unsigned2 Release_Lis_Pendens;
	unsigned2 Release_Lis_Pendens_1yr;
	unsigned2 Release_Lis_Pendens_2yr;
	unsigned2 Release_Lis_Pendens_3yr;
	unsigned2 Release_Lis_Pendens_4yr;
	unsigned2 Release_Lis_Pendens_5yr;
end;
layout_Foreclosures_Slim := record
	unsigned2 NOD;
	unsigned2 foreclosures;
	unsigned2 Deed_transfers;
	unsigned2 Release_Lis_Pendens;
end;
layout_Foreclosures_Geolink := record
	layout_geolink;
	layout_Foreclosures;
End;
layout_Liens := record
	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
End;
layout_Liens_geolink := record
	layout_geolink;
	layout_Liens;
end;
layout_Hedonics_cnt := record
	layout_geolink;
	unsigned4		occupant_owned_count;
	unsigned4		cnt_occupant_owned;
	unsigned4 	ave_building_age;
	unsigned4 	cnt_building_age;
	unsigned4 	ave_purchase_amount;
	unsigned4 	cnt_purchase_amount;
	unsigned4 	ave_mortgage_amount;
	unsigned4 	cnt_mortgage_amount;
	unsigned4 	ave_assessed_amount;
	unsigned4 	cnt_assessed_amount;
	unsigned8 	ave_building_area;
	unsigned8 	cnt_building_area;
	unsigned8		ave_price_per_sf;
	unsigned8		cnt_price_per_sf;
	unsigned8 	ave_no_of_buildings_count;
	unsigned8 	cnt_no_of_buildings_count;
	unsigned8 	ave_no_of_stories_count;
	unsigned8 	cnt_no_of_stories_count;
	unsigned8 	ave_no_of_rooms_count;
	unsigned8 	cnt_no_of_rooms_count;
	unsigned8 	ave_no_of_bedrooms_count;
	unsigned8 	cnt_no_of_bedrooms_count;
	unsigned8 	ave_no_of_baths_count;
	unsigned8 	cnt_no_of_baths_count;
	unsigned8 	ave_no_of_partial_baths_count;
	unsigned8 	cnt_no_of_partial_baths_count;
	unsigned4		total_property_count;
end;
layout_Hedonics := record
	unsigned4		occupant_owned_count;
	unsigned4 	cnt_building_age;
	unsigned4 	ave_building_age;
	unsigned4 	cnt_purchase_amount;	
	unsigned4 	ave_purchase_amount;
	unsigned4 	cnt_mortgage_amount;
	unsigned4 	ave_mortgage_amount;
	unsigned4 	cnt_assessed_amount;
	unsigned4 	ave_assessed_amount;
	unsigned8 	cnt_building_area;
	unsigned8 	ave_building_area;
	unsigned8		cnt_price_per_sf;
	unsigned8		ave_price_per_sf;
	unsigned8 	cnt_no_of_buildings_count;
	unsigned8 	ave_no_of_buildings_count;
	unsigned8 	cnt_no_of_stories_count;
	unsigned8 	ave_no_of_stories_count;
	unsigned8 	cnt_no_of_rooms_count;
	unsigned8 	ave_no_of_rooms_count;
	unsigned8 	cnt_no_of_bedrooms_count;
	unsigned8 	ave_no_of_bedrooms_count;
	unsigned8 	cnt_no_of_baths_count;
	unsigned8 	ave_no_of_baths_count;
	unsigned8 	cnt_no_of_partial_baths_count;
	unsigned8 	ave_no_of_partial_baths_count;
	unsigned4		total_property_count;
end;
layout_Hedonics_geolink := record
	layout_geolink;
	layout_Hedonics;
end;
layout_Bankruptcy := record
	UNSIGNED1 bk_cnt := 0;
	UNSIGNED1 bk_1yr := 0;
	UNSIGNED1 bk_2yr := 0;
	UNSIGNED1 bk_3yr := 0;
	UNSIGNED1 bk_4yr := 0;
	UNSIGNED1 bk_5yr := 0;	
	UNSIGNED1	bk_ch7_cnt := 0;
	UNSIGNED1	bk_ch11_cnt := 0;
	UNSIGNED1	bk_ch12_cnt := 0;
	UNSIGNED1	bk_ch13_cnt := 0;
	UNSIGNED1	bk_discharged_cnt := 0;
	UNSIGNED1 bk_dismissed_cnt := 0;
	UNSIGNED1	bk_pro_se_cnt := 0;
	UNSIGNED1	bk_business_flag_cnt := 0;
	UNSIGNED1	bk_corp_flag_cnt := 0;
end;

layout_Bankruptcy_geolink := record
	layout_geolink;	
	layout_bankruptcy;
end;
layout_Final := record
	layout_geolink;
	layout_ADVO;
	layout_Foreclosures;
	layout_Liens;
	layout_Hedonics;
	layout_Bankruptcy;
End;

//Data sources
layout_advo_in := record
  string5 zip;
  string10 prim_range;
  string28 prim_name;
  string4 addr_suffix;
  string2 predir;
  string2 postdir;
  string8 sec_range;
  string5 zip_5;
  string4 route_num;
  string4 zip_4;
  string9 walk_sequence;
  string10 street_num;
  string2 street_pre_directional;
  string28 street_name;
  string2 street_post_directional;
  string4 street_suffix;
  string4 secondary_unit_designator;
  string8 secondary_unit_number;
  string1 address_vacancy_indicator;
  string1 throw_back_indicator;
  string1 seasonal_delivery_indicator;
  string5 seasonal_start_suppression_date;
  string5 seasonal_end_suppression_date;
  string1 dnd_indicator;
  string1 college_indicator;
  string10 college_start_suppression_date;
  string10 college_end_suppression_date;
  string1 address_style_flag;
  string5 simplify_address_count;
  string1 drop_indicator;
  string1 residential_or_business_ind;
  string2 dpbc_digit;
  string1 dpbc_check_digit;
  string10 update_date;
  string10 file_release_date;
  string10 override_file_release_date;
  string3 county_num;
  string28 county_name;
  string28 city_name;
  string2 state_code;
  string2 state_num;
  string2 congressional_district_number;
  string1 owgm_indicator;
  string1 record_type_code;
  string10 advo_key;
  string1 address_type;
  string1 mixed_address_usage;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string8 vac_begdt;
  string8 vac_enddt;
  string8 months_vac_curr;
  string8 months_vac_max;
  string8 vac_count;
  string10 unit_desig;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_county;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
end;






// Start
// Append ADVO Neighborhood Data From RAW
layout_ADVO_Geolink addNeighborhoodAdvo(ADVO_BASE_GEOLINK l) := TRANSFORM
			street_add := l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.addr_suffix + ' ' +  l.postdir + ' ' + l.sec_range;
			clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(street_add, l.city_name, l.st, l.zip);
			self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			
			self.Neighborhood_Vacant_Properties 	:= if(l.address_vacancy_indicator ='Y', 1,0);
			self.Neighborhood_Business_Count 			:= if(l.Address_Type ='0', 1,0);
			self.Neighborhood_SFD_Count 					:= if(l.Address_Type ='1', 1,0);
			self.Neighborhood_MFD_Count						:= if(l.Address_Type ='2', 1,0);
			self.Neighborhood_CollegeAddr_Count		:= if(l.College_Indicator ='Y', 1,0);
			self.Neighborhood_SeasonalAddr_Count	:= if(l.Seasonal_Delivery_Indicator ='Y', 1,0);
			self.Neighborhood_POBox_Count 				:= if(l.Address_Type ='9', 0,1);
end;

Neighborhood_ADVO_init := project(ADVO_BASE_GEOLINK, addNeighborhoodAdvo(left));
Neighborhood_ADVO_dist := distribute(Neighborhood_ADVO_init, hash32(geolink));
layout_ADVO_geolink rollADVO( layout_ADVO_geolink l, layout_ADVO_geolink r ) := TRANSFORM
			self.Neighborhood_Vacant_Properties := l.Neighborhood_Vacant_Properties + r.Neighborhood_Vacant_Properties;
			self.Neighborhood_Business_Count := l.Neighborhood_Business_Count + r.Neighborhood_Business_Count;
			self.Neighborhood_SFD_Count := l.Neighborhood_SFD_Count + r.Neighborhood_SFD_Count;
			self.Neighborhood_MFD_Count := l.Neighborhood_MFD_Count + r.Neighborhood_MFD_Count;
			self.Neighborhood_CollegeAddr_Count := l.Neighborhood_CollegeAddr_Count + r.Neighborhood_CollegeAddr_Count;
			self.Neighborhood_SeasonalAddr_Count := l.Neighborhood_SeasonalAddr_Count + r.Neighborhood_SeasonalAddr_Count;
			self.Neighborhood_POBox_Count := l.Neighborhood_POBox_Count + r.Neighborhood_POBox_Count;
			self := l;
		END;
		
Neighborhood_ADVO := rollup(sort(Neighborhood_ADVO_dist, geolink, local), rollADVO(left,right), geolink, local);	

// Append Foreclosure Neighborhood Data
layout_Foreclosures_Geolink addNeighborhoodForeclosures(Foreclosure_Address l) := TRANSFORM
	self.geolink := l.situs1_st + l.situs1_fipscounty + l.situs1_geo_blk;
	self.NOD     := if( (unsigned4)l.recording_date between AddrFraud.Constants.oneYrAgo   and AddrFraud.Constants.today and l.Deed_Category IN ['L','N']    , 1, 0 );
	self.NOD_1yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.twoYrAgo   and AddrFraud.Constants.oneYrAgo and l.Deed_Category IN ['L','N']  , 1, 0 );
	self.NOD_2yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.threeYrAgo and AddrFraud.Constants.twoYrAgo and l.Deed_Category IN ['L','N']  , 1, 0 );
	self.NOD_3yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fourYrAgo  and AddrFraud.Constants.threeYrAgo and l.Deed_Category IN ['L','N'] , 1, 0 );
	self.NOD_4yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fiveYrAgo  and AddrFraud.Constants.fourYrAgo and l.Deed_Category IN ['L','N'] , 1, 0 );
	self.NOD_5yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.sixYrAgo   and AddrFraud.Constants.fiveYrAgo and l.Deed_Category IN ['L','N'] , 1, 0 );
	self.foreclosures     := if( (unsigned4)l.recording_date between AddrFraud.Constants.oneYrAgo   and AddrFraud.Constants.today and l.Deed_Category ='U'     , 1, 0 );
	self.foreclosures_1yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.twoYrAgo   and AddrFraud.Constants.oneYrAgo and l.Deed_Category ='U'  , 1, 0 );
	self.foreclosures_2yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.threeYrAgo and AddrFraud.Constants.twoYrAgo and l.Deed_Category ='U'  , 1, 0 );
	self.foreclosures_3yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fourYrAgo  and AddrFraud.Constants.threeYrAgo and l.Deed_Category ='U', 1, 0 );
	self.foreclosures_4yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fiveYrAgo  and AddrFraud.Constants.fourYrAgo and l.Deed_Category ='U' , 1, 0 );
	self.foreclosures_5yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.sixYrAgo   and AddrFraud.Constants.fiveYrAgo and l.Deed_Category ='U' , 1, 0 );
	self.Deed_transfers := if( (unsigned4)l.recording_date between AddrFraud.Constants.oneYrAgo   and AddrFraud.Constants.today and l.Deed_Category IN ['S','G','T','R']  , 1, 0 );
	self.Deed_transfers_1yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.twoYrAgo   and AddrFraud.Constants.oneYrAgo and l.Deed_Category IN ['S','G','T','R']  , 1, 0 );
	self.Deed_transfers_2yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.threeYrAgo and AddrFraud.Constants.twoYrAgo and l.Deed_Category IN ['S','G','T','R']  , 1, 0 );
	self.Deed_transfers_3yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fourYrAgo  and AddrFraud.Constants.threeYrAgo and l.Deed_Category IN ['S','G','T','R'], 1, 0 );
	self.Deed_transfers_4yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fiveYrAgo  and AddrFraud.Constants.fourYrAgo and l.Deed_Category IN ['S','G','T','R'] , 1, 0 );
	self.Deed_transfers_5yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.sixYrAgo   and AddrFraud.Constants.fiveYrAgo and l.Deed_Category IN ['S','G','T','R'] , 1, 0 );
	self.Release_Lis_Pendens := if( (unsigned4)l.recording_date between AddrFraud.Constants.oneYrAgo   and AddrFraud.Constants.today and l.Deed_Category ='R'     , 1, 0 );
	self.Release_Lis_Pendens_1yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.twoYrAgo   and AddrFraud.Constants.oneYrAgo and l.Deed_Category ='R'  , 1, 0 );
	self.Release_Lis_Pendens_2yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.threeYrAgo and AddrFraud.Constants.twoYrAgo and l.Deed_Category ='R'  , 1, 0 );
	self.Release_Lis_Pendens_3yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fourYrAgo  and AddrFraud.Constants.threeYrAgo and l.Deed_Category ='R', 1, 0 );
	self.Release_Lis_Pendens_4yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.fiveYrAgo  and AddrFraud.Constants.fourYrAgo and l.Deed_Category ='R' , 1, 0 );
	self.Release_Lis_Pendens_5yr := if( (unsigned4)l.recording_date between AddrFraud.Constants.sixYrAgo   and AddrFraud.Constants.fiveYrAgo and l.Deed_Category ='R' , 1, 0 );
	self := l;
END;
		
Neighborhood_Foreclosures_init := project(Foreclosure_Address, addNeighborhoodForeclosures(Left));
Neighborhood_Foreclosures_dist := distribute(Neighborhood_Foreclosures_init, hash32(geolink));
layout_Foreclosures_Geolink rollForeclosures( layout_Foreclosures_Geolink l, layout_Foreclosures_Geolink r ) := TRANSFORM
	self.NOD     := l.NOD     + r.NOD;
	self.NOD_1yr := l.NOD_1yr + r.NOD_1yr;
	self.NOD_2yr := l.NOD_2yr + r.NOD_2yr;
	self.NOD_3yr := l.NOD_3yr + r.NOD_3yr;
	self.NOD_4yr := l.NOD_4yr + r.NOD_4yr;
	self.NOD_5yr := l.NOD_5yr + r.NOD_5yr;
	self.foreclosures     := l.foreclosures     + r.foreclosures;
	self.foreclosures_1yr := l.foreclosures_1yr + r.foreclosures_1yr;
	self.foreclosures_2yr := l.foreclosures_2yr + r.foreclosures_2yr;
	self.foreclosures_3yr := l.foreclosures_3yr + r.foreclosures_3yr;
	self.foreclosures_4yr := l.foreclosures_4yr + r.foreclosures_4yr;
	self.foreclosures_5yr := l.foreclosures_5yr + r.foreclosures_5yr;
	self.Deed_transfers     := l.Deed_transfers     + r.Deed_transfers;
	self.Deed_transfers_1yr := l.Deed_transfers_1yr + r.Deed_transfers_1yr;
	self.Deed_transfers_2yr := l.Deed_transfers_2yr + r.Deed_transfers_2yr;
	self.Deed_transfers_3yr := l.Deed_transfers_3yr + r.Deed_transfers_3yr;
	self.Deed_transfers_4yr := l.Deed_transfers_4yr + r.Deed_transfers_4yr;
	self.Deed_transfers_5yr := l.Deed_transfers_5yr + r.Deed_transfers_5yr;
	self.Release_Lis_Pendens     := l.Release_Lis_Pendens     + r.Release_Lis_Pendens;
	self.Release_Lis_Pendens_1yr := l.Release_Lis_Pendens_1yr + r.Release_Lis_Pendens_1yr;
	self.Release_Lis_Pendens_2yr := l.Release_Lis_Pendens_2yr + r.Release_Lis_Pendens_2yr;
	self.Release_Lis_Pendens_3yr := l.Release_Lis_Pendens_3yr + r.Release_Lis_Pendens_3yr;
	self.Release_Lis_Pendens_4yr := l.Release_Lis_Pendens_4yr + r.Release_Lis_Pendens_4yr;
	self.Release_Lis_Pendens_5yr := l.Release_Lis_Pendens_5yr + r.Release_Lis_Pendens_5yr;
	self := l;
END;
Neighborhood_Foreclosures := rollup(sort(Neighborhood_Foreclosures_dist, geolink, local), rollForeclosures(left,right), geolink, local);

// Append Lien Neighborhood Data
liens_slimrec get_liens(LiensV2.file_liens_party le, liensv2.file_liens_main rt) := TRANSFORM
	self.tmsid := le.tmsid;
	self.rmsid := le.rmsid;
	
	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(le.orig_address1, le.orig_city, le.orig_state, le.orig_zip5);
	self.prim_range := clean_address [1..10];
	self.predir := clean_address [11..12];
	self.prim_name := clean_address [13..40];
	self.addr_suffix := clean_address [41..44];
	self.postdir := clean_address [45..46];
	self.unit_desig := clean_address [47..56];
	self.sec_range := clean_address [57..65];
	self.p_city_name := clean_address [90..114];
	self.st := clean_address [115..116];
	self.zip := clean_address [117..121];
	self.zip4 := clean_address[122..125];
	self.county := clean_address[143..145];
	self.geo_lat := clean_address[146..155];
	self.geo_long := clean_address[156..166];
	self.msa := clean_address[167..170];
	self.geo_blk := clean_address[171..177];
	self.geo_match := clean_address[178];
	
	//build geolink for AddrRisk
	self.geo_link := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];	
	
	self.v_city_name := le.v_city_name;  
	self.cr_sort_sz := le.cr_sort_sz;
	self.cart := le.cart;
	self.lot := le.lot;	
	self.lot_order := le.lot_order;	
	self.dbpc := le.dbpc;		
	self.chk_digit := le.chk_digit;	
	self.rec_type := le.rec_type;	
	self.err_stat := le.err_stat;	
					    
	history_date := 999999;
	isRecent := ut.DaysApart(le.date_first_seen,myGetDate)<365*2+1;

	// Unreleased Liens--------------------------------
	self.last_liens_unreleased_date := if((INTEGER)le.date_last_seen=0, le.date_first_seen, '');		
	SELF.liens_recent_unreleased_count := (INTEGER)(le.rmsid<>'' AND 
																				 (INTEGER)le.date_last_seen=0 AND
																					isRecent);
	SELF.liens_historical_unreleased_count := (INTEGER)(le.rmsid<>'' AND 
																						(INTEGER)le.date_last_seen=0 AND
																						~isRecent);
																						
	SELF.liens_unreleased_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_unreleased_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_unreleased_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_unreleased_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_unreleased_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_unreleased_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_unreleased_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and 
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));																			
																																									
	// Released Liens	-----------------------------------		
	SELF.last_liens_released_date := if((INTEGER)le.date_last_seen<>0, (unsigned)le.date_first_seen, 0);
	SELF.liens_recent_released_count := (INTEGER)(le.rmsid<>'' AND 
																			(INTEGER)le.date_last_seen<>0 AND
																			isRecent);
	SELF.liens_historical_released_count := (INTEGER)(le.rmsid<>'' AND 
																					(INTEGER)le.date_last_seen<>0 AND
																					~isRecent);
																					
	SELF.liens_released_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_released_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_released_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_released_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_released_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_released_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_released_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and 
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));																				
																					
																		
	isEviction := rt.eviction='Y';

	// evictions
	SELF.eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND isRecent);
	SELF.eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND ~isRecent);
	SELF.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND isRecent);
	SELF.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND ~isRecent);
	
	SELF.eviction_count := (integer)(isEviction);
	SELF.eviction_count30 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.eviction_count90 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.eviction_count180 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.eviction_count12 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.eviction_count24 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.eviction_count36 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.eviction_count60 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));

	SELF.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);
	
	// they want liens seperated by type and released or unreleased for boca shell 3.0
	ftd := trim(stringlib.stringtouppercase(rt.filing_type_desc));
	goodResult := rt.rmsid<>'';
	unreleased := (unsigned)le.date_last_seen=0;
	released := (unsigned)le.date_last_seen<>0;
	
	isCivilJudgment := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and unreleased;
	isCivilJudgmentReleased := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and released;
	isFederalTax := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and unreleased;
	isFederalTaxReleased := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and released;
	isForeclosure := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and unreleased;
	isForeclosureReleased := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and released;
	isLandlordTenant := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and unreleased;
	isLandlordTenantReleased := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and released;
	isLisPendens := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and unreleased;
	isLisPendensReleased := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and released;
	isOtherLJ := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and unreleased;
	isOtherLJReleased := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and released;
	isOtherTax := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and unreleased;
	isOtherTaxReleased := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and released;
	isSmallClaims := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and unreleased;
	isSmallClaimsReleased := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and released;
	
	self.liens_unreleased_civil_judgment.count := (integer)isCivilJudgment;
	self.liens_unreleased_civil_judgment.earliest_filing_date := if(isCivilJudgment, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_civil_judgment.most_recent_filing_date := if(isCivilJudgment, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_civil_judgment.total_amount := if(isCivilJudgment, (real)rt.amount, 0);
	
	self.liens_released_civil_judgment.count := (integer)isCivilJudgmentReleased;
	self.liens_released_civil_judgment.earliest_filing_date := if(isCivilJudgmentReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_civil_judgment.most_recent_filing_date := if(isCivilJudgmentReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_civil_judgment.total_amount := if(isCivilJudgmentReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_federal_tax.count := (integer)isFederalTax;
	self.liens_unreleased_federal_tax.earliest_filing_date := if(isFederalTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_federal_tax.most_recent_filing_date := if(isFederalTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_federal_tax.total_amount := if(isFederalTax, (real)rt.amount, 0);
	
	self.liens_released_federal_tax.count := (integer)isFederalTaxReleased;
	self.liens_released_federal_tax.earliest_filing_date := if(isFederalTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_federal_tax.most_recent_filing_date := if(isFederalTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_federal_tax.total_amount := if(isFederalTaxReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_foreclosure.count := (integer)isForeclosure;
	self.liens_unreleased_foreclosure.earliest_filing_date := if(isForeclosure, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_foreclosure.most_recent_filing_date := if(isForeclosure, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_foreclosure.total_amount := if(isForeclosure, (real)rt.amount, 0);
	
	self.liens_released_foreclosure.count := (integer)isForeclosureReleased;
	self.liens_released_foreclosure.earliest_filing_date := if(isForeclosureReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_foreclosure.most_recent_filing_date := if(isForeclosureReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_foreclosure.total_amount := if(isForeclosureReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_landlord_tenant.count := (integer)isLandlordTenant;
	self.liens_unreleased_landlord_tenant.earliest_filing_date := if(isLandlordTenant, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_landlord_tenant.most_recent_filing_date := if(isLandlordTenant, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_landlord_tenant.total_amount := if(isLandlordTenant, (real)rt.amount, 0);
	
	self.liens_released_landlord_tenant.count := (integer)isLandlordTenantReleased;
	self.liens_released_landlord_tenant.earliest_filing_date := if(isLandlordTenantReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_landlord_tenant.most_recent_filing_date := if(isLandlordTenantReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_landlord_tenant.total_amount := if(isLandlordTenantReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_lispendens.count := (integer)isLisPendens;
	self.liens_unreleased_lispendens.earliest_filing_date := if(isLisPendens, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_lispendens.most_recent_filing_date := if(isLisPendens, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_lispendens.total_amount := if(isLisPendens, (real)rt.amount, 0);
	
	self.liens_released_lispendens.count := (integer)isLisPendensReleased;
	self.liens_released_lispendens.earliest_filing_date := if(isLisPendensReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_lispendens.most_recent_filing_date := if(isLisPendensReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_lispendens.total_amount := if(isLisPendensReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_other_lj.count := (integer)isOtherLJ;
	self.liens_unreleased_other_lj.earliest_filing_date := if(isOtherLJ, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_lj.most_recent_filing_date := if(isOtherLJ, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_lj.total_amount := if(isOtherLJ, (real)rt.amount, 0);
	
	self.liens_released_other_lj.count := (integer)isOtherLJReleased;
	self.liens_released_other_lj.earliest_filing_date := if(isOtherLJReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_lj.most_recent_filing_date := if(isOtherLJReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_lj.total_amount := if(isOtherLJReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_other_tax.count := (integer)isOtherTax;
	self.liens_unreleased_other_tax.earliest_filing_date := if(isOtherTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_tax.most_recent_filing_date := if(isOtherTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_tax.total_amount := if(isOtherTax, (real)rt.amount, 0);
	
	self.liens_released_other_tax.count := (integer)isOtherTaxReleased;
	self.liens_released_other_tax.earliest_filing_date := if(isOtherTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_tax.most_recent_filing_date := if(isOtherTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_tax.total_amount := if(isOtherTaxReleased, (real)rt.amount, 0);
	
	self.liens_unreleased_small_claims.count := (integer)isSmallClaims;
	self.liens_unreleased_small_claims.earliest_filing_date := if(isSmallClaims, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_small_claims.most_recent_filing_date := if(isSmallClaims, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_small_claims.total_amount := if(isSmallClaims, (real)rt.amount, 0);
	
	self.liens_released_small_claims.count := (integer)isSmallClaimsReleased;
	self.liens_released_small_claims.earliest_filing_date := if(isSmallClaimsReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_small_claims.most_recent_filing_date := if(isSmallClaimsReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_small_claims.total_amount := if(isSmallClaimsReleased, (real)rt.amount, 0);

	
	self.did := (integer)le.did;
end;



lien_party_debtors := LiensV2.file_liens_party((integer)did != 0 and name_type='D');
lien_main := liensv2.file_liens_main;
w_main := join(lien_party_debtors, lien_main,  LEFT.rmsid=RIGHT.rmsid AND left.tmsid=right.tmsid,
									get_liens(LEFT, right), left outer);


liens_slimrec roll_liens(liens_slimrec le, liens_slimrec rt) := TRANSFORM
	sameLien := le.tmsid=rt.tmsid and le.rmsid=rt.rmsid;

	SELF.liens_recent_unreleased_count := le.liens_recent_unreleased_count + IF(sameLien,0,rt.liens_recent_unreleased_count);
	SELF.liens_historical_unreleased_count := le.liens_historical_unreleased_count + IF(sameLien,0,rt.liens_historical_unreleased_count);
	SELF.liens_unreleased_count30 := le.liens_unreleased_count30 + IF(sameLien,0,rt.liens_unreleased_count30);
	SELF.liens_unreleased_count90 := le.liens_unreleased_count90 + IF(sameLien,0,rt.liens_unreleased_count90);
	SELF.liens_unreleased_count180 := le.liens_unreleased_count180 + IF(sameLien,0,rt.liens_unreleased_count180);
	SELF.liens_unreleased_count12 := le.liens_unreleased_count12 + IF(sameLien,0,rt.liens_unreleased_count12);
	SELF.liens_unreleased_count24 := le.liens_unreleased_count24 + IF(sameLien,0,rt.liens_unreleased_count24);
	SELF.liens_unreleased_count36 := le.liens_unreleased_count36 + IF(sameLien,0,rt.liens_unreleased_count36);
	SELF.liens_unreleased_count60 := le.liens_unreleased_count60 + IF(sameLien,0,rt.liens_unreleased_count60);
	
	SELF.liens_recent_released_count := le.liens_recent_released_count + IF(sameLien,0,rt.liens_recent_released_count);
	SELF.liens_historical_released_count := le.liens_historical_released_count + IF(sameLien,0,rt.liens_historical_released_count);
	SELF.liens_released_count30 := le.liens_released_count30 + IF(sameLien,0,rt.liens_released_count30);
	SELF.liens_released_count90 := le.liens_released_count90 + IF(sameLien,0,rt.liens_released_count90);
	SELF.liens_released_count180 := le.liens_released_count180 + IF(sameLien,0,rt.liens_released_count180);
	SELF.liens_released_count12 := le.liens_released_count12 + IF(sameLien,0,rt.liens_released_count12);
	SELF.liens_released_count24 := le.liens_released_count24 + IF(sameLien,0,rt.liens_released_count24);
	SELF.liens_released_count36 := le.liens_released_count36 + IF(sameLien,0,rt.liens_released_count36);
	SELF.liens_released_count60 := le.liens_released_count60 + IF(sameLien,0,rt.liens_released_count60);
	
	SELF.last_liens_unreleased_date := if((integer)le.last_liens_unreleased_date > (integer)rt.last_liens_unreleased_date, le.last_liens_unreleased_date, rt.last_liens_unreleased_date);
	SELF.last_liens_released_date := if((integer)le.last_liens_released_date > (integer)rt.last_liens_released_date, le.last_liens_released_date, rt.last_liens_released_date);
	
	SELF.eviction_recent_unreleased_count := le.eviction_recent_unreleased_count + IF(sameLien,0,rt.eviction_recent_unreleased_count);
	SELF.eviction_historical_unreleased_count := le.eviction_historical_unreleased_count + IF(sameLien,0,rt.eviction_historical_unreleased_count);
	SELF.eviction_recent_released_count := le.eviction_recent_released_count + IF(sameLien,0,rt.eviction_recent_released_count);
	SELF.eviction_historical_released_count := le.eviction_historical_released_count + IF(sameLien,0,rt.eviction_historical_released_count);
	
	SELF.eviction_count := le.eviction_count + IF(sameLien,0,rt.eviction_count);
	SELF.eviction_count30 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count30);
	SELF.eviction_count90 := le.eviction_count90 + IF(sameLien,0,rt.eviction_count90);
	SELF.eviction_count180 := le.eviction_count180 + IF(sameLien,0,rt.eviction_count180);
	SELF.eviction_count12 := le.eviction_count12 + IF(sameLien,0,rt.eviction_count12);
	SELF.eviction_count24 := le.eviction_count24 + IF(sameLien,0,rt.eviction_count24);
	SELF.eviction_count36 := le.eviction_count36 + IF(sameLien,0,rt.eviction_count36);
	SELF.eviction_count60 := le.eviction_count60 + IF(sameLien,0,rt.eviction_count60);
	
	SELF.last_eviction_date := MAX(le.last_eviction_date,rt.last_eviction_date);
	
	self.liens_unreleased_civil_judgment.count := le.liens_unreleased_civil_judgment.count + IF(sameLien and le.liens_unreleased_civil_judgment.count>0,0,rt.liens_unreleased_civil_judgment.count);
	self.liens_unreleased_civil_judgment.earliest_filing_date := ut.Min2(le.liens_unreleased_civil_judgment.earliest_filing_date,rt.liens_unreleased_civil_judgment.earliest_filing_date);
	self.liens_unreleased_civil_judgment.most_recent_filing_date := MAX(le.liens_unreleased_civil_judgment.most_recent_filing_date,rt.liens_unreleased_civil_judgment.most_recent_filing_date);
	self.liens_unreleased_civil_judgment.total_amount := le.liens_unreleased_civil_judgment.total_amount + IF(sameLien and le.liens_unreleased_civil_judgment.total_amount>0,0,rt.liens_unreleased_civil_judgment.total_amount);
	
	self.liens_released_civil_judgment.count := le.liens_released_civil_judgment.count + IF(sameLien and le.liens_released_civil_judgment.count>0,0,rt.liens_released_civil_judgment.count);
	self.liens_released_civil_judgment.earliest_filing_date := ut.Min2(le.liens_released_civil_judgment.earliest_filing_date,rt.liens_released_civil_judgment.earliest_filing_date);
	self.liens_released_civil_judgment.most_recent_filing_date := MAX(le.liens_released_civil_judgment.most_recent_filing_date,rt.liens_released_civil_judgment.most_recent_filing_date);
	self.liens_released_civil_judgment.total_amount := le.liens_released_civil_judgment.total_amount + IF(sameLien and le.liens_released_civil_judgment.total_amount>0,0,rt.liens_released_civil_judgment.total_amount);
	
	self.liens_unreleased_federal_tax.count := le.liens_unreleased_federal_tax.count + IF(sameLien and le.liens_unreleased_federal_tax.count>0,0,rt.liens_unreleased_federal_tax.count);
	self.liens_unreleased_federal_tax.earliest_filing_date := ut.Min2(le.liens_unreleased_federal_tax.earliest_filing_date,rt.liens_unreleased_federal_tax.earliest_filing_date);
	self.liens_unreleased_federal_tax.most_recent_filing_date := MAX(le.liens_unreleased_federal_tax.most_recent_filing_date,rt.liens_unreleased_federal_tax.most_recent_filing_date);
	self.liens_unreleased_federal_tax.total_amount := le.liens_unreleased_federal_tax.total_amount + IF(sameLien and le.liens_unreleased_federal_tax.total_amount>0,0,rt.liens_unreleased_federal_tax.total_amount);
	
	self.liens_released_federal_tax.count := le.liens_released_federal_tax.count + IF(sameLien and le.liens_released_federal_tax.count>0,0,rt.liens_released_federal_tax.count);
	self.liens_released_federal_tax.earliest_filing_date := ut.Min2(le.liens_released_federal_tax.earliest_filing_date,rt.liens_released_federal_tax.earliest_filing_date);
	self.liens_released_federal_tax.most_recent_filing_date := MAX(le.liens_released_federal_tax.most_recent_filing_date,rt.liens_released_federal_tax.most_recent_filing_date);
	self.liens_released_federal_tax.total_amount := le.liens_released_federal_tax.total_amount + IF(sameLien and le.liens_released_federal_tax.total_amount>0,0,rt.liens_released_federal_tax.total_amount);
	
	self.liens_unreleased_foreclosure.count := le.liens_unreleased_foreclosure.count + IF(sameLien and le.liens_unreleased_foreclosure.count>0,0,rt.liens_unreleased_foreclosure.count);
	self.liens_unreleased_foreclosure.earliest_filing_date := ut.Min2(le.liens_unreleased_foreclosure.earliest_filing_date,rt.liens_unreleased_foreclosure.earliest_filing_date);
	self.liens_unreleased_foreclosure.most_recent_filing_date := MAX(le.liens_unreleased_foreclosure.most_recent_filing_date,rt.liens_unreleased_foreclosure.most_recent_filing_date);
	self.liens_unreleased_foreclosure.total_amount := le.liens_unreleased_foreclosure.total_amount + IF(sameLien and le.liens_unreleased_foreclosure.total_amount>0,0,rt.liens_unreleased_foreclosure.total_amount);
	
	self.liens_released_foreclosure.count := le.liens_released_foreclosure.count + IF(sameLien and le.liens_released_foreclosure.count>0,0,rt.liens_released_foreclosure.count);
	self.liens_released_foreclosure.earliest_filing_date := ut.Min2(le.liens_released_foreclosure.earliest_filing_date,rt.liens_released_foreclosure.earliest_filing_date);
	self.liens_released_foreclosure.most_recent_filing_date := MAX(le.liens_released_foreclosure.most_recent_filing_date,rt.liens_released_foreclosure.most_recent_filing_date);
	self.liens_released_foreclosure.total_amount := le.liens_released_foreclosure.total_amount + IF(sameLien and le.liens_released_foreclosure.total_amount>0,0,rt.liens_released_foreclosure.total_amount);
	
	self.liens_unreleased_landlord_tenant.count := le.liens_unreleased_landlord_tenant.count + IF(sameLien and le.liens_unreleased_landlord_tenant.count>0,0,rt.liens_unreleased_landlord_tenant.count);
	self.liens_unreleased_landlord_tenant.earliest_filing_date := ut.Min2(le.liens_unreleased_landlord_tenant.earliest_filing_date,rt.liens_unreleased_landlord_tenant.earliest_filing_date);
	self.liens_unreleased_landlord_tenant.most_recent_filing_date := MAX(le.liens_unreleased_landlord_tenant.most_recent_filing_date,rt.liens_unreleased_landlord_tenant.most_recent_filing_date);
	self.liens_unreleased_landlord_tenant.total_amount := le.liens_unreleased_landlord_tenant.total_amount + IF(sameLien and le.liens_unreleased_landlord_tenant.total_amount>0,0,rt.liens_unreleased_landlord_tenant.total_amount);
	
	self.liens_released_landlord_tenant.count := le.liens_released_landlord_tenant.count + IF(sameLien and le.liens_released_landlord_tenant.count>0,0,rt.liens_released_landlord_tenant.count);
	self.liens_released_landlord_tenant.earliest_filing_date := ut.Min2(le.liens_released_landlord_tenant.earliest_filing_date,rt.liens_released_landlord_tenant.earliest_filing_date);
	self.liens_released_landlord_tenant.most_recent_filing_date := MAX(le.liens_released_landlord_tenant.most_recent_filing_date,rt.liens_released_landlord_tenant.most_recent_filing_date);
	self.liens_released_landlord_tenant.total_amount := le.liens_released_landlord_tenant.total_amount + IF(sameLien and le.liens_released_landlord_tenant.total_amount>0,0,rt.liens_released_landlord_tenant.total_amount);
	
	self.liens_unreleased_lispendens.count := le.liens_unreleased_lispendens.count + IF(sameLien and le.liens_unreleased_lispendens.count>0,0,rt.liens_unreleased_lispendens.count);
	self.liens_unreleased_lispendens.earliest_filing_date := ut.Min2(le.liens_unreleased_lispendens.earliest_filing_date,rt.liens_unreleased_lispendens.earliest_filing_date);
	self.liens_unreleased_lispendens.most_recent_filing_date := MAX(le.liens_unreleased_lispendens.most_recent_filing_date,rt.liens_unreleased_lispendens.most_recent_filing_date);
	self.liens_unreleased_lispendens.total_amount := le.liens_unreleased_lispendens.total_amount + IF(sameLien and le.liens_unreleased_lispendens.total_amount>0,0,rt.liens_unreleased_lispendens.total_amount);
	
	self.liens_released_lispendens.count := le.liens_released_lispendens.count + IF(sameLien and le.liens_released_lispendens.count>0,0,rt.liens_released_lispendens.count);
	self.liens_released_lispendens.earliest_filing_date := ut.Min2(le.liens_released_lispendens.earliest_filing_date,rt.liens_released_lispendens.earliest_filing_date);
	self.liens_released_lispendens.most_recent_filing_date := MAX(le.liens_released_lispendens.most_recent_filing_date,rt.liens_released_lispendens.most_recent_filing_date);
	self.liens_released_lispendens.total_amount := le.liens_released_lispendens.total_amount + IF(sameLien and le.liens_released_lispendens.total_amount>0,0,rt.liens_released_lispendens.total_amount);
	
	self.liens_unreleased_other_lj.count := le.liens_unreleased_other_lj.count + IF(sameLien and le.liens_unreleased_other_lj.count>0,0,rt.liens_unreleased_other_lj.count);
	self.liens_unreleased_other_lj.earliest_filing_date := ut.Min2(le.liens_unreleased_other_lj.earliest_filing_date,rt.liens_unreleased_other_lj.earliest_filing_date);
	self.liens_unreleased_other_lj.most_recent_filing_date := MAX(le.liens_unreleased_other_lj.most_recent_filing_date,rt.liens_unreleased_other_lj.most_recent_filing_date);
	self.liens_unreleased_other_lj.total_amount := le.liens_unreleased_other_lj.total_amount + IF(sameLien and le.liens_unreleased_other_lj.total_amount>0,0,rt.liens_unreleased_other_lj.total_amount);
	
	self.liens_released_other_lj.count := le.liens_released_other_lj.count + IF(sameLien and le.liens_released_other_lj.count>0,0,rt.liens_released_other_lj.count);
	self.liens_released_other_lj.earliest_filing_date := ut.Min2(le.liens_released_other_lj.earliest_filing_date,rt.liens_released_other_lj.earliest_filing_date);
	self.liens_released_other_lj.most_recent_filing_date := MAX(le.liens_released_other_lj.most_recent_filing_date,rt.liens_released_other_lj.most_recent_filing_date);
	self.liens_released_other_lj.total_amount := le.liens_released_other_lj.total_amount + IF(sameLien and le.liens_released_other_lj.total_amount>0,0,rt.liens_released_other_lj.total_amount);
	
	self.liens_unreleased_other_tax.count := le.liens_unreleased_other_tax.count + IF(sameLien and le.liens_unreleased_other_tax.count>0,0,rt.liens_unreleased_other_tax.count);
	self.liens_unreleased_other_tax.earliest_filing_date := ut.Min2(le.liens_unreleased_other_tax.earliest_filing_date,rt.liens_unreleased_other_tax.earliest_filing_date);
	self.liens_unreleased_other_tax.most_recent_filing_date := MAX(le.liens_unreleased_other_tax.most_recent_filing_date,rt.liens_unreleased_other_tax.most_recent_filing_date);
	self.liens_unreleased_other_tax.total_amount := le.liens_unreleased_other_tax.total_amount + IF(sameLien and le.liens_unreleased_other_tax.total_amount>0,0,rt.liens_unreleased_other_tax.total_amount);
	
	self.liens_released_other_tax.count := le.liens_released_other_tax.count + IF(sameLien and le.liens_released_other_tax.count>0,0,rt.liens_released_other_tax.count);
	self.liens_released_other_tax.earliest_filing_date := ut.Min2(le.liens_released_other_tax.earliest_filing_date,rt.liens_released_other_tax.earliest_filing_date);
	self.liens_released_other_tax.most_recent_filing_date := MAX(le.liens_released_other_tax.most_recent_filing_date,rt.liens_released_other_tax.most_recent_filing_date);
	self.liens_released_other_tax.total_amount := le.liens_released_other_tax.total_amount + IF(sameLien and le.liens_released_other_tax.total_amount>0,0,rt.liens_released_other_tax.total_amount);
	
	self.liens_unreleased_small_claims.count := le.liens_unreleased_small_claims.count + IF(sameLien and le.liens_unreleased_small_claims.count>0,0,rt.liens_unreleased_small_claims.count);
	self.liens_unreleased_small_claims.earliest_filing_date := ut.Min2(le.liens_unreleased_small_claims.earliest_filing_date,rt.liens_unreleased_small_claims.earliest_filing_date);
	self.liens_unreleased_small_claims.most_recent_filing_date := MAX(le.liens_unreleased_small_claims.most_recent_filing_date,rt.liens_unreleased_small_claims.most_recent_filing_date);
	self.liens_unreleased_small_claims.total_amount := le.liens_unreleased_small_claims.total_amount + IF(sameLien and le.liens_unreleased_small_claims.total_amount>0,0,rt.liens_unreleased_small_claims.total_amount);
	
	self.liens_released_small_claims.count := le.liens_released_small_claims.count + IF(sameLien and le.liens_released_small_claims.count>0,0,rt.liens_released_small_claims.count);
	self.liens_released_small_claims.earliest_filing_date := ut.Min2(le.liens_released_small_claims.earliest_filing_date,rt.liens_released_small_claims.earliest_filing_date);
	self.liens_released_small_claims.most_recent_filing_date := MAX(le.liens_released_small_claims.most_recent_filing_date,rt.liens_released_small_claims.most_recent_filing_date);
	self.liens_released_small_claims.total_amount := le.liens_released_small_claims.total_amount + IF(sameLien and le.liens_released_small_claims.total_amount>0,0,rt.liens_released_small_claims.total_amount);
	
	SELF := rt;
END;

w_main_distr := DISTRIBUTE(w_main,HASH(did));
liens_and_main_rolled := ROLLUP(SORT(w_main_distr, did,tmsid,rmsid, local),LEFT.did=RIGHT.did, roll_liens(LEFT,RIGHT), local);

// remove the tmsid and rmsid from the final layout
liens_by_address := PROJECT(liens_and_main_rolled,liens_slimmerrec);

layout_Liens_Geolink addNeighborhoodLiens(liens_by_address l) := TRANSFORM
			self.geolink := l.geo_link;
			self.liens_recent_unreleased_count := l.liens_recent_unreleased_count;
			self.liens_historical_unreleased_count := l.liens_historical_unreleased_count;
			self.liens_recent_released_count := l.liens_recent_released_count;
			self.liens_historical_released_count := l.liens_historical_released_count;
			self.eviction_recent_unreleased_count := l.eviction_recent_unreleased_count;
			self.eviction_historical_unreleased_count := l.eviction_historical_unreleased_count;
			self.eviction_recent_released_count := l.eviction_recent_released_count;
			self.eviction_historical_released_count := l.eviction_historical_released_count;
end;

Neighborhood_Liens_init := project(liens_by_address, addNeighborhoodLiens(Left));
Neighborhood_Liens_dist := distribute(Neighborhood_Liens_init , hash32(geolink));
layout_Liens_Geolink rollLiens( layout_Liens_Geolink l, layout_Liens_Geolink r ) := TRANSFORM
			self.liens_recent_unreleased_count := l.liens_recent_unreleased_count + r.liens_recent_unreleased_count;
			self.liens_historical_unreleased_count := l.liens_historical_unreleased_count + r.liens_historical_unreleased_count;
			self.liens_recent_released_count := l.liens_recent_released_count + r.liens_recent_released_count;
			self.liens_historical_released_count := l.liens_historical_released_count + r.liens_historical_released_count;
			self.eviction_recent_unreleased_count := l.eviction_recent_unreleased_count + r.eviction_recent_unreleased_count;
			self.eviction_historical_unreleased_count := l.eviction_historical_unreleased_count + r.eviction_historical_unreleased_count;
			self.eviction_recent_released_count := l.eviction_recent_released_count + r.eviction_recent_released_count;
			self.eviction_historical_released_count := l.eviction_historical_released_count + r.eviction_historical_released_count;
			self := l;
		END;
		
Neighborhood_Liens := rollup(sort(Neighborhood_Liens_dist, geolink, local), rollLiens(left,right), geolink, local);		

// Append Hedonic Neighborhood Data From RAW
layout_Hedonics_cnt addNeighborhoodHedonics(Prop_Address_V4 l) := TRANSFORM
		self.geolink := l.st + l.county + l.geo_blk;
		self.occupant_owned_count := if(l.occupant_owned,1,0);
		self.cnt_occupant_owned := if(l.occupant_owned,1,0);
	 	self.ave_building_age := if(l.built_date !=0,(integer)((STRING8)Std.Date.Today())[1..4] - (integer)l.built_date, 0);
		self.cnt_building_age := if(l.built_date !=0,1,0);
	 	self.ave_purchase_amount := l.purchase_amount;
		self.cnt_purchase_amount := if(l.purchase_amount !=0,1,0);
	 	self.ave_mortgage_amount := l.mortgage_amount;
		self.cnt_mortgage_amount := if(l.mortgage_amount !=0,1,0);
	 	self.ave_assessed_amount := l.assessed_amount;
		self.cnt_assessed_amount := if(l.assessed_amount !=0,1,0);
	 	self.ave_building_area := l.building_area;
		self.cnt_building_area := if(l.building_area !=0,1,0);
		price_per_square := if(l.purchase_amount !=0 and l.building_area !=0, l.purchase_amount DIV l.building_area, 0);
		self.ave_price_per_sf := price_per_square;
		self.cnt_price_per_sf := if(price_per_square !=0,1,0);
	 	self.ave_no_of_buildings_count := l.no_of_buildings;
		self.cnt_no_of_buildings_count := if(l.no_of_buildings !=0,1,0);
	 	self.ave_no_of_stories_count := l.no_of_stories;
		self.cnt_no_of_stories_count := if(l.no_of_stories !=0,1,0);
	 	self.ave_no_of_rooms_count := l.no_of_rooms;
		self.cnt_no_of_rooms_count := if(l.no_of_rooms !=0,1,0);
	 	self.ave_no_of_bedrooms_count := l.no_of_bedrooms;
		self.cnt_no_of_bedrooms_count := if(l.no_of_bedrooms !=0,1,0);
	 	self.ave_no_of_baths_count := l.no_of_baths;
		self.cnt_no_of_baths_count := if(l.no_of_baths !=0,1,0);
	 	self.ave_no_of_partial_baths_count := l.no_of_partial_baths;
		self.cnt_no_of_partial_baths_count := if(l.no_of_partial_baths !=0,1,0);
		self.total_property_count := if(l.prim_name !='', 1,0);
end;

Neighborhood_Hedonics_init := project(Prop_Address_V4, addNeighborhoodHedonics(Left));
Neighborhood_Hedonics_dist := distribute(Neighborhood_Hedonics_init, hash32(geolink));
layout_Hedonics_cnt rollHedonics( layout_Hedonics_cnt l, layout_Hedonics_cnt r ) := TRANSFORM
		self.occupant_owned_count := l.occupant_owned_count + r.occupant_owned_count;
		self.cnt_occupant_owned := l.cnt_occupant_owned + r.cnt_occupant_owned;
	 	self.ave_building_age := l.ave_building_age + r.ave_building_age;
		self.cnt_building_age := l.cnt_building_age + r.cnt_building_age;
	 	self.ave_purchase_amount := l.ave_purchase_amount + r.ave_purchase_amount;
		self.cnt_purchase_amount := l.cnt_purchase_amount + r.cnt_purchase_amount;
	 	self.ave_mortgage_amount := l.ave_mortgage_amount + r.ave_mortgage_amount;
		self.cnt_mortgage_amount := l.cnt_mortgage_amount + r.cnt_mortgage_amount;
	 	self.ave_assessed_amount := l.ave_assessed_amount + r.ave_assessed_amount;
		self.cnt_assessed_amount := l.cnt_assessed_amount + r.cnt_assessed_amount;
	 	self.ave_building_area := l.ave_building_area + r.ave_building_area;
		self.cnt_building_area := l.cnt_building_area + r.cnt_building_area;
		self.ave_price_per_sf := l.ave_price_per_sf + r.ave_price_per_sf;
		self.cnt_price_per_sf := l.cnt_price_per_sf + r.cnt_price_per_sf;
	 	self.ave_no_of_buildings_count := l.ave_no_of_buildings_count + r.ave_no_of_buildings_count;
		self.cnt_no_of_buildings_count := l.cnt_no_of_buildings_count + r.cnt_no_of_buildings_count;
	 	self.ave_no_of_stories_count := l.ave_no_of_stories_count + r.ave_no_of_stories_count;
		self.cnt_no_of_stories_count := l.cnt_no_of_stories_count + r.cnt_no_of_stories_count;
	 	self.ave_no_of_rooms_count := l.ave_no_of_rooms_count + r.ave_no_of_rooms_count;
		self.cnt_no_of_rooms_count := l.cnt_no_of_rooms_count + r.cnt_no_of_rooms_count;
	 	self.ave_no_of_bedrooms_count := l.ave_no_of_bedrooms_count + r.ave_no_of_bedrooms_count;
		self.cnt_no_of_bedrooms_count := l.cnt_no_of_bedrooms_count + r.cnt_no_of_bedrooms_count;
	 	self.ave_no_of_baths_count :=  l.ave_no_of_baths_count + r.ave_no_of_baths_count;
		self.cnt_no_of_baths_count := l.cnt_no_of_baths_count + r.cnt_no_of_baths_count;
	 	self.ave_no_of_partial_baths_count := l.ave_no_of_partial_baths_count + r.ave_no_of_partial_baths_count;
		self.cnt_no_of_partial_baths_count := l.cnt_no_of_partial_baths_count + r.cnt_no_of_partial_baths_count;
		self.total_property_count := l.total_property_count + r.total_property_count;
		self := l;
END;
		
Neighborhood_Pre_Hedonics := rollup(sort(Neighborhood_Hedonics_dist, geolink, local), rollHedonics(left,right), geolink, local);		
layout_Hedonics_geolink calcNeighborhoodHedonics(Neighborhood_Pre_Hedonics l) := transform
		self.geolink := l.geolink;
		self.occupant_owned_count := l.occupant_owned_count / l.total_property_count;
	 	self.ave_building_age := l.ave_building_age / l.cnt_building_age;
	 	self.cnt_building_age := l.cnt_building_age;
	 	self.ave_purchase_amount := l.ave_purchase_amount / l.cnt_purchase_amount;
	 	self.cnt_purchase_amount := l.cnt_purchase_amount;
	 	self.ave_mortgage_amount := l.ave_mortgage_amount / l.cnt_mortgage_amount;
	 	self.cnt_mortgage_amount := l.cnt_mortgage_amount;
	 	self.ave_assessed_amount := l.ave_assessed_amount / l.cnt_assessed_amount;
	 	self.cnt_assessed_amount := l.cnt_assessed_amount;
	 	self.ave_building_area := l.ave_building_area / l.cnt_building_area;
	 	self.cnt_building_area := l.cnt_building_area;
		self.ave_price_per_sf := l.ave_price_per_sf / l.cnt_price_per_sf;
		self.cnt_price_per_sf := l.cnt_price_per_sf;
	 	self.ave_no_of_buildings_count := l.ave_no_of_buildings_count / l.cnt_no_of_buildings_count;
	 	self.cnt_no_of_buildings_count := l.cnt_no_of_buildings_count;
	 	self.ave_no_of_stories_count := l.ave_no_of_stories_count / l.cnt_no_of_stories_count;
	 	self.cnt_no_of_stories_count := l.cnt_no_of_stories_count;
	 	self.ave_no_of_rooms_count := l.ave_no_of_rooms_count / l.cnt_no_of_rooms_count;
	 	self.cnt_no_of_rooms_count := l.cnt_no_of_rooms_count;
	 	self.ave_no_of_bedrooms_count := l.ave_no_of_bedrooms_count / l.cnt_no_of_bedrooms_count;
	 	self.cnt_no_of_bedrooms_count := l.cnt_no_of_bedrooms_count;
	 	self.ave_no_of_baths_count :=  l.ave_no_of_baths_count / l.cnt_no_of_baths_count;
	 	self.cnt_no_of_baths_count :=  l.cnt_no_of_baths_count;
	 	self.ave_no_of_partial_baths_count := l.cnt_no_of_partial_baths_count;
	 	self.cnt_no_of_partial_baths_count := l.cnt_no_of_partial_baths_count;
		self.total_property_count := l.total_property_count;
end;

Neighborhood_Hedonics := project(Neighborhood_Pre_Hedonics, calcNeighborhoodHedonics(left), local);

// Append Bankruptcy Neighborhood Data
bk_slimrec get_bkrupt(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.did;
	self.bdid := (integer)L.bdid;
	
	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.orig_addr1, l.orig_city, l.orig_st, l.orig_zip5);
	self.prim_range := clean_address [1..10];
	self.predir := clean_address [11..12];
	self.prim_name := clean_address [13..40];
	self.addr_suffix := clean_address [41..44];
	self.postdir := clean_address [45..46];
	self.unit_desig := clean_address [47..56];
	self.sec_range := clean_address [57..65];
	self.p_city_name := clean_address [90..114];
	self.st := clean_address [115..116];
	self.zip := clean_address [117..121];
	self.zip4 := clean_address[122..125];
	self.county := clean_address[143..145];
	self.geo_lat := clean_address[146..155];
	self.geo_long := clean_address[156..166];
	self.msa := clean_address[167..170];
	self.geo_blk := clean_address[171..177];
	self.geo_match := clean_address[178];
	
	//build geolink for AddrRisk
	self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];	
	
	self.v_city_name := l.v_city_name;  
	self.cr_sort_sz := l.cr_sort_sz;
	self.cart := l.cart;
	self.lot := l.lot;	
	self.lot_order := l.lot_order;	
	self.dbpc := l.dbpc;		
	self.chk_digit := l.chk_digit;	
	self.rec_type := l.rec_type;	
	self.err_stat := l.err_stat;	
	
		// disposition and date file used to be on the main, but they're on the search file now
	self.filing_type := l.filing_type;
	self.disposition := l.disposition;
	date_last_seen := MAX((INTEGER)l.date_filed, (INTEGER)l.discharged);  // discharged now instead of disposed_date
	self.date_last_seen := date_last_seen;
	SELF.bk_disposed_recent_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)<365*2+1);
	SELF.bk_disposed_historical_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)>365*2);
	
	SELF.bk_count30  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,30, historydate);
	SELF.bk_count90  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,90, historydate);
	SELF.bk_count180 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,180, historydate);
	SELF.bk_count12  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(1), historydate);
	SELF.bk_count24  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(2), historydate);
	SELF.bk_count36  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(3), historydate);
	SELF.bk_count48  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(4), historydate);
	SELF.bk_count60  := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(5), historydate);
	
	SELF.bk_ch7_cnt  := (integer)(l.chapter =  '7');
	SELF.bk_ch11_cnt := (integer)(l.chapter = '11');
	SELF.bk_ch12_cnt := (integer)(l.chapter = '12');
	SELF.bk_ch13_cnt := (integer)(l.chapter = '13');
	
	SELF.bk_discharged_cnt := (integer)(l.disposition = 'Discharged');
	SELF.bk_dismissed_cnt  := (integer)(l.disposition = 'Dismissed');
	SELF.bk_pro_se_cnt  := (integer)(l.pro_se_ind = 'Y');
	
	SELF.bk_business_flag_cnt := (integer)(l.business_flag <> 'I' OR (integer)l.bdid <> 0 OR l.cname <> '');
	SELF.bk_corp_flag_cnt := (integer)(l.corp_flag = 'Y' AND ((integer)l.bdid <> 0 OR l.cname <> ''));
	// SELF.bk_assets_available_cnt := (integer)(l.chapter =  '7');  //missing from 
	// SELF.bk_joint_flag_cnt := (integer)(l.chapter =  '7');
	
	self := []
end;

w_bksearch := project(BankruptcyV2.file_bankruptcy_search_v3((integer)did != 0 and name_type='D'),			
				get_bkrupt(LEFT));

// output(w_bksearch, named('w_bksearch'));				

bk_slimrec get_bkmain(w_bksearch Le, BankruptcyV2.file_bankruptcy_main_v3 Ri) := transform
	SELF.bankrupt := ri.case_number<>'';
 	hit := ri.case_number<>'';
	SELF.filing_count := (INTEGER)hit;
	SELF.bk_recent_count := (INTEGER)(hit AND le.disposition='');
	self := le;
end;

w_bksearch_dist := distribute( w_bksearch, hash(trim(case_num),trim(court_code)));
main_dist := distribute( BankruptcyV2.file_bankruptcy_main_v3, hash(trim(case_number),trim(court_code)));

w_bk := join(w_bksearch_dist, main_dist,
			LEFT.case_num<>'' AND LEFT.court_code<>'' AND
			left.case_num = right.case_number and
			left.court_code = right.court_code,
		   get_bkmain(LEFT,RIGHT), local);

bk_slimrec roll_bankrupt(w_bk le, w_bk ri) := TRANSFORM

	sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
	SELF.bankrupt := le.bankrupt OR ri.bankrupt;
	
	// keep the filing type and disposition together with the date that is selected 
	// instead of always selecting the left filing type and left disposition
	use_right := ri.date_last_seen > le.date_last_seen;
	SELF.date_last_seen := if(use_right, ri.date_last_seen, le.date_last_seen);
	SELF.filing_type := if(use_right, ri.filing_type, le.filing_type);
	SELF.disposition := if(use_right, ri.disposition, le.disposition);
	
	SELF.filing_count := le.filing_count + IF(sameBankruptcy,0,ri.filing_count);
	SELF.bk_recent_count := le.bk_recent_count + IF(sameBankruptcy,0,ri.bk_recent_count);
	SELF.bk_disposed_recent_count := le.bk_disposed_recent_count + IF(sameBankruptcy,0,ri.bk_disposed_recent_count);
	SELF.bk_disposed_historical_count := le.bk_disposed_historical_count + IF(sameBankruptcy,0,ri.bk_disposed_historical_count);							
	
	SELF.bk_count30 := le.bk_count30 + IF(sameBankruptcy,0,ri.bk_count30);
	SELF.bk_count90 := le.bk_count90 + IF(sameBankruptcy,0,ri.bk_count90);							
	SELF.bk_count180:= le.bk_count180+ IF(sameBankruptcy,0,ri.bk_count180);
	SELF.bk_count12 := le.bk_count12 + IF(sameBankruptcy,0,ri.bk_count12);
	SELF.bk_count24 := le.bk_count24 + IF(sameBankruptcy,0,ri.bk_count24);
	SELF.bk_count36 := le.bk_count36 + IF(sameBankruptcy,0,ri.bk_count36);
	SELF.bk_count48 := le.bk_count48 + IF(sameBankruptcy,0,ri.bk_count48);
	SELF.bk_count60 := le.bk_count60 + IF(sameBankruptcy,0,ri.bk_count60);
			
	SELF.bk_ch7_cnt := le.bk_ch7_cnt + IF(sameBankruptcy,0,ri.bk_ch7_cnt);
	SELF.bk_ch11_cnt:= le.bk_ch11_cnt+ IF(sameBankruptcy,0,ri.bk_ch11_cnt);
	SELF.bk_ch12_cnt:= le.bk_ch12_cnt+ IF(sameBankruptcy,0,ri.bk_ch12_cnt);
	SELF.bk_ch13_cnt:= le.bk_ch13_cnt+ IF(sameBankruptcy,0,ri.bk_ch13_cnt);
	
	SELF.bk_discharged_cnt := le.bk_discharged_cnt + IF(sameBankruptcy,0,ri.bk_discharged_cnt);
	SELF.bk_dismissed_cnt  := le.bk_dismissed_cnt + IF(sameBankruptcy,0,ri.bk_dismissed_cnt);
	SELF.bk_pro_se_cnt  	 := le.bk_pro_se_cnt + IF(sameBankruptcy,0,ri.bk_pro_se_cnt);
	
	SELF.bk_business_flag_cnt := le.bk_business_flag_cnt + IF(sameBankruptcy,0,ri.bk_business_flag_cnt);
	SELF.bk_corp_flag_cnt := le.bk_corp_flag_cnt + IF(sameBankruptcy,0,ri.bk_corp_flag_cnt);
	
	// SELF.bk_assets_available_cnt := le.bk_assets_available_cnt + IF(sameBankruptcy,0,ri.bk_assets_available_cnt);
	// SELF.bk_joint_flag_cnt := le.bk_joint_flag_cnt + IF(sameBankruptcy,0,ri.bk_joint_flag_cnt);
	
	SELF := le;
END;

bankrupt_rolled := ROLLUP(SORT(distribute(w_bk, did), did,court_code,case_num,-date_last_seen, local), LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);
bankrupt_slim := PROJECT(bankrupt_rolled, bk_slimmerrec);

layout_Bankruptcy_Geolink addNeighborhoodBankruptcies(bankrupt_slim l) := TRANSFORM
	self.geolink := l.geolink;
	self.bk_cnt := l.bk_recent_count;
	self.bk_1yr := l.bk_count12;
	self.bk_2yr := l.bk_count24;
	self.bk_3yr := l.bk_count36;
	self.bk_4yr := l.bk_count48;
	self.bk_5yr := l.bk_count60;	
	self.bk_ch7_cnt := l.bk_ch7_cnt;
	self.bk_ch11_cnt := l.bk_ch11_cnt;
	self.bk_ch12_cnt := l.bk_ch12_cnt;
	self.bk_ch13_cnt := l.bk_ch13_cnt;
	self.bk_discharged_cnt := l.bk_discharged_cnt;
	self.bk_dismissed_cnt := l.bk_dismissed_cnt;
	self.bk_pro_se_cnt := l.bk_pro_se_cnt;
	self.bk_business_flag_cnt := l.bk_business_flag_cnt;
	self.bk_corp_flag_cnt := l.bk_corp_flag_cnt;	
END;
		
Neighborhood_Bankruptcies_init := project(bankrupt_slim, addNeighborhoodBankruptcies(Left));
Neighborhood_Bankruptcies_dist := distribute(Neighborhood_Bankruptcies_init, hash32(geolink));
layout_Bankruptcy_Geolink rollBankruptcies( layout_Bankruptcy_Geolink l, layout_Bankruptcy_Geolink r ) := TRANSFORM
	self.bk_cnt := l.bk_cnt + r.bk_cnt;
	self.bk_1yr := l.bk_1yr + r.bk_1yr;
	self.bk_2yr := l.bk_2yr + r.bk_2yr;
	self.bk_3yr := l.bk_3yr + r.bk_3yr;
	self.bk_4yr := l.bk_4yr + r.bk_4yr;
	self.bk_5yr := l.bk_5yr + r.bk_5yr;	
	self.bk_ch7_cnt := l.bk_ch7_cnt + r.bk_ch7_cnt;
	self.bk_ch11_cnt := l.bk_ch11_cnt + r.bk_ch11_cnt;
	self.bk_ch12_cnt := l.bk_ch12_cnt + r.bk_ch12_cnt;
	self.bk_ch13_cnt := l.bk_ch13_cnt + r.bk_ch13_cnt;
	self.bk_discharged_cnt := l.bk_discharged_cnt + r.bk_discharged_cnt;
	self.bk_dismissed_cnt := l.bk_dismissed_cnt + r.bk_dismissed_cnt;
	self.bk_pro_se_cnt := l.bk_pro_se_cnt + r.bk_pro_se_cnt;
	self.bk_business_flag_cnt := l.bk_business_flag_cnt + r.bk_business_flag_cnt;
	self.bk_corp_flag_cnt := l.bk_corp_flag_cnt + r.bk_corp_flag_cnt;
	self := l;
END;
Neighborhood_Bankruptcies := rollup(sort(Neighborhood_Bankruptcies_dist, geolink, local), rollBankruptcies(left,right), geolink, local);

// Transform to final form
layout_Final AddAdvo(Neighborhood_ADVO l) := transform
	self := l;
	self := [];
end;

final_withADVO := project(Neighborhood_ADVO, AddADVO(LEFT));

layout_Final AddForeclosures(final_withADVO l, Neighborhood_Foreclosures r) := transform
	self.geolink := l.geolink;
	self := r;
	self := l;
end;

final_withForeclosures := join(final_withADVO, Neighborhood_Foreclosures, 
						(left.geolink = right.geolink),
						AddForeclosures(left, right), Left Outer);

layout_Final AddLiens(final_withForeclosures l, Neighborhood_Liens r) := transform
	self.geolink := l.geolink;
	self := r;
	self := l;
end;

final_withLiens := join(final_withForeclosures, Neighborhood_Liens, 
						(left.geolink = right.geolink),
						AddLiens(left, right),Left Outer);

layout_Final AddHedonics(final_withLiens l, Neighborhood_Hedonics r) := transform
	self.geolink := l.geolink;
	self := r;
	self := l;
end;

final_withHedonics := join(final_withLiens, Neighborhood_Hedonics, 
						(left.geolink = right.geolink),
						AddHedonics(left, right), Left Outer);
						
layout_Final AddBankruptcy(final_withHedonics l, Neighborhood_Bankruptcies r) := transform
	self.geolink := l.geolink;
	self := r;
	self := l;
end;

final_withBankruptcy := join(final_withHedonics, Neighborhood_Bankruptcies, 
						(left.geolink = right.geolink),
						AddBankruptcy(left, right), Left Outer);


export key_Neighborhood_stats_geolink := index(final_withBankruptcy,{
																	geolink},
																	{final_withBankruptcy},data_services.data_location.prefix() + 'thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::neighborhoodstats::geolink');