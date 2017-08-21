import crim_common, Crim, Address;

//Flag court type
c := crim.File_CA_SantaClara.File_CA_SantaClara_Sup;

Layout_CA_SantaClara_append := record
Crim.Layout_CA_SantaClara;
string case_court;
end;

Layout_CA_SantaClara_append sCAOffend(c input) := Transform
self := input;
self.case_court := 'Superior';
end;

preCAOffend1 := project(c, sCAOffend(left));

d := crim.File_CA_SantaClara.File_CA_SantaClara_Mun;

Layout_CA_SantaClara_append mCAOffend(d input) := Transform
self := input;
self.case_court := 'Municipal';
end;

preCAOffend2 := project(d, mCAOffend(left));

preConcat := preCAOffend1+preCAOffend2;


//Regular Court Offender Mapping
Crim_Common.Layout_In_Court_Offender tCAOffend(preConcat input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '1K'+hash(trim(input.dyn04_case_number,left,right)+fSlashedMDYtoCYMD(input.dyn05_file)+trim(input.dyn02_defendant,all));
self.vendor				:= '1K';
self.state_origin		:= 'CA';
self.data_type			:= '2';
self.source_file		:= 'CA SANTA CLARA CRIM CT';
self.case_number		:= trim(input.dyn04_case_number,left,right);
self.case_court			:= input.case_court;
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.dyn05_file)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(input.dyn05_file),
							'');
self.pty_nm				:= regexreplace(' +',if(length(input.dyn02_defendant)>2 and regexfind('[0-9]+ ',trim(input.dyn02_defendant,left,right),0)='',
							trim(input.dyn02_defendant,left,right),
							''),' ');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dyn03_birth_date)[1..4] between '1900' and '1989',
							fSlashedMDYtoCYMD(input.dyn03_birth_date),
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

pCAOffend := project(preConcat, tCAOffend(left));

Crim.Crim_clean(pCAOffend,cleanCAOffend);

fCAOffend := dedup(sort(distribute(cleanCAOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_CA_SantaClara_Offender_Clean');

export Map_CA_SantaClara_Offender := fCAOffend;