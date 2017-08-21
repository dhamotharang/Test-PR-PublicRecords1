import marriages_divorces;

//this CA filter doesn't bring any records into the process
//this is not a problem - it simply means we have restored all
//raw data to the IN superfile
ca_mar_v1       := marriages_divorces.file_marriage_divorce_base(process_date < '20060511' and state_origin='CA' and filing_type ='3');
fl_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(process_date < '20070122' and state_origin='FL' and filing_type in ['3','7']);
//had to remap the address field for party1 and party2 for KY and map them to county and state fields.
ky_mar_div_v1   := marriage_divorce_v2.fn_addrMappingFix_v1(marriages_divorces.file_marriage_divorce_base(process_date < '20050429' and state_origin='KY' and filing_type in['3','7']));
nc_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(process_date < '20070306' and state_origin='NC' and filing_type in['3','7']);
tx_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(process_date < '20060703' and state_origin='TX' and filing_type in['3','7']);
inghm_mi_mar_v1 := marriages_divorces.file_marriage_divorce_base(state_origin='MI' and trim(vendor)='INGHM' and filing_type ='3');
co_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(state_origin='CO' and filing_type in ['3','7']);
ga_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(state_origin='GA' and filing_type in ['3','7']);
nv_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(state_origin='NV' and filing_type in ['3','7']);
oh_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(state_origin='OH' and filing_type in ['3','7']);
ct_mar_div_v1   := marriages_divorces.file_marriage_divorce_base(state_origin='CT' and filing_type in ['3','7']);
me_mar_v1       := marriages_divorces.file_marriage_divorce_base(state_origin='ME' and filing_type ='3');
mi_mar_v1       := marriages_divorces.file_marriage_divorce_base(state_origin='MI' and trim(vendor)='26055' and filing_type ='3');


concat0 :=
//  ca_mar_v1
  fl_mar_div_v1
+ ky_mar_div_v1
+ nc_mar_div_v1
+ tx_mar_div_v1
+ inghm_mi_mar_v1
+ co_mar_div_v1
+ ga_mar_div_v1
+ nv_mar_div_v1
+ oh_mar_div_v1
+ ct_mar_div_v1
+ me_mar_v1
+ mi_mar_v1
;

concat := concat0(party1_orig_name<>'' and party2_orig_name<>'');

marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriages_divorces.layout_marriage_divorces le) := transform
 
 self.dt_first_seen            := (unsigned3)le.filing_dt[1..6];
 self.dt_last_seen             := (unsigned3)le.filing_dt[1..6];
 self.dt_vendor_first_reported := (unsigned3)le.process_date[1..6];
 self.dt_vendor_last_reported  := (unsigned3)le.process_date[1..6];

 self.filing_type    := le.filing_type;
 self.filing_subtype := '';
 
 self.vendor       := le.vendor;
 self.source_file  := le.source_file;
 self.process_date := le.process_date;
 self.state_origin := le.state_origin;
 
 /*
 party fields not mapped from v1 were:
 party_residence_cds
 party_status_cd
 party_race
 */
 
 self.party1_type                    := le.party1_type;
 self.party1_name_format             := le.party1_name_fmt;
 self.party1_name                    := if(trim(le.party1_orig_name)='','UNKNOWN',le.party1_orig_name);
 self.party1_alias                   := le.party1_orig_name_alias;
 self.party1_dob                     := le.party1_dob;
 self.party1_birth_state             := '';
 self.party1_age                     := le.party1_age;
 self.party1_race                    := le.party1_race;
 self.party1_addr1                   := le.party1_residence_address1;
 self.party1_csz                     := marriage_divorce_v2.fn_csz_format(le.party1_residence_city,le.party1_residence_state,le.party1_orig_zip);
 self.party1_county                  := le.party1_residence_county;
 self.party1_previous_marital_status := le.party1_status;
 self.party1_how_marriage_ended      := '';
 self.party1_times_married           := le.party1_times_married;
 self.party1_last_marriage_end_dt    := '';

 self.party2_type                    := le.party2_type;
 self.party2_name_format             := le.party2_name_fmt;
 self.party2_name                    := if(trim(le.party2_orig_name)='','UNKNOWN',le.party2_orig_name);
 self.party2_alias                   := le.party2_orig_name_alias;
 self.party2_dob                     := le.party2_dob;
 self.party2_birth_state             := '';
 self.party2_age                     := le.party2_age;
 self.party2_race                    := le.party2_race;
 self.party2_addr1                   := le.party2_residence_address1;
 self.party2_csz                     := marriage_divorce_v2.fn_csz_format(le.party2_residence_city,le.party2_residence_state,le.party2_orig_zip);
 self.party2_county                  := le.party2_residence_county;
 self.party2_previous_marital_status := le.party2_status;
 self.party2_how_marriage_ended      := '';
 self.party2_times_married           := le.party1_times_married;
 self.party2_last_marriage_end_dt    := '';
 
 /*
 other information not mapped:
 divorce_granted_to_cd
 divorce_granted_to
 divorce_grounds_cd
 source_location_cd
 */
   
 self.number_of_children := le.number_children;
 
 self.marriage_filing_dt     := if(self.filing_type='3',le.filing_dt,'');
 self.marriage_dt            := le.marriage_dt;
 self.marriage_city          := if(self.filing_type='3',le.source_city,'');
 self.marriage_county        := if(self.filing_type='3',le.source_county,'');
 self.place_of_marriage      := '';
 self.type_of_ceremony       := '';
 self.marriage_filing_number := if(self.filing_type='3',le.filing_number,'');
 self.marriage_docket_volume := '';
 self.divorce_filing_dt      := if(self.filing_type='7',le.filing_dt,'');
 self.divorce_dt             := le.divorce_dt;
 self.divorce_docket_volume  := '';
 self.divorce_filing_number  := if(self.filing_type='7',le.filing_number,'');
 self.divorce_city           := if(self.filing_type='7',le.source_city,'');
 self.divorce_county         := if(self.filing_type='7',le.source_county,'');
 self.grounds_for_divorce    := le.divorce_grounds;
 self.marriage_duration_cd   := if(le.marriage_months_duration<>'','M','');
 self.marriage_duration      := le.marriage_months_duration;
 
 self.conjunctive_name_format := '';
 self.conjunctive_party       := '';
 
 self.pname_party1       := le.p1_title+le.p1_fname+le.p1_mname+le.p1_lname+le.p1_name_suffix+le.p1_score_in;
 self.pname_party2       := le.p2_title+le.p2_fname+le.p2_mname+le.p2_lname+le.p2_name_suffix+le.p2_score_in;
 self.pname_party1_alias := le.p1a_title+le.p1a_fname+le.p1a_mname+le.p1a_lname+le.p1a_name_suffix+le.p1a_score_in;
 self.pname_party2_alias := le.p2a_title+le.p2a_fname+le.p2a_mname+le.p2a_lname+le.p2a_name_suffix+le.p2a_score_in;

 //originally set to 'Y' so that we don't reclean
 //however address improvements in the functions
 //substantiate re-cleaning to, in most cases,
 //extract the city and state
 self.touched := '';
 
 self.ca_party1 := 
     le.prim_range_1
   + le.predir_1
   + le.prim_name_1
   + le.addr_suffix_1
   + le.postdir_1
   + le.unit_desig_1
   + le.sec_range_1
   + le.p_city_name_1
   + le.v_city_name_1
   + le.st_1
   + le.zip_1
   + le.zip4_1
   + le.cart_1
   + le.cr_sort_sz_1
   + le.lot_1
   + le.lot_order_1
   + le.dpbc_1
   + le.chk_digit_1
   + le.rec_type_1
   + le.ace_fips_st_1
   + le.ace_fips_county_1
   + le.geo_lat_1
   + le.geo_long_1
   + le.msa_1
   + le.geo_blk_1
   + le.geo_match_1
   + le.err_stat_1
   ;

 self.ca_party2 := 
     le.prim_range_2
   + le.predir_2
   + le.prim_name_2
   + le.addr_suffix_2
   + le.postdir_2
   + le.unit_desig_2
   + le.sec_range_2
   + le.p_city_name_2
   + le.v_city_name_2
   + le.st_2
   + le.zip_2
   + le.zip4_2
   + le.cart_2
   + le.cr_sort_sz_2
   + le.lot_2
   + le.lot_order_2
   + le.dpbc_2
   + le.chk_digit_2
   + le.rec_type_2
   + le.ace_fips_st_2
   + le.ace_fips_county_2
   + le.geo_lat_2
   + le.geo_long_2
   + le.msa_2
   + le.geo_blk_2
   + le.geo_match_2
   + le.err_stat_2
   ;
   
 self.party1_ssn := le.party1_ssn;
 self.party2_ssn := le.party2_ssn;

 self := [];
end;

export mapping_v1_to_v2 := project(concat,t_map_to_common(left));// : PERSIST('mar_div_v1_to_v2');