
Layout_Infile := AMIDIR.Layout_AMIDIR_With_Processdate;

Layout_AMIDIR_Common MyTransform(Layout_Infile input) := transform
	self.Key := input.ABI_Number;
	self.Process_Date := input.ProcessDate;
	self.Date_First_Seen := Self.Process_Date;
	self.Date_Last_Seen  := Self.Process_Date;
	self.Date_Vendor_First_Reported := Self.Process_Date;
	self.Date_Vendor_Last_Reported  := Self.Process_Date;
	self.Physician_First_Name := input.Physician_First_Name;
	self.Physician_Last_Name  := input.Physician_Last_Name;
	self.Physician_Full_Name  := input.Physician_Full_Name;
	self.Physician_Prof_Suffix_Code := input.Physician_Title;
	self.Physician_Prof_Suffix := map(trim(input.Physician_Title,left,right) = 'MD'  => 'M.D.',
									  trim(input.Physician_Title,left,right) = 'DO'  => 'D.O.',
									  trim(input.Physician_Title,left,right) = 'DDS' => 'D.D.S.',
								      '');
	self.Physician_Gender_Code := input.Gender;	
	self.Physician_Gender := map(trim(input.Gender,left,right) = 'M' => 'MALE',
	                             trim(input.Gender,left,right) = 'F' => 'FEMALE',
								 '');
	self.Physician_Year_Of_Birth  := input.Year_Of_Birth;
	self.Physician_DOB_yyyymmdd   := if(trim(input.Year_Of_Birth,left,right) <> '', input.Year_Of_Birth + '0101','');
	self.Primary_Specialty_Code   := input.Primary_Specialty_Code;
	self.Secondary_Specialty_Code := input.Secondary_Specialty_Code;
	self.Practice_Type_Code := input.Type_Of_Practice;
	self.Practice_Type      := map(trim(input.Type_Of_Practice,left,right) = 'A' => 'ADMINISTRATION',
								   trim(input.Type_Of_Practice,left,right) = 'C' => 'RESEARCH',
								   trim(input.Type_Of_Practice,left,right) = 'E' => 'OTHER',
								   trim(input.Type_Of_Practice,left,right) = 'F' => 'FELLOW CLINICAL',
								   trim(input.Type_Of_Practice,left,right) = 'I' => 'INTERN',
								   trim(input.Type_Of_Practice,left,right) = 'L' => 'LAST YEAR RESIDENT',
								   trim(input.Type_Of_Practice,left,right) = 'O' => 'OFFICE BASED',
								   trim(input.Type_Of_Practice,left,right) = 'R' => 'RESIDENT',
								   trim(input.Type_Of_Practice,left,right) = 'S' => 'HOSPITAL STAFF',
								   trim(input.Type_Of_Practice,left,right) = 'T' => 'MEDICAL TEACHING',
								   trim(input.Type_Of_Practice,left,right) = 'V' => 'RETIRED',
								   trim(input.Type_Of_Practice,left,right) = '2' => 'FELLOW RESEARCH',
								   '');
	self.Board_Certification_Indicator := input.Board_Certification_Indicator;
	self.Board_Certification := if(trim(input.Board_Certification_Indicator,left,right) = 'Y', 'YES',
	                            if(trim(input.Board_Certification_Indicator,left,right) = 'N', 'NO', ''));
	self.Year_Graduated              := input.Year_Graduated;
	self.Professional_Degree_Code    := input.Prof_Degree_Code; 
	self.Medical_School_Code         := input.Medical_School_Code;
	self.Medical_School_Name         := input.Medical_School_Name;
	self.Patients_Per_Week           := (string)((integer)input.Number_Of_Patients_Seen_Weekly); 
	self.Prescriptions_Per_Week_Code := input.Prescriptions_Per_Week;
	self.Prescriptions_Per_Week_High := map(trim(input.Prescriptions_Per_Week,left,right) = 'G' => '0',
											trim(input.Prescriptions_Per_Week,left,right) = 'H' => '25',
											trim(input.Prescriptions_Per_Week,left,right) = 'I' => '74',
											trim(input.Prescriptions_Per_Week,left,right) = 'J' =>'150',
											trim(input.Prescriptions_Per_Week,left,right) = 'K' =>'',
											'');
	self.Prescriptions_Per_Week_Low  := map(trim(input.Prescriptions_Per_Week,left,right) = 'G' => '',
											trim(input.Prescriptions_Per_Week,left,right) = 'H' => '1',
											trim(input.Prescriptions_Per_Week,left,right) = 'I' => '26',
											trim(input.Prescriptions_Per_Week,left,right) = 'J' => '75',
											trim(input.Prescriptions_Per_Week,left,right) = 'K' => '150',
											'');
	self.Hospital_Affiliation_Code   := input.Hospital_Affiliation;
	HighValues(string inVal) := map(trim(inVal,left,right) = 'A' => '0',
									trim(inVal,left,right) = 'B' => '5',
									trim(inVal,left,right) = 'C' => '9',
									trim(inVal,left,right) = 'D' => '19',
									trim(inVal,left,right) = 'E' => '',
									'');
	LowValues(string inVal)  := map(trim(inVal,left,right) = 'A' => '',
								    trim(inVal,left,right) = 'B' => '1',
									trim(inVal,left,right) = 'C' => '6',
									trim(inVal,left,right) = 'D' => '10',
									trim(inVal,left,right) = 'E' => '20',
									'');
	self.Patients_Treated_Cardiovascular_Code := input.Cardiovascular;
    self.Patients_Treated_Cardiovascular_High := HighValues(input.Cardiovascular);
	self.Patients_Treated_Cardiovascular_Low  := LowValues(input.Cardiovascular);
	
	self.Patients_Treated_Hypertension_Code := input.Hypertension;
    self.Patients_Treated_Hypertension_High := HighValues(input.Hypertension);
    self.Patients_Treated_Hypertension_Low  := LowValues(input.Hypertension);	
	
    self.Patients_Treated_Hypercholerterlemia_Code := input.Hypercholerterlemia;
    self.Patients_Treated_Hypercholerterlemia_High := HighValues(input.Hypercholerterlemia);
	self.Patients_Treated_Hypercholerterlemia_Low  := LowValues(input.Hypercholerterlemia);
	
    self.Patients_Treated_Fertility_Code := input.Fertility;
    self.Patients_Treated_Fertility_High := HighValues(input.Fertility);
	self.Patients_Treated_Fertility_Low  := LowValues(input.Fertility);
	
	self.Patients_Treated_Sexually_Transmit_Code := input.Sexually_Transmit;
	self.Patients_Treated_Sexually_Transmit_High := HighValues(input.Sexually_Transmit);
	self.Patients_Treated_Sexually_Transmit_Low  := LowValues(input.Sexually_Transmit);

	self.Patients_Treated_Diabetes_Code := input.Diabetes;
	self.Patients_Treated_Diabetes_High := HighValues(input.Diabetes);
	self.Patients_Treated_Diabetes_Low  := LowValues(input.Diabetes);

	self.Patients_Treated_CNS_Disorders_Code := input.CNS_Disorders;
	self.Patients_Treated_CNS_Disorders_High := HighValues(input.CNS_Disorders);
	self.Patients_Treated_CNS_Disorders_Low  := LowValues(input.CNS_Disorders);

	self.Patients_Treated_HIV_Code := input.HIV;
	self.Patients_Treated_HIV_High := HighValues(input.HIV);
	self.Patients_Treated_HIV_Low  := LowValues(input.HIV);

	self.Patients_Treated_Lasik_Surgery_Code := input.Lasik_Surgery;
	self.Patients_Treated_Lasik_Surgery_High := HighValues(input.Lasik_Surgery);
	self.Patients_Treated_Lasik_Surgery_Low  := LowValues(input.Lasik_Surgery);

	self.Patients_Treated_Cataracts_Code := input.Cataracts;
	self.Patients_Treated_Cataracts_High := HighValues(input.Cataracts);
	self.Patients_Treated_Cataracts_Low  := LowValues(input.Cataracts);

	self.Patients_Treated_Contact_Lens_Code := input.Contact_Lens;
	self.Patients_Treated_Contact_Lens_High := HighValues(input.Contact_Lens);
	self.Patients_Treated_Contact_Lens_Low  := LowValues(input.Contact_Lens);
	
	self.State_Of_License   := input.State_Of_License;
    self.Country_Of_License := input.Country_Of_License;
    self.License_Number     := input.License_Number;
	self.Expiration_Date    := input.Expiration_Date;
	self.License_Board_Type_Code := input.License_Board_Type;
	self.License_Board_Type := map(trim(input.License_Board_Type,left,right) = 'MD' => 'M.D.',
	                               trim(input.License_Board_Type,left,right) = 'DO' => 'D.O.',
								   trim(input.License_Board_Type,left,right) = 'DDS' => 'D.D.S.',
							       '');
	self.Physician_Activity_Financial_Code := input.Activity_Financial;
	self.Physician_Activity_Financial      := if(trim(input.Activity_Financial,left,right) <> '', 'YES', '');
	self.Physician_Activity_Boat_Code      := input.Activity_Boating;
	self.Physician_Activity_Boating        := if(trim(input.Activity_Boating,left,right) <> '', 'YES', ''); 
    self.Physician_Activity_Fish_Code      := input.Activity_Fishing;
	self.Physician_Activity_Fishing        := if(trim(input.Activity_Fishing,left,right) <> '', 'YES', '');
	self.Physician_Activity_Golf_Code      := input.Activity_Golf;
	self.Physician_Activity_Golf           := if(trim(input.Activity_Golf,left,right) <> '', 'YES', '');
	self.Physician_Activity_Snow_Ski_Code  := input.Activity_Snow_Ski;		
	self.Physician_Activity_Snow_Ski       := if(trim(input.Activity_Snow_Ski,left,right) <> '', 'YES', '');
	self.Physician_Activity_Tennis_Code    := input.Activity_Tennis;
	self.Physician_Activity_Tennis         := if(trim(input.Activity_Tennis,left,right) <> '', 'YES', '');
	self.Physician_Activity_Cruise_Code    := input.Activity_Cruise;
	self.Physician_Activity_Cruise    := if(trim(input.Activity_Cruise,left,right) <> '', 'YES', ''); 
	self.Business_Name                := input.Business_Name;
	self.Business_Address_Street_Line := input.Business_Address;
	self.Business_Address_City        := input.City;
	self.Business_Address_State       := input.State_Alpha;
	self.Business_Address_State_Code  := input.State_Code;
	self.Business_Address_Zip_5       := input.Zip_5;
	self.Business_Address_Zip_4       := input.Zip_4;
	self.Business_Address_County_Code := input.County_Code; 
	self.Business_Address_Type_Code   := input.Address_Type;
	self.Business_Address_Type := map(trim(input.Address_Type,left,right) = '1' => 'HOME',
									  trim(input.Address_Type,left,right) = '2' => 'OFFICE',
									  trim(input.Address_Type,left,right) = '3' => 'HOME & OFFICE',
									  trim(input.Address_Type,left,right) = '4' => 'OTHER',
									  trim(input.Address_Type,left,right) = '5' => 'HOSPITAL',
	                                  '');
	self.Business_Phone := input.Phone_Number;
	self.Employee_Size_Code := input.Employee_Size_Code;
	self.Employee_Size_High := map(trim(input.Employee_Size_Code,left,right) = 'A' => '4',
								   trim(input.Employee_Size_Code,left,right) = 'B' => '9',
								   trim(input.Employee_Size_Code,left,right) = 'C' => '19',	
	                               trim(input.Employee_Size_Code,left,right) = 'D' => '49',
								   trim(input.Employee_Size_Code,left,right) = 'E' => '99',
								   trim(input.Employee_Size_Code,left,right) = 'F' => '249',
								   trim(input.Employee_Size_Code,left,right) = 'G' => '499',
								   trim(input.Employee_Size_Code,left,right) = 'H' => '999',
								   trim(input.Employee_Size_Code,left,right) = 'I' => '4999',
								   trim(input.Employee_Size_Code,left,right) = 'J' => '9999',
								   trim(input.Employee_Size_Code,left,right) = 'K' => '',
								   '');
	self.Employee_Size_Low := map(trim(input.Employee_Size_Code,left,right) = 'A' => '1',
								  trim(input.Employee_Size_Code,left,right) = 'B' => '5',
								  trim(input.Employee_Size_Code,left,right) = 'C' => '10',
								  trim(input.Employee_Size_Code,left,right) = 'D' => '20',
								  trim(input.Employee_Size_Code,left,right) = 'E' => '50',
								  trim(input.Employee_Size_Code,left,right) = 'F' => '100',
								  trim(input.Employee_Size_Code,left,right) = 'G' => '250',
								  trim(input.Employee_Size_Code,left,right) = 'H' => '500',
								  trim(input.Employee_Size_Code,left,right) = 'I' => '1000',
								  trim(input.Employee_Size_Code,left,right) = 'J' => '5000',
								  trim(input.Employee_Size_Code,left,right) = 'K' => '10000',
	                              '');	
	self.Business_Type_Code := input.Business_Practice_Type;		
	self.Business_Type := if(trim(input.Business_Practice_Type,left,right) = '001', 'SOLO PRACTICE',
						     if(trim(input.Business_Practice_Type,left,right) = '002', 'PARTNERSHIP',
								if(trim(input.Business_Practice_Type,left,right) <> '', 'GROUP PRACTICE', ''))); 
	self.Office_Manager_Last_Name       := input.Office_Manager_Last_Name;
    self.Office_Manager_First_Name      := input.Office_Manager_First_Name;
	self.Number_Of_Nurses               := (string)((integer)input.Number_Of_Nurses);
    self.Number_Of_Nurse_Practitioners  := (string)((integer)input.Number_Of_Nurse_Practitioners);
    self.Number_Of_Physician_Assistants := (string)((integer)input.Number_Of_Phys_Assistants);
    self.Number_Of_Dental_Hygienists    := (string)((integer)input.Number_Of_Dental_Hygienists);
	self.Number_Of_Dental_Office_Chairs := (string)((integer)input.Number_Of_Dentist_Office_Chairs);
	self.ABI_Number                     := input.ABI_Number;
	self.SIC                            := input.Primary_SIC;
	self.Current_Linkage_Number         := input.Current_Linkage_Number;			
	self.UPIN                           := input.UPIN;
	self.DEA_Number                     := input.DEA_Number;
	self                                := input;
	self                                := [];
