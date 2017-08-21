import gong,risk_indicators,ut,cellphone, ut, risk_indicators,header,header_quick,phonesplus, yellowpages;

gongh := Gong.File_History;
f_gongh := gongh(phone10 != '' and length(stringlib.stringfilter(phone10,'0123456789')) = 10 and 
			phone10[1] > '1'and phone10[7..10] != '0000' and phone10[7..10] != '9999' and  
			phone10[1..3] != '555' and phone10[1..3] != '800');

s_gongh := sort(distribute(f_gongh,hash32(phone10)),phone10,filedate,local);
dd_gongh := dedup(s_gongh,phone10,right,local)(publish_code != 'N');

nonCurrentgongh := dd_gongh(current_record_flag = '');

Phonesplus.layoutCommonOut tgongh(nonCurrentgongh input) := Transform

newDateFirstSeen 				:= input.dt_first_seen[1..6];
newDateLastSeen 				:= input.dt_last_seen[1..6];

CleanCellPhone					:= CellPhone.CleanPhones(input.phone10);

self.DateVendorFirstReported 	:= 0;
self.DateVendorLastReported 	:= 0;
self.DateFirstSeen 				:= (unsigned3)newDateFirstSeen;
self.DateLastSeen 				:= (unsigned3)newDateLastSeen;
self.Vendor 					:= 'GH';
self.StateOrigin 				:= '';
self.SourceFile 				:= 'Gong History';
self.src						:= '';
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';
self.ActiveFlag					:= '';
self.CellphoneIDKey         	:= hashmd5((data)input.phone10 +(data)input.z5+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey         		:= hashmd5((data)input.phone10[1..7] +(data)input.z5+(data)input.prim_range+(data)input.prim_name);
self.ConfidenceScore			:= 0;
self.RecordKey 					:= '';
self.OrigName 					:= input.listed_name;
								   //if(input.listing_type_bus= '',input.listed_name,'');
self.NameFormat 				:= 'L';
self.Address1 					:= regexreplace('  +',input.prim_range + ' ' + input.predir + ' ' + input.prim_name, ' ');
self.Address2 					:= regexreplace('  +',input.name_suffix + ' ' + input.postdir + ' ' + input.unit_desig + ' ' + input.sec_range, ' ');
self.Address3 					:= '';
self.OrigCity 					:= input.p_city_name;
self.OrigState 					:= input.st;
self.OrigZip 					:= input.z5+input.z4;
self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',
								   CleanCellPhone, '');
self.ListingType		 		:= regexreplace('  +',if(input.listing_type_bus != '',input.listing_type_bus,'') +
								   if(input.listing_type_res != '',input.listing_type_res,'') +
								   if(input.listing_type_gov != '',input.listing_type_gov,''),'');
self.PublishCode		 		:= input.publish_code;
self.Company 					:= if(input.listing_type_bus != '',input.listed_name,'');
self.state						:= input.st;
self.zip5						:= input.z5;
self.zip4						:= input.z4;
self.addr_suffix				:= input.suffix;
self.ace_fips_st				:= input.rec_type;
self.ace_fips_county			:= input.county_code;
self.title						:= input.name_prefix;
self.fname						:= input.name_first;
self.mname						:= input.name_middle;
self.lname						:= input.name_last;

//temp use to test area code change
self.OrigTitle					:= input.phone10[..3];

self 							:= input;

end;



p_nonCurrentgongh := project(nonCurrentgongh,tgongh(left));
//Apply Area Code Change
ut.mac_phone_areacode_corrections(p_nonCurrentgongh,nonCurrentgongh_areacode, Cellphone);

export map_GongHtoPhonesplus := sort(distribute(nonCurrentgongh_areacode(Cellphone != '' and OrigName != ''),hash(CellPhoneIDKey)),CellPhoneIDKey,local)
							 : PERSIST('~thor400_30::persist::Phonesplus::map_GongHtoPhonesplus');