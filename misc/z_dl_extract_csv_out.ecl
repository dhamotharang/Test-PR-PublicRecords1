import drivers;

//in_file := sample(drivers.File_Dl,1000,1);

in_file := drivers.File_Dl;

d := in_file;

stat_rec := record
d.source_code;
d.orig_state;
total_records 	:= count(group);
end;
stats := table(d,stat_rec,d.source_code,d.orig_state,few);

output(sort(stats,orig_state,source_code));

extract_Layout_DL := record
//string12                     did:= 0 ;
//string12                     Preglb_did:= 0 ;
string                     	dt_first_seen;
string                    		 dt_last_seen;
string                     	dt_vendor_first_reported;
string                     	 dt_vendor_last_reported;
string                       orig_state;
string						  source_code	:=	'AD';
string                       history :='';
string                      name;
string                      addr1;  // chgd, 30 to 40, 20030325,New Mexico, TK
string                      city;
string                       state;
string                       zip;
string                      dob;
string                       race := '';
string                       sex_flag := '';
string                      license_type;	  // chgd, 2 to 4, 20030514, Wisconsin, TK
string                      attention_flag := '';
string                       dod := '';
string                       restrictions := '';
string						restrictions_delimited := '';
string                      orig_expiration_date := '';
string                      orig_issue_date := '';
string                      lic_issue_date := '';
string               	   expiration_date := '';
string                      active_date := '';
string                      inactive_date := '';
string                       lic_endorsement := '';
string                       motorcycle_code := '';
string                      dl_number;  // chgd, 13 to 14, 20030325,New Mexico, TK
//string9                       ssn := '';
//string9                       ssn_safe := '';
string                       age := '';
string						  privacy_flag := '';
string					      driver_edu_code := '';
string                       dup_lic_count:= '';
string                       rcd_stat_flag:= '';
string                       height := '';
string					  hair_color:= '';
string					  eye_color:= '';
string					  weight := '';
string                      oos_previous_dl_number := '';
string                       oos_previous_st := '';
string                       title;
string                      fname;
string                      mname;
string                      lname;
string                      name_suffix;
string                       cleaning_score;
//string1                       addr_fix_flag := '';
//string10                      prim_range;
//string2                       predir;
//string28                      prim_name;
//string4                       suffix;
//string2                       postdir;
//string10                      unit_desig;
//string8                       sec_range;
//string25                      p_city_name;
//string25                      v_city_name;
//string2                       st;
//string5                       zip5;
//string4                       zip4;
//string4                       cart;
//string1                       cr_sort_sz;
//string4                       lot;
//string1                       lot_order;
//string2                       dpbc := '';
//string1                       chk_digit;
//string2                       rec_type;
//string2                       ace_fips_st := '';
//string3                       county;
//string10                      geo_lat;
//string11                      geo_long;
//string4                       msa := '';
//string7                       geo_blk;
//string1                       geo_match;
//string4                       err_stat;
string                status := '';
string                issuance;
string                address_change := '';
string                name_change := '';
string                dob_change := '';
string                sex_change := '';
string               old_dl_number := ''; // chgd, 13 to 14, 20030325,New Mexico, TK
string				   dl_key_number:= '';
end;

extract_layout_dl in_to_extract(in_file l) := transform
self.dt_first_seen := if(l.dt_first_seen<>0,(string)l.dt_first_seen,'');
self.dt_last_seen := if(l.dt_last_seen<>0,(string)l.dt_last_seen,'');
self.dt_vendor_first_reported := if(l.dt_vendor_first_reported<>0,(string)l.dt_vendor_first_reported,'');
self.dt_vendor_last_reported := if(l.dt_vendor_last_reported<>0,(string)l.dt_vendor_last_reported,'');
self.dob := if(l.dob<>0,(string)l.dob,'');
self.orig_expiration_date := if(l.orig_expiration_date<>0,(string)l.orig_expiration_date,'');
self.orig_issue_date := if(l.orig_issue_date<>0,(string)l.orig_issue_date,'');
self.lic_issue_date := if(l.lic_issue_date<>0,(string)l.lic_issue_date,'');
self.expiration_date := if(l.expiration_date<>0,(string)l.expiration_date,'');
self.active_date := if(l.active_date<>0,(string)l.active_date,'');
self.inactive_date := if(l.inactive_date<>0,(string)l.inactive_date,'');
self := l;
end;

extract_ds_all := project(in_file, in_to_extract(left));


// temp version for small excel spreadsheets follows

