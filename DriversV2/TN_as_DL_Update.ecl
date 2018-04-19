IMPORT Ut;

export TN_as_DL_Update (dataset(DriversV2.Layouts_DL_TN_In.Layout_TN_Update2_Cleaned) in_file):=function

																												// process each two-character restriction code
	string f2CharCodeAndComma(string pRestrictionCode) := if(trim(pRestrictionCode,right)<>'', ',' + 
																													 trim(pRestrictionCode,right),'');

	Valid_Lic_type_cd 		  := ['A','AM','AMPA','AMPB','AMPC','APA','APB','APC',
															'B','BM','BMPA','BMPB','BMPC','BPA','BPB','BPC',
															'C','CM','CMPA','CMPB','CMPC','CPA','CPB','CPC',
															'D','DM','DMPA','DMPB','DMPC','DPA','DPB','DPC',
														  'DPM','HPM','ID','M','MPA','MPB','MPC','MPD','PD',
															'PDPM','PM','XD','XDM','XH','XHPM','XID','XM','XMPD',
															'XPD','XMPD','XPM'];
	bad_names  							 := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE','SEND TO'];
	bad_mnames 							 := ['NMN','NMI','INFORMATION'];
	 
	DriversV2.Layout_DL_Extended lTransform_TN_To_Common(DriversV2.Layouts_DL_TN_In.Layout_TN_Update2_Cleaned pInput):= TRANSFORM
		
		SELF.orig_state 			  						:= 'TN';
		SELF.dt_first_seen 			  					:= IF(pInput.orig_ISSUE_DATE = '',0,(UNSIGNED8)pInput.orig_ISSUE_DATE div 100);
		SELF.dt_last_seen 			  					:= IF(pInput.orig_ISSUE_DATE = '',0,(UNSIGNED8)pInput.orig_ISSUE_DATE div 100);
		SELF.dt_vendor_first_reported				:= (UNSIGNED8)pInput.process_date div 100;
		SELF.dt_vendor_last_reported 				:= (UNSIGNED8)pInput.process_date div 100;
		SELF.dateReceived										:= (INTEGER)pInput.PROCESS_DATE;
		SELF.name				     								:= TRIM(pInput.orig_FIRST_NAME)
																					 + TRIM(' ' + pInput.orig_MIDDLE_NAME)
																					 + TRIM(' ' + pInput.orig_LAST_NAME)
																					 + TRIM(' ' + pInput.orig_NAME_SUFFIX);
		SELF.RawFullName     								:= TRIM(pInput.orig_FIRST_NAME)
																					 + TRIM(' ' + pInput.orig_MIDDLE_NAME)
																					 + TRIM(' ' + pInput.orig_LAST_NAME)
																					 + TRIM(' ' + pInput.orig_NAME_SUFFIX);																		
		SELF.addr1					 								:= TRIM(pInput.orig_STREET_ADDRESS1,RIGHT) +' '+ TRIM(pInput.orig_STREET_ADDRESS2, LEFT, RIGHT);
		SELF.city 					  							:= TRIM(pInput.orig_CITY);		                             
		SELF.state					  							:= TRIM(pInput.orig_STATE);
		SELF.zip 					  								:= TRIM(pInput.orig_ZIP_CODE);		                             
		SELF.dob 					  								:= (UNSIGNED4)pInput.orig_DOB;
		SELF.sex_flag				  							:= TRIM(pInput.orig_SEX);
		SELF.expiration_date		 						:= (UNSIGNED4)pInput.orig_EXPIRE_DATE;
		SELF.lic_issue_date 		  					:= (UNSIGNED4)pInput.orig_ISSUE_DATE;
		SELF.dl_number 				  						:= TRIM(pInput.orig_DL_NUMBER);
		SELF.height 				  							:= TRIM(pInput.orig_HEIGHT_FT,RIGHT) + TRIM(pInput.orig_HEIGHT_IN, LEFT, RIGHT);
		SELF.weight					  							:= TRIM(pInput.orig_WEIGHT);
		SELF.eye_color	  					  			:= TRIM(pInput.orig_EYE_COLOR);
		SELF.hair_color 						  			:= TRIM(pInput.orig_HAIR_COLOR);
		SELF.restrictions						  			:= TRIM(pInput.orig_RESTRICTIONS1,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_RESTRICTIONS2,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_RESTRICTIONS3,LEFT,RIGHT) +
																					 ' ' + TRIM(pInput.orig_RESTRICTIONS4,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_RESTRICTIONS4,LEFT,RIGHT);
		SELF.restrictions_delimited  				:= TRIM(pInput.orig_RESTRICTIONS1,right) +
																								f2CharCodeAndComma(pInput.orig_RESTRICTIONS2) + 
																								f2CharCodeAndComma(pInput.orig_RESTRICTIONS3) + 
																								f2CharCodeAndComma(pInput.orig_RESTRICTIONS4) + 
																								f2CharCodeAndComma(pInput.orig_RESTRICTIONS5
																								);
		SELF.lic_endorsement				  			:= TRIM(pInput.orig_ENDORSEMENTS1,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_ENDORSEMENTS2,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_ENDORSEMENTS3,LEFT,RIGHT) +
																					 ' ' + TRIM(pInput.orig_ENDORSEMENTS4,LEFT,RIGHT) + ' ' + TRIM(pInput.orig_ENDORSEMENTS5,LEFT,RIGHT);
		SELF.license_class            			:= IF (TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT) IN Valid_Lic_type_cd, '', TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT));
		SELF.license_type			 							:= IF (TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT) IN Valid_Lic_type_cd, TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT), '');	
		SELF.OrigLicenseClass								:= IF (TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT) IN Valid_Lic_type_cd, '', TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT));
		SELF.OrigLicenseType								:= IF (TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT) IN Valid_Lic_type_cd, TRIM(pInput.orig_LICENSE_TYPE, LEFT, RIGHT), '');		
		SELF.moxie_license_type							:= TRIM(pInput.orig_LICENSE_TYPE);
		SELF.title 					 								:= pInput.clean_name_prefix;
		SELF.fname 					  							:= IF (TRIM(pInput.orig_FIRST_NAME, LEFT, RIGHT) IN bad_names,'',pInput.orig_FIRST_NAME);		                             
		SELF.mname 					  							:= IF (TRIM(pInput.orig_MIDDLE_NAME, LEFT, RIGHT) IN bad_names + bad_mnames,'',pInput.orig_MIDDLE_NAME);		                             
		SELF.lname 									  			:= IF (TRIM(pInput.orig_LAST_NAME, LEFT, RIGHT) IN bad_names,'',pInput.orig_LAST_NAME);		                             
		SELF.name_suffix 						  			:= pInput.orig_NAME_SUFFIX;		                             
		SELF.cleaning_score 				  			:= '';		                             
		SELF.prim_range               			:= '';
		SELF.predir 	     					 				:= '';
		SELF.prim_name 	     				  			:= '';
		SELF.suffix               	  			:= '';
		SELF.postdir 	     					  			:= '';
		SELF.unit_desig 	 					  			:= '';
		SELF.sec_range 	     				  			:= '';
		SELF.p_city_name						  			:= '';
		SELF.v_city_name	 					  			:= '';
		SELF.st	         						 				:= '';
		SELF.zip5 		     					  			:= '';
		SELF.zip4 		     					  			:= '';  
		SELF.cart 		     					  			:= ''; 
		SELF.cr_sort_sz 		     						:= ''; 
		SELF.lot 		     					  				:= ''; 
		SELF.lot_order 		     							:= ''; 
		SELF.chk_digit 		     							:= ''; 
		SELF.rec_type 		     							:= ''; 
		SELF.county 		     								:= ''; 
		SELF.geo_lat 		     								:= ''; 
		SELF.geo_long 		     							:= ''; 
		SELF.geo_blk 		     								:= ''; 
		SELF.geo_match 		     							:= ''; 
		SELF.err_stat	 		     							:= ''; 	
		SELF.issuance 				  						:= ''; // has no default
		SELF.status                   			:= pInput.orig_NON_CDL_STATUS;
		SELF.CDL_status               			:= pInput.orig_CDL_STATUS;
		SELF.race	  					        			:= ut.CleanSpacesAndUpper(DriversV2.Tables_CP_TN.Race_V3_Code(pInput.orig_RACE));		
		
	END;

	tn_as_dl_mapper := PROJECT(in_file, lTransform_TN_To_Common(LEFT));
	return tn_as_dl_mapper; 
	
end;