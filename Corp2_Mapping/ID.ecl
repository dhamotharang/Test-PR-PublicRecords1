import Corp2, _validate, Address, _control, versioncontrol;

export ID := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		// ID only has one vendor layout.
		export VendorLayout := record
			string1 	File_Type;
			string7 	File_Number;
			string1 	Dup_Number_Indicator;
			string77 	File_Name;
			string50 	Additional_Name_Line;
			string1 	Officer_Type;
			string1 	Office_Held;
			string9 	Date_Appointed;
			string40 	Officer_Name;
			string30 	Officer_Street;
			string30 	Officer_Bldng;
			string20 	Officer_City;
			string2 	Officer_State;
			string5 	Officer_Zip5;
			string4 	Officer_Zip4;
			string20 	Officer_Country;
			string8 	Officer_Foreign_Zip;
			string20 	State_of_Origin;
			string1 	Corporation_Type;
			string9 	File_Date;
			string1 	Current_Status;
			string9 	Status_Change_Date;
			string40 	Entity_Name;
			string30 	Entity_Street;
			string30 	Entity_Bldng;
			string20 	Entity_City;
			string2 	Entity_State;
			string5 	Entity_Zip5;
			string4 	Entity_Zip4;
			string20 	Entity_Country;
			string8 	Entity_Foreign_Zip;
			string40 	Nature_of_Business;
			string2 	lf;
		end;
		
	end; // end of Layouts_Raw_Input module
	
	export PreCleanedCommonLayouts := module;

		// This is the pre-cleaned corp layout. It doesn't include any of the parsed name 
		// or address fields.  	
		export corpPre := record
			corp2_mapping.Layout_CorpPreClean;
			string20	corp_address_country;
			string20	corp_ra_address_country;
		end;
		
		export contPre := record
			corp2_mapping.Layout_ContPreClean;
			string20	cont_address_country;
		end;//End of contact record.M.R.

	end; // end of PreCleanedCommonLayouts module	
	
	export Files_Raw_Input := MODULE;
	    
		// vendor file definition
		export VendorRaw(string filedate) := dataset(	'~thor_data400::in::corp2::'+filedate+'::VendorRaw::ID',	
														layouts_Raw_Input.VendorLayout,
														flat
													 );
									 
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		reformatDate(string inDate) := function
			string clean_inDate := trim(regexreplace('0:00',inDate,''),left,right);
			string2 outMM := if(clean_inDate[2] = '/',
								'0'+ clean_inDate[1],
								clean_inDate[1..2]);
			string2 outDD := if(clean_inDate[length(clean_inDate)-6] = '/',
								'0'+ clean_inDate[length(clean_inDate)-5],
								clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]);
			string8 newDate := clean_inDate[length(clean_inDate)-3..]+outMM+outDD;	
			return newDate;	
		end;
		
		ISOCountryCodesLayout := record,MAXLENGTH(100)
			string code;
			string countryName;
		end; 
	
		ISOCountryCodeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::ISOCountryCodes_Table', ISOCountryCodesLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));				

		ForgnStateDescLayout := record,MAXLENGTH(100)
			string desc;
			string code;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::statetable_id', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		trimFilterUpper(string s, string r) := function
			return trim(StringLib.StringFilterOut(stringlib.StringtoUpperCase(s),r),left,right);
		end;
		
		PreCleanedCommonLayouts.corpPre corpTransform(Layouts_Raw_Input.VendorLayout input, ForgnStateDescLayout r ) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '16-' + trimUpper(input.file_type + input.file_number + input.dup_number_indicator);
			self.corp_vendor					:= '16';
			self.corp_state_origin				:= 'ID';
			self.corp_process_date				:= fileDate;
			
			strippedFileNumber					:= (string)(integer)trim(input.file_number,left,right);
			
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.file_type + strippedFileNumber + input.dup_number_indicator);
			self.corp_src_type					:= 'SOS';						
			self.corp_legal_name				:= trim(trimFilterUpper(input.file_name + ' ' + input.additional_name_line,'"'),left,right); 														
			self.corp_ln_name_type_cd			:= '01';													   
			self.corp_ln_name_type_desc			:= 'LEGAL';
			
			cleanStatus							:= trimUpper(input.current_status);
			
			self.corp_status_cd					:= if (	cleanStatus <>'U',
														cleanStatus,
														''
													   );
													   
			self.corp_status_desc				:= map(	
														cleanStatus = 'A' => 'ADMINISTRATIVELY DISSOLVED',
														cleanStatus = 'B' => 'ADMINISTRATIVELY REVOKED',
														cleanStatus = 'C' => 'CURRENT',
														cleanStatus = 'D' => 'DISSOLVED',														
														cleanStatus = 'E' => 'EXPIRED',
														cleanStatus = 'F' => 'FORFEITED',
														cleanStatus = 'G' => 'GOOD STANDING',
														cleanStatus = 'H' => 'CANCELLATION',
														cleanStatus = 'J' => 'ADMINISTRATIVELY CANCELLED',
														cleanStatus = 'K' => 'CONVERTED',
														cleanStatus = 'L' => 'CONSOLIDATION',
														cleanStatus = 'P' => 'PENDING',
														cleanStatus = 'R' => 'REVOKED',
														cleanStatus = 'S' => 'LLP REVOKED',
														cleanStatus = 'T' => 'EXTENDED',
														cleanStatus = 'W' => 'WITHDRAWN',
														cleanStatus = 'X' => 'MERGED OUT',
														cleanStatus = 'Y' => 'EXISTING',
														cleanStatus = 'Z' => 'HISTORICAL',
														''
													   );
											
			SELF.corp_status_date				:= if(	trim(input.status_change_date,left,right) <> '' and 
														_validate.date.fIsValid(input.status_change_date[2..9]), 
														input.status_change_date[2..9],
														''
												     );
													   
			self.corp_inc_state					:= if(trimUpper(input.state_of_origin) = 'ID' or trimUpper(input.state_of_origin) = '',
			                                          'ID',
													  ''
												   );
												   
			self.corp_forgn_state_cd            := if(trimUpper(input.state_of_origin) <> 'ID' and trimUpper(input.state_of_origin) <> '',
			                                          trimUpper(input.state_of_origin),
													  ''
												   );
												   
			self.corp_forgn_state_desc          := if(trimUpper(input.state_of_origin) <> 'ID' and trimUpper(input.state_of_origin) <> '',
			                                          trimUpper(r.desc),
													  ''
												   );
												   
			self.corp_ra_name					:= if (	trimUpper(input.office_held) = '',
														trimUpper(input.officer_name),
														''
													   );
													   
			self.corp_ra_title_desc				:= if (	trimUpper(input.office_held) = '',
														'REGISTERED AGENT',
														''
													   );
													   
			self.corp_ra_effective_date			:= if (	trimUpper(input.office_held) = '' and 
														trim(input.date_appointed,left,right) <> '' and 
														_validate.date.fIsValid(input.date_appointed[2..9]) and 
														_validate.date.fIsValid(input.date_appointed[2..9],_validate.date.rules.DateInPast),
														input.date_appointed[2..9],
														''
													   );
			
			self.corp_address1_line1 			:= trimUpper(input.entity_name);
			self.corp_address1_line2			:= trim(trimUpper(input.entity_street + ' ' + input.entity_bldng),left,right);
			self.corp_address1_line3			:= trimUpper(input.entity_city);
			self.corp_address1_line4			:= trimUpper(input.entity_state);
			self.corp_address1_line5			:= if(	(string)(integer)trim(input.entity_zip5,left,right) <> '0',
														if( (string)(integer)trim(input.entity_zip4,left,right) <> '0',
															trim(input.entity_zip5 + input.entity_zip4,left,right),
															trim(input.entity_zip5,left,right)
														   ),
														input.entity_foreign_zip
													  );
													  
		    self.corp_address1_type_cd			:= if(	trim(input.entity_name,left,right) <> '' or 
														trim(input.entity_street,left,right) <> '' or 
														trim(input.entity_bldng,left,right) <> '' or
														trim(input.entity_city,left,right) <> '' or 
														trim(input.entity_state,left,right) <>'' or 
														trim(input.entity_zip5,left,right) <> '' or 
														trim(input.entity_foreign_zip,left,right) <> '',
														'M',
														''
													  );
													  
		    self.corp_address1_type_desc		:= if(	trim(input.entity_name,left,right) <> '' or 
														trim(input.entity_street,left,right) <> '' or 
														trim(input.entity_bldng,left,right) <> '' or
														trim(input.entity_city,left,right) <> '' or 
														trim(input.entity_state,left,right) <>'' or 
														trim(input.entity_zip5,left,right) <> '' or 
														trim(input.entity_foreign_zip,left,right) <> '',
														'MAILING',
														''
													  );
													  
			self.corp_address_country			:= trimUpper(input.entity_country);
													  
			self.corp_ra_address_line1 			:= if (	trimUpper(input.office_held) = '',
														trimUpper(input.officer_name),
														''
													   );
			self.corp_ra_address_line2			:= if (	trimUpper(input.office_held) = '',
														trim(trimUpper(input.officer_street + ' ' + input.officer_bldng),left,right),
														''
													   );
			self.corp_ra_address_line3			:= if (	trimUpper(input.office_held) = '',
														trimUpper(input.officer_city),
														''
													   );
			self.corp_ra_address_line4			:= if (	trimUpper(input.office_held) = '',
														trimUpper(input.officer_state),
														''
													   );
			self.corp_ra_address_line5			:= if(	trimUpper(input.office_held) = '',
														if(	(string)(integer)trim(input.officer_zip5,left,right) <> '0',
															if( (string)(integer)trim(input.officer_zip4,left,right) <> '0',
																trim(input.officer_zip5 + input.officer_zip4,left,right),
																trim(input.officer_zip5,left,right)
															   ),
															input.officer_foreign_zip
															),
														''
													  );
													  
		    self.corp_ra_address_type_cd		:= if(	trimUpper(input.office_held) = '' and 
														(trim(input.officer_name,left,right) <> '' or 
														trim(input.officer_street,left,right) <> '' or 
														trim(input.officer_bldng,left,right) <> '' or
														trim(input.officer_city,left,right) <> '' or 
														trim(input.officer_state,left,right) <>'' or 
														trim(input.officer_zip5,left,right) <> '' or 
														trim(input.officer_foreign_zip,left,right) <> ''),
														'1',
														''
													  );
													  
		    self.corp_ra_address_type_desc		:= if(	trimUpper(input.office_held) = '' and 
														(trim(input.officer_name,left,right) <> '' or 
														trim(input.officer_street,left,right) <> '' or 
														trim(input.officer_bldng,left,right) <> '' or
														trim(input.officer_city,left,right) <> '' or 
														trim(input.officer_state,left,right) <>'' or 
														trim(input.officer_zip5,left,right) <> '' or 
														trim(input.officer_foreign_zip,left,right) <> ''),
														'REGISTERED OFFICE',
														''
													  );
													  
			self.corp_ra_address_country		:= if(	trimUpper(input.office_held) = '',
															trimUpper(input.officer_country),
															''
													  );
			

			self.corp_inc_date                  := if((	trimUpper(input.state_of_origin) = 'ID' or trimUpper(input.state_of_origin) = '') and 
														trim(input.file_date,left,right) <> '' and 
														_validate.date.fIsValid(input.file_date[2..9]) and 
														_validate.date.fIsValid(input.file_date[2..9],_validate.date.rules.DateInPast),
														input.file_date[2..9],
														''
												     );
													
			self.corp_forgn_date 				:= if((	trimUpper(input.state_of_origin) <>'ID' and trimUpper(input.state_of_origin) <>'') and 
														trim(input.file_date,left,right) <> '' and 
														_validate.date.fIsValid(input.file_date[2..9]) and 
														_validate.date.fIsValid(input.file_date[2..9],_validate.date.rules.DateInPast),
														input.file_date[2..9],
														''
												      );
													  
			self.corp_orig_bus_type_desc		:= input.nature_of_business;
													
			CleanCorpType						:= TrimUpper(input.corporation_type);
													
			self.corp_orig_org_structure_cd     := CleanCorpType;
			
			self.corp_orig_org_structure_desc   := map(	
														CleanCorpType = 'B' => 'GENERAL BUSINESS',
														CleanCorpType = 'C' => 'COOPERATIVE MARKETING ASSOC.',
														CleanCorpType = 'D' => 'ASSUMED BUSINESS NAME',
														CleanCorpType = 'E' => 'EDUCATIONAL',														
														CleanCorpType = 'F' => 'FEDERAL CHARTERED',
														CleanCorpType = 'G' => 'PARTNERSHIP AUTHORITY',
														CleanCorpType = 'H' => 'HOMEOWNERS ASSOC.',
														CleanCorpType = 'I' => 'INSURANCE COMPANY',
														CleanCorpType = 'J' => 'LIMITED LIABILITY PARTNERSHIP',
														CleanCorpType = 'K' => 'PROFESSIONAL LIMITED LIABILITY',
														CleanCorpType = 'L' => 'LIMITED PARTNERSHIP',
														CleanCorpType = 'M' => 'LIMITED LIABILITY COMPANY',
														CleanCorpType = 'N' => 'GENERAL NON-PROFIT',
														CleanCorpType = 'O' => 'NO FILING',
														CleanCorpType = 'P' => 'PROFESSIONAL ASSOC.',
														CleanCorpType = 'Q' => 'FRATERNAL, BENEVOLENT, ETC.',
														CleanCorpType = 'R' => 'RELIGIOUS',
														CleanCorpType = 'S' => 'CORPORATION SOLE',
														CleanCorpType = 'T' => 'TITLE TRUST',
														CleanCorpType = 'U' => 'UNINCORPORATED NON-PROFIT ASSOCIATION',
														CleanCorpType = 'V' => 'MUNICIPAL CORPORATION',
														CleanCorpType = 'W' => 'WATER USERS ASSOCIATION',
														CleanCorpType = 'Y' => 'REGISTRATION',
														CleanCorpType = 'Z' => 'RESERVATION',
														''
													   );														   			
			self := [];
						
		end; // end Corp Transform
				
		PreCleanedCommonLayouts.contPre contTransform(Layouts_Raw_Input.VendorLayout input, ISOCountryCodesLayout r ) := transform, skip(trimUpper(input.office_held) = '' or trimUpper(input.officer_type) = 'N')

			self.dt_first_seen				:=fileDate;
			self.dt_last_seen					:=fileDate;

			self.corp_key						:= '16-' + trimUpper(input.file_type + input.file_number + input.dup_number_indicator);
			self.corp_vendor					:= '16';
			self.corp_state_origin				:= 'ID';
			self.corp_process_date				:= fileDate;
			
			strippedFileNumber					:= (string)(integer)trim(input.file_number,left,right);
			
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.file_type + strippedFileNumber + input.dup_number_indicator);
			
			self.corp_legal_name				:= trim(trimFilterUpper(input.file_name + ' ' + input.additional_name_line,'"'),left,right); 
			
			
			cleanOfficerType					:= trimUpper(input.officer_type); 	
			self.cont_status_cd					:= cleanOfficerType; 														
			self.cont_status_desc				:= map(	cleanOfficerType = 'A' => 'INITIAL',
														cleanOfficerType = 'C' => 'CURRENT',
														cleanOfficerType = 'D' => 'DISSOCIATED',														
														cleanOfficerType = 'P' => 'APPOINTED',
														cleanOfficerType = 'R' => 'RESIGNED',
														''
													   );
			self.cont_type_cd					:= 'F';
			self.cont_type_desc					:= 'OFFICER'; 			
			
			cleanOfficeHeld						:= trimUpper(input.office_held); 	
														
			self.cont_title1_desc				:= map(	cleanOfficeHeld = 'D' => 'DIRECTOR',
														cleanOfficeHeld = 'E' => 'DIRECTOR/INCORPORATOR',
														cleanOfficeHeld = 'G' => 'GENERAL PARTNER',														
														cleanOfficeHeld = 'I' => 'INCOPORATOR',
														cleanOfficeHeld = 'L' => 'LIMITED PARTNER',
														cleanOfficeHeld = 'P' => 'PRESIDENT',
														cleanOfficeHeld = 'R' => 'OWNER',
														cleanOfficeHeld = 'S' => 'SECRETARY',
														cleanOfficeHeld = 'X' => 'FILING OFFICER',
														cleanOfficeHeld = 'Y' => 'MANAGER',
													    cleanOfficeHeld = 'Z' => 'MEMBER',
														''
													   );
													   
			self.cont_effective_date			:= if(	trim(input.date_appointed,left,right) <> '' and 
														_validate.date.fIsValid(input.date_appointed[2..9]) and 
														_validate.date.fIsValid(input.date_appointed[2..9],_validate.date.rules.DateInPast),
														input.date_appointed[2..9],
														''
												      );
													  
			self.cont_name						:= trimUpper(input.officer_name);
			
			self.cont_address_line1 			:= trimUpper(input.officer_name),
														
			self.cont_address_line2				:= trim(trimUpper(input.officer_street + ' ' + input.officer_bldng),left,right),
														
			self.cont_address_line3				:= trimUpper(input.officer_city),
														
			self.cont_address_line4				:= trimUpper(input.officer_state),
														
			self.cont_address_line5				:= if(	(string)(integer)trim(input.officer_zip5,left,right) <> '0',
															if( (string)(integer)trim(input.officer_zip4,left,right) <> '0',
																trim(input.officer_zip5 + input.officer_zip4,left,right),
																trim(input.officer_zip5,left,right)
															   ),
															input.officer_foreign_zip
															);
																						
			self.cont_address_line6				:= r.code;
																											  
		    self.cont_address_type_cd			:= if(	trim(input.officer_name,left,right) <> '' or 
														trim(input.officer_street,left,right) <> '' or 
														trim(input.officer_bldng,left,right) <> '' or
														trim(input.officer_city,left,right) <> '' or 
														trim(input.officer_state,left,right) <>'' or 
														trim(input.officer_zip5,left,right) <> '' or 
														trim(input.officer_foreign_zip,left,right) <> '',
														'T',
														''
													  );
													  
		    self.cont_address_type_desc			:= if(	trim(input.officer_name,left,right) <> '' or 
														trim(input.officer_street,left,right) <> '' or 
														trim(input.officer_bldng,left,right) <> '' or
														trim(input.officer_city,left,right) <> '' or 
														trim(input.officer_state,left,right) <>'' or 
														trim(input.officer_zip5,left,right) <> '' or 
														trim(input.officer_foreign_zip,left,right) <> '',
														'CONTACT',
														''
													  );
													  
			self := [];	
			
		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(PreCleanedCommonLayouts.corppre input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 			:= Address.CleanAddress182(trim(input.corp_address1_line2,left,right),
														                   trim(trim(input.corp_address1_line3,left,right) + ', ' +
																				trim(input.corp_address1_line4,left,right) + ' ' +
																				trim(input.corp_address1_line5,left,right),
																				left,right));			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(input.corp_ra_address_line2,left,right),																				
														                   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right),
																				left,right));	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			      	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  			:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      		:= clean_ra_address[167..170];
			self.corp_ra_geo_blk				:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
			
			self.corp_addr1_prim_range    		:= clean_address[1..10];
			self.corp_addr1_predir 	      		:= clean_address[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address[47..56];
			self.corp_addr1_sec_range 	  		:= clean_address[57..64];
			self.corp_addr1_p_city_name	  		:= clean_address[65..89];
			self.corp_addr1_v_city_name	  		:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     	:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address[135];
			self.corp_addr1_dpbc 		     	:= clean_address[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk				:= clean_address[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self								:= input;
			self 								:= [];
		end;						
		
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(PreCleanedCommonLayouts.contPre input) := transform		
			string73 tempname 					:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_address 			:= Address.CleanAddress182(trim(input.cont_address_line2,left,right),
														                   trim(trim(input.cont_address_line3,left,right) + ', ' +
																				trim(input.cont_address_line4,left,right) + ' ' +
																				trim(input.cont_address_line5,left,right),
																				left,right));	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 			:= clean_address[90..114];
			self.cont_state 			      	:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     		:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	 	 			:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk					:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];

			self								:= input;
			self 								:= [];
		end;
	
		corps := join(	Files_Raw_Input.vendorRaw(filedate), ForgnStateTable,
						trimUpper(left.state_of_origin) = right.code,
						corpTransform(left,right),
						left outer, lookup
					  );
					  
		PreCleanedCommonLayouts.corppre findISOAddr1(PreCleanedCommonLayouts.corppre input, ISOCountryCodesLayout r ) := transform
			self.corp_address1_line6        := r.code;
			self         			 		:= input;
			self                           	:= [];
		end; // end transform					  
					  
		corpsISOAddr1 := join(corps, ISOCountryCodeTable,
								trimUpper(left.corp_address_country) = trim(right.countryName,left,right),
								findISOAddr1(Left,right),
								left Outer, lookup
							 );
							 
		PreCleanedCommonLayouts.corppre findISOAddr2(PreCleanedCommonLayouts.corppre input, ISOCountryCodesLayout r ) := transform
			self.corp_ra_address_line6      := r.code;
			self         			 		:= input;
			self                           	:= [];
		end; // end transform							 
							 
		corpsISOAddr2 := join(corpsISOAddr1, ISOCountryCodeTable,
								trimUpper(left.corp_ra_address_country) = trim(right.countryName,left,right),
								findISOAddr2(Left,right),
								left Outer, lookup
							 );							 
		
		cleanCorps := project(corpsISOAddr2, CleanCorpAddrName(left));
		
		
		conts := join(	Files_Raw_Input.vendorRaw(filedate), ISOCountryCodeTable,
						trimUpper(left.officer_country) = trim(right.countryName,left,right),
						contTransform(left,right),
						left outer, lookup
					  );
					  
		cleanConts := project(conts, CleanContAddrName(left));

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ID',cleanCorps,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ID',cleanConts,cont_out	,,,pOverwrite);
		                                                                                                                                                       
		mapIDCorpFiling := parallel(
			 corp_out	
			,cont_out	
		);
		
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('id',filedate,pOverwrite := pOverwrite))
			,mapIDCorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_id')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_id')
			)							
		);

		return result;
	end;					 
	
end; // end of ID module