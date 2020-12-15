/*2011-03-02T15:18:41Z (Jesse Shaw)

*/
Import Data_Services, advo, doxie,addrfraud, LN_PropertyV2, property, std, Risk_Indicators, dx_property;

//Data Declarations
ADVO_BASE_GEOLINK := address_attributes.key_ADVO_Neighborhood_geolink;

// isFCRA := false;
// prop_address_pre := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);
sfd := ['','100','109','135','136','137','138','160','163','454','460','465','500','999','1000','1001','1006','1007','1008','1012','1015','1016','1109','1999','8000','8001','9300','9301'];
prop_address := LN_PropertyV2.Key_Prop_Address_V4(standardized_land_use_code in sfd);

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




/*
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
*/
	
// Append ADVO Neighborhood Data From KEY
layout_ADVO_Geolink addAdvoBase(ADVO_BASE_GEOLINK l) := TRANSFORM
	self := l;
	self := [];
End;
Neighborhood_ADVO := project(ADVO_BASE_GEOLINK, addAdvoBase(Left));

// Append Foreclosure Neighborhood Data limit to SFD
foreclosures_sfd := dx_property.key_foreclosures_addr(situs1_sec_range ='');
layout_Foreclosures_Geolink addNeighborhoodForeclosures(foreclosures_sfd l) := TRANSFORM
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
		
Neighborhood_Foreclosures_init := project(foreclosures_sfd, addNeighborhoodForeclosures(Left));
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

// Append Lien Neighborhood Data limit to SFD
liens_sfd := address_attributes.key_liens_address(sec_range ='');
layout_Liens_Geolink addNeighborhoodLiens(liens_sfd l) := TRANSFORM
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

Neighborhood_Liens_init := project(liens_sfd, addNeighborhoodLiens(Left));
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
layout_Hedonics_cnt addNeighborhoodHedonics(prop_address l) := TRANSFORM
		address := l.prim_range + l.predir + l.prim_name + l.suffix + l.postdir + l.sec_range;
		clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(address, l.p_city_name, l.st, l.zip);
		self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
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

Neighborhood_Hedonics_init := project(prop_address, addNeighborhoodHedonics(Left));
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

// Append Bankruptcy Neighborhood Data limit to SFD
bankruptcies_sfd := address_attributes.key_bankruptcy_address(sec_range ='');
layout_Bankruptcy_Geolink addNeighborhoodBankruptcies(bankruptcies_sfd l) := TRANSFORM
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
		
Neighborhood_Bankruptcies_init := project(bankruptcies_sfd, addNeighborhoodBankruptcies(Left));
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

export key_nbrhd_sfd_stats_geolink := index(final_withBankruptcy,{
																	geolink},
																	{final_withBankruptcy},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::neighborhood::' + doxie.Version_SuperKey + '::neighborhoodsfdstats::geolink');

