EXPORT fnMakeESDLOutput() := functionmacro

	AddressNull := row([],iesp.share.t_Address);
	DOB_Null 		:= row([],iesp.share.t_MaskableDate);
							
	iesp.childidentityfraudreport.t_ChildIdentityPerson normXformR(ChildIdentityFraudSolutionServices.Layouts.BatchOut le, integer c) := 
	TRANSFORM, 
	SKIP((c = 1 and TRIM(le.rel_first_name_1) = '')  or 
	(c = 2 and TRIM(le.rel_first_name_2) = '') or 
	(c = 3 and TRIM(le.rel_first_name_3 )= '')) 
		self.Name := map(c = 1 => iesp.ECL2ESP.SetName(le.rel_first_name_1, '', le.rel_last_name_1, '', '', ''),
											c = 2 => iesp.ECL2ESP.SetName(le.rel_first_name_2, '', le.rel_last_name_2, '', '', ''),
															 iesp.ECL2ESP.SetName(le.rel_first_name_3, '', le.rel_last_name_3, '', '', ''));
		Address := iesp.ECL2ESP.SetAddress ('','' ,'' ,'' ,'' ,'' ,'' , 
																				le.rel_city_1,le.rel_state_1, le.rel_zipcode_1,
																				'' ,'' ,'' , le.rel_address_1,'' ,'') ;																	 
		self.Address 	:=  if(c = 1 , Address,AddressNull);
		DOB_Pre 			:= iesp.ECL2ESP.toMaskableDatestring8(le.rel_dob_1);
		DOB 					:= iesp.ECL2ESP.ApplyDateStringMask (dob_Pre ,input_dob_mask_value,true) ;	
		self.DOB 			:= if(c = 1 , DOB, DOB_Null);
		self.UniqueId :=	map(c = 3 => (string) le.rel_DID_3,
													c = 2 => (string) le.rel_DID_2,
													'');				
	END;

	iesp.childidentityfraudreport.t_ChildIdentityPerson normXformA(ChildIdentityFraudSolutionServices.Layouts.BatchOut le, integer c) := 
	TRANSFORM,
	SKIP((c = 1 and TRIM(le.asso_first_name_1) = '')  or (c = 2 and TRIM(le.asso_first_name_2) = '') or 
	(c = 3 and TRIM(le.asso_first_name_3) = ''))
		self.Name := map(c = 1 => iesp.ECL2ESP.SetName (le.asso_first_name_1, '', le.asso_last_name_1, '', '', ''),
										 c = 2 => iesp.ECL2ESP.SetName (le.asso_first_name_2, '', le.asso_last_name_2, '', '', ''),
										 iesp.ECL2ESP.SetName (le.asso_first_name_3, '', le.asso_last_name_3, '', '', ''));
		Address := iesp.ECL2ESP.SetAddress ( '','' ,'' ,'' ,'' ,'' ,'' , le.asso_city_1,le.asso_state_1, 
																				le.asso_zipcode_1,'' ,'' ,'' , le.asso_address_1) ;
		self.Address 	:= if(c = 1 , Address,AddressNull);
		DOB_Pre 			:= iesp.ECL2ESP.toMaskableDatestring8(le.asso_dob_1);
		DOB 					:= iesp.ECL2ESP.ApplyDateStringMask (dob_Pre ,input_dob_mask_value,true) ;	
		self.DOB 			:= if(c = 1 , DOB, DOB_Null);
		self.UniqueId :=	map(c = 3 => (string)le.asso_DID_3,
													c = 2 => (string)le.asso_DID_2,
													'');			
	END;

	// Prepare relatives 
	normOutRelatives := normalize(BatchResults,3,normXformR(left,counter));

	// Prepare associates
	normOutAssociates := normalize(BatchResults,3,normXformA(left,counter));
	header_row 	 :=  iesp.ECL2ESP.GetHeaderRow();

	iesp.childidentityfraudreport.t_ChildIdentityFraudReportResponse	xformToESDL(BatchResults L ) := transform
		self.InputEcho	:= report_by;
		//share.t_ResponseHeader _Header {xpath('Header')};
		self._Header :=  project(header_row, transform(iesp.share.t_ResponseHeader,
			self.status :=  left.status,
			self := left));
		self.Individual.UniqueId	:= (string)L.Header_DID;
		//t_ChildIdentityIndividual Individual {xpath('Individual')};
		//t_ChildIdentityBestInfo BestInfo {xpath('BestInfo')};
		self.Individual.BestInfo.UniqueId := (string) L.Best_Did ;
		self.Individual.BestInfo.SSN := Suppress.ssn_mask(L.Best_SSN,input_ssn_mask_value);
		self.Individual.BestInfo.Name := iesp.ECL2ESP.SetName (L.Best_Fname, '', L.Best_Lname, '', '', ''); 

		//share.t_Address Address {xpath('Address')};
		self.Individual.BestInfo.Address :=  iesp.ECL2ESP.SetAddress ('','','' ,'' ,'','' ,'' , 
																																	L.Best_City, L.Best_State, 
																																	L.Best_Zip,'' ,'' ,'', L.Best_Addr1,'','') ;
		//share.t_Date AddressDateLastSeen {xpath('AddressDateLastSeen')};
		self.Individual.BestInfo.AddressDateLastSeen := iesp.ECL2ESP.toDatestring8(L.Best_Date_Last_Seen);
		// t_ChildIdentityFraudInfo FraudInfo {xpath('FraudInfo')};
		self.Individual.FraudInfo.IsMisrepresentedSSN := L.Misrepresented_SSN ;
		self.Individual.FraudInfo.IsCompromisedSSN := L.Compromised_SSN;
		self.Individual.FraudInfo.IsHighlyCompromisedSSN := L.Highly_Compromised_SSN;
		self.Individual.FraudInfo.IsNewlyCompromisedSSN := L.Newly_Compromised_SSN;
		self.Individual.FraudInfo.IsITINFraudFiler := L.ITIN_FraudFiler;
		self.Individual.FraudInfo.HasMultipleSSNs := map(L.Hri_1_Code = 'MI' => 'Y',
																											'N');
		self.Individual.FraudInfo.SSNIsAnITIN := map(L.Hri_2_Code = 'IT' and report_by.IdentityType in['A','a']=> 'Y',
																									L.Hri_2_Code = ' ' and  report_by.IdentityType in['A','a'] => 'N',
																											' ');
		self.Individual.FraudInfo.HasRiskyAssociates := L.Input_Identities_With_Risky_Associates ; //values['U','Y','N','']
		self.Individual.FraudInfo.ImposterUniqueId := (string) L.Imposter_Did;
		self.Individual.FraudInfo.ImposterSSN := Suppress.ssn_mask(L.Imposter_SSN,input_ssn_mask_value);
		// t_ChildIdentityDeceasedInfo DeceasedInfo {xpath('DeceasedInfo')};
		self.Individual.DeceasedInfo.IsDeceased := L.Deceased_Indicator;

		self.Individual.DeceasedInfo.Name := iesp.ECL2ESP.SetName (L.Deceased_Fname, '', L.Deceased_Lname, '', '', ''); 

		//share.t_Date DOD {xpath('DOD')};
		self.Individual.DeceasedInfo.DOD := iesp.ECL2ESP.toDatestring8(L.DOD);
		self.Individual.DeceasedInfo.MatchCode := L.Deceased_Matchcode ;
		// t_ChildIdentityCriminalInfo Criminal {xpath('Criminal')};
		//share.t_Name Name {xpath('Name')};
		self.Individual.Criminal.Name := iesp.ECL2ESP.SetName ( L.doc_fname, '',  L.doc_lname, '', '', '');
		// share.t_Date DOB {xpath('DOB')};
		dt1 := iesp.ECL2ESP.toMaskableDatestring8(L.doc_dob);
		self.Individual.Criminal.DOB := iesp.ECL2ESP.ApplyDateStringMask (dt1 ,input_dob_mask_value,true) ;
		self.Individual.Criminal.SSN := Suppress.ssn_mask(L.doc_ssn,input_ssn_mask_value);
		self.Individual.Criminal.DOCNumber := L.doc_num ;
		self.Individual.Criminal.State := L.doc_state_origin ;
		// dataset(t_ChildIdentityPerson) Relatives {xpath('Relatives/Relative'), MAXCOUNT(iesp.constants.ChildIdentityFraudReport.MaxPersonRecords)};
		// share.t_Name Name {xpath('Name')};
		self.Individual.Relatives := normOutRelatives;

		// dataset(t_ChildIdentityPerson) Associates {xpath('Associates/Associates'), MAXCOUNT(iesp.constants.ChildIdentityFraudReport.MaxPersonRecords)};
		// share.t_Name Name {xpath('Name')};
		self.Individual.Associates := normOutAssociates;
		// t_ChildIdentityBankruptcy Bankruptcy {xpath('Bankruptcy')};
		self.Individual.Bankruptcy.Count := L.BKcount ;
		self.Individual.Bankruptcy.UniqueId := (string) L.debtor_DID ;
		// share.t_Name Name {xpath('Name')};
		self.Individual.Bankruptcy.Name := iesp.ECL2ESP.SetName (L.debtor_1_fname, '', L.debtor_1_lname, '', '', '');
		// share.t_Address Address {xpath('Address')};
		self.Individual.Bankruptcy.Address := iesp.ECL2ESP.SetAddress (L.debtor_prim_name, L.debtor_prim_range,'','' ,''	,'' ,'' , 
																																	 L.debtor_p_city_name,L.debtor_st, L.debtor_zip,'' ,'' ,'' ,'' ,'' ,'' ); 
		self.Individual.Bankruptcy.CaseNumber := L.bk_case_number ;
		self.Individual.Bankruptcy.CourtLocation := L.court_location ;

		// t_ChildIdentityLien Lien {xpath('Lien')};
		self.Individual.Lien.Count := L.LJ_count;
		self.Individual.Lien.UniqueId := (string) L.debtor_1_party_1_did;
		// share.t_Name DebtorName {xpath('DebtorName')};
		self.Individual.Lien.DebtorName := iesp.ECL2ESP.SetName (L.debtor_1_party_1_fname, '', L.debtor_1_party_1_lname, '', '', ''); 
		// share.t_Name CreditorName {xpath('CreditorName')};
		self.Individual.Lien.CreditorName := iesp.ECL2ESP.SetName ('', '','','', '', L.creditor_orig_name); 
		self.Individual.Lien.CaseNumber := L.LJ_case_number ;
		// share.t_Date FilingDate {xpath('FilingDate')};
		self.Individual.Lien.FilingDate := iesp.ECL2ESP.toDatestring8(L.orig_filing_date);
		// share.t_Date ReleaseDate {xpath('ReleaseDate')};
		self.Individual.Lien.ReleaseDate := iesp.ECL2ESP.toDatestring8(L.release_date);

		// t_ChildIdentityProperty Property {xpath('Property')};
		self.Individual.Property.Count  						 := L.Prop_count;
		self.Individual.Property.UniqueId  		 := (string) L.buyer_1_did;

		self.Individual.Property.Address 							:=	iesp.ECL2ESP.SetAddress ( '','' ,'' ,'' ,'' ,'' ,'' , 
																																	L.property_p_city_name,
																																	L.property_st, L.property_zip,'' ,'' ,'' , 
																																	L.property_address1,'' ,'' );
		self.Individual.Property.County 						 := L.property_county_name;
		//self.Individual.Property.Assessor ;
		self.Individual.Property.Assessor.County     := L.assess_county_name;
		self.Individual.Property.Assessor.ParcelId   := L.assess_apna_or_pin_number;
		self.Individual.Property.Assessor.Owner1Name := L.buyer_1_orig_name;
		self.Individual.Property.Assessor.Owner2Name := L.buyer_2_orig_name ;
		//self.Individual.Property.Deed ;
		self.Individual.Property.Deed.ParcelId 			:= L.deed_apnt_or_pin_number;
		self.Individual.Property.Deed.RecordingDate	:= iesp.ECL2ESP.toDatestring8(L.deed_recording_date); 
		self.Individual.Property.Deed.Owner1Name 		:=  L.owner_1_orig_name;
		self.Individual.Property.Deed.Owner2Name 		:=  L.owner_2_orig_name;
		self.Individual.Property.Deed.SellerName 		:=  L.seller_1_orig_name;

		// t_ChildIdentitySexOffender SexOffender {xpath('SexOffender')};
		self.Individual.SexOffender.Count  				:= L.SOF_count;
		// share.t_Name Name {xpath('Name')};
		self.Individual.SexOffender.Name  					:= iesp.ECL2ESP.SetName (L.SOF_name_first, '', L.SOF_name_last, '', '', ''); 
		// share.t_Address Address {xpath('Address')};
		self.Individual.SexOffender.Address  				:= iesp.ECL2ESP.SetAddress ( '','' ,'' ,'' ,'' ,'' ,'' , 
																																						L.SOF_City,L.SOF_State, L.SOF_Zip5,'' ,'' ,'' , 
																																						L.SOF_Street_Address1,'' ,'' ); 
		// share.t_Date DateLastSeen {xpath('DateLastSeen')};
		self.Individual.SexOffender.DateLastSeen  := iesp.ECL2ESP.toDatestring8(L.SOF_date_last_seen); 
		// share.t_Date DOB {xpath('DOB')};
		dt2 := iesp.ECL2ESP.toMaskableDatestring8(L.SOF_dob);
		self.Individual.SexOffender.DOB  					:= iesp.ECL2ESP.ApplyDateStringMask (dt2 ,input_dob_mask_value,true);

		// t_ChildIdentityPeopleAtWork PeopleAtWork {xpath('PeopleAtWork')};
		self.Individual.PeopleAtWork.Count  			:= L.PAWK_count;
		self.Individual.PeopleAtWork.UniqueId  		:= (string) L.pawk_1_did;
		// share.t_Name Name {xpath('Name')};
		self.Individual.PeopleAtWork.Name  				:= iesp.ECL2ESP.SetName (L.pawk_1_first, '', L.pawk_1_last, '', '', ''); 
		self.Individual.PeopleAtWork.CompanyName  := L.pawk_1_company_name;
		// share.t_Address Address {xpath('Address')};
		self.Individual.PeopleAtWork.Address  		:= iesp.ECL2ESP.SetAddress ('','' ,'' ,'' ,'' ,'' ,'' ,
																									L.pawk_1_city, L.pawk_1_state, 
																									L.pawk_1_zip5,'' ,'' ,'' , L.pawk_1_address,'' ,'' ); 
		self.Individual.PeopleAtWork.Phone  			:= L.pawk_1_phone;
		self.Individual.PeopleAtWork.FEIN  				:= L.pawk_1_fein;
		// t_ChildIdentityForeclosure Foreclosure {xpath('Foreclosure')};
		self.Individual.Foreclosure.Count  				:= L.FC_count;
		self.Individual.Foreclosure.Plaintiff1Name  := L.plntff1_name;
		self.Individual.Foreclosure.Plaintiff2Name  := L.plntff2_name;
		self.Individual.Foreclosure.Defendant1Name  := L.ownr_1_first_name + ' ' + L.ownr_1_last_name;
		self.Individual.Foreclosure.Defendant2Name  := L.ownr_2_first_name + ' ' + L.ownr_2_last_name;
		// share.t_Address Address {xpath('Address')};
		self.Individual.Foreclosure.Address := iesp.ECL2ESP.SetAddress ('','' ,'' ,'' ,'' ,'' ,'' , L.fc_p_city_name,
																																			L.fc_st, L.fc_zip,'' ,'' ,'' ,'' ,'' ,'' ); 
		// share.t_Date RecordingDate {xpath('RecordingDate')};
		self.Individual.Foreclosure.RecordingDate 	:= iesp.ECL2ESP.toDatestring8(L.fc_deed_recording_date); 
		// t_ChildIdentityMotorVehicle MotorVehicle {xpath('MotorVehicle')};
		self.Individual.MotorVehicle.Count  				:= L.MV_count;
		self.Individual.MotorVehicle.LicensePlate  	:= L.reg_license_plate;
		self.Individual.MotorVehicle.VIN  					:= L.vin_out;
		self.Individual.MotorVehicle.OwnerUniqueId  := (string) L.own_1_did;
		self.Individual.MotorVehicle.RegistrantUniqueId := (string) L.reg_1_did;
		//share.t_Date RegistrationEffectiveDate {xpath('RegistrationEffectiveDate')};
		self.Individual.MotorVehicle.RegistrationEffectiveDate := iesp.ECL2ESP.toDatestring8(L.reg_latest_effective_date);
		// t_ChildIdentityProfessionalLicense ProfessionalLicense {xpath('ProfessionalLicense')};
		self.Individual.ProfessionalLicense.Count  		:= L.PL_count;
		self.Individual.ProfessionalLicense.UniqueId  	:= (string) L.PL_did;
		// share.t_Name Name {xpath('Name')};
		self.Individual.ProfessionalLicense.Name  					:= iesp.ECL2ESP.SetName ('', '', '', '', '', L.orig_name); 
		// share.t_Address Address {xpath('Address')};
		self.Individual.ProfessionalLicense.Address  				:= iesp.ECL2ESP.SetAddress ( '','' ,'' ,'' ,'' ,'' ,'' , 
																																				L.orig_city,L.orig_st, L.orig_zip,'' ,'' ,'' , 
																																				L.orig_addr_1,'' ,'' );
		self.Individual.ProfessionalLicense.SourceState  		:= L.source_st;
		self.Individual.ProfessionalLicense.LicenseNumber  	:= L.orig_license_number;
		self.Individual.ProfessionalLicense.LicenseType  		:= L.license_type;
		// share.t_Date IssueDate {xpath('IssueDate')};
		self.Individual.ProfessionalLicense.IssueDate  := iesp.ECL2ESP.toDatestring8(L.issue_date); 

		// t_ChildIdentityWatercraft Watercraft {xpath('Watercraft')};
		self.Individual.Watercraft.Count  					:= L.WC_count;
		self.Individual.Watercraft.UniqueId  				:= (string) L.wc_did_1;
		// share.t_Name Name {xpath('Name')};
		self.Individual.Watercraft.Name  						:= iesp.ECL2ESP.SetName (L.fname_1, '', L.lname_1, '', '', '');; 
		self.Individual.Watercraft.HullNumber  			:= L.hull_number;
		// share.t_Date RegistrationDate {xpath('RegistrationDate')};
		self.Individual.Watercraft.RegistrationDate := iesp.ECL2ESP.toDatestring8(L.registration_date); 
		// t_ChildIdentityAircraft Aircraft {xpath('Aircraft')};
		self.Individual.Aircraft.Count 							:= L.AC_count;
		self.Individual.Aircraft.UniqueId 					:= (string) L.did_out;
		// share.t_Name Name {xpath('Name')};
		self.Individual.Aircraft.Name 							:= iesp.ECL2ESP.SetName ('', '', '', '', '', L.name); 
		self.Individual.Aircraft.SerialNumber 			:= L.serial_number;
		// share.t_Date LastActionDate {xpath('LastActionDate')};
		self.Individual.Aircraft.LastActionDate 		:= iesp.ECL2ESP.toDatestring8(L.last_action_date); 
		// t_ChildIdentityBusiness Business {xpath('Business')};
		self.Individual.Business.Count 							:= L.Biz_count;
		self.Individual.Business.BusinessId 				:= (string) L.bdid_out;
		self.Individual.Business.CompanyName 				:= L.company_name;
		// share.t_Address Address {xpath('Address')};
		self.Individual.Business.Address 						:= iesp.ECL2ESP.SetAddress ( '','' ,'' ,'' ,'' ,'' ,'' , 
																																			L.biz_city,L.biz_state, L.biz_zip,'' ,'' ,'' , 
																																			L.biz_street,'' ,'' ); 
	end;

	ESDLOutput := project(BatchResults,xformToESDL(left));

	return(ESDLOutput);
	
endmacro;