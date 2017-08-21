import Crim_Common, ArrestLogs, Address, ut;

ds	:= ArrestLogs.File_FL_Dade;

LatLongPattern	:= '\\([0-9]+(.*)\\)';

Crim_Common.Layout_In_Court_Offender tDade(ds dInput) := Transform
UpperName					:= ut.CleanSpacesAndUpper(dInput.PA_DEFENDANT);
ClnDOB						:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.pa_dob);
ClnBookDate				:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(dInput.pa_book_date);
self.process_date	:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key	:= 'AT'+hash(UpperName)+ClnDOB+ClnBookDate;
self.vendor				:= 'AT';
self.state_origin	:= 'FL';
self.data_type		:= '5';
self.source_file	:= 'FL-DadeCtyArrest';
self.case_number	:= '';
self.case_court		:= '';
self.case_name		:= '';
self.case_type		:= '';
self.case_type_desc	:= 'Dade County(FL)Arrest';
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
self.dob					:= IF(ClnDOB[1..2] = '19',ClnDOB,'');
self.dob_alias		:= '';
self.place_of_birth		:= '';
RmvLatLong				:= StringLib.StringCleanSpaces(IF(REGEXFIND(LatLongPattern,dInput.pa_addr),REGEXREPLACE(LatLongPattern,dInput.pa_addr,''),
																										ut.CleanSpacesAndUpper(dInput.pa_addr)));
RmvNewLine				:= regexreplace('\n',RmvLatLong,'*');
GetCSZ						:= REGEXFIND('\\*(.*)$',RmvNewLine,1);
ClnStreet					:= REGEXREPLACE(GetCSZ,RmvNewLine,'');
self.street_address_1	:= StringLib.StringFindReplace(ClnStreet,'*','');
self.street_address_2	:= StringLib.StringFindReplace(GetCSZ,'*','');
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race					:= '';
self.race_desc		:= '';
self.sex					:= '';
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

pDade := project(ds, tDade(left));

ArrestLogs.ArrestLogs_clean(pDade,cleanDade);

dd_arrOut:= dedup(sort(distribute(cleanDade,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,local)
										,record,local): 
										PERSIST('~thor_dell400::persist::Arrestlogs_FL_Dade_Offender');

EXPORT map_FL_DadeOffender := dd_arrOut(pty_nm <> '');