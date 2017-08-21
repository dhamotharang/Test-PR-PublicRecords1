import Address,paw,gong,ut,cellphone, risk_indicators;

paw_f :=  paw.File_Base;

paw_with_ph 			:= paw_f ((string)phone != '' and length(stringlib.stringfilter((string)phone,'0123456789')) = 10 and 
							(string)phone[7..10] != '0000' and (string)phone[7..10] != '9999');
					
paw_with_ph_src 		:= paw_with_ph (source in phonesplus.codes.paw_src);
			
paw_with_ph_d 			:= 	distribute(paw_with_ph_src, hash32(phone));
paw_with_ph_s 			:= 	sort(paw_with_ph_d, phone, -dt_last_seen, -source, local) ;
paw_with_ph_dedp 		:= 	dedup(paw_with_ph_s,phone, local) :PERSIST('~thor_data400::persist::dist_paw'); 


Phonesplus.layoutCommonOut t_paw(paw_with_ph_dedp input) := Transform
phplus_source 					:= 'paw';
CleanCellPhone					:= CellPhone.CleanPhones(input.phone);

self.initscore					:= phonesplus.codes.initial_score(input.source);
self.InitScoreType				:= phonesplus.codes.score_type(input.source);
self.DateVendorFirstReported 	:= 0;
self.DateVendorLastReported 	:= 0;
self.DateFirstSeen 				:= (unsigned3) input.dt_first_seen[..6];
self.DateLastSeen 				:= (unsigned3) input.dt_last_seen[..6];
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';		
self.ActiveFlag					:= '';
self.CellphoneIDKey             := hashmd5((data)input.phone +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey           		:= hashmd5((data)input.phone[1..7] +(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.ConfidenceScore			:= 0;
self.RecordKey 					:= '';
self.Vendor 					:= phonesplus.codes.vendor_code(phplus_source);
self.StateOrigin 				:= '';
self.SourceFile 				:= phonesplus.codes.source_file(phplus_source);
self.src						:= input.source;
self.OrigName 					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname);
self.NameFormat 				:= 'F';
self.Address1 					:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name);
self.Address2 					:= StringLib.StringCleanSpaces(input.addr_suffix + ' ' + input.postdir + ' ' + input.unit_desig);
self.Address3 					:= '';
self.OrigCity 					:= input.city;
self.OrigState 					:= input.state;
self.OrigZip 					:= input.zip+input.zip4;
self.dob						:= '';
self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',
								   CleanCellPhone, '');
self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.p_city_name                := input.city;
self.addr_suffix                := input.addr_suffix;
self.state						:= input.state;
self.zip5						:= input.zip;
self.ace_fips_st				:= '';
self.ace_fips_county			:= input.county;
self.Company					:= input.company_name;
self.Email						:= input.email_address;
self							:= input;
end;

p_paw := project(paw_with_ph_dedp,t_paw(left));

export map_Paw_asPhonesplus := p_paw (Cellphone != '' and OrigName != '');