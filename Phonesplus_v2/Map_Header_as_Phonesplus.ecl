//****************Maps header sources to a common layout********************
import Gong, ut, _validate, Header, Mdr;
//DF-22944 modified filter to choose specific header sources in case new phone number sources are added without our knowledge
phone_file := Header.File_Headers(src in mdr.sourceTools.set_Phonesplus_Header and MDR.sourceTools.SourceIsOnProbation(src) = false and phone <> '' ) +
							 Header.File_TN_did (phone <> '');

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform

	self.DateFirstSeen 				:= if(input.src <> 'EQ', (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_first_seen) [1..6],200106 );
	self.DateLastSeen 				:= if(input.src <> 'EQ', (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_last_seen) [1..6], 200106 );
	self.DateVendorLastReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_last_reported) [1..6];
	self.DateVendorFirstReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_first_reported) [1..6];
	
	self.orig_dt_last_seen			:= self.DateLastSeen;

//G=GLB, D=DPPA, B=Both, ''=Neither ('U' = Utility changed to 'G' with 118021)
	self.glb_dppa_flag		 		:= map(MDR.Source_is_DPPA(input.src) and mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false => 'B',
										//Commented out when Utility became GLB
										//MDR.Source_is_Utility(input.src) or input.pflag3 = 'W' or input.pflag3 = 'X' => 'U',
										MDR.Source_is_DPPA(input.src) =>'D',  
										mdr.sourcetools.sourceisglb(input.src)=true and input.src in ['EN', 'TN'] => 'G',
										mdr.sourcetools.sourceisglb(input.src)=true and header.ispreglb(input)=false=> 'G','');
										
	self.glb_dppa_all					:=	Self.glb_dppa_flag;

	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.src_all						:= translation_codes.source_bitmap_code(input.src);
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(input.src);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;	
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname + ' ' + input.name_suffix);
	self.Address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + input.suffix + ' ' + input.postdir);
	self.Address2				:= StringLib.StringCleanSpaces(input.unit_desig + ' ' + input.sec_range);
	self.OrigCity					:= input.city_name;
	self.OrigState					:= input.st;
	self.OrigZip					:= input.zip+input.zip4;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
	self.state						:= input.st;
	self.zip5						:= input.zip;
	self.p_city_name				:= input.city_name;
	self.v_city_name				:= input.city_name;
	self.addr_suffix				:= input.suffix;
	self.ace_fips_county			:= input.county;
  self.Dob                   := (string8)input.dob;
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

export Map_Header_as_Phonesplus:= project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_Header_as_Phonesplus_test');			  
