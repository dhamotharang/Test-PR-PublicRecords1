import CellPhone,Gong, ut, yellowpages;

joinedIntrado := CellPhone.Intrado_DID;


Phonesplus.layoutCommonOut t_intrado(joinedIntrado input) := Transform

DateVendorLastReported          := input.last_update[1..6];
DateFirstSeen               	:= input.service_begin_date[1..6];
DateLastSeen                	:= if(input.service_end_date != '',input.service_end_date[1..6],input.EndDate[1..6]);

newRegistrationDate			    := input.service_begin_date[1..6];

self.DateVendorLastReported 	:= (unsigned3)DateVendorLastReported;
self.DateFirstSeen 				:= if(DateFirstSeen <> '', (unsigned3)DateFirstSeen, (unsigned3)DateLastSeen);
self.DateLastSeen 				:= if(DateLastSeen <> '', (unsigned3)DateLastSeen, (unsigned3)DateFirstSeen);
self.StateOrigin				:= input.state;
self.SourceFile					:= 'INTRADO-BNA';
self.Vendor						:= 'IN';
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';
self.ActiveFlag					:= '';
self.RecordKey					:= input.record_number;
self.CellphoneIDKey         	:= hashmd5((data)input.phone10 +(data)input.zip5+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey      		   	:= hashmd5((data)input.phone10[1..7] +(data)input.zip5+(data)input.prim_range+(data)input.prim_name);
self.InitScore					:= if(input.service_end_date = '',11,3);
self.InitScoreType				:= if(input.service_end_date = '','INTRADO','DISCONN');
self.ConfidenceScore			:= 0;
self.src						:= '';
self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.RegistrationDate 			:= (unsigned3)newRegistrationDate;
self.did						:= (unsigned)input.did;
self.CellPhone					:= input.phone10;
self.Company					:= if(CellPhone.func_is_company(trim(input.BillingName1)) = '', 
												'',StringLib.StringFilter(StringLib.StringToUpperCase(input.BillingName1),
												' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'));
self.OrigName	 				:= input.BillingName1;
self.Address1	 				:= input.BillingAddress1;
//self. 						:= input.BillingAddress2; two different addresses
self.OrigCity					:= input.BillingCity;
self.OrigState					:= input.BillingState;
self.OrigZip					:= input.BillingZip	;

//temp use to test area code change
self.OrigTitle					:= input.phone10[..3];

self 							:= input;

end;

p_joinedIntrado := project(joinedIntrado,t_intrado(left));
//Apply Area Code Change
ut.mac_phone_areacode_corrections(p_joinedIntrado, p_joinedIntrado_areacode, Cellphone);

export map_Intrado_asPhonesplus := p_joinedIntrado_areacode
								   : PERSIST('~thor400_30::persist::Phonesplus::map_Intrado_asPhonesplus');