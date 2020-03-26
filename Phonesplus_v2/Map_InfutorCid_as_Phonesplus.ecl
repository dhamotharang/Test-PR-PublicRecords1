//****************Maps infutor CID to a common layout********************
import Gong, ut, _validate, InfutorCID, Mdr;

base_history := infutorCID.File_InfutorCID_Base;
phone_file := base_history
						//Exclude phones with low confidence
						(//orig_telephoneconfidencescore not in ['4','5'] and
						
						//Include records with RecordType R and with a name
	                    Orig_RecordType = 'R' and
						trim(lname,all) <> '' and
						
						//Include records with address (from source or appended)
						((orig_City <> '' and orig_State <> '' and orig_Zip <> '') or
						 (append_p_city_name <> ''and  append_st <> '' and append_zip <> ''))
						);

//Select records with valid phone numbers
phonesplus_v2.Mac_Filter_Bad_Phones (phone_file,phone,,,phone_f);

//map to a common layout
Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	orig_addr1 := StringLib.StringCleanSpaces(input.orig_PrimaryHouseNumber + ' ' + input.orig_PrimaryPreDirAbbrev + ' ' + input.orig_PrimaryStreetName + ' ' + input.orig_PrimaryStreetType +  ' ' + input.orig_PrimaryPostDirAbbrev);
	orig_addr2 := StringLib.StringCleanSpaces(input.orig_SecondaryAptType +  ' ' + input.orig_SecondaryAptNbr);

// ************ Determine if address will be appended from header
	appended_addr := if(
					 (input.append_in_eq    <> ''or
					 input.append_in_wp    <> ''or
					 input.append_in_util  <> ''or
					 input.append_in_ts    <> '') and 
					 (length(trim(orig_addr1 + orig_addr2,all)) = 0 or
					  input.err_stat[1] = 'E'), true, false);

// ************ Choose source for src fields
	hdr_source := map(appended_addr and input.append_in_ts   <> '' => input.append_in_ts,
					  appended_addr and input.append_in_util <> '' => input.append_in_util,
					  appended_addr and input.append_in_wp   <> '' => input.append_in_wp,
					  appended_addr and input.append_in_eq   <> '' => input.append_in_eq,
					  '');

	self.DateFirstSeen 				:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_first_seen) [1..6];
	self.DateLastSeen 				:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_last_seen) [1..6];
	self.DateVendorLastReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_last_reported) [1..6];
	self.DateVendorFirstReported 	:= (unsigned3) _validate.date.fCorrectedDateString((string)input.dt_vendor_first_reported) [1..6];

	self.orig_dt_last_seen			:= self.DateLastSeen;
	
//G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility
	self.glb_dppa_flag		 		:= if(appended_addr and mdr.sourcetools.sourceisglb(hdr_source), 'G', if(mdr.Source_is_Utility(hdr_source), 'U', ''));
	
	self.src_all						:= translation_codes.source_bitmap_code(mdr.sourceTools.src_InfutorCID) | translation_codes.source_bitmap_code(hdr_source);
	self.append_avg_source_conf 	:= phonesplus_v2.Translation_Codes.source_conf(mdr.sourceTools.src_InfutorCID);
	self.append_max_source_conf 	:= self.append_avg_source_conf;
	self.append_min_source_conf 	:= self.append_avg_source_conf;
	self.append_total_source_conf   := self.append_avg_source_conf;
	
	self.OrigName					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname);
	self.Address1				:= orig_addr1;
	self.Address2				:= orig_addr2;
	self.OrigCity					:= input.orig_City;
	self.OrigState					:= input.orig_State;
	self.OrigZip					:= input.zip+input.zip4;
	self.orig_listing_type		 	:= input.orig_RecordType;
	self.orig_conf_score			:= input.orig_telephoneconfidencescore;
	self.max_orig_conf_score		:= (unsigned)input.orig_telephoneconfidencescore;
	self.min_orig_conf_score 		:= (unsigned)input.orig_telephoneconfidencescore;
	self.cur_orig_conf_score		:= if(input.historical = false, (unsigned)input.orig_telephoneconfidencescore,0);
	self.orig_phone_type		 	:= input.orig_phonetype;
	self.orig_phone					:= Fn_Clean_Phone10(input.phone);
	self.orig_carrier_name			:= input.orig_TelcoName;
	self.npa						:= self.orig_phone[..3];
	self.phone7						:= self.orig_phone[4..];
//************Cleaned Address fields
	self.prim_range				    :=if(appended_addr, input.append_prim_range,  input.prim_range);
	self.predir 					:=if(appended_addr, input.append_predir,      input.predir) ;
	self.prim_name 					:=if(appended_addr, input.append_prim_name,   input.prim_name);
	self.addr_suffix 				:=if(appended_addr, input.append_addr_suffix, input.addr_suffix);
	self.postdir 					:=if(appended_addr, input.append_postdir,     input.postdir);
	self.sec_range 					:=if(appended_addr, input.append_sec_range,   input.sec_range);
	self.p_city_name 				:=if(appended_addr, input.append_p_city_name, input.p_city_name);
	self.state 						:=if(appended_addr, input.append_st,          input.st);
	self.zip5 						:=if(appended_addr, input.append_zip,         input.zip);
	self.zip4 						:=if(appended_addr, input.append_zip4,        input.zip4);
//************Fields appended by address cleaner.  Appended addresses don't have those fields
	self.v_city_name  				:=if(appended_addr, '', input.v_city_name);
	self.cart 						:=if(appended_addr, '', input.cart);
	self.cr_sort_sz 				:=if(appended_addr, '', input.cr_sort_sz);
	self.lot 						:=if(appended_addr, '', input.lot);
	self.lot_order 					:=if(appended_addr, '', input.lot_order);
	self.dpbc 						:=if(appended_addr, '', input.dbpc);
	self.chk_digit 					:=if(appended_addr, '', input.chk_digit);
	self.rec_type 					:=if(appended_addr, '', input.rec_type); 
	self.ace_fips_st 				:=if(appended_addr, '', input.county[..2]); 
	self.ace_fips_county 			:=if(appended_addr, '', input.county[3..]); 
	self.geo_lat 					:=if(appended_addr, '', input.geo_lat); 
	self.geo_long 					:=if(appended_addr, '', input.geo_long); 	
	self.msa 						:=if(appended_addr, '', input.msa); 
	self.geo_blk 					:=if(appended_addr, '', input.geo_blk);
	self.geo_match 					:=if(appended_addr, '', input.geo_match); 
	self.err_stat 					:=if(appended_addr, '', input.err_stat);
	self.name_score					:=  input.name_score;
	self.did 						:= if(input.did > 0,  input.did, input.did_instantID);
	//self.did_score 					:= if(input.did_score > 0,  input.did_score, input.did_score_instantID);
	self.phone7_did_key         	:= hashmd5((data)input.phone [length(input.phone) - 6 ..length(input.phone)] + (data)(unsigned)self.did);
	self.source				:= mdr.sourceTools.src_InfutorCID; //DF-25784
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

export Map_InfutorCid_as_Phonesplus	:= project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_InfutorCid_as_Phonesplus');		