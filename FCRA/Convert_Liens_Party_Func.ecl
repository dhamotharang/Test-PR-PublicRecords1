import liensv2;
export Convert_Liens_Party_Func := function
	string_rec := record
string50 tmsid;
string50 rmsid;
string250 orig_full_debtorname;
string200 orig_name;
string50 orig_lname;
string20 orig_fname;
string20 orig_mname;
string10 orig_suffix;
string9 tax_id;
string9 ssn;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 name_score;
string200 cname;
string100 orig_address1;
string50 orig_address2;
string70 orig_city;
string2 orig_state;
string10 orig_zip5;
string4 orig_zip4;
string2 orig_county;
string4 orig_country;
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
string2 dbpc;
string1 chk_digit;
string2 rec_type;
string5 county;
string10 geo_lat;
string11 geo_long;
string4 msa;
string7 geo_blk;
string1 geo_match;
string4 err_stat;
string10 phone;
string1 name_type;
string12 DID;
string12 BDID;
string8 date_first_seen;
string8 date_last_seen;
string8 date_vendor_first_reported;
string8 date_vendor_last_reported;
unsigned8 persistent_record_id := 0 ; 
string20 flag_file_id;
end;

ds :=  dedup(sort(dataset('~thor_data400::base::override::fcra::qa::liensv2_party',string_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),tmsid,rmsid,-flag_file_id),except flag_file_id,keep(1));

FCRA.Layout_Override_Liensv2_party proj_func(ds l) := transform
	self := l;
end;	

proj_out := project(ds,proj_func(left));

return proj_out;

end;