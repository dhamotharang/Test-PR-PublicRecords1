//****************Maps intrado to a common layout********************
import Cellphone, ut, _validate;
phone_file := CellPhone.Intrado_DID;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone10,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.dt_first_seen 				:= if(input.service_begin_date <> '', 
										  (unsigned3) _validate.date.fCorrectedDateString(input.service_begin_date) [1..6] , 
										  (unsigned3) _validate.date.fCorrectedDateString(input.StartDate) [1..6] ); 
	self.dt_last_seen 				:= if(input.service_end_date <> '',
										  (unsigned3) _validate.date.fCorrectedDateString(input.service_end_date) [1..6],
										  (unsigned3) _validate.date.fCorrectedDateString(input.EndDate) [1..6]);

	self.orig_dt_last_seen			:= self.dt_last_seen;
	
	self.dt_vendor_last_reported 	:= (unsigned3) input.last_update[..6];
	self.dt_vendor_first_reported 	:= 0;


	self.phone7_did_key         	:= hashmd5((data)input.phone10 [length(input.phone10) - 6 ..length(input.phone10)] + (unsigned)input.did);
	self.src						:= translation_codes.source_bitmap_code('IN');
    self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf('IN');
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	self.orig_name					:= input.BillingName1;
	self.orig_address1				:= input.BillingAddress1;
	self.orig_address2				:= '';
	self.orig_city					:= input.BillingCity;
	self.orig_state					:= input.BillingState;
	self.orig_zip					:= input.BillingZip	;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone10);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.name_score					:= (unsigned1)input.name_score;
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

export Map_Intrado_as_Phoneplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Intrado_as_Phoneplus');			  