co:=(choosen(sample(extract_ds_all(orig_state='CO'),862,1),10000));
ct:=(choosen(sample(extract_ds_all(orig_state='CT'),590,1),10000));
de:=(choosen(sample(extract_ds_all(orig_state='DE'),110,1),10000));
fl:=(choosen(sample(extract_ds_all(orig_state='FL'),9800,1),10000));
id:=(choosen(sample(extract_ds_all(orig_state='ID'),520,1),10000));
il:=(choosen(sample(extract_ds_all(orig_state='IL'),2519,1),10000));
ky:=(choosen(sample(extract_ds_all(orig_state='KY'),1400,1),10000));
la:=(choosen(sample(extract_ds_all(orig_state='LA'),664,1),10000));
ma:=(choosen(sample(extract_ds_all(orig_state='MA'),1860,1),10000));
md:=(choosen(sample(extract_ds_all(orig_state='MD'),760,1),10000));
me:=(choosen(sample(extract_ds_all(orig_state='ME'),486,1),10000));
mi:=(choosen(sample(extract_ds_all(orig_state='MI'),3504,1),10000));
mn:=(choosen(sample(extract_ds_all(orig_state='MN'),2520,1),10000));
mo:=(choosen(sample(extract_ds_all(orig_state='MO'),4745,1),10000));
ms:=(choosen(sample(extract_ds_all(orig_state='MS'),425,1),10000));
nd:=(choosen(sample(extract_ds_all(orig_state='ND'),101,1),10000));
nh:=(choosen(sample(extract_ds_all(orig_state='NH'),190,1),10000));
nm:=(choosen(sample(extract_ds_all(orig_state='NM'),970,1),10000));
oh:=(choosen(sample(extract_ds_all(orig_state='OH'),5600,1),10000));
sc:=(choosen(sample(extract_ds_all(orig_state='SC'),795,1),10000));
tn:=(choosen(sample(extract_ds_all(orig_state='TN'),3770,1),10000));
tx:=(choosen(sample(extract_ds_all(orig_state='TX'),7430,1),10000));
wi:=(choosen(sample(extract_ds_all(orig_state='WI'),1575,1),10000));
wv:=(choosen(sample(extract_ds_all(orig_state='WV'),1050,1),10000));
wy:=(choosen(sample(extract_ds_all(orig_state='WY'),125,1),10000));

output(co,,'~thor_200::misc::dl_extract_co_20060913',csv(separator('|')),overwrite);
output(ct,,'~thor_200::misc::dl_extract_ct_20060913',csv(separator('|')),overwrite);
output(de,,'~thor_200::misc::dl_extract_de_20060913',csv(separator('|')),overwrite);
output(fl,,'~thor_200::misc::dl_extract_fl_20060913',csv(separator('|')),overwrite);
output(id,,'~thor_200::misc::dl_extract_id_20060913',csv(separator('|')),overwrite);
output(il,,'~thor_200::misc::dl_extract_il_20060913',csv(separator('|')),overwrite);
output(ky,,'~thor_200::misc::dl_extract_ky_20060913',csv(separator('|')),overwrite);
output(la,,'~thor_200::misc::dl_extract_la_20060913',csv(separator('|')),overwrite);
output(ma,,'~thor_200::misc::dl_extract_ma_20060913',csv(separator('|')),overwrite);
output(md,,'~thor_200::misc::dl_extract_md_20060913',csv(separator('|')),overwrite);
output(me,,'~thor_200::misc::dl_extract_me_20060913',csv(separator('|')),overwrite);
output(mi,,'~thor_200::misc::dl_extract_mi_20060913',csv(separator('|')),overwrite);
output(mn,,'~thor_200::misc::dl_extract_mn_20060913',csv(separator('|')),overwrite);
output(mo,,'~thor_200::misc::dl_extract_mo_20060913',csv(separator('|')),overwrite);
output(ms,,'~thor_200::misc::dl_extract_ms_20060913',csv(separator('|')),overwrite);
output(nd,,'~thor_200::misc::dl_extract_nd_20060913',csv(separator('|')),overwrite);
output(nh,,'~thor_200::misc::dl_extract_nh_20060913',csv(separator('|')),overwrite);
output(nm,,'~thor_200::misc::dl_extract_nm_20060913',csv(separator('|')),overwrite);
output(oh,,'~thor_200::misc::dl_extract_oh_20060913',csv(separator('|')),overwrite);
output(sc,,'~thor_200::misc::dl_extract_sc_20060913',csv(separator('|')),overwrite);
output(tn,,'~thor_200::misc::dl_extract_tn_20060913',csv(separator('|')),overwrite);
output(tx,,'~thor_200::misc::dl_extract_tx_20060913',csv(separator('|')),overwrite);
output(wi,,'~thor_200::misc::dl_extract_wi_20060913',csv(separator('|')),overwrite);
output(wv,,'~thor_200::misc::dl_extract_wv_20060913',csv(separator('|')),overwrite);
output(wy,,'~thor_200::misc::dl_extract_wy_20060913',csv(separator('|')),overwrite);





