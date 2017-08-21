import crim_common, Crim, Address, lib_stringlib,ut;

input := CRIM.File_CA_Orange(CaseNumber <> '');


//////////////////////////////////////////////////////////////////////////////////

Crim_Common.Layout_In_Court_Offender tCA(input l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');
			

self.process_date		:= Crim_Common.Version_Development;


self.vendor				:= '21';
self.state_origin		:= 'CA';
self.data_type			:= '2';
self.source_file		:= 'CA-ORANGE_CTY_CRIM';
self.case_number		:= trim(l.CaseNumber,left,right);
self.case_court 		:= 'Orange County';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt 	:= if(l.OriginatingFilingDate <> ''
							, getReasonableRange(fSlashedMDYtoCYMD(l.OriginatingFilingDate))
							, getReasonableRange(fSlashedMDYtoCYMD(l.currentchargingdocumentfiledate)));
self.pty_nm 			:= regexreplace(' +',l.LastName + ' ' + l.FirstName + ' ' + l.MiddleName, ' ');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= l.LastName ;
self.orig_fname			:= l.FirstName;     
self.orig_mname			:= l.MiddleName;
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
self.dob				:= getReasonableRange(fSlashedMDYtoCYMD(l.DateOfBirth));
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= ''; 
self.street_address_2	:= ''; 
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
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

self.offender_key := self.vendor + hash(self.pty_nm) + self.case_number;

end;

refOffender := project(input, tCA(left));
	

outfile := refoffender;

Crim.Crim_clean(outfile,cleanOffender);

dedOffender := dedup(sort(distribute(cleanOffender,hash(offender_key)),
										offender_key,pty_nm,pty_typ,dob,case_filing_dt,local),
										offender_key,pty_nm,pty_typ,dob,right,local) 
										:PERSIST('~thor_dell400::persist::Crim_CA_Orange_Offender_Clean')
										;

export Map_CA_ORANGE_Offender := dedOffender;