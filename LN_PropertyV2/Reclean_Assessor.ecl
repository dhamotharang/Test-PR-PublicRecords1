import address;

ds_layout := RECORD
  string12 ln_fares_id;
  string2 source_code;
  integer8 cnt;
  integer8 search_count;
 END;
 
ds_isolated_recs := dedup(sort(distribute(dataset('~thor_data400::jltemp::prop_missing_names',ds_layout,flat),hash(ln_fares_id)),ln_fares_id, local),ln_fares_id, local);

ds_layout2 := record
  string12 ln_fares_id;
  string8 process_date;
  string1 vendor_source_flag;
  string1 current_record;
  string5 fips_code;
  string2 state_code;
  string30 county_name;
  string45 apna_or_pin_number;
  string45 fares_unformatted_apn;
  string2 duplicate_apn_multiple_address_id;
  string80 assessee_name;
  string60 second_assessee_name;
  string3 assessee_ownership_rights_code;
  string2 assessee_relationship_code;
  string10 assessee_phone_number;
  string30 tax_account_number;
  string45 contract_owner;
  string1 assessee_name_type_code;
  string1 second_assessee_name_type_code;
  string1 mail_care_of_name_type_code;
  string60 mailing_care_of_name;
  string80 mailing_full_street_address;
  string6 mailing_unit_number;
  string51 mailing_city_state_zip;
  string60 property_full_street_address;
  string6 property_unit_number;
  string51 property_city_state_zip;
  string3 property_country_code;
  string1 property_address_code;
  string2 legal_lot_code;
  string7 legal_lot_number;
  string10 legal_land_lot;
  string7 legal_block;
  string7 legal_section;
  string12 legal_district;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string40 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string250 legal_brief_description;
  string15 legal_assessor_map_ref;
  string10 census_tract;
  string2 record_type_code;
  string2 ownership_type_code;
  string2 new_record_type_code;
  string10 county_land_use_code;
  string45 county_land_use_description;
  string4 standardized_land_use_code;
  string1 timeshare_code;
  string25 zoning;
  string1 owner_occupied;
  string20 recorder_document_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string8 transfer_date;
  string8 recording_date;
  string8 sale_date;
  string25 document_type;
  string11 sales_price;
  string1 sales_price_code;
  string11 mortgage_loan_amount;
  string5 mortgage_loan_type_code;
  string60 mortgage_lender_name;
  string1 mortgage_lender_type_code;
  string8 prior_transfer_date;
  string8 prior_recording_date;
  string11 prior_sales_price;
  string1 prior_sales_price_code;
  string11 assessed_land_value;
  string11 assessed_improvement_value;
  string11 assessed_total_value;
  string4 assessed_value_year;
  string11 market_land_value;
  string11 market_improvement_value;
  string11 market_total_value;
  string4 market_value_year;
  string1 homestead_homeowner_exemption;
  string1 tax_exemption1_code;
  string1 tax_exemption2_code;
  string1 tax_exemption3_code;
  string1 tax_exemption4_code;
  string18 tax_rate_code_area;
  string13 tax_amount;
  string4 tax_year;
  string4 tax_delinquent_year;
  string15 school_tax_district1;
  string1 school_tax_district1_indicator;
  string15 school_tax_district2;
  string1 school_tax_district2_indicator;
  string15 school_tax_district3;
  string1 school_tax_district3_indicator;
  string30 land_acres;
  string30 land_square_footage;
  string30 land_dimensions;
  string9 building_area;
  string1 building_area_indicator;
  string8 building_area1;
  string2 building_area1_indicator;
  string8 building_area2;
  string2 building_area2_indicator;
  string8 building_area3;
  string2 building_area3_indicator;
  string8 building_area4;
  string2 building_area4_indicator;
  string8 building_area5;
  string2 building_area5_indicator;
  string8 building_area6;
  string2 building_area6_indicator;
  string8 building_area7;
  string2 building_area7_indicator;
  string4 year_built;
  string4 effective_year_built;
  string3 no_of_buildings;
  string5 no_of_stories;
  string5 no_of_units;
  string5 no_of_rooms;
  string5 no_of_bedrooms;
  string8 no_of_baths;
  string2 no_of_partial_baths;
  string3 garage_type_code;
  string5 parking_no_of_cars;
  string3 pool_code;
  string5 style_code;
  string3 type_construction_code;
  string3 exterior_walls_code;
  string3 foundation_code;
  string3 roof_cover_code;
  string5 roof_type_code;
  string3 heating_code;
  string3 heating_fuel_type_code;
  string3 air_conditioning_code;
  string1 air_conditioning_type_code;
  string1 elevator;
  string1 fireplace_indicator;
  string3 fireplace_number;
  string3 basement_code;
  string1 building_class_code;
  string3 site_influence1_code;
  string1 site_influence2_code;
  string1 site_influence3_code;
  string1 site_influence4_code;
  string1 site_influence5_code;
  string1 amenities1_code;
  string1 amenities2_code;
  string1 amenities3_code;
  string1 amenities4_code;
  string1 amenities5_code;
  string3 other_buildings1_code;
  string1 other_buildings2_code;
  string1 other_buildings3_code;
  string1 other_buildings4_code;
  string1 other_buildings5_code;
  string9 neighborhood_code;
  string20 condo_project_name;
  string20 building_name;
  string1 assessee_name_indicator;
  string1 second_assessee_name_indicator;
  string1 mail_care_of_name_indicator;
  string120 comments;
  string6 tape_cut_date;
  string8 certification_date;
  string2 edition_number;
  string1 prop_addr_propagated_ind;
 END;

