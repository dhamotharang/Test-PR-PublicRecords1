IMPORT Business_Header, ut;

dca_contacts := dca.File_dca_all_In;

// Normalize 10 contact names
layout_Pub_slim := record
 string8   process_date;
   string6 Enterprise_num;
   string105 Name;
   string6 Root;
   string3 Sub;
   string45 Phone;
   string82 E_mail;
   string8 Update_Date;
string65 exec_title;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 name_score;
string10  prim_range;
string2   predir;
string28  prim_name;
string4   addr_suffix;
string2   postdir;
string10  unit_desig;
string8   sec_range;
string25  p_city_name;
string25  v_city_name;
string2   st;
string5   z5;
string4   zip4;
string4   cart;
string1   cr_sort_sz;
string4   lot;
string1   lot_order;
string2   dpbc;
string1   chk_digit;
string2   rec_type;
string5   county;
string10  geo_lat;
string11  geo_long;
string4   msa;
string7   geo_blk;
string1   geo_match;
string4   err_stat;
string10  prim_rangeA;
string2   predirA;
string28  prim_nameA;
string4   addr_suffixA;
string2   postdirA;
string10  unit_desigA;
string8   sec_rangeA;
string25  p_city_nameA;
string25  v_city_nameA;
string2   stA;
string5   zipA;
string4   zip4A;
string4   cartA;
string1   cr_sort_szA;
string4   lotA;
string1   lot_orderA;
string2   dpbcA;
string1   chk_digitA;
string2   rec_typeA;
string5   countyA;
string10  geo_latA;
string11  geo_longA;
string4   msaA;
string7   geo_blkA;
string1   geo_matchA;
string4   err_statA;
   string1 lf;
end;


layout_pub_slim dca_norm_names(Layout_pub_In l, integer CTR) := TRANSFORM
self.title := choose(CTR, l.exec1_title, l.exec2_title, l.exec3_title, l.exec4_title, 
		l.exec5_title, l.exec6_title, l.exec7_title, l.exec8_title, l.exec9_title, l.exec10_title);
self.fname := choose(CTR, l.exec1_fname, l.exec2_fname, l.exec3_fname, l.exec4_fname, 
		l.exec5_fname, l.exec6_fname, l.exec7_fname, l.exec8_fname, l.exec9_fname, l.exec10_fname);
self.mname := choose(CTR, l.exec1_mname, l.exec2_mname, l.exec3_mname, l.exec4_mname, 
		l.exec5_mname, l.exec6_mname, l.exec7_mname, l.exec8_mname, l.exec9_mname, l.exec10_mname);
self.lname := choose(CTR, l.exec1_lname, l.exec2_lname, l.exec3_lname, l.exec4_lname, 
		l.exec5_lname, l.exec6_lname, l.exec7_lname, l.exec8_lname, l.exec9_lname, l.exec10_lname);
self.name_suffix := choose(CTR, l.exec1_name_suffix, l.exec2_name_suffix, l.exec3_name_suffix, 
		l.exec4_name_suffix, l.exec5_name_suffix, l.exec6_name_suffix, l.exec7_name_suffix, 
		l.exec8_name_suffix, l.exec9_name_suffix, l.exec10_name_suffix);
self.name_score := choose(CTR, l.exec1_score, l.exec2_score, l.exec3_score, l.exec4_score, l.exec5_score, 
		l.exec6_score, l.exec7_score, l.exec8_score, l.exec9_score, l.exec10_score);
self.exec_title := choose(CTR, l.Title_1, l.Title_2, l.Title_3, l.Title_4, l.Title_5, l.Title_6, 
		l.Title_7, l.Title_8, l.Title_9, l.Title_10);
self := L;
end;

dca_pub_slim := NORMALIZE(dca_contacts, 10, dca_norm_names(LEFT, COUNTER));


