import CellPhone,Gong,Targus,Address,bankrupt,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header, Business_Header_SS, yellowpages;

dTargus := Targus.File_consumer_base;

//Map AsPhonesplus----------------------------------------------------------------------
Phonesplus.layoutCommonOut t_targus(dTargus input) := Transform

DateVendorFirstReported         := input.dt_vendor_first_reported[1..6];
DateVendorLastReported          := input.dt_vendor_last_reported[1..6];
DateFirstSeen               	:= input.dt_first_seen[1..6];
DateLastSeen                	:= input.dt_last_seen[1..6];

self.DateVendorFirstReported 	:= (unsigned3)DateVendorFirstReported;
self.DateVendorLastReported 	:= (unsigned3)DateVendorLastReported;
self.DateFirstSeen 				:= if((unsigned3)DateFirstSeen > 0, (unsigned3)DateFirstSeen,(unsigned3)DateLastSeen);
self.DateLastSeen 				:= if((unsigned3)DateLastSeen > 0, (unsigned3)DateLastSeen,(unsigned3)DateFirstSeen); 
self.SourceFile					:= 'TargusWP';
self.Vendor						:= 'WP';
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';
self.ActiveFlag					:= '';
self.RecordKey					:= input.record_type+input.record_id;
self.CellphoneIDKey         	:= hashmd5((data)input.phone_number +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey      		   	:= hashmd5((data)input.phone_number[1..7] +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.CellPhone					:= input.phone_number;
self.OrigName	 				:= regexreplace('  +',input.fname + ' '+input.minit+ ' '+input.lname + ' '+input.name_suffix,' ');
self.NameFormat					:= 'FML';
self.Address1	 				:= regexreplace('  +',input.house_number+ ' '+input.pre_direction+' '+input.street_name+' '+input.post_direction+' '+input.apt_number,' ');
self.OrigCity					:= input.postal_city_name;
self.OrigState					:= input.state;
self.OrigZip					:= input.z5+' '+input.plus4;
self.did						:= (unsigned6)input.did;
self.did_score					:= (string)input.did_score;
self.src						:= '';
self.ListingType				:= '';
self.PublishCode				:= '';
self.mname						:= input.minit;
self.addr_suffix				:= input.suffix;
self.p_city_name				:= input.city_name;
self.state						:= input.st;
self.zip5						:= input.zip;
self.ace_fips_county			:= input.county;

//temp use to test area code change
self.OrigTitle					:= input.phone_number[..3];

self 							:= input;

end;

p_dTargus  := project(dTargus,t_targus(left));
dd_Targus  := dedup(sort(distribute(p_dTargus,hash(cellphoneidkey,lname,fname,datelastseen)),
											cellphoneidkey,lname,fname,datelastseen,local),cellphoneidkey,lname,fname,right);
//Apply Area Code Change											
ut.mac_phone_areacode_corrections(dd_Targus, dd_Targus_areacode, Cellphone);

export map_TargusWP_asPhonesplus := dd_Targus_areacode 
									: PERSIST('~thor400_30::persist::Phonesplus::map_TargusWP_asPhonesplus');