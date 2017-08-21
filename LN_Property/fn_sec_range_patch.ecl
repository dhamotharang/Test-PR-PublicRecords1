import ln_mortgage,address;


export fn_sec_range_patch(
	dataset(recordof(ln_property.Layout_Property_Common_Model_BASE))      assr_in0,
	dataset(recordof(ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE)) deed_in0,
	dataset(recordof(ln_property.Layout_Deed_Mortgage_Property_Search))   srch_in0) :=
function

output(count(srch_in0),named('incoming_search_file_count'));

assr_candidates := assr_in0(property_unit_number<>'' or mailing_unit_number<>'');
deed_candidates := deed_in0(buyer_mailing_address_unit_number<>'' or borrower_mailing_unit_number<>'' or seller_mailing_address_unit_number<>'' or property_address_unit_number<>'');
srch_candidates := srch_in0(trim(sec_range)='');

srch_recs_with_sec_range := srch_in0(sec_range<>'');

r_norm := record
 string12 ln_fares_id;
 string1  type_;
 string1  which_file;
 string80 street;
 string10 apt_unit;
 string70 csz;
end;

r_norm t_norm_assr(assr_candidates le, integer c) := transform
 self.street   := choose(c,le.property_full_street_address,le.mailing_full_street_address);
 self.apt_unit := choose(c,le.property_unit_number,        le.mailing_unit_number);
 self.csz      := choose(c,le.property_city_state_zip,     le.mailing_city_state_zip);
 self.type_    := choose(c,'P','O');
 self.which_file := 'A';
 self          := le;
end;

r_norm t_norm_deed(deed_candidates le, integer c) := transform
 self.street   := choose(c,le.property_full_street_address, le.buyer_mailing_full_street_address, le.borrower_mailing_full_street_address,le.seller_mailing_full_street_address);
 self.apt_unit := choose(c,le.property_address_unit_number, le.buyer_mailing_address_unit_number, le.borrower_mailing_unit_number,        le.seller_mailing_address_unit_number);
 self.csz      := choose(c,le.property_address_citystatezip,le.buyer_mailing_address_citystatezip,le.borrower_mailing_citystatezip,       le.seller_mailing_address_citystatezip);
 self.type_    := choose(c,'P','O','B','S');
 self.which_file := 'D';
 self          := le;
end;

norm_assr := normalize(assr_candidates,2,t_norm_assr(left,counter)) : persist('jtrost_property_assr_temp');
norm_deed := normalize(deed_candidates,4,t_norm_deed(left,counter)) : persist('jtrost_property_deed_temp');

concat := (norm_assr+norm_deed)(street<>'' and apt_unit<>'' and csz<>'');

base_property  := distribute(concat(type_='P'),hash(ln_fares_id));
base_owners    := distribute(concat(type_='O'),hash(ln_fares_id));
base_borrowers := distribute(concat(type_='B'),hash(ln_fares_id));
base_sellers   := distribute(concat(type_='S'),hash(ln_fares_id));

srch_property  := dedup(distribute(srch_candidates(source_code[2]='P'),hash(ln_fares_id)),ln_fares_id,local);
srch_owners    := dedup(distribute(srch_candidates(source_code[2]='O'),hash(ln_fares_id)),ln_fares_id,local);
srch_borrowers := dedup(distribute(srch_candidates(source_code[2]='B'),hash(ln_fares_id)),ln_fares_id,local);
srch_sellers   := dedup(distribute(srch_candidates(source_code[2]='S'),hash(ln_fares_id)),ln_fares_id,local);


//output(base_owners(ln_fares_id in bad_set));
//output(base_property(ln_fares_id in bad_set));

//output(srch_owners(ln_fares_id in bad_set));
//output(srch_property(ln_fares_id in bad_set));

r_combine := record
 //orig address
 string12  ln_fares_id;
 string1   type_;
 string80  street;
 string10  apt_unit;
 string70  csz;
 //in search file...
 string2   source_code;
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

r_combine t_j1(r_norm le,ln_property.Layout_Deed_Mortgage_Property_Search ri) := transform
 self.ln_fares_id := le.ln_fares_id;
 self             := le;
 self             := ri;
end;

//This could also be done in a single join by adding the condition type_=source_code[2]

j_owners := join(base_owners,srch_owners,
                 left.ln_fares_id=right.ln_fares_id,
				 t_j1(left,right),
				 local
				);

j_borrowers := join(base_borrowers,srch_borrowers,
                 left.ln_fares_id=right.ln_fares_id,
				 t_j1(left,right),
				 local
				);

j_sellers := join(base_sellers,srch_sellers,
                 left.ln_fares_id=right.ln_fares_id,
				 t_j1(left,right),
				 local
				);
				
j_property := join(base_property,srch_property,
                 left.ln_fares_id=right.ln_fares_id,
				 t_j1(left,right),
				 local
				);

count(j_owners);
count(j_borrowers);
count(j_sellers);
count(j_property);

