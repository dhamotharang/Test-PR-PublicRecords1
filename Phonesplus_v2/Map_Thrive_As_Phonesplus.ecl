//****************Maps Thrive to a common layout********************
import ut, _validate, VersionControl, mdr, thrive;

norm_layout := record
Thrive.Layouts.Base;
string10 Phone;
string1 orig_phone_usage;
end;

norm_layout t_norm(Thrive.Layouts.Base le, c) := transform
self.Phone := if(c = 1, le.clean_Phone_Work,
													if(c = 2, le.clean_Phone_Home, le.clean_Phone_Cell));
self.orig_phone_usage := if(c = 1, 'O',
													if(c = 2, 'H', 'M'));
self := le;
end;

phone_file:= normalize(Thrive.Files().Base.qa (clean_Phone_Work <> '' or 
																			clean_Phone_Home <> '' or
																			clean_Phone_Cell <> ''),	3, t_norm(left, counter)) (phone <> '');	
		
//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.DateFirstSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString((string)input.dt_first_seen)[1..6])[1..6];
	self.DateLastSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString((string)input.dt_last_seen)[1..6]);;
	self.DateVendorLastReported 	:= (unsigned3)((string)input.dt_vendor_last_reported)[1..6];
	self.DateVendorFirstReported 	:= (unsigned3)((String)input.dt_vendor_first_reported)[1..6];

	self.orig_dt_last_seen			:= self.DateLastSeen;

	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.src_all						:= translation_codes.source_bitmap_code(input.src);
  self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(input.src);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.orig_fname + ' ' + input.orig_mname + ' ' + input.orig_lname );
	self.Address1				:= input.orig_addr;
	self.Address2				:= '';
	self.OrigCity					:= input.orig_city;
	self.OrigState					:= input.orig_state;
	self.OrigZip					:= input.orig_zip5 + input.orig_zip4	;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.zip4						:= input.zip4;
	self.did_score 					:= (string) input.did_score;
	self.source				:= input.src;	//DF-25784
	self.cellphone 		:= self.npa + self.phone7; //DF-25784		
	self 							:= input; 
	self.CellPhoneIDKey         	:= hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
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

export Map_Thrive_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Thrive_as_Phonesplus');