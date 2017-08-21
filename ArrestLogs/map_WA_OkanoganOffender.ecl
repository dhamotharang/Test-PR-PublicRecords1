import Crim_Common, ArrestLogs, Address, ut, hygenics_crim,STD;

ds	:= ArrestLogs.File_WA_Okanogan.raw_out;

	fmtsin := '%m/%d/%y';
	fmtout := '%Y%m%d';

Crim_Common.Layout_In_Court_Offender tOkanogan(ds dInput) := TRANSFORM
UpperName					:= REGEXREPLACE('^[^A-Z]|"',ut.CleanSpacesAndUpper(dInput.lfm_name),'');
bookdate_temp     := REGEXREPLACE('"',STD.Date.ConvertDateFormat(dInput.booking_date, fmtsin, fmtout),'');
ClnBookDate				:= if( bookdate_temp <> '-11130',bookdate_temp, '');
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'A7'+ClnBookDate+hash(UpperName);
self.vendor				:= 'A7';
self.state_origin	:= 'WA';
self.data_type		:= '5';
self.source_file	:= 'WA-OkanoganCtyArrest';
self.case_number	:= '';
self.case_court		:= '';
self.case_name		:= '';
self.case_type		:= '';
self.case_type_desc	:= 'OkanoganCounty(WA)Arrest';
self.case_filing_dt	:= '';
self.pty_nm				:= UpperName;
self.pty_nm_fmt		:= 'L';
self.orig_lname		:= '';
self.orig_fname		:= '';
self.orig_mname		:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag		:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship	:= '';
self.dob					:= '';
self.dob_alias		:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race					:= REGEXREPLACE('"',ut.CleanSpacesAndUpper(dInput.race),'');
self.race_desc		:= hygenics_crim._functions.fn_standarddize_race(self.race);
self.sex					:= REGEXREPLACE('"',ut.CleanSpacesAndUpper(dInput.SEX),'');
self.hair_color		:= '';
self.hair_color_desc	:= '';
self.eye_color		:= '';
self.eye_color_desc		:= '';
self.skin_color		:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status	:= '';
self.party_status_desc	:= '';
self.prim_range 	:= ''; 
self.predir 			:= '';					   
self.prim_name 		:= '';
self.addr_suffix 	:= '';
self.postdir 			:= '';
self.unit_desig 	:= '';
self.sec_range 		:= '';
self.p_city_name 	:= '';
self.v_city_name 	:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 	:= '';
self.lot 					:= '';
self.lot_order 		:= '';
self.dpbc 				:= '';
self.chk_digit 		:= '';
self.rec_type 		:= '';
self.ace_fips_st	:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 		:= '';
self.msa 					:= '';
self.geo_blk 			:= '';
self.geo_match 		:= '';
self.err_stat 		:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 	:= '';
self.cleaning_score := ''; 
end;

pOkanogan := project(ds, tOkanogan(left));

ArrestLogs.ArrestLogs_clean(pOkanogan,clnOkanogan);

dd_arrOut:= dedup(sort(distribute(clnOkanogan,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,local)
										,record,local): 
										PERSIST('~thor_dell400::persist::Arrestlogs_WA_Okanogan_Offender');

EXPORT map_WA_OkanoganOffender := dd_arrOut(trim(pty_nm,all)<> '');