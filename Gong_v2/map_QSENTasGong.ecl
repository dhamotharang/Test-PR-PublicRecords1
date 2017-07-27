 import Cellphone,Address,Gong_v2,Phonesplus;

qsent := Gong_v2.file_QSENT_GONG_IN;

Gong_v2.Layout_GongHistory tqsent(qsent input) := Transform


CleanCellPhone		:= CellPhone.CleanPhones(input.phone_number);	
preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(input.listed_name),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

CleanName		    := Address.CleanPersonFML73(preCleanName);

cleanAddress		:= Address.CleanAddress182(input.full_address,
					   input.p_city_name + ' ' + input.st+' '+ input.z9[1..5]);


self.dt_first_seen 				:= '';
self.dt_last_seen 				:= '';
self.seisintid 					:= input.record_key;
self.bell_id    				:= 'QSE';
self.filedate 					:= input.filedate;
self.dual_name_flag 			:= '';
self.sequence_number 			:= 0;
self.listing_type_bus 			:= if(regexfind('B',input.listing_type,0) != '','B','');
self.listing_type_res			:= if(regexfind('R',input.listing_type,0) != '','R','');
self.listing_type_gov 			:= if(regexfind('G',input.listing_type,0) != '','G','');
self.publish_code 				:= input.publish_code;
self.style_code 				:= '';
self.indent_code 				:= '';
self.phoneno 					:= input.phone_number;
self.special_listing_txt 		:='';
self.appnd_prim_range 			:='';
self.appnd_predir 				:='';
self.appnd_prim_name 			:='';
self.appnd_suffix 				:='';
self.appnd_postdir 				:='';
self.appnd_unit_desig 			:='';
self.appnd_sec_range 			:='';
self.appnd_p_city_name 			:='';
self.appnd_st 					:='';
self.appnd_z5 					:='';
self.appnd_z4 					:='';
self.prim_range 				:= cleanAddress[1..10]; 
self.predir 					:= cleanAddress[11..12];					   
self.prim_name 					:= cleanAddress[13..40];
self.suffix 					:= cleanAddress[41..44];
self.postdir 					:= cleanAddress[45..46];
self.unit_desig 				:= cleanAddress[47..56];
self.sec_range 					:= cleanAddress[57..64];
self.p_city_name 				:= cleanAddress[65..89];
self.v_city_name 				:= cleanAddress[90..114];
self.st 						:= if(cleanAddress[115..116]='',ziplib.ZipToState2(cleanAddress[117..121]),
									cleanAddress[115..116]);

self.z5 						:= cleanAddress[117..121];
self.z4 						:= cleanAddress[122..125];
self.cart 						:= cleanAddress[126..129];
self.cr_sort_sz 				:= cleanAddress[130];
self.lot 						:= cleanAddress[131..134];
self.lot_order 					:= cleanAddress[135];
self.dpbc 						:= cleanAddress[136..137];
self.chk_digit 					:= cleanAddress[138];
self.rec_type 					:= cleanAddress[139..140];
self.county_code				:= cleanAddress[141..145];
self.geo_lat 					:= cleanAddress[146..155];
self.geo_long 					:= cleanAddress[156..166];
self.msa 						:= cleanAddress[167..170];
self.geo_blk 					:= cleanAddress[171..177];
self.geo_match 					:= cleanAddress[178];
self.err_stat 					:= cleanAddress[179..182];


self.name_prefix				:= CleanName[1..5];
self.name_last					:= CleanName[6..25];
self.name_first					:= CleanName[26..45];
self.name_middle				:= CleanName[46..65];
self.name_suffix 				:= CleanName[66..70];


self.company_name 				:= input.listed_name;
self.caption_text 				:= '';
self.group_id 					:= '';
self.group_seq 					:= '';
self.omit_address 				:= '';
self.omit_phone 				:= '';
self.omit_locality 				:= '';
self.privacy_flag 				:= '';


end;


p_qsent := project(qsent,tqsent(left));
p_qsentOut := output(p_qsent ,,'~thor_data400::in::qsent_clean_asGongh',overwrite);

export map_QSENTasGong := p_qsentOut;














