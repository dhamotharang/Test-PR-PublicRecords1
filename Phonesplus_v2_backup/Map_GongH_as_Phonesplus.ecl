//****************Maps Gong history  to a common layout********************
import Gong, ut, _validate;
phone_file := dedup(sort(distribute(Gong.File_History((unsigned)phone10 <> 0 and current_record_flag <> 'Y'), hash(phone10)), phone10, -dt_last_seen, local), phone10, local);

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone10,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform

	self.dt_first_seen 				:= (unsigned3) _validate.date.fCorrectedDateString(input.dt_first_seen) [1..6];
	self.dt_last_seen 				:= (unsigned3) _validate.date.fCorrectedDateString(input.dt_last_seen) [1..6];
	self.dt_vendor_last_reported 	:= (unsigned3) _validate.date.fCorrectedDateString(input.dt_first_seen) [1..6];
	self.dt_vendor_first_reported 	:= (unsigned3) _validate.date.fCorrectedDateString(input.dt_last_seen) [1..6];

	self.orig_dt_last_seen			:= self.dt_last_seen;
	
	self.phone7_did_key         	:= hashmd5((data)input.phone10 [length(input.phone10) - 6 ..length(input.phone10)] + (unsigned)input.did);
	self.src						:= translation_codes.source_bitmap_code('GH');
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf('GH');
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.orig_name					:= input.listed_name;;
	self.orig_address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + ' ' + input.suffix + ' ' + input.postdir);
	self.orig_address2				:= StringLib.StringCleanSpaces(input.unit_desig + ' ' + input.sec_range);
	self.orig_city					:= input.p_city_name;
	self.orig_state					:= input.st;
	self.orig_zip					:= input.z5+input.z4;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone10);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.orig_publish_code			:= input.publish_code;
	self.orig_listing_type			:= trim(input.listing_type_res + input.listing_type_bus + input.listing_type_gov,all);
	
	self.state						:= input.st;
	self.zip5						:= input.z5;
	self.zip4						:= input.z4;
	self.addr_suffix				:= input.suffix;
	self.ace_fips_st				:= input.rec_type;
	self.ace_fips_county			:= input.county_code;
	self.title						:= input.name_prefix;
	self.fname						:= input.name_first;
	self.mname						:= input.name_middle;
	self.lname						:= input.name_last;
	self.did						:= (unsigned)input.did;
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

export Map_GongH_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_GongH_as_Phonesplus');			  