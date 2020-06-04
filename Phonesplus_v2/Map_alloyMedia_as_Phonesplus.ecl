//****************Maps Alloy Media to a common layout********************
import ut, _validate, VersionControl, mdr, AlloyMediaConsumer;

phone_file:= AlloyMediaConsumer.Files().base.qa;	
		
//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,clean_Phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.DateFirstSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString((string)input.dt_first_seen)[1..6])[1..6];
	self.DateLastSeen 				:=  (unsigned3)(_validate.date.fCorrectedDateString((string)input.dt_last_seen)[1..6]);
	self.DateVendorLastReported 	:= (unsigned3)((string)input.dt_vendor_last_reported)[1..6];
	self.DateVendorFirstReported 	:= (unsigned3)((String)input.dt_vendor_first_reported)[1..6];

	self.orig_dt_last_seen			:= self.DateLastSeen;

	self.phone7_did_key         	:= hashmd5((data)input.clean_Phone [length(input.clean_Phone) - 6 ..length(input.clean_Phone)] + (data)(unsigned)input.did);
	self.src_all									:=  translation_codes.source_bitmap_code(mdr.sourceTools.src_AlloyMedia_consumer);
  self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_AlloyMedia_consumer);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.orig_first_name + ' ' + input.orig_last_name);
	self.Address1				:= input.orig_address1;
	self.Address2				:= input.orig_address2;
	self.OrigCity				:= input.orig_city;
	self.OrigState			:= input.orig_state_province;
	self.OrigZip				:= input.orig_zip5;
	self.state					:= input.st;
	self.zip5						:= input.zip;
	self.orig_phone			:= input.clean_Phone;
	self.npa						:= self.orig_phone[..3];
	self.phone7					:= self.orig_phone[4..];
	self.title					:= input.title;
	self.did_score 			:= (string) input.did_score;
	self.source					:= mdr.sourceTools.src_AlloyMedia_consumer;	//DF-25784
	self.cellphone 		:= self.npa + self.phone7; //DF-25784		
	self 							:= input; 
	self.CellPhoneIDKey        := hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
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

export Map_alloyMedia_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_AlloyMedia_as_Phonesplus');