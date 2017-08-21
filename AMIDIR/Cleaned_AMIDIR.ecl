import Address, lib_stringlib;


Layout_AMIDIR_Common CleanAMIDIR(Layout_AMIDIR_Common InputRecord) := transform
	string73 tempPhysicianName := stringlib.StringToUpperCase(if(trim(trim(InputRecord.Physician_First_Name,left,right) + ' ' +
																					                          trim(InputRecord.Physician_Last_Name,left,right)  + ' ' +
																					                          trim(InputRecord.Physician_Prof_Suffix,left,right),left,right) <> '',
																	                             Address.CleanPerson73(trim(trim(InputRecord.Physician_Last_Name,left,right) + ', ' +
																	                                                                           trim(InputRecord.Physician_First_Name,left,right) + ' ' +
																					                                                                   trim(InputRecord.Physician_Prof_Suffix,left,right),left,right)),
																		                           if(trim(InputRecord.Physician_Full_Name,left,right) <> '',
																														      Address.CleanPerson73(trim(InputRecord.Physician_Full_Name,left,right)),
																													        '')));
	string182 tempBusinessAddressReturn := stringlib.StringToUpperCase(if(InputRecord.Business_Address_Street_Line <> '' or
																																		   	InputRecord.Business_Address_City <> '' or
																																		  	InputRecord.Business_Address_State <> '' or
																																		  	InputRecord.Business_Address_ZIP_5 <> '',
																																		  	Address.CleanAddress182(trim(InputRecord.Business_Address_Street_Line,left,right),
																							                                                                trim(trim(InputRecord.Business_Address_City,left,right) + ', ' +
																								                                                                   trim(InputRecord.Business_Address_State,left,right) + ' ' +
																																		  												                     trim(InputRecord.Business_Address_ZIP_5,left,right) +
																																		  																						 trim(InputRecord.Business_Address_ZIP_4,left,right),left,right)),
																															    	    ''));
	string182 tempOfficeManagerName := stringlib.StringToUpperCase(if(trim(trim(InputRecord.Office_Manager_First_Name,left,right) + ' ' +
																					                               trim(InputRecord.Office_Manager_Last_Name,left,right),left,right) <> '',
																	                                  Address.CleanPerson73(trim(trim(InputRecord.Office_Manager_Last_Name,left,right) + ', ' +
																	                                                                                trim(InputRecord.Office_Manager_First_Name,left,right),left,right)),
																																		''));																					                                    
	
	self.Physician_Name_Clean_title			      		:= tempPhysicianName[1..5];
	self.Physician_Name_Clean_fname			      		:= tempPhysicianName[6..25];
	self.Physician_Name_Clean_mname			      		:= tempPhysicianName[26..45];
	self.Physician_Name_Clean_lname			      		:= tempPhysicianName[46..65];
	self.Physician_Name_Clean_name_suffix	    		:= tempPhysicianName[66..70];
	self.Physician_Name_Clean_cleaning_score			:= tempPhysicianName[71..73];
	self.Business_Address_Clean_prim_range    		:= tempBusinessAddressReturn[1..10];
	self.Business_Address_Clean_predir 	      		:= tempBusinessAddressReturn[11..12];
	self.Business_Address_Clean_prim_name 	  		:= tempBusinessAddressReturn[13..40];
	self.Business_Address_Clean_addr_suffix   		:= tempBusinessAddressReturn[41..44];
	self.Business_Address_Clean_postdir 	    		:= tempBusinessAddressReturn[45..46];
	self.Business_Address_Clean_unit_desig 	  		:= tempBusinessAddressReturn[47..56];
	self.Business_Address_Clean_sec_range 	  		:= tempBusinessAddressReturn[57..64];
	self.Business_Address_Clean_p_city_name	  		:= tempBusinessAddressReturn[65..89];
	self.Business_Address_Clean_v_city_name	  		:= tempBusinessAddressReturn[90..114];
	self.Business_Address_Clean_st 			      		:= tempBusinessAddressReturn[115..116];
	self.Business_Address_Clean_zip 		      		:= tempBusinessAddressReturn[117..121];
	self.Business_Address_Clean_zip4 		      		:= tempBusinessAddressReturn[122..125];
	self.Business_Address_Clean_cart 		      		:= tempBusinessAddressReturn[126..129];
	self.Business_Address_Clean_cr_sort_sz 	 		 	:= tempBusinessAddressReturn[130];
	self.Business_Address_Clean_lot 		      		:= tempBusinessAddressReturn[131..134];
	self.Business_Address_Clean_lot_order 	  		:= tempBusinessAddressReturn[135];
	self.Business_Address_Clean_dpbc 		      		:= tempBusinessAddressReturn[136..137];
	self.Business_Address_Clean_chk_digit 	  		:= tempBusinessAddressReturn[138];
	self.Business_Address_Clean_record_type	  		:= tempBusinessAddressReturn[139..140];
	self.Business_Address_Clean_ace_fips_st	  		:= tempBusinessAddressReturn[141..142];
	self.Business_Address_Clean_fipscounty 	  		:= tempBusinessAddressReturn[143..145];
	self.Business_Address_Clean_geo_lat 	    		:= tempBusinessAddressReturn[146..155];
	self.Business_Address_Clean_geo_long 	    		:= tempBusinessAddressReturn[156..166];
	self.Business_Address_Clean_msa 		      		:= tempBusinessAddressReturn[167..170];
	self.Business_Address_Clean_geo_blk 	  		  := tempBusinessAddressReturn[171..177];
	self.Business_Address_Clean_geo_match 	  		:= tempBusinessAddressReturn[178];
	self.Business_Address_Clean_err_stat 	    		:= tempBusinessAddressReturn[179..182];
	self.Office_Manager_Name_Clean_title		  		:= tempOfficeManagerName[1..5];
	self.Office_Manager_Name_Clean_fname		  	  := tempOfficeManagerName[6..25];
	self.Office_Manager_Name_Clean_mname		      := tempOfficeManagerName[26..45];
	self.Office_Manager_Name_Clean_lname		      := tempOfficeManagerName[46..65];
	self.Office_Manager_Name_Clean_name_suffix		:= tempOfficeManagerName[66..70];
	self.Office_Manager_Name_Clean_cleaning_score	:= tempOfficeManagerName[71..73];
  self.Key                         := stringlib.StringToUpperCase(trim(InputRecord.ABI_Number,left,right));
	self.Process_Date                := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Process_Date,left,right),'0123456789');
	self.Date_First_Seen             := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_First_Seen,left,right),'0123456789');
	self.Date_Last_Seen              := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Last_Seen,left,right),'0123456789');
	self.Date_Vendor_First_Reported  := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Vendor_First_Reported,left,right),'0123456789');
	self.Date_Vendor_Last_Reported   := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Date_Vendor_Last_Reported,left,right),'0123456789');
	self.Physician_Last_Name         := stringlib.StringToUpperCase(trim(InputRecord.Physician_Last_Name,left,right));
	self.Physician_First_Name        := stringlib.StringToUpperCase(trim(InputRecord.Physician_First_Name,left,right));
	self.Physician_Full_Name         := stringlib.StringToUpperCase(trim(InputRecord.Physician_Full_Name,left,right));
	self.Physician_Prof_Suffix_Code  := stringlib.StringToUpperCase(trim(InputRecord.Physician_Prof_Suffix_Code,left,right));
	self.Physician_Prof_Suffix       := stringlib.StringToUpperCase(trim(InputRecord.Physician_Prof_Suffix,left,right));	
	self.Physician_Gender_Code       := stringlib.StringToUpperCase(trim(InputRecord.Physician_Gender_Code,left,right));
	self.Physician_Gender            := stringlib.StringToUpperCase(trim(InputRecord.Physician_Gender,left,right));
	self.Physician_Year_Of_Birth     := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Physician_Year_Of_Birth,left,right),'0123456789');
	self.Primary_Specialty_code      := stringlib.StringToUpperCase(trim(InputRecord.Primary_Specialty_code,left,right));
	self.Primary_Specialty           := stringlib.StringToUpperCase(trim(InputRecord.Primary_Specialty,left,right));
	self.Secondary_Specialty_code    := stringlib.StringToUpperCase(trim(InputRecord.Secondary_Specialty_code,left,right));
	self.Secondary_Specialty         := stringlib.StringToUpperCase(trim(InputRecord.Secondary_Specialty,left,right));
	self.Practice_Type_Code          := stringlib.StringToUpperCase(trim(InputRecord.Practice_Type_Code,left,right));
	self.Practice_Type               := stringlib.StringToUpperCase(trim(InputRecord.Practice_Type,left,right));
  self.Board_Certification_Indicator  := stringlib.StringToUpperCase(trim(InputRecord.Board_Certification_Indicator,left,right));
	self.Board_Certification            := stringlib.StringToUpperCase(trim(InputRecord.Board_Certification,left,right));
  self.Year_Graduated                 := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Year_Graduated,left,right),'0123456789');
	self.Professional_Degree_Code       := stringlib.StringToUpperCase(trim(InputRecord.Professional_Degree_Code,left,right));	
  self.Professional_Degree            := stringlib.StringToUpperCase(trim(InputRecord.Professional_Degree,left,right));
	self.Medical_School_Code            := stringlib.StringToUpperCase(trim(InputRecord.Medical_School_Code,left,right));	
  self.Medical_School_Name            := stringlib.StringToUpperCase(trim(InputRecord.Medical_School_Name,left,right));
	self.Patients_Per_Week              := stringlib.StringToUpperCase(trim(InputRecord.Patients_Per_Week,left,right));	
	self.Prescriptions_Per_Week_Code    := stringlib.StringToUpperCase(trim(InputRecord.Prescriptions_Per_Week_Code,left,right));	
	self.Prescriptions_Per_Week_High    := stringlib.StringToUpperCase(trim(InputRecord.Prescriptions_Per_Week_High,left,right));	
	self.Prescriptions_Per_Week_Low     := stringlib.StringToUpperCase(trim(InputRecord.Prescriptions_Per_Week_Low,left,right));
	self.Hospital_Affiliation_Code                   := stringlib.StringToUpperCase(trim(InputRecord.Hospital_Affiliation_Code,left,right));
	self.Hospital_Affiliation                        := stringlib.StringToUpperCase(trim(InputRecord.Hospital_Affiliation,left,right));
	self.Patients_Treated_Cardiovascular_Code        := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cardiovascular_Code,left,right));	
	self.Patients_Treated_Cardiovascular_High        := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cardiovascular_High,left,right));	
	self.Patients_Treated_Cardiovascular_Low         := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cardiovascular_Low,left,right));	
	self.Patients_Treated_Hypertension_Code          := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypertension_Code,left,right));	
	self.Patients_Treated_Hypertension_High          := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypertension_High,left,right));	
	self.Patients_Treated_Hypertension_Low           := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypertension_Low,left,right));	
	self.Patients_Treated_Hypercholerterlemia_Code   := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypercholerterlemia_Code,left,right));
	self.Patients_Treated_Hypercholerterlemia_High   := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypercholerterlemia_High,left,right));
	self.Patients_Treated_Hypercholerterlemia_Low    := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Hypercholerterlemia_Low,left,right));
	self.Patients_Treated_Fertility_Code             := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Fertility_Code,left,right));
	self.Patients_Treated_Fertility_High             := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Fertility_High,left,right));
	self.Patients_Treated_Fertility_Low              := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Fertility_Low,left,right));
	self.Patients_Treated_Sexually_Transmit_Code     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Sexually_Transmit_Code,left,right));
	self.Patients_Treated_Sexually_Transmit_High     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Sexually_Transmit_High,left,right));
	self.Patients_Treated_Sexually_Transmit_Low      := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Sexually_Transmit_Low,left,right));
	self.Patients_Treated_Diabetes_Code         := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Diabetes_Code,left,right));
	self.Patients_Treated_Diabetes_High         := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Diabetes_High,left,right));
	self.Patients_Treated_Diabetes_Low          := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Diabetes_Low,left,right));
	self.Patients_Treated_CNS_Disorders_Code    := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_CNS_Disorders_Code,left,right));
	self.Patients_Treated_CNS_Disorders_High    := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_CNS_Disorders_High,left,right));
	self.Patients_Treated_CNS_Disorders_Low     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_CNS_Disorders_Low,left,right));
	self.Patients_Treated_HIV_Code              := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_HIV_Code,left,right));
	self.Patients_Treated_HIV_High              := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_HIV_High,left,right));
	self.Patients_Treated_HIV_Low               := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_HIV_Low,left,right));
	self.Patients_Treated_Lasik_Surgery_Code    := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Lasik_Surgery_Code,left,right));
	self.Patients_Treated_Lasik_Surgery_High    := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Lasik_Surgery_High,left,right));
	self.Patients_Treated_Lasik_Surgery_Low     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Lasik_Surgery_Low,left,right));
	self.Patients_Treated_Cataracts_Code        := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cataracts_Code,left,right));
	self.Patients_Treated_Cataracts_High        := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cataracts_High,left,right));
	self.Patients_Treated_Cataracts_Low         := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Cataracts_Low,left,right));
	self.Patients_Treated_Contact_Lens_Code     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Contact_Lens_Code,left,right));
	self.Patients_Treated_Contact_Lens_High     := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Contact_Lens_High,left,right));
	self.Patients_Treated_Contact_Lens_Low      := stringlib.StringToUpperCase(trim(InputRecord.Patients_Treated_Contact_Lens_Low,left,right));
	self.State_Of_License                  := stringlib.StringToUpperCase(trim(InputRecord.State_Of_License,left,right));
	self.Country_Of_License                := stringlib.StringToUpperCase(trim(InputRecord.Country_Of_License,left,right));
	self.License_Number                    := stringlib.StringToUpperCase(trim(InputRecord.License_Number,left,right));
	self.Expiration_Date                   := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Expiration_Date,left,right),'0123456789');
	self.License_Board_Type_Code           := stringlib.StringToUpperCase(trim(InputRecord.License_Board_Type_Code,left,right));
	self.License_Board_Type                := stringlib.StringToUpperCase(trim(InputRecord.License_Board_Type,left,right));
	self.Physician_Activity_Financial_Code := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Financial_Code,left,right));
	self.Physician_Activity_Financial      := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Financial,left,right));
	self.Physician_Activity_Boat_Code      := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Boat_Code,left,right));
	self.Physician_Activity_Boating        := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Boating,left,right));
	self.Physician_Activity_Fish_Code      := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Fish_Code,left,right));
	self.Physician_Activity_Fishing        := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Fishing,left,right));
	self.Physician_Activity_Golf_Code      := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Golf_Code,left,right));
	self.Physician_Activity_Golf           := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Golf,left,right));
	self.Physician_Activity_Snow_Ski_Code  := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Snow_Ski_Code,left,right));
	self.Physician_Activity_Snow_Ski       := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Snow_Ski,left,right));
	self.Physician_Activity_Tennis_Code    := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Tennis_Code,left,right));
	self.Physician_Activity_Tennis         := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Tennis,left,right));
	self.Physician_Activity_Cruise_Code    := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Cruise_Code,left,right));
	self.Physician_Activity_Cruise         := stringlib.StringToUpperCase(trim(InputRecord.Physician_Activity_Cruise,left,right));
	self.Business_Name                     := stringlib.StringToUpperCase(trim(InputRecord.Business_Name,left,right));
	self.Business_Address_Street_Line      := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_Street_Line,left,right));
	self.Business_Address_City             := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_City,left,right));
	self.Business_Address_State_Code       := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_State_Code,left,right));
	self.Business_Address_State            := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_State,left,right));
	self.Business_Address_ZIP_5            := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Business_Address_ZIP_5,left,right),'0123456789');
	self.Business_Address_ZIP_4            := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Business_Address_ZIP_4,left,right),'0123456789');
  self.Business_Address_County_Code      := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_County_Code,left,right));
  self.Business_Address_County           := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_County,left,right));
	self.Business_Address_Type_Code        := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_Type_Code,left,right));
	self.Business_Address_Type             := stringlib.StringToUpperCase(trim(InputRecord.Business_Address_Type,left,right));
	self.Business_Phone                    := lib_stringlib.stringlib.stringfilter(trim(InputRecord.Business_Phone,left,right),'0123456789');
	self.Employee_Size_Code                := stringlib.StringToUpperCase(trim(InputRecord.Employee_Size_Code,left,right));
	self.Employee_Size_High                := stringlib.StringToUpperCase(trim(InputRecord.Employee_Size_High,left,right));
	self.Employee_Size_Low                 := stringlib.StringToUpperCase(trim(InputRecord.Employee_Size_Low,left,right));
	self.Business_Type_Code                := stringlib.StringToUpperCase(trim(InputRecord.Business_Type_Code,left,right));
	self.Business_Type                     := stringlib.StringToUpperCase(trim(InputRecord.Business_Type,left,right));
	self.Office_Manager_Last_Name          := stringlib.StringToUpperCase(trim(InputRecord.Office_Manager_Last_Name,left,right));
	self.Office_Manager_First_Name         := stringlib.StringToUpperCase(trim(InputRecord.Office_Manager_First_Name,left,right));
	self.Number_Of_Nurses                  := stringlib.StringToUpperCase(trim(InputRecord.Number_Of_Nurses,left,right));
	self.Number_Of_Nurse_Practitioners     := stringlib.StringToUpperCase(trim(InputRecord.Number_Of_Nurse_Practitioners,left,right));
	self.Number_Of_Physician_Assistants    := stringlib.StringToUpperCase(trim(InputRecord.Number_Of_Physician_Assistants,left,right));
	self.Number_Of_Dental_Hygienists       := stringlib.StringToUpperCase(trim(InputRecord.Number_Of_Dental_Hygienists,left,right));
	self.Number_Of_Dental_Office_Chairs    := stringlib.StringToUpperCase(trim(InputRecord.Number_Of_Dental_Office_Chairs,left,right));
	self.ABI_Number                        := stringlib.StringToUpperCase(trim(InputRecord.ABI_Number,left,right));
	self.SIC                               := stringlib.StringToUpperCase(trim(InputRecord.SIC,left,right));
	self.Current_Linkage_Number            := stringlib.StringToUpperCase(trim(InputRecord.Current_Linkage_Number,left,right));
	self.UPIN                              := stringlib.StringToUpperCase(trim(InputRecord.UPIN,left,right));
	self.DEA_Number                        := stringlib.StringToUpperCase(trim(InputRecord.DEA_Number,left,right));
	self.Hospital_Number                   := stringlib.StringToUpperCase(trim(InputRecord.Hospital_Number,left,right));
	self.Hospital_Name                     := stringlib.StringToUpperCase(trim(InputRecord.Hospital_Name,left,right));
	self := InputRecord;
end;

export Cleaned_AMIDIR := project(Mapping_AMIDIR_As_Common,CleanAMIDIR(left));
