import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_TX_Montgomery+arrestlogs.file_reformat_TX_Montgomery;

fMontgomery := p(trim(p.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tMontgomery(fMontgomery input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F3'+trim(input.id,left,right)+fSlashedMDYtoCYMD(input.Book_Dt);
self.vendor				:= 'F3';
self.state_origin		:= 'TX';
self.data_type			:= '5';
self.source_file		:= '(CV)TX-MontgomeryCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if((fSlashedMDYtoCYMD(input.book_dt) < Crim_Common.Version_In_Arrest_Offender) 
							and fSlashedMDYtoCYMD(input.book_dt)[1..2] between '19' and '20',
							fSlashedMDYtoCYMD(input.book_dt),
							'');
self.pty_nm				:= if(length(trim(input.name,left,right))>1,
							regexreplace('\\, $',regexreplace('^,+$|'+'[0-9]+|'+'NMN|'+'\\.+$',trim(input.name,left,right),''),''),
							'');
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989',
							fSlashedMDYtoCYMD(input.dob),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(length(input.address)>1 and regexfind(':|'+'UNKNOWN|'+'UNKN|'+'UKNOWN|'+'UNK',input.address,0)='',
							input.address,
							'');
self.street_address_2	:= if(regexfind('UNK|'+'UNKN|'+'UKNOWN',StringLib.StringToUpperCase(trim(input.city_state_zip,left,right)),0)='' and length(trim(input.city_state_zip,left,right))>1,
							input.city_state_zip,
							'');
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= if(StringLib.StringToUpperCase(input.race) ~in['','x','U','F'],
							StringLib.StringToUpperCase(input.race),
							'');
self.race_desc			:= MAP(StringLib.StringToUpperCase(input.race) = 'W' => 'White',
							StringLib.StringToUpperCase(input.race) ='B' => 'Black',
							StringLib.StringToUpperCase(input.race) ='N' =>	'Black',
							StringLib.StringToUpperCase(input.race) ='O' => '', 
							StringLib.StringToUpperCase(input.race) ='H' => 'Hispanic', 
							StringLib.StringToUpperCase(input.race) ='M' => 'Hispanic',
							StringLib.StringToUpperCase(input.race) ='I' => 'Indian',
							StringLib.StringToUpperCase(input.race) ='O' => 'Other',
							StringLib.StringToUpperCase(input.race) ='A' => 'Asian',
							StringLib.StringToUpperCase(input.race) ='J' => 'Japanese',
							StringLib.StringToUpperCase(input.race) ='C' => 'Chinese',
							'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
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

pMontgomery := project(fMontgomery, tMontgomery(left));

ArrestLogs.ArrestLogs_clean(pMontgomery,cleanMontgomery);

//arrOut:= cleanMontgomery + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanMontgomery,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,party_status_desc,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_TX_Montgomery_Offender');

export Map_TX_MontgomeryOffender := dd_arrOut;