import crim_common, Crim, Address, lib_stringlib, ut;

df := CRIM.File_OH_Delaware(Summary_Name != 'Summary_Name' and Parties_Type = 'Defendant' and Summary_LastName <> '');


Crim_Common.Layout_In_Court_Offender tOHOffend(df input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key 		:= '1H'+ trim(input.Summary_CaseNumber,left,right) + trim(input.Summary_LastName,left,right);
self.vendor				:= '1H';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH-DelawareCrmCrt';
self.case_number		:= trim(input.Summary_CaseNumber,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(trim(input.Summary_CaseFiled,left,right))[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(trim(input.Summary_CaseFiled,left,right)),
							'');
self.pty_nm				:= regexreplace('AKA',input.Summary_Name,'');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(input.Summary_LastName,left,right);
self.orig_fname			:= trim(input.Summary_FirstName,left,right);     
self.orig_mname			:= trim(input.Summary_MiddleName,left,right);
self.orig_name_suffix	:= trim(input.Summary_Suffix,left,right);
self.pty_typ			:= '0'; //if(input.Parties_Type = 'AKA', '2', '0');
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
//self.dob				:= if(fSlashedMDYtoCYMD(trim(input.Summary_DateOfBirth,left,right))[1..2] = '19',
//							fSlashedMDYtoCYMD(trim(input.Summary_DateOfBirth,left,right)),
//							'');
self.dob				:= if(((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.Summary_DateOfBirth)[1..4])>=18,
							fSlashedMDYtoCYMD(input.Summary_DateOfBirth), '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(regexfind( 'C/O|%|AKA |INMATE |UNKNOWN|JAIL|TO BE SERVED|DEPARTMENT STORE|REGIONAL|FACILITY| MOTEL |GENERAL DELIVER|COUNTY|CORRECTI|REFORMATORY|HOMELESS|SHERIFF|NO ADDRESS GIVEN|JEWELERS|ON THE STREETS |JUVI', stringlib.StringToUpperCase(input.Summary_Address)), '', trim(regexreplace('LKA |LKA: |^LKA', input.Summary_Address, ''),left,right));


self.street_address_2	:= if(regexfind( 'C/O|%|AKA |INMATE |UNKNOWN|JAIL|TO BE SERVED|DEPARTMENT STORE|REGIONAL|FACILITY| MOTEL |GENERAL DELIVER|COUNTY|CORRECTI|REFORMATORY|HOMELESS|SHERIFF|NO ADDRESS GIVEN|JEWELERS|ON THE STREETS |JUVI', stringlib.StringToUpperCase(input.Summary_Address)), '',trim(input.Summary_City,left,right));
self.street_address_3	:= if(regexfind( 'C/O|%|AKA |INMATE |UNKNOWN|JAIL|TO BE SERVED|DEPARTMENT STORE|REGIONAL|FACILITY| MOTEL |GENERAL DELIVER|COUNTY|CORRECTI|REFORMATORY|HOMELESS|SHERIFF|NO ADDRESS GIVEN|JEWELERS|ON THE STREETS |JUVI', stringlib.StringToUpperCase(input.Summary_Address)), '',trim(input.Summary_State,left,right));
self.street_address_4	:= if(regexfind( 'C/O|%|AKA |INMATE |UNKNOWN|JAIL|TO BE SERVED|DEPARTMENT STORE|REGIONAL|FACILITY| MOTEL |GENERAL DELIVER|COUNTY|CORRECTI|REFORMATORY|HOMELESS|SHERIFF|NO ADDRESS GIVEN|JEWELERS|ON THE STREETS |JUVI', stringlib.StringToUpperCase(input.Summary_Address)), '',trim(input.Summary_Zip,left,right));
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

pOHOffend := project(df, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
										offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Delaware_Offender_Clean');



export Map_OH_Delaware_Offender := fOHOffend;