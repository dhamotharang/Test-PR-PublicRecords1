import	_control, PRTE_CSV;

export Proc_Build_DL2_Keys(string pIndexVersion) := function
	
	
	rKeyDL2__wildcard	:=
	record
		PRTE_CSV.DL2.rthor_data400__data__DL2__wildcard;
	end;
	
	rKeyDL2__accident_dlcp_key	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__accident_dlcp_key;
	end;
	
	rKeyDL2__autokey__address	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__address;
	end;

	rKeyDL2__autokey__citystname	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__citystname;
	end;

	rKeyDL2__autokey__name	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__name;
	end;

	rKeyDL2__autokey__payload	:=
	RECORD
  unsigned6 fakeid;
  unsigned6 dl_seq;
  unsigned6 did;
  unsigned6 preglb_did;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string14 dlcp_key;
  string2 orig_state;
  string2 source_code;
  string1 history;
  qstring52 name;
  string1 addr_type;
  qstring40 addr1;
  qstring20 city;
  qstring2 state;
  qstring5 zip;
  string2 province;
  string3 country;
  string10 postal_code;
  unsigned4 dob;
  string1 race;
  string1 sex_flag;
  string6 license_class;
  qstring4 license_type;
  qstring4 moxie_license_type;
  qstring14 attention_flag;
  qstring8 dod;
  qstring42 restrictions;
  qstring42 restrictions_delimited;
  unsigned4 orig_expiration_date;
  unsigned4 orig_issue_date;
  unsigned4 lic_issue_date;
  unsigned4 expiration_date;
  unsigned3 active_date;
  unsigned3 inactive_date;
  qstring10 lic_endorsement;
  qstring4 motorcycle_code;
  qstring24 dl_number;
  qstring9 ssn;
  qstring9 ssn_safe;
  qstring3 age;
  string1 privacy_flag;
  string1 driver_edu_code;
  string1 dup_lic_count;
  string1 rcd_stat_flag;
  qstring3 height;
  qstring3 hair_color;
  qstring3 eye_color;
  qstring3 weight;
  qstring25 oos_previous_dl_number;
  string2 oos_previous_st;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring3 cleaning_score;
  string1 addr_fix_flag;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  qstring2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  qstring3 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  string3 status;
  qstring2 issuance;
  qstring8 address_change;
  string1 name_change;
  string1 dob_change;
  string1 sex_change;
  qstring24 old_dl_number;
  qstring9 dl_key_number;
  string3 cdl_status;
  string1 record_type;
  unsigned1 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
 END;

	
	rKeyDL2__autokey__ssn2	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__ssn2;
	end;
	
	rKeyDL2__autokey__stname	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__stname;
	end;
	
	rKeyDL2__autokey__uberrefs	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__uberrefs;
	end;	
	
	rKeyDL2__autokey__uberwords	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__uberwords;
	end;	
	
	rKeyDL2__autokey__zip	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__zip;
	end;	
	
	rKeyDL2__indicatives__public	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__dl2__indicatives_public;
	end;	
	
	rKeyDL2__conviction_dlcp_key   :=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__conviction_dlcp_key;
	end;	
	
	rKeyDL2__did_public	:=
