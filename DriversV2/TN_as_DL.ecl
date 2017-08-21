import Ut, lib_stringlib, Drivers;

string1 fSingleEndorsement(string2 pEndorsement)
 := case(pEndorsement,
		 'BS' => 'B',
		 'CH' => 'X',
		 'CT' => 'C',
		 'FH' => 'F',
		 'HM' => 'H',
		 'NN' => 'N',
		 'PS' => 'P',
		 'SB' => 'S',
		 'TT' => 'T',
		 ''
		);

string10 fTranslateEndorsements(string10 pEndorsements)
 := trim(fSingleEndorsement(pEndorsements[1..2]))
 +	trim(fSingleEndorsement(pEndorsements[3..4]))
 +	trim(fSingleEndorsement(pEndorsements[5..6]))
 +	trim(fSingleEndorsement(pEndorsements[7..8]))
 +	trim(fSingleEndorsement(pEndorsements[9..10]))
 ;

string f2CharCodeAndComma(string pRestrictionCode) :=  // process each two-character restriction code
					 if(trim(pRestrictionCode,right)<>'',
						',' + trim(pRestrictionCode,right),
						''
					   );

Valid_Lic_type_cd := ['**','0','00','04','05','0A','1',
                      '10','15','2','20','24','25','3',
					  '30','34','4','5' ,'60','6M','7',
					  '70','80','90'];


bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];
 
