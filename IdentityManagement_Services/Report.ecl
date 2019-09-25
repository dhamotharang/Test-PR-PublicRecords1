/***
/***
 ** Function gathers output from various requested services and returns them packed nicely into a dataset record.
***/

IMPORT doxie, iesp, IdentityManagement_Services, ut;

EXPORT Report(DATASET (doxie.layout_references) dids, IdentityManagement_Services.IParam._report param) := FUNCTION

	out_rec := iesp.identitymanagementreport.t_IdentityManagementReportIndividual;

	// DID should be at most one
  did := dids[1].did;

	pers := IdentityManagement_Services.report_records(dids, param);
	bestPerson := pers.person_report[1];

	compromisedDLHash := IF(param.SuppressCompromisedDLs,
		IdentityManagement_Services.CompromisedDL.fn_CheckForMatch(bestPerson.Name.Last, bestPerson.SSNInfo.SSN), '');

	isDLCompromised :=  compromisedDLHash <> '';

	//Personal record
	p_person         := pers.person_report;

	//DL
	p_drivers					:= if(~isDLCompromised, pers.driver_licenses_v2);

	//Ins DL
	p_insurance_dl		:= if(~isDLCompromised, pers.insurance_dl);

	//Historical Phones
	p_histphones     := CHOOSEN(pers.hist_phones, iesp.constants.IDM.MaxHistoricalPhones);

	//Students
	p_students       := pers.students;

	//Relatives
	p_relatives      := CHOOSEN(pers.Relatives, iesp.constants.IDM.MaxRelatives);

	//Associates
	p_associates     := CHOOSEN(pers.associates, iesp.constants.IDM.MaxAssociates);

	//Neighbors
	p_neighbors 	 	 := CHOOSEN(pers.neighbors, iesp.constants.IDM.MaxNeighbors);

	//Watercraft
  p_watercrafts_v2 := CHOOSEN(pers.watercrafts_v2, iesp.constants.IDM.MaxWatercrafts);

	//Aircraft
	p_aircrafts_v2   := CHOOSEN(pers.aircrafts_v2, iesp.constants.IDM.MaxAircrafts);

	//Vehicles
	p_vehicles       := CHOOSEN(pers.vehicles_V2, iesp.constants.IDM.MaxVehicles);

	//Property
  p_prop_v2        := CHOOSEN(pers.property_v2, iesp.constants.IDM.MaxProperties);

	//People At Work (PAW)
	p_paw 					 := CHOOSEN(pers.peopleatwork, iesp.constants.IDM.MaxPeopleAtWork);

	//Corporate Affiliations (corp)
	p_corp 					 := CHOOSEN(pers.corpaffiliation, iesp.constants.IDM.MaxPeopleAtWork);

	//Vehicles From Gateways
	p_veh_gtways 		 := IF (param.include_realtimevehicle, CHOOSEN(pers.veh_gateways, iesp.constants.IDM.MaxVehicles));

	//Emails
	p_emails				 := CHOOSEN(pers.emails, iesp.constants.IDM.MaxEmails);

	//Transactions / Chase Data
	p_transactions 	 := CHOOSEN(pers.transactions, iesp.constants.IDM.MaxTransactions);

	//Professional Licenses
	p_proflicense 	 := CHOOSEN(pers.proflicense, iesp.constants.IDM.MaxProfLicenses);

	// Internet Domain Names
	p_domain_names		:= CHOOSEN(pers.domain_names, iesp.Constants.IDM.MaxInternetDomains);

  //Combine all of them together
  out_rec Format () := TRANSFORM
    SELF.UniqueId 							:= (String)did;
    SELF.Relatives          		:= IF (param.include_relatives, p_relatives);
		SELF.Neighbors				 			:= IF (param.include_neighbors, p_neighbors);
    SELF.Associates        			:= IF (param.include_associates, p_associates);
		SELF.PersonRecord	 					:= IF (param.include_personreport, ROW(p_person[1], iesp.identitymanagementreport.t_IdmPersonRecord));
    SELF.HistoricalPhones  			:= IF (param.include_histphones, p_histphones);
		SELF.StudentRecord					:= IF (param.include_studentrecords, ROW(p_students[1], iesp.identitymanagementreport.t_IdmStudentRecord));
    SELF.Vehicles          			:= IF (param.include_motorvehicles, p_vehicles);
    SELF.DriverLicenses     		:= IF (param.include_driverslicenses, p_drivers);
		SELF.Watercrafts 						:= IF (param.include_watercrafts, p_watercrafts_v2);
		SELF.Aircrafts         			:= IF (param.include_aircrafts, p_aircrafts_v2);
		SELF.Properties							:= IF (param.include_properties, p_prop_v2);
		SELF.PeopleAtWork						:= IF (param.include_peopleatwork, p_paw);
		SELF.CorporateAffiliations	:= IF (param.include_corporateaffiliations, p_corp);
		SELF.EmailAddresses 				:= IF (param.include_emailaddresses, p_emails );
		SELF.TransactionHistory			:= IF (param.include_transactionhistory, p_transactions);
		SELF.MotorVehicleRecords 		:= p_veh_gtways;
		SELF.ProfessionalLicenses		:= IF (param.include_professionallicenses, p_proflicense);
		SELF.InternetDomains				:= IF (param.include_InternetDomains, p_domain_names);
		SELF.InsuranceDriverLicenses:= IF (param.include_InsuranceDL, p_insurance_dl);
		SELF.SuppressCompromisedDLIndicator  := isDLCompromised;
		SELF.CompromisedDLHash 			:= compromisedDLHash;
  END;

  individual := DATASET([Format ()]);

	RETURN individual;
END;