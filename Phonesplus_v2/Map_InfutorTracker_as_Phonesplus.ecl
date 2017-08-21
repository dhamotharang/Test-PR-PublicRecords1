//****************Maps Infutor Tracker to a common layout********************
import Infutor, ut, _validate;
phone_file := Infutor.File_Infutor_DID(name_type = 'O');

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.DateFirstSeen 				:= map(input.addr_type = 'O' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'O' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   input.addr_type = 'P1' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'P1' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   input.addr_type = 'P2' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'P2' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   input.addr_type = 'P3' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'P3' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   input.addr_type = 'P4' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'P4' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   input.addr_type = 'P5' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
	                                       input.addr_type = 'P5' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
										   0);

	self.DateLastSeen 				:= map(input.addr_type = 'O' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'O' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
										   input.addr_type = 'P1' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'P1' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
									       input.addr_type = 'P2' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'P2' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
									       input.addr_type = 'P3' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'P3' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
									       input.addr_type = 'P4' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'P4' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
									       input.addr_type = 'P5' and (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.last_activity_dt) [1..6],
	                                       input.addr_type = 'P5' and (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6] > 0 =>  (unsigned3) _validate.date.fCorrectedDateString(input.effective_dt) [1..6],
										   0);	
	self.DateVendorLastReported 	:= 0;
	self.DateVendorFirstReported 	:= 0;

	self.orig_dt_last_seen			:= self.DateLastSeen;

	self.dt_nonglb_last_seen 		:= 0;
	self.glb_dppa_flag		 		:= '';

	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.src_all						:= translation_codes.source_bitmap_code('IF');
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf('IF');
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname + ' ' + input.name_suffix);
	self.Address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name +  input.addr_suffix + ' ' + input.postdir);
	self.Address2				:= StringLib.StringCleanSpaces(input.unit_desig + ' ' + input.sec_range);
	self.OrigCity					:= input.p_city_name;
	self.OrigState					:= input.orig_st;
	self.OrigZip					:= input.zip+input.zip4;
	self.orig_rec_type				:= if(input.name_type = 'O', 1, ((unsigned1) input.name_type[length(input.name_type).. length(input.name_type)]) + 1);
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.addr_suffix				:= input.addr_suffix;
	self.ace_fips_st				:= input.county[1..2];
	self.ace_fips_county			:= input.county[3..5];
	self.name_score					:= (unsigned1) input.name_score;
	self.did						:= (unsigned)input.did;
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

export Map_InfutorTracker_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_InfutorTracker_as_Phonesplus');			  
