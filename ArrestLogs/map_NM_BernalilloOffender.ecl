import Crim_Common, Address, Gong;

p	:= ArrestLogs.file_NM_Bernalillo;

fBernalillo := p(trim(p.Name,left,right)<>'Name');

Crim_Common.Layout_In_Court_Offender tBernalillo(fBernalillo input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'AF'+trim(input.booking_num,left,right)+input.ID;
self.vendor				:= 'AF';
self.state_origin		:= 'NM';
self.data_type			:= '5';
self.source_file		:= '(CV)NM-BernalilloCtyArr';
self.case_number		:= input.case_num;
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= fSlashedMDYtoCYMD(input.Arrival_Dt);//NEED TO FIX
self.pty_nm				:= input.name;
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= if(input.ID<>'ID',input.ID,'');
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(input.DOB)[1..2] = '19',
						   fSlashedMDYtoCYMD(input.DOB),
						   '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= if(input.race='UNKNOWN','',input.race);
self.sex				:= input.sex[1];
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
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

pBernalillo := project(fBernalillo, tBernalillo(left));

ArrestLogs.ArrestLogs_clean(pBernalillo,cleanBernalillo);

arrOut:= cleanBernalillo + ArrestLogs.FileAbinitioOffender(vendor='AF');
/*
dd_arrOut :=  dedup(sort(distribute(arrOut,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left)
										: PERSIST('~thor_dell400::persist::Arrestlogs_NM_Bernalillo_Offender_clean');
*/
dd_arrOut :=  dedup(sort(distribute(arrOut,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
										,offender_key,pty_nm,pty_typ,local,left)
										: PERSIST('~thor_dell400::persist::Arrestlogs_NM_Bernalillo_Offender_clean');
export map_NM_BernalilloOffender :=  dd_arrOut;