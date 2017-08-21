//****************Maps Pcnsr to a common layout********************
import ut, _validate, VersionControl;
phone_file := Phonesplus_v2.Norm_Pcnsr;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	DateLastReported                := VersionControl.fGetFilenameVersion('~thor_data400::base::daybatch_pcnsr')[1..6] : stored('DateLastReported');

	self.dt_first_seen 				:= if((unsigned3) _validate.date.fCorrectedDateString(input.telephone_acquisition_date) > 0, 
										  (unsigned3) _validate.date.fCorrectedDateString(input.telephone_acquisition_date) [1..6] , 
										  (unsigned3) _validate.date.fCorrectedDateString(input.refresh_date) [1..6] ); 
	self.dt_last_seen 				:= (unsigned3) _validate.date.fCorrectedDateString(input.recency_date) [1..6];
	self.dt_vendor_last_reported 	:= (unsigned3) DateLastReported [..6];
	self.dt_vendor_first_reported 	:= 0;

	self.orig_dt_last_seen			:= self.dt_last_seen;

	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (unsigned)input.did);
	self.src						:= translation_codes.source_bitmap_code('PC');
    self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf('PC');
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.orig_name					:= if(input.rec_num = 1, 
										  StringLib.StringCleanSpaces(input.fname_orig + ' ' + input.mname_orig + ' ' + input.lname_orig + ' ' + input.name_suffix_orig),
										  StringLib.StringCleanSpaces(input.spouse_fname_orig + ' ' + input.spouse_mname_orig + ' ' + input.spouse_lname_orig + ' ' + input.spouse_name_suffix_orig));
	self.orig_address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + input.addr_suffix + ' ' + input.postdir);
	self.orig_address2				:= StringLib.StringCleanSpaces(input.unit_desig +  ' ' + input.sec_range);
	self.orig_city					:= input.p_city_name;
	self.orig_state					:= input.st;
	self.orig_zip					:= input.zip + input.zip4	;
	self.orig_rec_type				:= input.rec_num;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.zip4						:= input.zip4;
	self.ace_fips_st				:= input.county[1..2];
	self.ace_fips_county			:= input.county[3..5];
	self.name_score					:= (unsigned1)input.name_score;
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

export Map_Pcnsr_as_Phonesplus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Pcnsr_as_Phonesplus');