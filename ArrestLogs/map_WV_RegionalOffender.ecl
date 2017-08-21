import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_WV_Regional;

fRegional := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tRegional(fRegional input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'E3'+trim(input.id,all)+fSlashedMDYtoCYMD(input.Book_Dt);
self.vendor				:= 'E3';//NEED TO UPDATE
self.state_origin		:= 'WV';
self.data_type			:= '5';
self.source_file		:= '(CV)WV-RegionalArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((fSlashedMDYtoCYMD(input.Book_Dt) < Crim_Common.Version_In_Arrest_Offender) and fSlashedMDYtoCYMD(input.Book_Dt) <>'00000000', 
							  fSlashedMDYtoCYMD(input.Book_Dt),
							  '');
self.pty_nm				:= trim(input.name,left,right);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(input.lastname,left,right);
self.orig_fname			:= trim(input.firstname,left,right);
self.orig_mname			:= trim(input.middlename,left,right);
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(input.birth_dt)[1..4] between '1916' and '1989',
						   fSlashedMDYtoCYMD(input.birth_dt),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= if(input.gender[1] in ['F','M'],
							input.gender[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',input.height,'')[1]*12+(integer)regexreplace('\'|'+'\"',input.height,'')[3..4]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',input.height,'')[1]*12+(integer)regexreplace('\'|'+'\"',input.height,'')[3..4]),
							'');
self.weight				:= regexreplace('lbs.',
							trim(input.weight,left,right),
							'');
self.party_status		:= '';
self.party_status_desc	:= input.imprison_status+'-'+input.facility+'-Release Dt Unknown';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 
end;

pRegional := project(fRegional, tRegional(left));

ArrestLogs.ArrestLogs_clean(pRegional,cleanRegional);

//arrOut:= cleanRegional + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanRegional,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_WV_Regional_Offender');

export Map_WV_RegionalOffender := dd_arrOut;