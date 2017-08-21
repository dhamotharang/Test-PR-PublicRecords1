import Address, gong,ut, cellphone,InfutorCID,risk_indicators,header,header_quick, yellowpages,MDR;

//*********Define Base file Infutor and create a persist file with unique phone numbers

//*******Temp Code while Infutor confidence score changes are investigated
		//Take original file (June2009) and add any new phones in August

infutor_original 		:= dataset('~thor_data400::out::infutorcid::20090623d',infutorCID.Layout_InfutorCID_Base, thor);
infutor_update			:= InfutorCID.File_InfutorCID_Base;

recordof(infutor_update) t_add_additional_phones(infutor_original le, infutor_update ri) := transform
self := ri;
end;

Additional_in_update := join(distribute(infutor_original, hash(phone)), 
							 distribute(infutor_update, hash(phone)), 
							 left.phone = right.phone,
							 t_add_additional_phones(left, right),
							 right only,
							 local);


infutorCID_f 			:= infutor_original + Additional_in_update;

infutorCID_with_ph 		:= 
						//Include records with a phone
					     infutorCID_f ((string)phone != '' and length(stringlib.stringfilter((string)phone,'0123456789')) = 10 and 
						(string)phone[7..10] != '0000' and (string)phone[7..10] != '9999' and
						
						//Exclude phones with low confidence
						orig_telephoneconfidencescore not in ['4','5'] and
						
						//Include records with RecordType R and with a name
	                    Orig_RecordType = 'R' and
						trim(lname,all) <> '' and
						
						//Include records an address (from source or appended)
						((orig_City <> '' and orig_State <> '' and orig_Zip <> '') or
						 (append_p_city_name <> ''and  append_st <> '' and append_zip <> '')) and
						 historical = false
						);
				
//-------------------------------------------
						
//**********Reformat InfutorCID to phonesplus common layout
Phonesplus.layoutCommonOut t_infutorCID(infutorCID_with_ph  input) := Transform

	phplus_source 					:= 'infutorcid';
	
	orig_addr1 := StringLib.StringCleanSpaces(input.orig_PrimaryHouseNumber + ' ' + input.orig_PrimaryPreDirAbbrev + ' ' + input.orig_PrimaryStreetName);
	orig_addr2 := StringLib.StringCleanSpaces(input.orig_PrimaryStreetType + ' ' + input.orig_PrimaryPostDirAbbrev + ' ' + input.orig_SecondaryAptType +  ' ' + input.orig_SecondaryAptNbr);
	CleanCellPhone					:= CellPhone.CleanPhones(input.phone);
	
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
						 
	self.DateVendorFirstReported 	:= (unsigned)(string)input.dt_vendor_first_reported[..6];
	self.DateVendorLastReported 	:= (unsigned)(string)input.dt_vendor_last_reported[..6];
	self.DateFirstSeen 				:= (unsigned)(string)input.dt_first_seen[..6];
	self.DateLastSeen 				:= (unsigned)(string)input.dt_last_seen[..6];
	self.dt_nonglb_last_seen 		:= 0;

	//G=GLB, D=DPPA, B=Both, ''=Neither, 'U'=Utility
	self.glb_dppa_flag		 		:= if(appended_addr = true and input.append_only_glb, 'G', if(hdr_source in Phonesplus.Codes.utility_src, 'U', '')); 						   
	self.ActiveFlag					:= '';
	self.CellphoneIDKey             := if(appended_addr,
											hashmd5((data)input.phone +(data)input.append_zip+(data)input.append_prim_range+(data)input.append_prim_name),
											hashmd5((data)input.phone +(data)input.zip+(data)input.prim_range+(data)input.prim_name));;
	self.phone7IDKey           		:= if(appended_addr,
											hashmd5((data)input.phone[1..7] +(data)input.append_zip+(data)input.append_prim_range+(data)input.append_prim_name),
											hashmd5((data)input.phone[1..7] +(data)input.zip+(data)input.prim_range+(data)input.prim_name));

	self.InitScore					:= if((unsigned1)input.orig_telephoneconfidencescore = 2, 11, Phonesplus.Codes.initial_score(phplus_source));
	self.ConfidenceScore			:= 0;
	
	self.Vendor 					:= Phonesplus.Codes.vendor_code(phplus_source);
	self.StateOrigin 				:= '';
	self.SourceFile 				:= Phonesplus.Codes.source_file(phplus_source);
	self.src						:= hdr_source;
	self.OrigName 					:= StringLib.StringCleanSpaces(input.fname + ' ' + input.mname + ' ' + input.lname);
	self.NameFormat 				:= 'F';
	self.Address1 					:= orig_addr1;
	self.Address2 					:= orig_addr2;
	self.Address3 					:= '';
	self.OrigCity 					:= input.orig_City;
	self.OrigState 					:= input.orig_State;
	self.OrigZip 					:= input.orig_Zip+input.orig_Zip4;
	self.CellPhone 					:= if (CleanCellPhone[1] != '0' and CleanCellPhone[1] != '1',
									   CleanCellPhone, '');
	self.ListingType		 		:= input.orig_RecordType;
	self.PublishCode		 		:= '';

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

	self.did 						:= if(input.did > 0,  input.did, input.did_instantID);
	//self.did_score 					:= if(input.did_score > 0,  (string)input.did_score, (string)input.did_score_instantID);
	
	//Using unused field to place values that can be used for testing
	self.CarrierCode				:= input.orig_phonetype;
	self.KeyCode					:= input.orig_telephoneconfidencescore;
	self.GlobalKeyCode			    := input.append_in_eq + input.append_in_wp + input.append_in_util + input.append_in_ts; 
	
	//temp use to test area code change
	self.OrigTitle					:= input.phone[..3];
	
	self 							:= input;
end;

infutorCID_p := project(infutorCID_with_ph ,t_infutorCID(left));
//Apply Area Code Change
ut.mac_phone_areacode_corrections(infutorCID_p,infutorCID_p_areacode, Cellphone);

export map_InfutorCID_asPhonesplus := infutorCID_p_areacode(Cellphone != '' and OrigName != '') 
									  : PERSIST('~thor400_30::persist::Phonesplus::map_InfutorCID_asPhonesplus');