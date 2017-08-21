import doxie,Data_Services;
slim_layout := RECORD
  string12 did;
  unsigned1 did_score;
  string12 b_did;
  unsigned1 b_did_score;
  string1 rec_type_7;
  string9 accident_nbr;
  string2 prop_damage_code;
  string2 prop_damage_nbr;
  string25 prop_damaged;
  string7 prop_damage_amount;
  string25 prop_owner_name;
  string16 filler1;
  string1 prop_owner_suffix;
  string40 prop_owner_st_city;
  string18 filler2;
  string2 prop_owner_state;
  string9 prop_owner_zip;
  string2 fr_fixed_object_cap_code;
  string241 filler3;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 score;
  string25 cname;
 END;

flc7 := project(basefile_flcrash7,transform(slim_layout,
  self.prop_owner_st_city := trim(trim(left.prop_owner_address,left,right)+' '+ trim(left.prop_owner_st_city,left,right),left,right),

 , self := left));

export key_flcrash7 := index(flc7
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc7}
							,Data_Services.Data_location.Prefix('NONAMEGIVEN') +'~thor_data400::key::flcrash7_' + doxie.Version_SuperKey);
