import Crim_Common, Address, lib_date;

p	:= ArrestLogs.Map_TX_Denton_Combined;

fDenton := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'' and 
			regexfind('[0-9][0-9]+',trim(p.Name,left,right),0)='' and 
			trim(p.Name,left,right)<>'1');

Crim_Common.Layout_In_Court_Offender tDenton(fDenton input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F7'+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dt_confined);
self.vendor				:= 'F7';
self.state_origin		:= 'TX';
self.data_type			:= '5';
self.source_file		:= '(CV)TX-DentonCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= regexreplace('\"|\\(|\\)|$[0-9]+|\\*',trim(input.name,left,right),'');
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
self.street_address_1	:= if(length(trim(input.address,left,right))>=4,
							trim(input.address,left,right),
							'');
self.street_address_2	:= '';
self.street_address_3	:= if(length(trim(input.city,left,right))>=4 and regexfind('[0-9]+',trim(input.city,left,right),0)='',
							trim(input.city,left,right),
							'');
self.street_address_4	:= trim(input.state,left,right);
self.street_address_5	:= trim(input.zipcode,left,right);
self.race				:= '';
self.race_desc			:= if(trim(input.race,left,right) in ['Black','White','Asian'],
							trim(input.race,left,right),
							'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= if(trim(input.hair,left,right) in ['Grey or Partially Grey','Sandy','Black',
							'Blond or Strawberry','Red or Auburn','Brown','Unknown or Completely Bal'],
							trim(input.hair,left,right),
							'');
self.eye_color			:= '';
self.eye_color_desc		:= if(trim(input.eyes,left,right) in ['Green','Blue','Grey','Hazel','Black','Brown'],
							trim(input.eyes,left,right),
							'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]),
							'');
self.weight				:= if(regexreplace('\"|'+'\\/',trim(input.weight,left,right),'') between '50' and '500',
							regexreplace('\"|'+'\\/',trim(input.weight,left,right),''),
							'');
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

pDenton := project(fDenton, tDenton(left));


//AKAs//////////////////////////////////////////////////////////////////////////////////////////
fDenton2 := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'' and 
			regexfind('[A-Z]',trim(p.Alias,left,right),0)<>'');

pattern SingleName := pattern('[^;]+');

MyParsedRecord := record 
	p;
	string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
end;
	
// Parse the AKA name values	
ParsedDs := PARSE(p,alias,SingleName,MyParsedRecord,scan,first);
MyParsedDs  := ParsedDs(trim(ParsedDs.Name,left,right)<>'Alias' and 
				regexfind('[A-Z]',trim(ParsedDs.Alias,left,right),0)<>'' and 
				regexfind('[0-9][0-9]+',trim(ParsedDs.Alias,left,right),0)='' and
				trim(ParsedDs.Alias,left,right)<>'1');
				
// Specify the invalid AKA name values
Invalid_AKA_names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];



Crim_Common.Layout_In_Court_Offender trfAkaName(MyParsedDs input, unsigned c) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F7'+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dt_confined);
self.vendor				:= 'F7';
self.state_origin		:= 'TX';
self.data_type			:= '5';
self.source_file		:= '(CV)TX-DentonCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= IF(stringlib.StringToUpperCase(TRIM(input.CompleteName,left,right)) in Invalid_AKA_names
	                    ,SKIP
						,regexreplace('\"|\\(|\\)|$[0-9]+|\\*',TRIM(input.CompleteName,left,right),''));
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
self.street_address_1	:= if(length(trim(input.address,left,right))>=4,
							trim(input.address,left,right),
							'');
self.street_address_2	:= '';
self.street_address_3	:= if(length(trim(input.city,left,right))>=4 and regexfind('[0-9]+',trim(input.city,left,right),0)='',
							trim(input.city,left,right),
							'');
self.street_address_4	:= trim(input.state,left,right);
self.street_address_5	:= trim(input.zipcode,left,right);
self.race				:= '';
self.race_desc			:= if(trim(input.race,left,right) in ['Black','White','Asian'],
							trim(input.race,left,right),
							'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= if(trim(input.hair,left,right) in ['Grey or Partially Grey','Sandy','Black',
							'Blond or Strawberry','Red or Auburn','Brown','Unknown or Completely Bal'],
							trim(input.hair,left,right),
							'');
self.eye_color			:= '';
self.eye_color_desc		:= if(trim(input.eyes,left,right) in ['Green','Blue','Grey','Hazel','Black','Brown'],
							trim(input.eyes,left,right),
							'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]),
							'');
self.weight				:= if(regexreplace('\"|'+'\\/',trim(input.weight,left,right),'') between '50' and '500',
							regexreplace('\"|'+'\\/',trim(input.weight,left,right),''),
							'');
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

//pDenton2 := project(MyParsedDs, trfAkaName(left));
ds_NornAkaNames := NORMALIZE(MyParsedDs
                            ,1
							,trfAkaName(left,counter));

pDentonConcat := pDenton + ds_NornAkaNames(trim(pty_nm,left,right)<>'Alias' and trim(pty_nm,left,right)<>'1');

ArrestLogs.ArrestLogs_clean(pDentonConcat,cleanDenton);

//arrOut:= cleanDenton + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanDenton,hash(offender_key)),
										offender_key,fname,mname,lname,case_filing_dt,party_status_desc,pty_typ,local)
										,offender_key,fname,mname,lname,case_filing_dt,party_status_desc,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_TX_Denton_Offender');

export Map_TX_DentonOffender := dd_arrOut;