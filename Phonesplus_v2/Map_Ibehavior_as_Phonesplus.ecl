//****************Maps IBehavior to a common layout********************
import ut, _validate, VersionControl, mdr, Ibehavior;

norm_layout := record
IBehavior.layouts.layout_consumer;
string10 Phone;
string1 orig_phone_usage;
end;

norm_layout t_norm(IBehavior.layouts.layout_consumer le, c) := transform
self.Phone := if(c = 1, le.Primary_Phone_Number,le.Secondary_Phone_number);
self.orig_phone_usage := if(c = 1, 'P', 'S');
self := le;
end;

phone_file:= normalize(IBehavior.Files.File_consumer (Primary_Phone_Number <> '' or 
																			Secondary_Phone_number <> ''),	2, t_norm(left, counter)) (phone <> '');	
		
//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.DateFirstSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString(input.date_first_seen)[1..6]);
	self.DateLastSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString(input.date_last_seen)[1..6]);
	self.DateVendorLastReported 	:= (unsigned3)((string)input.date_vendor_last_reported[1..6]);
	self.DateVendorFirstReported 	:= (unsigned3)((string)input.date_vendor_first_reported[1..6]);

	self.orig_dt_last_seen			:= self.DateLastSeen;

	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.src_all						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_ibehavior);
  self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_ibehavior);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.first_name + ' ' + input.middle_initial + ' ' + input.last_name );
	self.Address1				:= input.address_line1;
	self.Address2				:= input.address_line2;
	self.OrigCity					:= input.city;
	self.OrigState					:= input.state;
	self.OrigZip					:= input.zip_code + input.zip_4	;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.did_score 					:= (string) input.did_score;
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

export Map_Ibehavior_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Ibehaivor_as_Phonesplus');