concat_combine := (j_owners+j_borrowers+j_sellers+j_property) : persist('jtrost_property_combine_temp');

r_reclean := record
 concat_combine;
 string10  rc_prim_range;
 string2   rc_predir;
 string28  rc_prim_name;
 string4   rc_addr_suffix;
 string2   rc_postdir;
 string10  rc_unit_desig;
 string8   rc_sec_range;
 string25  rc_p_city_name;
 string25  rc_v_city_name;
 string2   rc_st;
 string5   rc_zip;
 string4   rc_zip4;
 string4   rc_cart;
 string1   rc_cr_sort_sz;
 string4   rc_lot;
 string1   rc_lot_order;
 string2   rc_dbpc;
 string1   rc_chk_digit;
 string2   rc_rec_type;
 string5   rc_county;
 string10  rc_geo_lat;
 string11  rc_geo_long;
 string4   rc_msa;
 string7   rc_geo_blk;
 string1   rc_geo_match;
 string4   rc_err_stat;
end;

r_reclean t_reclean(r_combine le) := transform

 string182 v_ca := address.cleanaddress182(le.street+', UNIT: '+le.apt_unit,le.csz);

 self.rc_prim_range   := v_ca[ 1..  10];
 self.rc_predir       := v_ca[ 11.. 12];
 self.rc_prim_name   := v_ca[ 13.. 40];
 self.rc_addr_suffix := v_ca[ 41.. 44];
 self.rc_postdir     := v_ca[ 45.. 46];
 self.rc_unit_desig  := v_ca[ 47.. 56];
 self.rc_sec_range   := v_ca[ 57.. 64];
 self.rc_p_city_name := v_ca[ 65.. 89];
 self.rc_v_city_name := v_ca[ 90..114];
 self.rc_st          := v_ca[115..116];
 self.rc_zip         := v_ca[117..121]; 
 self.rc_zip4        := v_ca[122..125]; 
 self.rc_cart        := v_ca[126..129];
 self.rc_cr_sort_sz  := v_ca[130..130];
 self.rc_lot         := v_ca[131..134];
 self.rc_lot_order   := v_ca[135..135];
 self.rc_dbpc        := v_ca[136..137];
 self.rc_chk_digit   := v_ca[138..138];
 self.rc_rec_type    := v_ca[139..140];
 self.rc_county      := v_ca[141..145];
 self.rc_geo_lat     := v_ca[146..155];
 self.rc_geo_long    := v_ca[156..166];
 self.rc_msa         := v_ca[167..170];
 self.rc_geo_blk     := v_ca[171..177];
 self.rc_geo_match   := v_ca[178..178];
 self.rc_err_stat    := v_ca[179..182];
 self                := le;
end;
 
p_reclean            := distribute(project(concat_combine,t_reclean(left)),hash(ln_fares_id));

srch_candidates_dist := distribute(srch_candidates,hash(ln_fares_id));

ln_property.Layout_Deed_Mortgage_Property_Search t_replace_bad_clean_addresses(srch_candidates_dist le, p_reclean ri) := transform

 self.prim_range  := ri.rc_prim_range;
 self.predir      := ri.rc_predir;
 self.prim_name   := ri.rc_prim_name;
 self.suffix      := ri.rc_addr_suffix;
 self.postdir     := ri.rc_postdir;
 self.unit_desig  := ri.rc_unit_desig;
 self.sec_range   := ri.rc_sec_range;
 self.p_city_name := ri.rc_p_city_name;
 self.v_city_name := ri.rc_v_city_name;
 self.st          := ri.rc_st;
 self.zip         := ri.rc_zip;
 self.zip4        := ri.rc_zip4;
 self.cart        := ri.rc_cart;
 self.cr_sort_sz  := ri.rc_cr_sort_sz;
 self.lot         := ri.rc_lot;
 self.lot_order   := ri.rc_lot_order;
 self.dbpc        := ri.rc_dbpc;
 self.chk_digit   := ri.rc_chk_digit;
 self.rec_type    := ri.rc_rec_type;
 self.county      := ri.rc_county;
 self.geo_lat     := ri.rc_geo_lat;
 self.geo_long    := ri.rc_geo_long;
 self.msa         := ri.rc_msa;
 self.geo_blk     := ri.rc_geo_blk;
 self.geo_match   := ri.rc_geo_match;
 self.err_stat    := ri.rc_err_stat;
 
 self             := le;
end;

p_replace_bad_clean_addresses := join(srch_candidates_dist,p_reclean,
                                      left.ln_fares_id=right.ln_fares_id and left.source_code[2]=right.type_,
									  t_replace_bad_clean_addresses(left,right),
									  local
									 );

bad_plus_originally_good := srch_recs_with_sec_range+p_replace_bad_clean_addresses;
									 
output(count(bad_plus_originally_good),named('outgoing_search_file_count'));

return p_replace_bad_clean_addresses;

end;