import Crim_Common, Address, lib_date;

p	:= ArrestLogs.file_TX_Brazoria.old_f+file_reformat_TX_Brazoria;

//Added to accomodate new layout
ArrestLogs.Layout_TX_Brazoria.new_format pre_tBrazoria(p input) := Transform
self := input;
self.photo := '';
end;

pre_pBrazoria := project(p, pre_tBrazoria(left));

p_new 	:= ArrestLogs.file_TX_Brazoria.new_f;


p_all := pre_pBrazoria + p_new;

fBrazoria := p_all(trim(p_all.Name,left,right)<>'Name' and
			regexfind('[A-Z]',trim(p_all.Name,left,right),0)<>'');

Crim_Common.Layout_In_Court_Offender tBrazoria(fBrazoria input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_In_Arrest_Offender;
self.offender_key		:= 'F4'+hash(trim(input.id,left,right)+fSlashedMDYtoCYMD(input.dt_confined[1..10]));
self.vendor				:= 'F4';
self.state_origin		:= 'TX';
self.data_type			:= '5';
self.source_file		:= '(CV)TX-BrazoriaCtyArr';
self.case_number		:= '';
self.case_court			:= '';
self.case_name			:= '';
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= '';
self.pty_nm				:= trim(input.name,left,right);
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
self.dob				:= if(fSlashedMDYtoCYMD(input.dob)[1..2] between '19' 
							and '20' and fSlashedMDYtoCYMD(input.dob)[1..4] between '1900' and '1989',
							fSlashedMDYtoCYMD(input.dob),
							'');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= if(regexfind('Unk|'+'Unknown',trim(input.address,left,right),0)='',
							if(length(trim(input.address,left,right)) > 3, trim(input.address,left,right), ''),
							'');
self.street_address_2	:= '';
self.street_address_3	:= trim(input.city,left,right);
self.street_address_4	:= trim(input.state,left,right);
self.street_address_5	:= trim(input.zip,left,right);
self.race				:= '';
self.race_desc			:= if(StringLib.StringToUpperCase(trim(input.race,left,right)) in ['WHITE','BLACK','HISPANIC',
							'INDIAN','ASIAN','JAPANESE','CHINESE'],
							StringLib.StringToUpperCase(trim(input.race,left,right)),
							'');
self.sex				:= if(input.sex[1] in ['F','M'],
							input.sex[1],
							'');
self.hair_color			:= '';
self.hair_color_desc	:= if(StringLib.StringToUpperCase(trim(input.hair,left,right)) in ['BALD',   
							'BLACK','BLOND','BROWN','GREY','RED','SANDY','WHITE'],
							StringLib.StringToUpperCase(trim(input.hair,left,right)),
							if(regexfind('BLOND',StringLib.StringToUpperCase(trim(input.hair,left,right)),0)<>'',
							'BLOND',
							if(regexfind('GREY',StringLib.StringToUpperCase(trim(input.hair,left,right)),0)<>'',
							'GREY',
							'')));
self.eye_color			:= '';
self.eye_color_desc		:= if(StringLib.StringToUpperCase(trim(input.eyes,left,right)) in ['BLACK',
							'BLUE','BROWN','GREEN','GREY','HAZEL','MAROON','MULTI','PINK'],
							StringLib.StringToUpperCase(trim(input.eyes,left,right)),
							'');
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= if((string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]) between '48' and '84',
                            (string)((integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[1]*12+(integer)regexreplace('\'|'+'\"',trim(input.height,all),'')[2..3]),
							'');
self.weight				:= if(regexreplace('\\/',input.weight,'') between '050' and '500',
							regexreplace('\\/',input.weight,''),
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

pBrazoria := project(fBrazoria, tBrazoria(left));

ArrestLogs.ArrestLogs_clean(pBrazoria,cleanBrazoria);

//arrOut:= cleanBrazoria + ArrestLogs.FileAbinitioOffender(vendor='');

dd_arrOut:= dedup(sort(distribute(cleanBrazoria,hash(offender_key)),
										offender_key,pty_nm,pty_typ,case_filing_dt,party_status_desc,local)
										,offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Arrestlogs_TX_Brazoria_Offender');

export Map_TX_BrazoriaOffender := dd_arrOut;