import Crim_Common, Address;

p	:= ArrestLogs.file_CA_Placer;

fPlacer := p(trim(p.ID,left,right)<>'ID' and
			   trim(p.Name,left,right)<>'Name' and
			   trim(p.Age,left,right)<>'Age');

Crim_Common.Layout_In_Court_Offender tPlacer(fPlacer input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'A8'+trim(input.jailid,left,right)+fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right)); 
self.vendor				:= 'A8';
self.state_origin		:= 'CA';
self.data_type			:= '5';
self.source_file		:= '(CV)CA-PlacerArrest';
self.case_number		:= regexreplace('PC#',trim(input.Book_Num,left,right),'');//if(input.case_no <> '9999999999', input.case_no, '');//booking number?
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right)) < Crim_Common.Version_In_Arrest_Offender,
							fSlashedMDYtoCYMD(trim(input.book_dt[1..11],left,right)),'');
self.pty_nm				:= trim(input.Name,left,right);
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
self.id_num				:= '';
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= '';
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= input.gender[1];
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= trim(input.custody_Status,left,right);
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

pPlacer := project(fPlacer, tPlacer(left));

ArrestLogs.ArrestLogs_clean(pPlacer,cleanPlacer);

arrOut:= CleanPlacer + ArrestLogs.FileAbinitioOffender(vendor='A8');

dd_arrOut := dedup(sort(distribute(cleanPlacer,hash(offender_key)),
									offender_key,pty_nm,pty_typ,case_filing_dt,source_file,local)
									,offender_key,pty_nm,pty_typ,local,left): 
									PERSIST('~thor_dell400::persist::Arrestlogs_CA_Placer_Offender');

export map_CA_PlacerOffender := dd_arrOut;