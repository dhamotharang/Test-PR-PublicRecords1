EXPORT Layouts := module

import ln_propertyv2, address;

export wide_rec := record
 string2   src;
 unsigned3 dt_last_seen;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 string5   addr_suffix;
 string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string30  county_name;

 //integer   hdr_did_street_within_the_county_ct    :=0;
 integer   hdr_name_street_within_the_county_ct   :=0;
 integer   hdr_street_within_the_county_ct        :=0;
 //integer   hdr_did_csz_within_the_county_ct       :=0;
 integer   hdr_name_primname_within_the_county_ct :=0;
 //integer   hdr_name_within_the_county_ct          :=0;

 //integer   hdr_unreg_did_street_within_the_county_ct    :=0;
 integer   hdr_unreg_name_street_within_the_county_ct   :=0;
 integer   hdr_unreg_street_within_the_county_ct        :=0;
 //integer   hdr_unreg_did_csz_within_the_county_ct       :=0;
 integer   hdr_unreg_name_primname_within_the_county_ct :=0;
 //integer   hdr_unreg_name_within_the_county_ct          :=0;

 //integer   hdr_cl_did_street_within_the_county_ct    :=0;
 //integer   hdr_cl_name_street_within_the_county_ct   :=0;
 //integer   hdr_cl_street_within_the_county_ct        :=0;
 //integer   hdr_cl_did_csz_within_the_county_ct       :=0;
 //integer   hdr_cl_name_primname_within_the_county_ct :=0;
 //integer   hdr_cl_name_within_the_county_ct          :=0;
  
 boolean   addr_in_hdr                      :=false;
 boolean   addr_in_hdr_unreg                :=false;
 //boolean   addr_in_hdr_cl                   :=false;
 boolean   addr_in_advo                     :=false;
 integer   advo_street_within_the_county_ct :=0;
 
 //boolean did_street_in_non_cl     := false;
 //boolean did_street_in_non_okc    := false;
 boolean name_street_in_non_cl    := false;
 boolean name_street_in_non_okc   := false;
 boolean street_in_non_cl         := false;
 boolean street_in_non_okc        := false;
 boolean name_primname_in_non_cl  := false;
 boolean name_primname_in_non_okc := false;
 //boolean name_in_cl               := false;
 //boolean name_in_okc              := false;
end;
/*
export did_street_in_county := record
 unsigned3 dt_last_seen;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 //string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 //string4   zip4;
 string30  county_name;
 boolean   addr_in_hdr                               :=false;
 boolean   addr_in_hdr_unreg                         :=false;
 //boolean   addr_in_hdr_cl                            :=false;
 integer   hdr_did_street_within_the_county_ct       :=0;
 integer   hdr_unreg_did_street_within_the_county_ct :=0;
 //integer   hdr_cl_did_street_within_the_county_ct    :=0;
 boolean   did_street_in_non_cl  := false;
 boolean   did_street_in_non_okc := false;
end;
*/
export name_street_in_county := record
 unsigned3 dt_last_seen;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 //string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 //string4   zip4;
 string30  county_name;
 boolean   addr_in_hdr                                :=false;
 boolean   addr_in_hdr_unreg                          :=false;
 //boolean   addr_in_hdr_cl                             :=false;
 integer   hdr_name_street_within_the_county_ct       :=0;
 integer   hdr_unreg_name_street_within_the_county_ct :=0;
 //integer   hdr_cl_name_street_within_the_county_ct    :=0;
 boolean   name_street_in_non_cl  := false;
 boolean   name_street_in_non_okc := false;
end;

export street_in_county := record
 unsigned3 dt_last_seen;
 string10  prim_range;
 string28  prim_name;
 //string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 //string4   zip4;
 string30  county_name;
 boolean   addr_in_hdr                           :=false;
 boolean   addr_in_hdr_unreg                     :=false;
 //boolean   addr_in_hdr_cl                        :=false;
 boolean   addr_in_advo                          :=false;
 integer   hdr_street_within_the_county_ct       :=0;
 integer   hdr_unreg_street_within_the_county_ct :=0;
 //integer   hdr_cl_street_within_the_county_ct    :=0;
 integer   advo_street_within_the_county_ct      :=0;
 boolean   street_in_non_cl                      := false;
 boolean   street_in_non_okc                     := false;
end;

export name_primname_in_county := record
 unsigned3 dt_last_seen;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 string5   addr_suffix;
 //string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 //string4   zip4;
 string30  county_name;
 boolean   addr_in_hdr                                :=false;
 boolean   addr_in_hdr_unreg                          :=false;
 //boolean   addr_in_hdr_cl                             :=false;
 integer   hdr_name_primname_within_the_county_ct       :=0;
 integer   hdr_unreg_name_primname_within_the_county_ct :=0;
 //integer   hdr_cl_name_primname_within_the_county_ct    :=0;
 boolean   name_primname_in_non_cl  := false;
 boolean   name_primname_in_non_okc := false;