end;

//MyInterimFile := project(File_AMIDIR,MyTransform(left));
Recs_in_Common := project(Joined_AMIDIR,MyTransform(left));

// COde to get the translation value for Hosipital Affiliation code
Layout_AMIDIR_Common getHospName(Layout_AMIDIR_Common input, Layout_AMIHOSP HospTable) := transform
	self.Hospital_Affiliation := HospTable.Hospital_Name;
	self := input;
end;

Recs_w_HospName := join(Recs_in_Common, File_AMIHOSP, 
                        trim(left.Hospital_Affiliation_Code,left,right) = trim(right.Hospital_Num,left,right),
                        getHospName(left,right), left outer, lookup);

// COde to get the translation value for Primary Specialty code
Layout_AMIDIR_Common getPrimarySpec(Layout_AMIDIR_Common input, Layout_AMISPEC SpecTable) := transform
	self.Primary_Specialty := SpecTable.Specialty_Name;
	self := input;
end;

Recs_w_PrimarySpec := join(Recs_w_HospName, File_AMISPEC, 
                           trim(left.Primary_Specialty_Code,left,right) = trim(right.Specialty_Code,left,right),
                           getPrimarySpec(left,right), left outer, lookup);


// COde to get the translation value for Secondary Specialty code
Layout_AMIDIR_Common getSecondarySpec(Layout_AMIDIR_Common input, Layout_AMISPEC SpecTable) := transform
	self.Secondary_Specialty := SpecTable.Specialty_Name;
	self := input;
end;

Recs_w_SecondarySpec := join(Recs_w_PrimarySpec, File_AMISPEC, 
                             trim(left.Secondary_Specialty_Code,left,right) = trim(right.Specialty_Code,left,right),
                             getSecondarySpec(left,right), left outer, lookup);
							
// COde to get the translation value for Business Address County code							
Layout_AMIDIR_Common getCounty(Layout_AMIDIR_Common input, Layout_Countyp CountyTable) := transform
	self.Business_Address_County := CountyTable.County_Name;
	self := input;
end;

Recs_W_County := join(Recs_w_SecondarySpec, File_AMICountyp, 
                      trim(left.Business_Address_State_Code,left,right) + 
					  trim(left.Business_Address_County_Code,left,right) = trim(right.County_Id,left,right),
                      getCounty(left,right), left outer, lookup);							
												
export Mapping_AMIDIR_As_Common := Recs_W_County;
                                 