//*************************************************************************
// Translate Contact from dca to Business Contact Format
//*************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_dca_to_BCF(Layout_pub_slim l, integer CTR) := TRANSFORM
self.company_title := stringlib.stringtouppercase(trim(L.exec_title)[1..35]); 
self.vendor_id := L.root + '-' + L.sub;
self.source := 'DC';
self.name_score := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
SELF.prim_range := CHOOSE(CTR, L.prim_range, L.prim_rangeA, L.prim_range, L.prim_rangeA);
SELF.predir := CHOOSE(CTR, L.predir, L.predirA, L.predir, L.predirA);
SELF.prim_name := CHOOSE(CTR, L.prim_name, L.prim_nameA, L.prim_name, L.prim_nameA);
SELF.addr_suffix := CHOOSE(CTR, L.addr_suffix, L.addr_suffixA, L.addr_suffix, L.addr_suffixA);
SELF.postdir := CHOOSE(CTR, L.postdir, L.postdirA, L.postdir, L.postdirA);
SELF.unit_desig := CHOOSE(CTR, L.unit_desig, L.unit_desigA, L.unit_desig, L.unit_desigA);
SELF.sec_range := CHOOSE(CTR, L.sec_range, L.sec_rangeA, L.sec_range, L.sec_rangeA);
SELF.city := CHOOSE(CTR, L.p_city_name, L.p_city_nameA, L.p_city_name, L.p_city_nameA);
SELF.state := CHOOSE(CTR, L.st, L.stA, L.st, L.stA);
SELF.zip := CHOOSE(CTR, (UNSIGNED3)L.z5, (UNSIGNED3)L.zipA, (UNSIGNED3)L.z5, (UNSIGNED3)L.zipA);
SELF.zip4 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip4A, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip4A);
SELF.county := CHOOSE(CTR, L.county[3..5], L.countyA[3..5], L.county[3..5], L.countyA[3..5]);
SELF.msa := CHOOSE(CTR, L.msa, L.msaA, L.msa, L.msaA);
SELF.geo_lat := CHOOSE(CTR, L.geo_lat, L.geo_latA, L.geo_lat, L.geo_latA);
SELF.geo_long := CHOOSE(CTR, L.geo_long, L.geo_longA, L.geo_long, L.geo_longA);
SELF.company_name := stringlib.stringtouppercase(L.Name);
self.company_source_group := L.root + '-' + L.sub;
SELF.company_prim_range := CHOOSE(CTR, L.prim_range, L.prim_rangeA, L.prim_rangeA, L.prim_range);
SELF.company_predir := CHOOSE(CTR, L.predir, L.predirA, L.predirA, L.predir);
SELF.company_prim_name := CHOOSE(CTR, L.prim_name, L.prim_nameA, L.prim_nameA, L.prim_name);
SELF.company_addr_suffix := CHOOSE(CTR, L.addr_suffix, L.addr_suffixA, L.addr_suffixA, L.addr_suffix);
SELF.company_postdir := CHOOSE(CTR, L.postdir, L.postdirA, L.postdirA, L.postdir);
SELF.company_unit_desig := CHOOSE(CTR, L.unit_desig, L.unit_desigA, L.unit_desigA, L.unit_desig);
SELF.company_sec_range := CHOOSE(CTR, L.sec_range, L.sec_rangeA, L.sec_rangeA, L.sec_range);
SELF.company_city := CHOOSE(CTR, L.p_city_name, L.p_city_nameA, L.p_city_nameA, L.p_city_name);
SELF.company_state := CHOOSE(CTR, L.st, L.stA, L.stA, L.st);
SELF.company_zip := CHOOSE(CTR, (UNSIGNED3)L.z5, (UNSIGNED3)L.zipA, (UNSIGNED3)L.zipA, (UNSIGNED3)L.z5);
SELF.company_zip4 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip4A, (UNSIGNED2)L.zip4A, (UNSIGNED2)L.zip4);
self.company_phone := (UNSIGNED6)((UNSIGNED8)L.Phone);
self.company_fein := 0;
self.phone := (unsigned6)((unsigned8)L.Phone);
self.email_address := l.E_mail;
SELF.dt_first_seen := (unsigned4)business_header.validatedate(L.Update_Date);
SELF.dt_last_seen := self.dt_first_seen;
self.record_type := 'C';
self := l;
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_dca_norm := NORMALIZE(dca_pub_slim(trim(lname) <> ''), 4, Translate_dca_To_BCF(LEFT, COUNTER));

// Removed extra contacts with blank addresses
from_dca_dist := distribute(from_dca_norm, hash(trim(vendor_id), trim(company_name)));

from_dca_sort := sort(from_dca_dist, vendor_id, company_name,
                     fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
					 local);

from_dca_dedup := dedup(from_dca_sort,
                             left.vendor_id = right.vendor_id and
							 left.company_name = right.company_name and
							 left.fname= right.fname and
							 left.mname = right.mname and
							 left.lname = right.lname and
							 left.name_suffix = right.name_suffix and
							 left.company_title = right.company_title and
							 ((left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range) or
                             (left.zip <> 0 and right.zip = 0)),
							 local);


export DCA_as_Business_Contact := from_dca_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('TEMP::DCA_Contacts_As_BC');