DriversV2.Layout_DL_Extended lTransform_TN_To_Common(Drivers.File_TN_Full pInput)
 := transform
	self.orig_state 			  			:= 'TN';
	self.dt_first_seen 			  		:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_last_seen 			  		:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_first_reported := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_last_reported  := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dateReceived							:= (integer)pInput.append_PROCESS_DATE;

	self.name				     					:= trim(pInput.orig_FIRST_NAME)
																		+ trim(' ' + pInput.orig_MIDDLE_NAME)
																		+ trim(' ' + pInput.orig_LAST_NAME)
																		+ trim(' ' + pInput.orig_NAME_SUFFIX);
	self.RawFullName     					:= trim(pInput.orig_FIRST_NAME)
																		+ trim(' ' + pInput.orig_MIDDLE_NAME)
																		+ trim(' ' + pInput.orig_LAST_NAME)
																		+ trim(' ' + pInput.orig_NAME_SUFFIX);																		
	self.addr1					 					:= trim(pInput.orig_STREET_ADDRESS_1) + ' ' + trim(pInput.orig_STREET_ADDRESS_2);
	self.city 					  				:= pInput.orig_CITY;		                             
	self.state					  				:= pInput.orig_STATE;
	self.zip 					  					:= pInput.orig_ZIP_CODE;		                             
	self.dob 					  					:= (unsigned4)pInput.orig_DOB;
	self.sex_flag				  				:= pInput.orig_SEX;
	self.expiration_date		 			:= (unsigned4)pInput.orig_EXPIRE_DATE;
	self.lic_issue_date 		  		:= (unsigned4)pInput.orig_ISSUE_DATE;
	self.dl_number 				  			:= pInput.orig_DL_NUMBER;
	self.height 				  				:= pInput.orig_HEIGHT;
	self.weight					  				:= pInput.orig_WEIGHT;
    self.eye_color						  := pInput.orig_EYE_COLOR;
    self.hair_color						  := pInput.orig_HAIR_COLOR;
	self.restrictions						  := pInput.orig_RESTRICTIONS;
	self.restrictions_delimited   := trim(pInput.orig_RESTRICTIONS[1..2],right) +
																				f2CharCodeAndComma(pInput.orig_RESTRICTIONS[3..4]) + 
																				f2CharCodeAndComma(pInput.orig_RESTRICTIONS[5..6]) + 
																				f2CharCodeAndComma(pInput.orig_RESTRICTIONS[7..8]) + 
																				f2CharCodeAndComma(pInput.orig_RESTRICTIONS[9..10]
																				);
	self.lic_endorsement				  := fTranslateEndorsements(pInput.orig_ENDORSEMENTS);
	self.license_class            := if (trim(pInput.orig_LICENSE_TYPE, left, right) in Valid_Lic_type_cd, '', trim(pInput.orig_LICENSE_TYPE, left, right));
	self.license_type			 				:= if (trim(pInput.orig_LICENSE_TYPE, left, right) in Valid_Lic_type_cd, trim(pInput.orig_LICENSE_TYPE, left, right), '');	
	self.OrigLicenseClass					:= if (trim(pInput.orig_LICENSE_TYPE, left, right) in Valid_Lic_type_cd, '', trim(pInput.orig_LICENSE_TYPE, left, right));
	self.OrigLicenseType					:= if (trim(pInput.orig_LICENSE_TYPE, left, right) in Valid_Lic_type_cd, trim(pInput.orig_LICENSE_TYPE, left, right), '');		
	self.moxie_license_type				:= pInput.orig_LICENSE_TYPE;
	self.title 					 					:= pInput.clean_name_prefix;
	self.fname 					  				:= if (trim(pInput.orig_FIRST_NAME,left,right) in bad_names,'',pInput.orig_FIRST_NAME);		                             
	self.mname 					  				:= if (trim(pInput.orig_MIDDLE_NAME,left,right) in bad_names + bad_mnames,'',pInput.orig_MIDDLE_NAME);		                             
	self.lname 									  := if (trim(pInput.orig_LAST_NAME,left,right) in bad_names,'',pInput.orig_LAST_NAME);		                             
	self.name_suffix 						  := pInput.orig_NAME_SUFFIX;		                             
	self.cleaning_score 				  := pInput.clean_name_score;		                             
	self.prim_range 						  := pInput.clean_prim_range;		                             
	self.predir 								  := pInput.clean_predir;		                             
	self.prim_name 							  := pInput.clean_prim_name;		                             
	self.suffix 								  := pInput.clean_addr_suffix;		                             
	self.postdir 								  := pInput.clean_postdir;		                             
	self.unit_desig 						  := pInput.clean_unit_desig;		                             
	self.sec_range 							  := pInput.clean_sec_range;		                             
	self.p_city_name 						  := pInput.clean_p_city_name;		                             
	self.v_city_name			 			  := pInput.clean_v_city_name;		                             
	self.st 				  				    := pInput.clean_st;		                             
	self.zip5 									  := pInput.clean_zip;		                             
	self.zip4 									  := pInput.clean_zip4;		                             
	self.cart 									  := pInput.clean_cart;		                             
	self.cr_sort_sz 						  := pInput.clean_cr_sort_sz;		                             
	self.lot 								      := pInput.clean_lot;		                             
	self.lot_order 					      := pInput.clean_lot_order;		                             
	self.dpbc 									  := pInput.clean_dpbc;		                             
	self.chk_digit 				  			:= pInput.clean_chk_digit;		                             
	self.rec_type 				  			:= pInput.clean_record_type;		                             
	self.ace_fips_st 			  			:= pInput.clean_ace_fips_st;		                             
	self.county 				  				:= pInput.clean_fipscounty;		                             
	self.geo_lat 				 					:= pInput.clean_geo_lat;		                             
	self.geo_long 				  			:= pInput.clean_geo_long;		                             
	self.msa 				      				:= pInput.clean_msa;		                             
	self.geo_blk 				  				:= pInput.clean_geo_blk;		                             
	self.geo_match 			  	  		:= pInput.clean_geo_match;		                             
	self.err_stat 				  			:= pInput.clean_err_stat;		                             
	self.issuance 				  			:= ''; // has no default
	self.status                   := pInput.orig_NON_CDL_STATUS;
	self.CDL_status               := pInput.orig_CDL_STATUS;
end;

export TN_as_DL := project(Drivers.File_TN_Full + Drivers.File_TN_Update, lTransform_TN_To_Common(left));