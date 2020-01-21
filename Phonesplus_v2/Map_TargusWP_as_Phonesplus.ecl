//****************Maps TargusWP to a common layout********************
import Targus, ut, _validate, mdr;
phone_file := Targus.File_consumer_base;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone_number,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.DateFirstSeen 				:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_first_seen) [1..6];
	self.DateLastSeen 				:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_last_seen) [1..6];
	self.DateVendorLastReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_last_reported) [1..6];
	self.DateVendorFirstReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_first_reported) [1..6];

	self.orig_dt_last_seen			:= self.DateLastSeen;
	
	self.phone7_did_key         	:= hashmd5((data)input.phone_number [length(input.phone_number) - 6 ..length(input.phone_number)] + (data)(unsigned)input.did);
	self.src_all						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_Targus_White_Pages);
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_Targus_White_Pages);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;		
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' '+input.minit+ ' '+input.lname + ' '+input.name_suffix);
	self.Address1				:= StringLib.StringCleanSpaces(input.house_number+ ' '+input.pre_direction+' '+input.street_name+' '+ input.street_type + ' ' + input.post_direction);
	self.Address2				:= input.apt_type + ' ' + input.apt_number + ' ' + input.box_number;
	self.OrigCity					:= input.postal_city_name;
	self.OrigState					:= input.state;
	self.OrigZip					:= input.z5+input.plus4;
	self.orig_listing_type			:= map(input.record_type = 'P' => 'B',
										   input.record_type in ['O','S'] => 'RB',
										   input.record_type);
	self.orig_phone_type			:= map(input.phone_type = 'M' => 'C',
										   input.phone_type in ['P', 'A', 'D','R', 'W', 'S', 'C', 'H', 'O'] => 'L',
										   input.phone_type = 'G' => 'P',
										   input.phone_type);
	self.orig_phone_usage			:= input.phone_type;	
	self.orig_rec_type				:= (unsigned1)input.rec_type;
	self.Orig_phone_reg_dt			:= (unsigned3) _validate.date.fCorrectedDateString((string)input.pubDate) [1..6];
	self.orig_phone					:= Fn_Clean_Phone10(input.phone_number);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.mname						:= input.minit;
	self.addr_suffix				:= input.suffix;
	self.p_city_name				:= input.city_name;
	self.v_city_name				:= input.city_name;
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.ace_fips_county			:= input.county;
	self.did_score 						:= (string)input.did_score;
	self.source				:= mdr.sourceTools.src_Targus_White_Pages;	//DF-25784
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
export Map_TargusWP_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_TargusWP_as_Phonesplus');
									  