end;

/*
export name_in_county := record
 unsigned3 dt_last_seen;
 unsigned6 did;
 string20  fname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 string5   addr_suffix;
 //string8   sec_range;
 string25  city_name;
 string2   st;
 string5   zip;
 //string4   zip4;
 string30  county_name;
 boolean   addr_in_hdr                         :=false;
 boolean   addr_in_hdr_unreg                   :=false;
 //boolean   addr_in_hdr_cl                      :=false;
 integer   hdr_name_within_the_county_ct       :=0;
 integer   hdr_unreg_name_within_the_county_ct :=0;
 //integer   hdr_cl_name_within_the_county_ct    :=0;
 boolean   name_in_cl  := false;
 boolean   name_in_okc := false;
end;
*/
/*
export name_apn_in_county := record
 string2   state;
 string30  county;
 string45  apn;
 unsigned6 property_address_did;
 string20  property_address_fname;
 string20  property_address_lname;
 string5   property_address_name_suffix;
 string10  property_address_prim_range;
 string28  property_address_prim_name;
 string5   property_address_addr_suffix;
 //string8   sec_range;
 string25  property_address_v_city_name;
 string2   property_address_st;
 string5   property_address_zip;
 //string4   zip4;
 integer   prop_name_addr_apn_within_the_county_ct;
 boolean   name_apn_in_cl;
 boolean   name_apn_in_okc;
 string12  appended_from_cl_fares_id; 
 string12  appended_from_okc_fares_id;
end;
*/ 
 
