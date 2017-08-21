import Crim_Common, Address;

dfilter := crim.Map_OH_Hancock_Combined(name<>'Name');
d 		:= dfilter(firstName<>'');

Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 		:= '2H'+fSlashedMDYtoCYMD(input.case_filed)+hash(trim(input.name,left,right));
self.vendor				:= '2H';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH HANCOCK CRIM CT';
self.case_number		:= trim(input.case_num,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(input.case_filed,left,right))[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(trim(input.case_filed,left,right)),
							'');
self.pty_nm				:= regexreplace('AKA',input.name,'');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(input.lastname,left,right);
self.orig_fname			:= trim(input.firstname,left,right);     
self.orig_mname			:= trim(input.middlename,left,right);
self.orig_name_suffix	:= trim(input.suffix,left,right);
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
self.dob				:= if(fSlashedMDYtoCYMD(trim(input.dob,left,right))[1..4] between '1900' and '1989',
							fSlashedMDYtoCYMD(trim(input.dob,left,right)),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(regexfind('UNKNOWN|'+'TRANSFER|'+'NONE|'+'ADDRESS UNKNOWN|'+'DECEASED',trim(input.address,left,right),0)='',
							trim(input.address,left,right),
							'');
self.street_address_2	:= '';
self.street_address_3	:= trim(input.city,left,right);
self.street_address_4	:= trim(input.state,left,right);
self.street_address_5	:= if(trim(input.zip,left,right)<>'00000',
							trim(input.zip,left,right),
							'');
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
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

pOHOffend := project(d, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
										offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Hancock_Offender_Clean');

export Map_OH_Hancock_Offender := fOHOffend;