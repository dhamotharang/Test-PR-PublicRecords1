import crim_common, Crim, Address;

input := crim.File_OH_Wayne(partiestype = 'DEFENDANT' and Charge_Decision <> 'Charge_Decision');

input NormIt(input L, INTEGER C) := TRANSFORM
SELF.name := CHOOSE(C, L.name, L.alias);
SELF.Officer := CHOOSE(C, '0', '2');
SELF := L;

END;

infile := NORMALIZE(input,2,NormIt(LEFT,COUNTER));

Crim_Common.Layout_In_Court_Offender tOHOffend(infile l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key 		:= '2L'+l.casenumber;
self.vendor				:= '2L';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= '(CV)OH Wayne CRIM';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= stringlib.stringfindreplace(regexreplace( '(\\([A-Z]+\\))',trim(if(l.caption <>'' and stringlib.stringfind(l.caption, 'STATE OF OHIO', 1) > 0 and l.casenumber <> '', regexreplace(l.casenumber, l.caption, ''), ''), left), ''), 'STATE OF OHIO', 'STATE OF OHIO vs.');
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(l.casefiled,left,right)) between '19010101' and Crim_Common.Version_Development,
							fSlashedMDYtoCYMD(trim(l.casefiled,left,right)),
							'');
self.pty_nm				:= trim(regexreplace('^(AKA )|( AKA )|( AKA)$', l.name, ' '), left);
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(if(l.officer = '2' or regexfind('[^A-Z \\-]', l.lastname), '', regexreplace('^(AKA )|( AKA )|( AKA)$|^(AKA)$', trim(l.lastname, all), ' ')), left);
self.orig_fname			:= trim(if(l.officer = '2' or regexfind('[^A-Z \\-]', l.firstname), '', regexreplace('^(AKA )|( AKA )|( AKA)$|^(AKA)$', trim(l.firstname, all), ' ')), left);     
self.orig_mname			:= trim(if(l.officer = '2' or regexfind('[^A-Z \\-]', l.middlename), '', regexreplace('^(AKA)|( AKA )|( AKA)$|^(AKA)$', trim(stringlib.stringfindreplace(l.middlename, '"', ' '), all), ' ')), left);
self.orig_name_suffix	:= trim(if(l.officer = '2' or regexfind('[^A-Z \\-]', l.suffix), '', regexreplace('^(AKA )|( AKA )|( AKA)$|^(AKA)$', trim(l.suffix, all), ' ')), left);
self.pty_typ			:= l.officer;
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
self.street_address_1	:= trim(regexreplace('(INMATE)', stringlib.stringfilterout(if(regexfind(' ', trim(trim(regexreplace('(INMATE)|(\\(.*\\))|(UNKNOWN +ADDRESS)', l.address, ''), left), left, right)), trim(regexreplace('(UNKNOWN)|(\\(.*\\))|(UNKNOWN +ADDRESS)', l.address, ''), left), ''), '*'), '') , left, right);
self.street_address_2	:= if(~regexfind('[^A-Z \\-]', l.city), trim(regexreplace('(\\(.*\\))', l.city, ''), left), '');
self.street_address_3	:= trim(regexreplace('(\\(.*\\))', l.state, ''), left);
self.street_address_4	:= if(length(l.zip) in [5, 9] and regexfind('[1-9]', l.zip), l.zip, '');
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

end;

pOHOffend := project(infile(name <> ''), tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend(case_number <>''),hash(offender_key)),
										offender_key,pty_nm,pty_typ,pty_nm_fmt,dob,street_address_1,local),
										offender_key,pty_nm,dob,street_address_1,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Wayne_Offender_Clean');

export Map_OH_Wayne_Offender := fOHOffend;