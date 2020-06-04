//****************Maps Pcnsr to a common layout********************
import ut, _validate, VersionControl, mdr;
phone_file := Phonesplus_v2.Norm_Pcnsr;

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
phonesplus_v2.Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	DateLastReported := ((string)VersionControl.fGetFilenameVersion('~thor_data400::base::daybatch_pcnsr'))[1..6] : stored('DateLastReported');
	tempFirstSeen		:= IF((integer)input.refresh_date > 0 and (integer)input.telephone_acquisition_date > 0 and (integer)input.refresh_date <> (integer)input.telephone_acquisition_date and
												(integer)input.refresh_date < (integer)input.telephone_acquisition_date, input.refresh_date,
											IF((integer)input.refresh_date = 0 and (integer)input.telephone_acquisition_date > 0 and (integer)input.recency_date > 0 and
												(integer)input.telephone_acquisition_date < (integer)input.recency_date, input.telephone_acquisition_date,
												IF((integer)input.telephone_acquisition_date = 0 and (integer)input.refresh_date > 0 and (integer)input.recency_date > 0 and
													(integer)input.refresh_date < (integer)input.recency_date, input.refresh_date,
													IF((integer)input.refresh_date > 0 and (integer)input.telephone_acquisition_date > 0 and (integer)input.refresh_date = (integer)input.telephone_acquisition_date and 
														(integer)input.refresh_date < (integer)input.recency_date, input.refresh_date,input.recency_date))));
	
	self.DateFirstSeen 	:= (unsigned3)_validate.date.fCorrectedDateString(tempFirstSeen)[1..6];
	
	tempLastSeen1	:= IF((integer)input.recency_date > 0 and (integer)input.refresh_date > 0 and (integer)input.refresh_date > (integer)input.telephone_acquisition_date and
											(integer)input.refresh_date > (integer)input.recency_date, input.refresh_date,
											IF((integer)input.recency_date > 0 and (integer)input.refresh_date = 0 and (integer)input.telephone_acquisition_date > 0 and
													(integer)input.telephone_acquisition_date > (integer)input.recency_date, input.telephone_acquisition_date,
													IF((integer)input.recency_date > 0 and (integer)input.refresh_date > 0 and (integer)input.telephone_acquisition_date > 0 and (integer)input.refresh_date < (integer)input.telephone_acquisition_date and
															(integer)input.telephone_acquisition_date > (integer)input.recency_date, input.telephone_acquisition_date,input.recency_date)));
	tempLastSeen2	:= IF((integer)tempLastSeen1 = 0 and (integer)input.refresh_date > 0 and (integer)input.telephone_acquisition_date > 0 and
												(integer)input.refresh_date > (integer)input.telephone_acquisition_date, input.refresh_date,
												IF((integer)tempLastSeen1 = 0 and (integer)input.refresh_date > 0 and (integer)input.telephone_acquisition_date > 0 and
														(integer)input.refresh_date < (integer)input.telephone_acquisition_date, input.telephone_acquisition_date, tempLastSeen1));
	
	self.DateLastSeen 						:= (unsigned3)_validate.date.fCorrectedDateString(tempLastSeen2)[1..6];
	self.DateVendorLastReported 	:= (unsigned3) DateLastReported [..6];
	self.DateVendorFirstReported 	:= 0;

	self.orig_dt_last_seen	:= self.DateLastSeen;

	self.phone7_did_key     := hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)input.did);
	self.src_all						:= phonesplus_v2.translation_codes.source_bitmap_code(mdr.sourceTools.src_Pcnsr);
  self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_Pcnsr);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;	
	self.append_total_source_conf := self.append_avg_source_conf;
	
	self.OrigName				:= if(input.rec_num = 1, 
										  StringLib.StringCleanSpaces(input.fname_orig + ' ' + input.mname_orig + ' ' + input.lname_orig + ' ' + input.name_suffix_orig),
										  StringLib.StringCleanSpaces(input.spouse_fname_orig + ' ' + input.spouse_mname_orig + ' ' + input.spouse_lname_orig + ' ' + input.spouse_name_suffix_orig));
	self.Address1				:= StringLib.StringCleanSpaces(input.prim_range + ' ' + input.predir + ' ' + input.prim_name + ' ' + input.addr_suffix + ' ' + input.postdir);
	self.Address2				:= StringLib.StringCleanSpaces(input.unit_desig +  ' ' + input.sec_range);
	self.OrigCity				:= input.p_city_name;
	self.OrigState			:= input.st;
	self.OrigZip				:= input.zip + input.zip4	;
	self.orig_rec_type	:= input.rec_num;
	self.orig_phone			:= phonesplus_v2.Fn_Clean_Phone10(input.phone);
	self.npa						:= self.orig_phone[..3];
	self.phone7					:= self.orig_phone[4..];
	self.state					:= input.st;
	self.zip5						:= input.zip;
	self.zip4						:= input.zip4;
	self.ace_fips_st		:= input.county[1..2];
	self.ace_fips_county	:= input.county[3..5];
	self.did_score 				:= (string) input.did_score;
	self.source						:= mdr.sourceTools.src_Pcnsr;	//DF-25784
	self.cellphone 				:= self.npa + self.phone7; //DF-25784	
	self 									:= input; 
	self.CellPhoneIDKey   := hashmd5((data)self.orig_phone [length(self.orig_phone) - 6 ..length(self.orig_phone)] + 
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