//dont forget the did's
export prep_rec := record
 string1  vendor_source_flag;
 string12 ln_fares_id;
 string45 apn;
 string45 apn_unformatted;
 string2  state;
 string30 county;
 string5  fips;
 string80 mailing_street;
 string6  mailing_unit_nbr;
 string51 mailing_csz;
 string80 property_street;
 string6  property_unit_nbr;
 string51 property_csz;
 string3  property_country_code;
 string1  property_address_code;
 string1  prop_addr_propagated_ind;
 string80 owner_name;
 string4   standardized_land_use_code;
 string50  sluc;
 //unsigned6 mailing_address_did:=0;
 //string20  mailing_address_fname:='';
 //string20  mailing_address_mname:='';
 //string20  mailing_address_lname:='';
 //string20  mailing_address_name_suffix:='';
 //string1   mailing_address_name_type:='';
 //string1   mailing_address_party_type:='';
 //string50  mailing_address_append_prepaddr1:='';
 //string50  mailing_address_append_prepaddr2:='';
 //string10  mailing_address_prim_range:='';
 //string28  mailing_address_prim_name:='';
 //string8   mailing_address_sec_range:='';
 //string25  mailing_address_v_city_name:='';
 //string2   mailing_address_st:='';
 //string5   mailing_address_zip:='';
 //string4   mailing_address_err_stat:='';
 unsigned6 property_address_did:=0;
 string20  property_address_fname:='';
 string20  property_address_mname:='';
 string20  property_address_lname:='';
 string20  property_address_name_suffix:='';
 string1   property_address_name_type:='';
 string1   property_address_party_type:='';
 string50  property_address_append_prepaddr1:='';
 string50  property_address_append_prepaddr2:='';
 string10  property_address_prim_range:='';
 string28  property_address_prim_name:='';
 string5   property_address_addr_suffix:='';
 string8   property_address_sec_range:='';
 string25  property_address_v_city_name:='';
 string2   property_address_st:='';
 string5   property_address_zip:='';
 string4   property_address_err_stat:='';

 boolean   property_address_prim_name_all_numeric     := false;
 //new fields needed for this function
 //string2   matched_by_did_street                      :='';
 string2   matched_by_name_street                     :='';
 string2   matched_by_street                          :='';
 string2   matched_by_name_primname                   :='';
 //string2   matched_by_name                            :='';
 //string2   matched_by_name_apn                        :='';
 string1   matched_any                                :='';
 
 //string25  appended_city_name_by_did_street  :='';
 //string2   appended_st_by_did_street         :='';
 //string5   appended_zip_by_did_street        :=''; 
 string25  appended_city_name_by_name_street :='';
 string2   appended_st_by_name_street        :='';
 string5   appended_zip_by_name_street       :='';
 string25  appended_city_name_by_street      :='';
 string2   appended_st_by_street             :='';
 string5   appended_zip_by_street            :='';
 string10  appended_prim_range_by_name_primname  := '';
 string10  appended_addr_suffix_by_name_primname := '';
 string25  appended_city_name_by_name_primname   :='';
 string2   appended_st_by_name_primname          :='';
 string5   appended_zip_by_name_primname         :='';
 //string10  appended_prim_range_by_name  := '';
 //string10  appended_prim_name_by_name   := '';
 //string5   appended_addr_suffix_by_name := '';
 //string25  appended_city_name_by_name   :='';
 //string2   appended_st_by_name          :='';
 //string5   appended_zip_by_name         :='';
 //string10  appended_prim_range_by_name_apn  := '';
 //string10  appended_prim_name_by_name_apn   := '';
 //string5   appended_addr_suffix_by_name_apn := '';
 //string25  appended_city_name_by_name_apn   :='';
 //string2   appended_st_by_name_apn          :='';
 //string5   appended_zip_by_name_apn         :='';
 
 //full header counts
 //string    hdr_did_street_within_the_county_ct    :='';
 string    hdr_name_street_within_the_county_ct   :='';
 string    hdr_street_within_the_county_ct        :='';
 //string    hdr_did_csz_within_the_county_ct       :='';
 string    hdr_name_primname_within_the_county_ct :='';
 //string    hdr_name_within_the_county_ct          :='';
 //header unregulated counts
 //string    hdr_unreg_did_street_within_the_county_ct    :='';
 string    hdr_unreg_name_street_within_the_county_ct   :='';
 string    hdr_unreg_street_within_the_county_ct        :='';
 //string    hdr_unreg_did_csz_within_the_county_ct       :='';
 string    hdr_unreg_name_primname_within_the_county_ct :='';
 //string    hdr_unreg_name_within_the_county_ct          :='';
 //advo counts
 string    advo_street_within_the_county_ct           :='';
 
 string50  property_address_append_prepaddr1_from_hdr:='';
 string50  property_address_append_prepaddr2_from_hdr:='';

 //string50  property_address_append_prepaddr1_from_prop:='';
 //string50  property_address_append_prepaddr2_from_prop:='';
 
 string1   doesnt_violate_source_restrictions := '';
 //integer   prop_name_addr_apn_within_the_county_ct :=1;
 //boolean   name_apn_in_cl             :=false;
 //string12  appended_from_cl_fares_id  :='';
 //boolean   name_apn_in_okc            :=false;
 //string12  appended_from_okc_fares_id :='';
 
 //for cleaning the enhanced addresses
 typeof(address.Layout_Clean182.prim_range)  prim_range_property :='';
 typeof(address.Layout_Clean182.predir)      predir_property     :='';
 typeof(address.Layout_Clean182.prim_name)   prim_name_property  :='';
 typeof(address.Layout_Clean182.addr_suffix) addr_suffix_property:='';
 typeof(address.Layout_Clean182.postdir)     postdir_property    :='';
 typeof(address.Layout_Clean182.unit_desig)  unit_desig_property :='';
 typeof(address.Layout_Clean182.sec_range)   sec_range_property  :='';
 typeof(address.Layout_Clean182.p_city_name) p_city_name_property:='';
 typeof(address.Layout_Clean182.v_city_name) v_city_name_property:='';
 typeof(address.Layout_Clean182.st)          st_property         :='';
 typeof(address.Layout_Clean182.zip)         zip_property        :='';
 typeof(address.Layout_Clean182.zip4)        zip4_property       :='';
 typeof(address.Layout_Clean182.cart)        cart_property       :='';
 typeof(address.Layout_Clean182.cr_sort_sz)  cr_sort_sz_property :='';
 typeof(address.Layout_Clean182.lot)         lot_property        :='';
 typeof(address.Layout_Clean182.lot_order)   lot_order_property  :='';
 typeof(address.Layout_Clean182.dbpc)        dbpc_property       :='';
 typeof(address.Layout_Clean182.chk_digit)   chk_digit_property  :='';
 typeof(address.Layout_Clean182.rec_type)    rec_type_property   :='';
 string5		                                 fips_county_property:='';
 typeof(address.Layout_Clean182.geo_lat)     geo_lat_property    :='';
 typeof(address.Layout_Clean182.geo_long)    geo_long_property   :='';
 typeof(address.Layout_Clean182.msa)         msa_property        :='';
 typeof(address.Layout_Clean182.geo_blk)     geo_blk_property    :='';
 typeof(address.Layout_Clean182.geo_match)   geo_match_property  :='';
 typeof(address.Layout_Clean182.err_stat)    err_stat_property   :='';
 unsigned8                                   rawaid_property     :=0;
end;

end;