import Gong, ut, _validate, Mdr,phonesplus_v2,ExperianIRSG_Build;
phone_file := ExperianIRSG_Build.Files.Base_File_Out;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,orig_phone_num,,,phone_f);

//map to a common layout
phonesplus_v2.Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform

	self.DateFirstSeen 				:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_first_seen) [1..6];
	self.DateLastSeen 				:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_last_seen) [1..6];
	self.DateVendorLastReported 	:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_vendor_last_reported) [1..6];
	self.DateVendorFirstReported	:= (unsigned3)_validate.date.fCorrectedDateString((string)input.date_vendor_first_reported) [1..6];	
	self.orig_dt_last_seen			:= self.DateLastSeen;

	// G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility
	// self.glb_dppa_flag		 		:= map(MDR.Source_is_DPPA(input.src) and mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false => 'B',
										// MDR.Source_is_Utility(input.src) or input.pflag3 = 'W' or input.pflag3 = 'X' => 'U',
										// MDR.Source_is_DPPA(input.src) =>'D',  
										// mdr.sourcetools.sourceisglb(input.src)=true and input.src ='EN' => 'G',
										// mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false=> 'G','');

	self.phone7_did_key         	:= hashmd5((data)input.orig_phone_num[length(input.orig_phone_num)-6..length(input.orig_phone_num)]+(data)(unsigned)input.did);
	self.src_all						:= phonesplus_v2.translation_codes.source_bitmap_code('IR');
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf('IR');
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname + ' ' + input.name_suffix);
	self.Address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + input.addr_suffix + ' ' + input.postdir);
	self.Address2				:= StringLib.StringCleanSpaces(input.unit_desig + ' ' + input.sec_range);
	self.OrigCity					:= input.orig_city;
	self.OrigState					:= input.st;
	self.OrigZip					:= input.zip+input.zip4;
	// self.orig_phone_type			:= input.Phone_Type;
	self.orig_phone					:= phonesplus_v2.Fn_Clean_Phone10(input.orig_phone_num);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.p_city_name				:= input.p_city_name;
	self.v_city_name				:= input.v_city_name;
	self.addr_suffix				:= input.orig_suffix;
	self.ace_fips_county			:= input.county;
	self.name_score					:= (integer)input.name_score;
	self.did						:= (unsigned)input.did;
	self.did_score					:= (unsigned1)input.did_score_field;
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

export Map_ExperianIRSG_asPhonesplus:= project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_ExperianIRSG_as_Phonesplus');			  
