import ut,crim_common, Crim, Address, ut;

fPAOffend_nohdr	:= Crim.File_PA_History(first_name<>'' and regexfind('[A-Z]',StringLib.StringToUpperCase(first_name)[1],0)<>'');

// Remove Expunge Records //

dPA_Exp := dedup(sort(Crim.File_PA_Expunge.File_PA_History_Expunge,Docket_Number), Docket_Number);

fPAOffend_exp := join(fPAOffend_nohdr, dPA_Exp, left.Docket_number=right.Docket_number, left only);

Crim.Layout_PA_History Exp_remove(fPAOffend_exp input) := transform
self := input;
END;

fPAOffend := project(fPAOffend_exp, Exp_remove(left));
// End Of Remove Expunge Records //

Crim_Common.Layout_In_Court_Offender tPAOffend(fPAOffend input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= '46'+trim(input.DOCKET_NUMBER,left,right);
self.vendor				:= '46';
self.state_origin		:= 'PA';
self.data_type			:= '2';
self.source_file		:= 'PA_STATEWIDE_HIS(CV)';
self.case_number		:= trim(input.DOCKET_NUMBER,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= if(trim(input.FIRST_NAME,left,right)<>'' and trim(input.MIDDLE_NAME,left,right)='' and trim(input.LAST_NAME,left,right)<>'' and
							regexfind('[A-Z]',(StringLib.StringToUpperCase(regexreplace('AKA',input.FIRST_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA',input.LAST_NAME,'')))[1],0)<>'',
							StringLib.StringToUpperCase(regexreplace('AKA',input.FIRST_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA',input.LAST_NAME,'')),
							if(trim(input.FIRST_NAME,left,right)<>'' and trim(input.MIDDLE_NAME,left,right)<>'' and trim(input.LAST_NAME,left,right)<>'' and
							regexfind('[A-Z]',(StringLib.StringToUpperCase(regexreplace('AKA',input.FIRST_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA|[0-9]+',input.MIDDLE_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA',input.LAST_NAME,'')))[1],0)<>'',
							StringLib.StringToUpperCase(regexreplace('AKA',input.FIRST_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA|[0-9]+',input.MIDDLE_NAME,''))+' '+StringLib.StringToUpperCase(regexreplace('AKA',input.LAST_NAME,'')),
							''));
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= StringLib.StringToUpperCase(regexreplace('AKA',input.LAST_NAME,''));
self.orig_fname			:= StringLib.StringToUpperCase(regexreplace('AKA',input.FIRST_NAME,''));     
self.orig_mname			:= StringLib.StringToUpperCase(regexreplace('AKA|[0-9]+',input.MIDDLE_NAME,'')); 
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
self.dob				:= if(regexreplace('/',input.dob,'')[1..2] between '19' and '20' and
							regexreplace('/',input.dob,'')<>'19000101' and 
							(integer)stringlib.GetDateYYYYMMDD()[1..4]-(integer)regexreplace('/',input.dob,'')[1..4] >=18,
							regexreplace('/',input.dob,''),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= if(length(trim(input.city,left,right))>=4 and 
							regexfind('AKA|A.K.A|A/K/A',StringLib.StringToUpperCase(trim(input.city,left,right)),0)='' and
							regexfind('[A-Z]',StringLib.StringToUpperCase(trim(input.city,left,right))[1],0)<>'' and
							regexfind('[0-9]',StringLib.StringToUpperCase(trim(input.city,left,right)),0)='',
							StringLib.StringToUpperCase(trim(input.city,left,right)),
							'');
self.street_address_4	:= input.state;
self.street_address_5	:= if(regexfind('[0-9]+',trim(input.zipcode[1],left,right),0)<>'' and 
							length(trim(input.zipcode,left,right))>=5 and trim(input.zipcode[1..4],left,right)<>'0000',
							trim(input.zipcode,left,right),
							'');
self.race				:= '';
self.race_desc			:= if(regexfind('UNK',StringLib.StringToUpperCase(trim(input.race,left,right)),0)='',
							StringLib.StringToUpperCase(trim(input.race,left,right)),
							'');
self.sex				:= if(trim(input.gender,left,right)[1] in ['F','M'],
							trim(input.gender,left,right)[1],
							'');
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

pPAOffend := project(fPAOffend, tPAOffend(left));

Crim.Crim_clean(pPAOffend,cleanPAOffend);

dd_PAOut := dedup(sort(distribute(cleanPAOffend,hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_PA_Historical_Offender_Clean');

export Map_PA_Historical_Offender := dd_PAOut;