ds_file_assess   := sort(distribute(dataset('~thor_data400::base::ln_propertyv2::Assesor',ds_layout2,flat),hash(ln_fares_id)),ln_fares_id,local);

ds_slim_layout := record
string12 	ln_fares_id;
string8		process_date;
string1   	vendor_source_flag;
string2		source_code;
string80	assessee_name;
string60	second_assessee_name;
string10	assessee_phone_number;
string60	mailing_care_of_name;
string80	mailing_full_street_address;
string6		mailing_unit_number;
string51	mailing_city_state_zip;
string60	property_full_street_address;
string6		property_unit_number;
string51  	property_city_state_zip;
string1		prop_addr_propagated_ind;
string4		tax_year;
end;

ds_slim_layout ds_reformat(ds_file_assess l, ds_isolated_recs r) := transform 
self.source_code := r.source_code;
self := l;
end ; 

ds := join(ds_file_assess, ds_isolated_recs,  
			left.ln_fares_id = right.ln_fares_id,
			ds_reformat(left,right),local);

new_search_candidates := ds((assessee_name<>'' or (second_assessee_name<>'' 
							and stringlib.stringfind(second_assessee_name,'TRUST',1)=0) 
							and (mailing_full_street_address<>'' and mailing_city_state_zip<>''
							or 	property_full_street_address<>'' and property_city_state_zip<>'')));

p_norm_layout := record
 string12 	ln_fares_id;
 string5  	vendor_source_flag;
 string8  	process_date;
 string80 	name;
 string2  	source_code;
 string70 	mailing_full_street_address;
 string51 	mailing_city_state_zip;
 string70 	property_full_street_address;
 string51  	property_city_state_zip;
 string10  	phone_number;
 unsigned3 	dt_first_seen; 
 unsigned3 	dt_last_seen; 
 unsigned3 	dt_vendor_first_reported; 
 unsigned3 	dt_vendor_last_reported; 
 string1   	conjunctive_name_seq; 
end;

p_norm_layout t_norm(new_search_candidates le, integer c) := transform
 self.name                      := choose(c,le.assessee_name,le.second_assessee_name);                                               				
 self.phone_number              := choose(c,le.assessee_phone_number,'');  //check this 
 self.dt_first_seen             := (integer)(le.tax_year + '00'); 
 self.dt_last_seen              := (integer)(le.tax_year + '00'); 
 self.dt_vendor_first_reported  := (integer)(le.tax_year + '00'); 
 self.dt_vendor_last_reported   := (integer)le.process_date[1..6]; 
 self.conjunctive_name_seq      := '1'; 						 
 self           				:= le;						 
end;

p_norm := normalize(new_search_candidates,2,t_norm(left,counter))(trim(name)<>'');

