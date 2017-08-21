import crim_common, Crim, Address;


Crim_Common.Layout_In_Court_Offender tOHOffend(crim.Layout_OH_Franklin l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key 		:= '2P'+l.id;
self.vendor				:= '2P';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH Franklin CRIM';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= l.title;
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(l.datefiled,left,right)) between '19010101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(trim(l.datefiled,left,right)),
							'');
self.pty_nm				:= l.name;
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= l.lastname;
self.orig_fname			:= l.firstname;
self.orig_mname			:= l.middlename;
self.orig_name_suffix	:= l.suffix;
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= l.id;
self.dl_num				:= '';
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(trim(l.dateofbirth,left,right)) between '19010102' and (string)((integer)Crim_Common.Version_Development - 16),fSlashedMDYtoCYMD(trim(l.dateofbirth,left,right)), '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(length(l.defendant_address) > 10, l.defendant_address, '');
self.street_address_2	:= if(regexfind('[0-9]', l.defendant_city), '', l.defendant_city);
self.street_address_3	:= if(length(l.defendant_state) = 2 and l.defendant_state <> 'ZZ', trim(l.defendant_state, all), '');
self.street_address_4	:= if(regexfind('[1-9]', l.defendant_zip), l.defendant_zip, '');
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= l.gender;
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

pOHOffend := project(crim.File_OH_Franklin(name <> ''and name <> 'Name'), tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend(case_number <>''),hash(offender_key)),
										offender_key,pty_nm,pty_typ,pty_nm_fmt,dob,street_address_1,local),
										offender_key,dob,street_address_1,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Franklin_Offender_Clean');

export Map_OH_Franklin_Offender := fOHOffend;
