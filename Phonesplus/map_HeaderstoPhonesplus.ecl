import Address,header,gong,ut, cellphone, risk_indicators,MDR, header_quick,  yellowpages;

dd_headers_phones := Gong.fileHeaders_filteredforBadPhones(src in Phonesplus.Codes.utility_src or 
														  (src not in Phonesplus.Codes.utility_src and 
														   pflag3 not in Phonesplus.Codes.utility_phones_flag_codes and
														   //Exclude TUCS from Phonesplus
														   src <> 'TS' and
														   //Exclude sources that are on probation
														   MDR.sourceTools.SourceIsOnProbation(src) = false));
dd_headers := dedup(
				    sort(dd_headers_phones ,phone,dt_Last_Seen,local),
					phone,right,local);
					
//------------------------------------------------------------------------------------------
//Bug 42113
//If there are record where the same name, address and phone is sourced from multiple souces
//select the record with the least regulated data

layout_temp_priority := record
	recordof(dd_headers);
	unsigned1 priority_;
end;


layout_temp_priority t_get_highest_priority(dd_headers_phones le, dd_headers ri)  := transform
	self.priority_ := map(mdr.Source_is_DPPA(le.src) => 1,
						  mdr.sourcetools.sourceisglb(le.src)=true and header.ispreglb(le)=false => 2,
						  3),
	self := le;
end;


get_highest_priority := join(distribute(dd_headers_phones, hash(phone)), 
							 distribute(dd_headers, hash(phone)),
							 left.phone = right.phone and
							 left.prim_range = right.prim_range and
							 left.predir = right.predir and
							 left.prim_name = right.prim_name and
							 left.suffix = right.suffix and
							 left.postdir = right.postdir and 
							 left.unit_desig = right.unit_desig and
							 left.zip = right.zip and
							 left.fname = right.fname and
							 left.lname = right.lname,
							 t_get_highest_priority(left, right),
							 local);
							 

dd_headers_highest_priority  := dedup(
								sort(get_highest_priority ,phone, -priority_,-dt_Last_Seen, local),
								phone,local);							 

//------------------------------------------------------------------------------------------
					
Phonesplus.layoutCommonOut t_headers(dd_headers_highest_priority input) := Transform
phplus_source 					:= 'header';
CleanCellPhone					:= CellPhone.CleanPhones(input.phone);

self.DateVendorFirstReported 	:= input.dt_vendor_first_reported;
self.DateVendorLastReported 	:= input.dt_vendor_last_reported;
self.DateFirstSeen 				:= input.dt_first_seen;
self.DateLastSeen 				:= input.dt_last_seen;

//G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility


	self.glb_dppa_flag		 		:= map(MDR.Source_is_DPPA(input.src) and mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false => 'B',
										MDR.Source_is_Utility(input.src) or input.pflag3 = 'W' or input.pflag3 = 'X' => 'U',
										MDR.Source_is_DPPA(input.src) =>'D',  
										input.src = 'EN' => 'G',
										mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false=> 'G','');							   
								   
self.ActiveFlag					:= '';
self.CellphoneIDKey             := hashmd5((data)input.phone +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey           		:= hashmd5((data)input.phone[1..7] +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.ConfidenceScore			:= 0;
self.RecordKey 					:= '';
self.InitScore					:= Phonesplus.Codes.initial_score(input.src);
self.Vendor 					:= Phonesplus.Codes.vendor_code(phplus_source);
self.StateOrigin 				:= '';
self.SourceFile 				:= Phonesplus.Codes.source_file(phplus_source);
self.OrigName 					:= regexreplace('  +',input.fname + ' ' + input.mname + ' ' + input.lname,' ');
self.NameFormat 				:= 'F';
self.Address1 					:= regexreplace('  +',input.prim_range + ' ' + input.predir + ' ' + input.prim_name, ' ');
self.Address2 					:= regexreplace('  +',input.suffix + ' ' + input.postdir + ' ' + input.unit_desig, ' ');
self.Address3 					:= '';
self.OrigCity 					:= input.city_name;
self.OrigState 					:= input.st;
self.OrigZip 					:= input.zip+input.zip4;
self.dob						:= (string8)input.dob;
self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',
								   CleanCellPhone, '');
self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.p_city_name                := input.city_name;
self.addr_suffix                := input.suffix;
self.state						:= input.st;
self.zip5						:= input.zip;
self.ace_fips_st				:= input.rec_type;
self.ace_fips_county			:= input.county;

//temp use to test area code change
self.OrigTitle					:= input.phone[..3];

self 							:= input;

end;

p_headers := project(dd_headers_highest_priority,t_headers(left));
//Apply Area Code Change
ut.mac_phone_areacode_corrections(p_headers,p_headers_areacode, Cellphone);

export map_HeaderstoPhonesplus := p_headers_areacode (Cellphone != '' and OrigName != '')
								  : PERSIST('~thor400_30::persist::Phonesplus::map_HeaderstoPhonesplus');