import Crim_Common, ArrestLogs, Address, ut, hygenics_crim;

ds	:= ArrestLogs.File_CA_SantaMonica.raw;

	fmtsin := '%m/%d/%Y';
	fmtout := '%Y%m%d';
	
//filter header/footer records
f_ds	:= ds(REGEXFIND('^[0-9]',booking_date));

Crim_Common.Layout_In_Court_Offender tSantaMonica(f_ds dInput) := TRANSFORM
ClnBookDate				:= ut.ConvertDate(trim(dInput.booking_date,all));
ClnBookNum				:= REGEXREPLACE('-',trim(dInput.booking_number,all),'');
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'A3'+ClnBookNum;
self.vendor				:= 'A3';
self.state_origin	:= 'CA';
self.data_type		:= '5';
self.source_file	:= 'CA-SantaMonicaCtyArr';
self.case_number	:= '';
self.case_court		:= '';
self.case_name		:= '';
self.case_type		:= '';
self.case_type_desc	:= 'SantaMonicaCty(CA)Arrest';
self.case_filing_dt	:= '';
ClnFName					:= ut.CleanSpacesAndUpper(dInput.first_name);
ClnLName					:= ut.CleanSpacesAndUpper(dInput.last_name);
self.pty_nm				:= StringLib.StringCleanSpaces(ClnFName+' '+ClnLName);
self.pty_nm_fmt		:= 'F';
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
self.race					:= ut.CleanSpacesAndUpper(dInput.race);
self.race_desc		:= hygenics_crim._functions.fn_standarddize_race(self.race);
self.sex					:= ut.CleanSpacesAndUpper(dInput.gender);
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

pSantaMonica := project(f_ds, tSantaMonica(left));

ArrestLogs.ArrestLogs_clean(pSantaMonica,clnSantaMonica);

dd_arrOut:= dedup(sort(distribute(clnSantaMonica,hash(offender_key)),
										offender_key,pty_nm,case_number,case_filing_dt,local)
										,record,local): 
										PERSIST('~thor_dell400::persist::Arrestlogs_CA_SantaMonica_Offender');

EXPORT map_CA_SantaMonicaOffender := dd_arrOut(trim(pty_nm,all)<>'');