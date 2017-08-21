 import Cellphone, Address;

qsent := dedup(sort(distribute(Phonesplus.File_QSENT_DailyTransfer,hash(phone_number)),phone_number,filedate,local),
					phone_number,right,local);
					
Phonesplus.layoutCommonOut tqsent(qsent input) := Transform

newDateFirstSeen := input.filedate[1..6];

CleanCellPhone		:= CellPhone.CleanPhones(input.phone_number);	
preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(input.listed_name),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

CleanName		    := Address.CleanPersonFML73(preCleanName);

CleanAddress		:= Address.CleanAddress182(input.full_address,
					   input.p_city_name + ' ' + input.st+' '+ input.z9[1..5]);

self.DateVendorFirstReported 	:= 0;
self.DateVendorLastReported 	:= 0;
self.DateFirstSeen 				:= (unsigned3)newDateFirstSeen;
self.DateLastSeen 				:= (unsigned3)newDateFirstSeen;
self.Vendor 					:= 'QT';
self.StateOrigin 				:= '';
self.SourceFile 				:= 'QSENT_TRANSFER';
self.src						:= '';
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag				:= '';
self.ActiveFlag					:= '';
self.CellphoneIDKey         	:= hashmd5((data)input.phone_number +(data)input.z9[1..5]+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey         		:= hashmd5((data)input.phone_number[1..7] +(data)input.z9[1..5]+(data)input.prim_range+(data)input.prim_name);
self.ConfidenceScore			:= 0;
self.RecordKey 					:= input.record_key;
self.OrigName					:= preCleanName;
self.NameFormat 				:= 'L';
self.Address1 					:= input.full_address;
self.Address2 					:= '';
self.Address3 					:= '';
self.OrigCity 					:= input.p_city_name;
self.OrigState 					:= input.st;
self.OrigZip 					:= input.z9;
self.Gender						:= input.gender;
self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',CleanCellPhone, '');
self.ListingType				:= input.listing_type;
self.PublishCode				:= input.publish_code;
self.Company 					:= if(regexfind('B',input.listing_type,0) != '',input.listed_name,'');
self.prim_range 				:= CleanAddress[1..10]; 
self.predir 					:= CleanAddress[11..12];					   
self.prim_name 					:= CleanAddress[13..40];
self.addr_suffix 				:= CleanAddress[41..44];
self.postdir 					:= CleanAddress[45..46];
self.unit_desig 				:= CleanAddress[47..56];
self.sec_range 					:= CleanAddress[57..64];
self.p_city_name 				:= CleanAddress[65..89];
self.v_city_name 				:= CleanAddress[90..114];
self.state 						:= if(CleanAddress[115..116]='',ziplib.ZipToState2(CleanAddress[117..121]),
									CleanAddress[115..116]);

self.zip5 						:= CleanAddress[117..121];
self.zip4 						:= CleanAddress[122..125];
self.cart 						:= CleanAddress[126..129];
self.cr_sort_sz 				:= CleanAddress[130];
self.lot 						:= CleanAddress[131..134];
self.lot_order 					:= CleanAddress[135];
self.dpbc 						:= CleanAddress[136..137];
self.chk_digit 					:= CleanAddress[138];
self.rec_type 					:= CleanAddress[139..140];
self.ace_fips_st				:= CleanAddress[141..142];
self.ace_fips_county			:= CleanAddress[143..145];
self.geo_lat 					:= CleanAddress[146..155];
self.geo_long 					:= CleanAddress[156..166];
self.msa 						:= CleanAddress[167..170];
self.geo_blk 					:= CleanAddress[171..177];
self.geo_match 					:= CleanAddress[178];
self.err_stat 					:= CleanAddress[179..182];

self.title 						:= CleanName[1..5];
self.lname 						:= CleanName[6..25];
self.fname 						:= CleanName[26..45];
self.mname 						:= CleanName[46..65];
self.name_suffix 				:= CleanName[66..70];
self.name_score 				:= CleanName[71..73]; 

self 							:= input;

end;


p_qsent := project(qsent,tqsent(left));
p_qsentOut := output(p_qsent(Cellphone != '') ,,'~thor_data400::in::qsent_clean_' + Phonesplus.version,overwrite);

export map_QSENTtoPhonesplus := sequential(p_qsentOut
//,
	//fileservices.startsuperfiletransaction(),
	//fileservices.addsuperfile('~thor_data400::in::qsent_processed','~thor_data400::in::qsent_update',0,true),
	//fileservices.clearsuperfile('~thor_data400::in::qsent_update'),
	//fileservices.addsuperfile('~thor_data400::in::qsent_clean','~thor_data400::in::qsent_clean_' + Phonesplus.version,0,true),
//	fileservices.finishsuperfiletransaction()
	);














