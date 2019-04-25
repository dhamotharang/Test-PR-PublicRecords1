// cert_prop := thor_data400::key::ln_propertyv2::fcra::20170526::search.fid
// prod_prop := thor_data400::key::ln_propertyv2::fcra::20170517::search.fid
// prod_prop := thor_data400::key::ln_propertyv2::fcra::20170502::search.fid


	// property_by_did := choosen(ln_propertyv2.key_property_did()(keyed(searchdid=s_did) and
							// keyed(source_code_2 = 'P')),max_recs);

	layout_fares_search := RECORDOF (ln_propertyv2.key_search_fid());


// KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

//Appeend Linkids to existing key layout
file_search_bld := project(LN_PropertyV2.file_search_building_Bip, {recordof(LN_PropertyV2.file_search_building_Bip),  unsigned8 persistent_record_id := 0}); 
//appends persistent_record_id field as in LN_PropertyV2.file_search_building
append_puid_  := ln_propertyV2.fn_append_puid(file_search_bld);

append_puid := project(append_puid_, {LN_PropertyV2.layout_search_building_orig, BIPV2.IDlayouts.l_xlink_ids, 
string2		ln_party_status,
string6		ln_percentage_ownership,
string2		ln_entity_type,
string8		ln_estate_trust_date,
string1		ln_goverment_type,
integer2	xadl2_weight,
string2 	Addr_ind,
string1 	Best_addr_ind,
unsigned6 addr_tx_id,
string1   best_addr_tx_id,
unsigned8	Location_id,
string1   best_locid});

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
in_file := DISTRIBUTE(append_puid(ln_fares_id <> ''), HASH(ln_fares_id));
d:= in_file(ln_fares_id[1] != 'R');

d patch_deed_dates(d le, ln_propertyv2.File_Deed ri) :=
TRANSFORM
  patch_date := ri.recording_date;
  SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
  SELF := le;
END;
deed_check := JOIN(d(ln_fares_id[2]<>'A'), DISTRIBUTE(ln_propertyv2.File_Deed(ln_fares_id[1] != 'R'),HASH(ln_fares_id)),
                   LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_deed_dates(LEFT,RIGHT),KEEP(1),LOCAL);

d patch_assess_dates(d le, ln_propertyv2.File_Assessment ri) :=
TRANSFORM
  patch_date := IF(ri.recording_date != '', ri.recording_date, ri.sale_date);
  SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
  SELF := le;
END;
assessment_check := JOIN(d(ln_fares_id[2]='A'), DISTRIBUTE(ln_propertyv2.File_Assessment(ln_fares_id[1] != 'R'),HASH(ln_fares_id)), 
                         LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_assess_dates(LEFT,RIGHT),KEEP(1),LOCAL);

all_check := deed_check+assessment_check;

all_check blankField(all_check l):= transform
	self.xadl2_weight := 0;
	self := l;
end;

all_check2 := project(all_check, blankField(left));
IsFCRA := true;
base_file := if(IsFCRA, all_check2, in_file);

Cert_key_name := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::ln_propertyv2::fcra::20170526::search.fid';
Prod1_key_name := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::ln_propertyv2::fcra::20170502::search.fid';
// Prod2_key_name := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::ln_propertyv2::fcra::20170517::search.did';
// key_name := '~' + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::search.fid';
	
lay := RECORD
  string12 ln_fares_id;
  string1 which_orig;
  string1 source_code_2;
  string1 source_code_1;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string1 vendor_source_flag;
  string8 process_date;
  string2 source_code;
  string1 conjunctive_name_seq;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string80 cname;
  string80 nameasis;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
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
  string10 phone_number;
  unsigned6 did;
  unsigned6 bdid;
  string9 app_ssn;
  string9 app_tax_id;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  string2 ln_party_status;
  string6 ln_percentage_ownership;
  string2 ln_entity_type;
  string8 ln_estate_trust_date;
  string1 ln_goverment_type;
  integer2 xadl2_weight;
  string2 addr_ind;
  string1 best_addr_ind;
  unsigned6 addr_tx_id;
  string1 best_addr_tx_id;
  unsigned8 location_id;
  string1 best_locid;
  unsigned8 __internal_fpos__;
 END;	
	
// Cert_return_file := pull(Cert_key_name);
Cert_return_file		:= INDEX(base_file,{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},
											{base_file},
											Cert_key_name);
// prod1_return_file :=pull(Prod1_key_name);
prod1_return_file		:= INDEX(base_file,{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},
											{base_file},
											Prod1_key_name);

lay2 := record
recordof(Cert_return_file);
end;

bdid_in_file := prod1_return_file(bdid <> 0);
output(choosen(bdid_in_file,100),named('bdid_in_file'));


bdid_not_in_file := Cert_return_file(bdid = 0);
output(choosen(bdid_not_in_file,100),named('bdid_not_in_file'));

inq_prod_FCRA_distr := distribute(bdid_in_file, hash64(ln_fares_id));
inq_cert_FCRA_distr := distribute(bdid_not_in_file, hash64(ln_fares_id));


j1 := join(inq_prod_FCRA_distr, inq_cert_FCRA_distr,
					left.ln_fares_id = right.ln_fares_id
					and left.source_code_2 = right.source_code_2
					and left.source_code_1 = right.source_code_1
					and left.dt_first_seen = right.dt_first_seen
					and left.process_date = right.process_date
					and left.dt_last_seen = right.dt_last_seen
					and left.geo_blk	 = right.geo_blk,
						transform({dataset(lay2) res}, self.res := left + right), local);

output(choosen(j1,100),named('j1'));
output(count(j1));