RECORD
  unsigned6 did;
  unsigned6 dl_seq;
  unsigned6 preglb_did;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string14 dlcp_key;
  string2 orig_state;
  string2 source_code;
  string1 history;
  qstring52 name;
  string1 addr_type;
  qstring40 addr1;
  qstring20 city;
  qstring2 state;
  qstring5 zip;
  string2 province;
  string3 country;
  string10 postal_code;
  unsigned4 dob;
  string1 race;
  string1 sex_flag;
  string6 license_class;
  qstring4 license_type;
  qstring4 moxie_license_type;
  qstring14 attention_flag;
  qstring8 dod;
  qstring42 restrictions;
  qstring42 restrictions_delimited;
  unsigned4 orig_expiration_date;
  unsigned4 orig_issue_date;
  unsigned4 lic_issue_date;
  unsigned4 expiration_date;
  unsigned3 active_date;
  unsigned3 inactive_date;
  qstring10 lic_endorsement;
  qstring4 motorcycle_code;
  qstring24 dl_number;
  qstring9 ssn;
  qstring9 ssn_safe;
  qstring3 age;
  string1 privacy_flag;
  string1 driver_edu_code;
  string1 dup_lic_count;
  string1 rcd_stat_flag;
  qstring3 height;
  qstring3 hair_color;
  qstring3 eye_color;
  qstring3 weight;
  qstring25 oos_previous_dl_number;
  string2 oos_previous_st;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring3 cleaning_score;
  string1 addr_fix_flag;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  qstring2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  qstring3 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  string3 status;
  qstring2 issuance;
  qstring8 address_change;
  string1 name_change;
  string1 dob_change;
  string1 sex_change;
  qstring24 old_dl_number;
  qstring9 dl_key_number;
  string3 cdl_status;
  string1 record_type;
  string18 county_name;
  string30 history_name;
  string30 attention_name;
  string30 race_name;
  string30 sex_name;
  string30 hair_color_name;
  string30 eye_color_name;
  string30 orig_state_name;
  unsigned8 __internal_fpos__;
 END;


	rKeyDL2__dl_number_public	:=
	RECORD
  qstring24 s_dl;
  unsigned6 dl_seq;
  unsigned6 did;
  unsigned6 preglb_did;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string14 dlcp_key;
  string2 orig_state;
  string2 source_code;
  string1 history;
  qstring52 name;
  string1 addr_type;
  qstring40 addr1;
  qstring20 city;
  qstring2 state;
  qstring5 zip;
  string2 province;
  string3 country;
  string10 postal_code;
  unsigned4 dob;
  string1 race;
  string1 sex_flag;
  string6 license_class;
  qstring4 license_type;
  qstring4 moxie_license_type;
  qstring14 attention_flag;
  qstring8 dod;
  qstring42 restrictions;
  qstring42 restrictions_delimited;
  unsigned4 orig_expiration_date;
  unsigned4 orig_issue_date;
  unsigned4 lic_issue_date;
  unsigned4 expiration_date;
  unsigned3 active_date;
  unsigned3 inactive_date;
  qstring10 lic_endorsement;
  qstring4 motorcycle_code;
  qstring24 dl_number;
  qstring9 ssn;
  qstring9 ssn_safe;
  qstring3 age;
  string1 privacy_flag;
  string1 driver_edu_code;
  string1 dup_lic_count;
  string1 rcd_stat_flag;
  qstring3 height;
  qstring3 hair_color;
  qstring3 eye_color;
  qstring3 weight;
  qstring25 oos_previous_dl_number;
  string2 oos_previous_st;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring3 cleaning_score;
  string1 addr_fix_flag;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  qstring2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  qstring3 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  string3 status;
  qstring2 issuance;
  qstring8 address_change;
  string1 name_change;
  string1 dob_change;
  string1 sex_change;
  qstring24 old_dl_number;
  qstring9 dl_key_number;
  string3 cdl_status;
  string1 record_type;
  string18 county_name;
  string30 history_name;
  string30 attention_name;
  string30 race_name;
  string30 sex_name;
  string30 hair_color_name;
  string30 eye_color_name;
  string30 orig_state_name;
  unsigned8 __internal_fpos__;
 END;
		
	rKeyDL2__dl_seq	:=
	RECORD
  unsigned6 dl_seq;
  unsigned6 did;
  unsigned6 preglb_did;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string14 dlcp_key;
  string2 orig_state;
  string2 source_code;
  string1 history;
  qstring52 name;
  string1 addr_type;
  qstring40 addr1;
  qstring20 city;
  qstring2 state;
  qstring5 zip;
  string2 province;
  string3 country;
  string10 postal_code;
  unsigned4 dob;
  string1 race;
  string1 sex_flag;
  string6 license_class;
  qstring4 license_type;
  qstring4 moxie_license_type;
  qstring14 attention_flag;
  qstring8 dod;
  qstring42 restrictions;
  qstring42 restrictions_delimited;
  unsigned4 orig_expiration_date;
  unsigned4 orig_issue_date;
  unsigned4 lic_issue_date;
  unsigned4 expiration_date;
  unsigned3 active_date;
  unsigned3 inactive_date;
  qstring10 lic_endorsement;
  qstring4 motorcycle_code;
  qstring24 dl_number;
  qstring9 ssn;
  qstring9 ssn_safe;
  qstring3 age;
  string1 privacy_flag;
  string1 driver_edu_code;
  string1 dup_lic_count;
  string1 rcd_stat_flag;
  qstring3 height;
  qstring3 hair_color;
  qstring3 eye_color;
  qstring3 weight;
  qstring25 oos_previous_dl_number;
  string2 oos_previous_st;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring3 cleaning_score;
  string1 addr_fix_flag;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  qstring2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  qstring3 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  string3 status;
  qstring2 issuance;
  qstring8 address_change;
  string1 name_change;
  string1 dob_change;
  string1 sex_change;
  qstring24 old_dl_number;
  qstring9 dl_key_number;
  string3 cdl_status;
  string1 record_type;
  unsigned8 __internal_fpos__;
 END;
				
	rKeyDL2__dr_info_dlcp_key	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__dr_info_dlcp_key;
	end;		
		
	rKeyDL2__fra_insur_dlcp_key	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__fra_insur_dlcp_key;
	end;		
	
	rKeyDL2__suspension_dlcp_key	:=
	record
		PRTE_CSV.DL2.rthor_data400__key__DL2__suspension_dlcp_key;
	end;			

	dDataDL2__wildcard								:= 	project(PRTE_CSV.DL2.dthor_data400__data__DL2__wildcard, rKeyDL2__wildcard);
	dKeyDL2__accident_dlcp_key				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__accident_dlcp_key, rKeyDL2__accident_dlcp_key);
	dKeyDL2__autokey__address				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__address, rKeyDL2__autokey__address);	
	dKeyDL2__autokey__citystname			:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__citystname, rKeyDL2__autokey__citystname);
	dKeyDL2__autokey__name					:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__name, rKeyDL2__autokey__name);
	rKeyDL2__autokey__payload trans__autokey_payload(PRTE_CSV.DL2.rthor_data400__key__DL2__autokey__payload l):=transform
	self :=l;	
	end;
	
	tKeyDL2__autokey__payload				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__payload,trans__autokey_payload(left) );		
	dKeyDL2__autokey__ssn2  				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__ssn2, rKeyDL2__autokey__ssn2);
	dKeyDL2__autokey__stname				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__stname, rKeyDL2__autokey__stname);
	dKeyDL2__autokey__uberrefs			:= 	project(PRTE_CSV.DL2.dthor_data400__key__dl2__autokey__uberrefs, rKeyDL2__autokey__uberrefs);
	dKeyDL2__autokey__uberwords			:= 	project(PRTE_CSV.DL2.dthor_data400__key__dl2__autokey__uberwords, rKeyDL2__autokey__uberwords);

	dKeyDL2__autokey__zip					:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__autokey__zip, rKeyDL2__autokey__zip);
	dKeyDL2__conviction_dlcp_key			:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__conviction_dlcp_key, rKeyDL2__conviction_dlcp_key);
	dKeyDL2__indicatives_public      	:= 	project(PRTE_CSV.DL2.dthor_data400__key__dl2__indicatives_public, rKeyDL2__indicatives__public);	

	rKeyDL2__did_public	trans__public(PRTE_CSV.DL2.rthor_data400__key__DL2__did_public  l):=transform
			self							:=l;
	end;
	
	tKeyDL2__did_public						:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__did_public, trans__public(left));	
	rKeyDL2__dl_number_public trans__dl_number_public(PRTE_CSV.DL2.rthor_data400__key__DL2__dl_number_public l):=transform
	self:=l;
	end;
	tKeyDL2__dl_number_public            	:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__dl_number_public, trans__dl_number_public(left));	
	
	rKeyDL2__dl_seq 	Trans__dl_seq(PRTE_CSV.DL2.rthor_data400__key__DL2__dl_seq		l):=transform
		self	:=l;
	end;
	
	tKeyDL2__dl_seq           				:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__dl_seq, Trans__dl_seq(left));	

	dKeyDL2__dr_info_dlcp_key            	:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__dr_info_dlcp_key, rKeyDL2__dr_info_dlcp_key);	
	dKeyDL2__fra_insur_dlcp_key            	:= 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__fra_insur_dlcp_key, rKeyDL2__fra_insur_dlcp_key);	
	dKeyDL2__suspension_dlcp_key            := 	project(PRTE_CSV.DL2.dthor_data400__key__DL2__suspension_dlcp_key, rKeyDL2__suspension_dlcp_key);	
	
	kKeyDL2__accident_dlcp_key				:=	index(dKeyDL2__accident_dlcp_key, {dlcp_key}, {dKeyDL2__accident_dlcp_key}, '~prte::key::DL2::' + pIndexVersion + '::accident_dlcp_key');
	kKeyDL2__autokey__address				:=	index(dKeyDL2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyDL2__autokey__address}, '~prte::key::DL2::' + pIndexVersion + '::autokey::address');	
	kKeyDL2__autokey__citystname			:=	index(dKeyDL2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDL2__autokey__citystname}, '~prte::key::DL2::' + pIndexVersion + '::autokey::citystname');
	kKeyDL2__autokey__name					:=	index(dKeyDL2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDL2__autokey__name}, '~prte::key::DL2::' + pIndexVersion + '::autokey::name');	
	kKeyDL2__autokey__payload				:=	index(tKeyDL2__autokey__payload, {fakeid}, {tKeyDL2__autokey__payload}, '~prte::key::DL2::' + pIndexVersion + '::autokey::payload');	
	kKeyDL2__autokey__ssn2					:=	index(dKeyDL2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyDL2__autokey__ssn2}, '~prte::key::DL2::' + pIndexVersion + '::autokey::ssn2');
	kKeyDL2__autokey__stname				:=	index(dKeyDL2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDL2__autokey__stname}, '~prte::key::DL2::' + pIndexVersion + '::autokey::stname');	
  kKeyDL2__autokey__uberrefs			:=	index(dKeyDL2__autokey__uberrefs, {word_id,field,uid}, {dKeyDL2__autokey__uberrefs}, '~prte::key::DL2::' + pIndexVersion + '::autokey::uberrefs');
	kKeyDL2__autokey__uberwords			:=	index(dKeyDL2__autokey__uberwords, {word}, {dKeyDL2__autokey__uberwords}, '~prte::key::DL2::' + pIndexVersion + '::autokey::uberwords');
	kKeyDL2__autokey__zip					:=	index(dKeyDL2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDL2__autokey__zip}, '~prte::key::DL2::' + pIndexVersion + '::autokey::zip');
	kKeyDL2__indicatives_public			:=	index(dKeyDL2__indicatives_public, {race,sex_flag,age,orig_state,randomizer}, {dKeyDL2__indicatives_public}, '~prte::key::DL2::' + pIndexVersion + '::indicatives_public');
	kKeyDL2__conviction_dlcp_key			:=	index(dKeyDL2__conviction_dlcp_key, {dlcp_key}, {dKeyDL2__conviction_dlcp_key}, '~prte::key::DL2::' + pIndexVersion + '::conviction_dlcp_key');
	kKeyDL2__did_public						:=	index(tKeyDL2__did_public, {did}, {tKeyDL2__did_public}, '~prte::key::DL2::' + pIndexVersion + '::did_public');
	kKeyDL2__dl_number_public				:=	index(tKeyDL2__dl_number_public, {s_dl}, {tKeyDL2__dl_number_public}, '~prte::key::DL2::' + pIndexVersion + '::dl_number_public');
	kKeyDL2__dl_seq							:=	index(tKeyDL2__dl_seq, {dl_seq}, {tKeyDL2__dl_seq}, '~prte::key::DL2::' + pIndexVersion + '::dl_seq');
	kKeyDL2__dr_info_dlcp_key				:=	index(dKeyDL2__dr_info_dlcp_key, {dlcp_key}, {dKeyDL2__dr_info_dlcp_key}, '~prte::key::DL2::' + pIndexVersion + '::dr_info_dlcp_key');
	kKeyDL2__fra_insur_dlcp_key				:=	index(dKeyDL2__fra_insur_dlcp_key, {dlcp_key}, {dKeyDL2__fra_insur_dlcp_key}, '~prte::key::DL2::' + pIndexVersion + '::fra_insur_dlcp_key');
	kKeyDL2__suspension_dlcp_key			:=	index(dKeyDL2__suspension_dlcp_key, {dlcp_key}, {dKeyDL2__suspension_dlcp_key}, '~prte::key::DL2::' + pIndexVersion + '::suspension_dlcp_key');	


	return	sequential(
											parallel(		                               														
																output(dDataDL2__wildcard,,'~prte::data::DL2::' + pIndexVersion + '::wildcard', overwrite),																	
																build(kKeyDL2__accident_dlcp_key			, update),
																build(kKeyDL2__autokey__address			, update),																
																build(kKeyDL2__autokey__citystname	, update),																
																build(kKeyDL2__autokey__name				, update),																
																build(kKeyDL2__autokey__payload			, update),																																																
																build(kKeyDL2__autokey__ssn2			, update),
																build(kKeyDL2__autokey__stname			, update),																
 																build(kKeyDL2__autokey__uberrefs			, update),																
																build(kKeyDL2__autokey__uberwords			, update),																
																build(kKeyDL2__autokey__zip					, update),																
																build(kKeyDL2__conviction_dlcp_key				    	, update),
																build(kKeyDL2__indicatives_public				    	, update),
																build(kKeyDL2__did_public						    	, update),
																build(kKeyDL2__dl_number_public						    	, update),
																build(kKeyDL2__dl_seq						    	, update),
																build(kKeyDL2__dr_info_dlcp_key						    	, update),
																build(kKeyDL2__fra_insur_dlcp_key						    	, update),																
																build(kKeyDL2__suspension_dlcp_key				    	, update)																																															
															 ),
											PRTE.UpdateVersion('DLV2Keys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
