import Address, gong,ut, cellphone,Infutor,risk_indicators,header,header_quick, yellowpages;

//*********Define Base file Infutor and create a persist file with unique phone numbers
infutor_f 		:= Infutor.File_Infutor_DID;
infutor_with_ph := infutor_f ((string)phone != '' and length(stringlib.stringfilter((string)phone,'0123456789')) = 10 and 
					(string)phone[7..10] != '0000' and (string)phone[7..10] != '9999');
			
infutor_with_ph_d 		:= 	distribute(infutor_with_ph (name_type = 'O' and addr_type = 'O') ,hash32(phone));
infutor_with_ph_s 		:= 	sort(infutor_with_ph_d,phone, -last_activity_dt, local) ;
infutor_with_ph_dedp 	:= dedup(infutor_with_ph_s,phone, local) :PERSIST('~thor_data400::persist::dist_infutor'); 


//**********Reformat Infutor to phonesplus common layout
Phonesplus.layoutCommonOut t_infutor(infutor_with_ph_dedp input) := Transform

is_valid_date(string dt)  		:= if((unsigned3) dt[..6] >= 180001 and (unsigned3) dt[..6] <= (unsigned3)ut.GetDate[..6], true, false);

CleanCellPhone					:= CellPhone.CleanPhones(input.phone);

self.DateVendorFirstReported 	:= 0;
self.DateVendorLastReported 	:= 0;
self.DateFirstSeen 				:= if(is_valid_date(input.effective_dt), 
										(unsigned3)input.effective_dt[..6], 
										if(is_valid_date(input.last_activity_dt), 
										(unsigned3)input.last_activity_dt[..6], 0));
self.DateLastSeen 				:= if(is_valid_date(input.last_activity_dt), 
									  (unsigned3)input.last_activity_dt[..6], 
									  if (is_valid_date(input.effective_dt),
									  (unsigned3)input.effective_dt[..6], 0));
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';							   
self.ActiveFlag					:= '';
self.CellphoneIDKey             := hashmd5((data)input.phone +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey           		:= hashmd5((data)input.phone[1..7] +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.ConfidenceScore			:= 0;
self.RecordKey 					:= '';
self.Vendor 					:= 'IF';
self.StateOrigin 				:= '';
self.SourceFile 				:= 'Infutor';
self.src						:= '';
self.OrigName 					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname);
self.NameFormat 				:= 'F';
self.Address1 					:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name);
self.Address2 					:= StringLib.StringCleanSpaces(input.addr_suffix + ' ' + input.postdir + ' ' + input.unit_desig);
self.Address3 					:= '';
self.OrigCity 					:= input.orig_city;
self.OrigState 					:= input.orig_st;
self.OrigZip 					:= input.zip+input.zip4;
self.dob						:= If((unsigned3)input.orig_dob_dd_appended [..4] > 1800, (string8)input.orig_dob_dd_appended, '');
self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',
								   CleanCellPhone, '');
self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.p_city_name                := input.p_city_name;
self.addr_suffix                := input.addr_suffix;
self.state						:= input.st;
self.zip5						:= input.zip;
self.ace_fips_st				:= input.rec_type;
self.ace_fips_county			:= input.county;

//temp use to test area code change
self.OrigTitle					:= input.phone[..3];

self 							:= input;
end;

infutor_p := project(infutor_with_ph_dedp,t_infutor(left));
//Apply Area Code Change
ut.mac_phone_areacode_corrections(infutor_p,infutor_p_areacode, Cellphone);

export map_Infutor_asPhonesplus := infutor_p_areacode (Cellphone != '' and OrigName != '')
								   : PERSIST('~thor400_30::persist::Phonesplus::map_Infutor_asPhonesplus'); 