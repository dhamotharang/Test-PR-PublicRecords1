//****************Maps cellphones sources to a common layout********************
import cellphone, ut, _validate;
phone_file := Norm_Cellphone;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform

	self.dt_first_seen 				:= (unsigned3) if((unsigned)_validate.date.fCorrectedDateString(input.RegistrationDate) <> 0, 
													  _validate.date.fCorrectedDateString(input.RegistrationDate) [..6],
													  if ((unsigned)_validate.date.fCorrectedDateString(input.DateFirstSeen) <> 0,
													      _validate.date.fCorrectedDateString(input.DateFirstSeen)[..6],
														  _validate.date.fCorrectedDateString(input.DateLastSeen)[..6]));
	
	self.dt_last_seen 				:= (unsigned3) if((unsigned)_validate.date.fCorrectedDateString(input.RegistrationDate) <> 0, 
													  _validate.date.fCorrectedDateString(input.RegistrationDate) [..6],
													  if ((unsigned)_validate.date.fCorrectedDateString(input.DateLastSeen) <> 0,
													      _validate.date.fCorrectedDateString(input.DateLastSeen)[..6],
														  _validate.date.fCorrectedDateString(input.DateFirstSeen)[..6]));
	
	self.dt_vendor_last_reported 	:= (unsigned3) if((unsigned)_validate.date.fCorrectedDateString(input.DateLastSeen) [..6] <> 0,
													  _validate.date.fCorrectedDateString(input.DateLastSeen) [..6],
													  _validate.date.fCorrectedDateString(input.DateFirstSeen) [..6]);
	
	self.dt_vendor_first_reported 	:= (unsigned3) if((unsigned)_validate.date.fCorrectedDateString(input.DateFirstSeen) [..6] <> 0,
													  _validate.date.fCorrectedDateString(input.DateFirstSeen) [..6],
													  _validate.date.fCorrectedDateString(input.DateLastSeen) [..6]);
	
	self.orig_dt_last_seen			:= self.dt_last_seen;
	
	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (unsigned)input.did);
	self.src						:= translation_codes.source_bitmap_code(input.Vendor);
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(input.Vendor);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.orig_name					:= input.OrigName;
	self.orig_address1				:= input.Address1;
	self.orig_address2				:= input.Address2;
	self.orig_address3 				:= input.Address3;
	self.orig_city					:= input.OrigCity;
	self.orig_state					:= input.OrigState;
	self.orig_zip					:= input.OrigZip;
	self.orig_dob					:= input.dob;
	self.orig_agegroup				:= input.agegroup;
	self.orig_gender                := input.gender;
	self.orig_email                 := input.email;
	self.orig_phone_type			:= input.Phone_Type;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.orig_phone_reg_dt			:= (unsigned3) _validate.date.fCorrectedDateString(input.RegistrationDate) [1..6];
	self.name_score					:= (unsigned1)input.name_score;
	self.did						:= (unsigned)input.did;
	self.did_score					:= (unsigned1)input.did_score;
	self 							:= input; 
	self.phone7_rec_key         	:= hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
											   (data)self.prim_range + 
											   (data)self.predir + 
											   (data)self.prim_name + 
											   (data)self.addr_suffix + 
											   (data)self.postdir + 
											   (data)self.unit_desig + 
											   (data)self.sec_range + 
											   (data)self.zip5 +
											   (data)self.lname + 
											   (data)self.fname);
end;

export Map_Cellphone_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Cellphone_as_Phonesplus');			  