add_norm_layout := record
 string12 	ln_fares_id;
 string5  	vendor_source_flag;
 string8  	process_date;
 string80 	name;
 string2  	source_code;
 string70 	mailing_full_street_address;
 string51 	mailing_city_state_zip;
 string10  	phone_number;
 unsigned3 	dt_first_seen; 
 unsigned3 	dt_last_seen; 
 unsigned3 	dt_vendor_first_reported; 
 unsigned3 	dt_vendor_last_reported; 
 string1   	conjunctive_name_seq; 
end;

add_norm_layout a_norm(p_norm le, integer c) := transform
 self.source_code 					:= choose(c,'OO','OP'); 
 self.mailing_full_street_address	:= choose(c,le.mailing_full_street_address,le.property_full_street_address);                                               				
 self.mailing_city_state_zip		:= choose(c,le.mailing_city_state_zip,le.property_city_state_zip); 	 						 
 self           					:= le;						 
end;

add_norm := normalize(p_norm,2,a_norm(left,counter))(trim(mailing_full_street_address)<>'' and trim(mailing_city_state_zip)<>'');

r_clean := record
 add_norm;
 
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string70  cname;
 
 string80  nameasis;
 
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  p_city_name;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string4   cart;
 string1   cr_sort_sz;
 string4   lot;
 string1   lot_order;
 string2   dbpc;
 string1   chk_digit;
 string2   rec_type;
 string5   county;
 string10  geo_lat;
 string11  geo_long;
 string4   msa;
 string7   geo_blk;
 string1   geo_match;
 string4   err_stat;
end;

r_clean t_clean(add_norm le) := transform
 
 string73  v_pname      := address.cleanpersonlfm73(le.name);
 string182 v_clean_addr := address.cleanaddress182(le.mailing_full_street_address,le.mailing_city_state_zip);
 
 integer   v_pname_score := (integer)v_pname[71..73];
 
 self.title       := if(v_pname_score>=85,v_pname[ 1.. 5],'');
 self.fname       := if(v_pname_score>=85,v_pname[ 6..25],'');
 self.mname       := if(v_pname_score>=85,v_pname[26..45],'');
 self.lname       := if(v_pname_score>=85,v_pname[46..65],'');
 self.name_suffix := if(v_pname_score>=85,v_pname[66..70],'');
 
 self.cname       := if(v_pname_score<85,le.name,'');
 self.nameasis    := le.name;
 
 self.prim_range  := v_clean_addr[ 1..  10];
 self.predir      := v_clean_addr[ 11.. 12];
 self.prim_name   := v_clean_addr[ 13.. 40];
 self.suffix      := v_clean_addr[ 41.. 44];
 self.postdir     := v_clean_addr[ 45.. 46];
 self.unit_desig  := v_clean_addr[ 47.. 56];
 self.sec_range   := v_clean_addr[ 57.. 64];
 self.p_city_name := v_clean_addr[ 65.. 89];
 self.v_city_name := v_clean_addr[ 90..114];
 self.st          := v_clean_addr[115..116];
 self.zip         := v_clean_addr[117..121];
 self.zip4        := v_clean_addr[122..125];
 self.cart        := v_clean_addr[126..129];
 self.cr_sort_sz  := v_clean_addr[130..130];
 self.lot         := v_clean_addr[131..134];
 self.lot_order   := v_clean_addr[135..135];
 self.dbpc        := v_clean_addr[136..137];
 self.chk_digit   := v_clean_addr[138..138];
 self.rec_type    := v_clean_addr[139..140];
 self.county      := v_clean_addr[141..145];
 self.geo_lat     := v_clean_addr[146..155];
 self.geo_long    := v_clean_addr[156..166];
 self.msa         := v_clean_addr[167..170];
 self.geo_blk     := v_clean_addr[171..177];
 self.geo_match   := v_clean_addr[178..178];
 self.err_stat    := v_clean_addr[179..182];
 
 self             := le;
end;

p_clean := project(add_norm,t_clean(left));

LN_PropertyV2.layout_deed_mortgage_property_search t_map_to_search(p_clean le) := transform
 self             := le;
end;

ds1 := project(p_clean,t_map_to_search(left));

p_dedup := dedup(sort(distribute(ds1,hash(ln_fares_id,source_code)),
					ln_fares_id,source_code,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local),
					ln_fares_id,source_code,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local) : PERSIST('~thor_dell400::persist::File_Assessment_dedup');

//output(choosen(p_dedup,100));

export Reclean_Assessor := p_dedup;

