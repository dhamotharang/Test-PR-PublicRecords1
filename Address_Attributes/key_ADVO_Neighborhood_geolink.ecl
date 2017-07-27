import advo, doxie, Risk_Indicators;

//Data Declarations
ADVO_BASE_PRE := advo.key_addr1;

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



//Append ADVO Neighborhood Data
layout_ADVO_Geolink addNeighborhoodAdvo(ADVO_BASE_PRE l) := TRANSFORM
			address := l.prim_range + l.predir + l.prim_name + l.addr_suffix + l.postdir + l.sec_range;
			clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(address, l.p_city_name, l.st, l.zip);
			//build geolink for AddrRisk
			self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			
			self.Neighborhood_Vacant_Properties 	:= if(l.address_vacancy_indicator ='Y', 1,0);
			self.Neighborhood_Business_Count 			:= if(l.Address_Type ='0' OR l.Address_Type ='', 1,0);
			self.Neighborhood_SFD_Count 					:= if(l.Address_Type ='1', 1,0);
			self.Neighborhood_MFD_Count 					:= if(l.Address_Type ='2', 1,0);
			self.Neighborhood_CollegeAddr_Count 	:= if(l.College_Indicator ='Y', 1,0);
			self.Neighborhood_SeasonalAddr_Count 	:= if(l.Seasonal_Delivery_Indicator ='Y', 1,0);
			self.Neighborhood_POBox_Count 				:= if(l.Address_Type ='9', 0,1);
end;

Neighborhood_ADVO_init := project(ADVO_BASE_PRE, addNeighborhoodAdvo(left));
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

export key_ADVO_Neighborhood_geolink  := index(Neighborhood_ADVO,{
																			geolink},
																			{Neighborhood_ADVO},'~thor_data400::key::neighborhood::'+ doxie.Version_SuperKey +'::advo_neighborhoodstats::geolink');


