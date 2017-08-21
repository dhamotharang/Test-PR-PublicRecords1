import crim_common, Crim, Address;

//ALL RECORDS//////////////////////////////////////////////////////////////////////
d := crim.File_FL_Hernando(name<>'Name');

Crim_Common.Layout_In_Court_Offender tFLOffend(d input) := Transform

addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right))]);
cleanstate(string address1):= if(regexfind(' [A-Z][A-Z] [A-Z][A-Z]$',address1,0)<>'',regexreplace(' [A-Z][A-Z]$',address1,''),'');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string4		fCleanHeight(string pHeight)
:= regexreplace('\'|'+'\"|'+'\\;|'+',|'+'\\.|'+'-|'+'\\*|'+'\\:|'+'\\/',pHeight,'');

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 		:= '2T'+trim(input.caseno,left,right)+fSlashedMDYtoCYMD(trim(input.datefiled,left,right))+hash(regexreplace('AKA',input.name,''));
self.vendor				:= '2T';
self.state_origin		:= 'FL';
self.data_type			:= '2';
self.source_file		:= 'FL HERNANDO CRIM CT';
self.case_number		:= trim(input.caseno,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.datefiled)[1..2] between '19' and '20' 
							and fSlashedMDYtoCYMD(input.datefiled)<=stringlib.GetDateYYYYMMDD(),
							fSlashedMDYtoCYMD(input.datefiled),
							'');
self.pty_nm				:= regexreplace('AKA|\\"',input.name,'');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..8] >= '19000101'  
							and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.dob)[1..4])>=18
							and regexfind('\\*',fSlashedMDYtoCYMD(trim(input.dob,left,right)),0)='',
							fSlashedMDYtoCYMD(trim(input.dob,left,right)),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(regexfind('UNKNOWN',input.address,0)='' and length(trim(input.address,left,right))>=10,
							trim(addrp1(input.address),left,right),
							'');
self.street_address_2	:= if(regexfind('UNKNOWN',input.address,0)='',
							cleanstate(trim(addrp2(input.address),left,right)),
							'');					
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= MAP(input.race = 'W' => 'White',
							input.race ='B' => 'Black',
							input.race ='N' =>'Black',
							input.race ='H' => 'Hispanic', 
							input.race ='M' => 'Hispanic',
							input.race ='I' => 'Indian',
							input.race ='A' => 'Asian',
							input.race ='J' => 'Asian',
							input.race ='C' => 'Asian',
							'');
self.sex				:= if(trim(input.sex,left,right)[1] in ['F','M'],
							trim(input.sex,left,right)[1],
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

pFLOffend_all := project(d, tFLOffend(left));


//ALIAS RECORDS////////////////////////////////////////////////////////////////////
d2 := crim.File_FL_Hernando(name<>'Name' and alias<>'');


Crim_Common.Layout_In_Court_Offender tFLOffend2(d2 input) := Transform

addrp1(string address1) := stringlib.stringtouppercase(address1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)]);
addrp2(string address1) := stringlib.stringtouppercase(address1[26-stringlib.stringfind(StringLib.StringReverse(address1[1..25]), ' ', 1)..length(trim(address1, left, right))]);
cleanstate(string address1):= if(regexfind(' [A-Z][A-Z] [A-Z][A-Z]$',address1,0)<>'',regexreplace(' [A-Z][A-Z]$',address1,''),'');

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string4		fCleanHeight(string pHeight)
:= regexreplace('\'|'+'\"|'+'\\;|'+',|'+'\\.|'+'-|'+'\\*|'+'\\:|'+'\\/',pHeight,'');

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key 		:= '2T'+trim(input.caseno,left,right)+fSlashedMDYtoCYMD(trim(input.datefiled,left,right))+hash(regexreplace('AKA',input.name,''));
self.vendor				:= '2T';
self.state_origin		:= 'FL';
self.data_type			:= '2';
self.source_file		:= 'FL HERNANDO CRIM CT';
self.case_number		:= trim(input.caseno,left,right);
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(input.datefiled)[1..2] between '19' and '20' 
							and fSlashedMDYtoCYMD(input.datefiled)<=stringlib.GetDateYYYYMMDD(),
							fSlashedMDYtoCYMD(input.datefiled),
							'');
self.pty_nm				:= regexreplace('AKA|\\"',input.alias,'');
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= '2';
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..8] >= '19000101'  
							and ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)fSlashedMDYtoCYMD(input.dob)[1..4])>=18
							and regexfind('\\*',fSlashedMDYtoCYMD(trim(input.dob,left,right)),0)='',
							fSlashedMDYtoCYMD(trim(input.dob,left,right)),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(regexfind('UNKNOWN',input.address,0)='' and length(trim(input.address,left,right))>=10,
							trim(addrp1(input.address),left,right),
							'');
self.street_address_2	:= if(regexfind('UNKNOWN',input.address,0)='',
							cleanstate(trim(addrp2(input.address),left,right)),
							'');							
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= MAP(input.race = 'W' => 'White',
							input.race ='B' => 'Black',
							input.race ='N' =>'Black',
							input.race ='H' => 'Hispanic', 
							input.race ='M' => 'Hispanic',
							input.race ='I' => 'Indian',
							input.race ='A' => 'Asian',
							input.race ='J' => 'Asian',
							input.race ='C' => 'Asian',
							'');
self.sex				:= if(trim(input.sex,left,right)[1] in ['F','M'],
							trim(input.sex,left,right)[1],
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

pFLOffend_alias := project(d2, tFLOffend2(left));

//CONCAT RECORDS/////////////////////////////////////////////////////
pFLOffend := pFLOffend_all+pFLOffend_alias;

Crim.Crim_clean(pFLOffend,cleanFLOffend);

fFLOffend := dedup(sort(distribute(cleanFLOffend,hash(offender_key)),
										offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_FL_Hernando_Offender_Clean');

export Map_FL_Hernando_Offender := fFLOffend;