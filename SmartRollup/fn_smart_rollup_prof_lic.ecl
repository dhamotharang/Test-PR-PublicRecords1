import doxie_crs, iesp, Address;

// 3 DataSources are used :Prof License,  Med Providers, Med Sanctions
// Prof License and Med Providers are combined into 1 record for each State/LicenseNumber combination.
// Med Sanctions are combined into 1 record for each State/LicenseNumber and Date

export fn_smart_rollup_prof_lic(dataset(iesp.proflicense.t_ProfessionalLicenseRecord) inPLRecs,
																dataset(iesp.proflicense.t_ProviderRecord) inMPRecs,
																dataset(iesp.proflicense.t_SanctionRecord) inMSRecs
                                ) := function
	
	commonLayout := record
	   integer licenseNumber4dedup;
	   iesp.smartlinxreport.t_SLRProfLicenseAndSanctionAndProvider;
	end;
  commonLayout  pl2Common(inPLRecs l) := transform
	  //removed suffix as a workaround for bug
		NameExists := length(trim(Address.NameFromComponents(l.Name.first, l.Name.middle, l.Name.last,''))) > 0;	
		OrigName := trim(Address.NameFromComponents(l.originalName.first, l.originalName.middle, l.originalName.last, l.originalName.suffix));	
		Name := trim(Address.NameFromComponents(l.Name.first, l.Name.middle, l.Name.last, l.Name.suffix));	
		Addr := address.Addr1FromComponents(l.address.streetNumber,l.address.StreetPreDirection,l.address.streetName,l.address.StreetSuffix,
																								 l.address.StreetPostDirection,'',l.address.UnitNumber);
		AddrExists := length(trim(addr)) > 0;
		self.DOB := l.dob; 
	  self.RecordType := 'ProfLicense';
		self.name.last := if (NameExists,  l.name.last, '');
		self.name.first := if (NameExists, l.name.first, '');
		self.name.middle := if (NameExists,l.name.middle, '');
		self.name.suffix := if (NameExists,l.name.suffix, '');
		self.name.prefix := if (NameExists,l.name.prefix, '');
		self.name.full := if (NameExists, Name, L.originalName.full);
		self.address := if (AddrExists,  l.address,l.originalAddress);
		//self.address2 := if (origNameExists, l.AdditionalOrigAddress);
		self.phone := l.phone;
		self.county := if (AddrExists, l.address.county,l.originalAddress.county);
		self.ssn := l.ssn;   //best_ssn
		self.ProfessionOrBoard := l.ProfessionOrBoard; 
		self.State := l.SourceState; //
		self.licenseNumber := l.licenseNumber;
		self.licenseNumber4dedup := (integer)stringlib.stringfilter(l.licenseNumber, '0123456789');
		self.licenseType := l.licenseType;
		self.issueDate := l.issuedDate;
		self.expirationDate := l.expirationDate;
		self.status := l.status;
		self.TaxIds := [];
    self.Specialties := [];
		self := [];
	end;
	commonLayout  mp2Common(inMPRecs l, iesp.proflicense.t_PL2LicenseInfo r) := transform
    self.RecordType := 'ProfLicense';
	  self.name := l.Names[1];   //multiple names exist do you only want most recently reported name
		self.address := l.BusAddrAndPhones[1].address;  //multiple addr exist do you only want most recently reported name
		self.DOB := l.dobs[1]; 
		self.upin := l.upins[1].value;
		self.phone := l.BusAddrAndPhones[1].PhonesInfo[1].number;
		self.county := l.BusAddrAndPhones[1].address.county;     //we could use fipscode to find county....if necessary,
		self.ssn := '';//l.taxids[1].value; //multiple ssns exist do you only want most recently reported name
		self.professionOrBoard := '';  //blank
		self.State := r.state;   
		self.licenseNumber := r.number ; 
		self.licenseNumber4dedup := (integer)stringlib.stringfilter(r.number, '0123456789');
		self.licenseType := '';    //specialty[].SpecialtyName
		self.issueDate := r.effectiveDate;  //effective date
		self.expirationDate := r.terminationDate; //terminate date
		self.status := '';     //blank
		self.TaxIds :=  l.taxids;
		Specialties2Use := dedup(sort(l.specialties,id,stringlib.stringToUppercase(name),groupid, -trim(groupname)),id,stringlib.stringToUppercase(name),groupid);
    self.Specialties := Specialties2Use;		
		self := [];
	end;
	commonLayout  mp2NoCommon(inMPRecs l) := transform
    self.RecordType := 'ProfLicense';
	  self.name := l.Names[1];   //multiple names exist do you only want most recently reported name
		self.address := l.BusAddrAndPhones[1].address;  //multiple addr exist do you only want most recently reported name
		self.DOB := l.dobs[1]; 
		self.upin := l.upins[1].value;
		self.phone := l.BusAddrAndPhones[1].PhonesInfo[1].number;
		self.county := l.BusAddrAndPhones[1].address.county;     //we could use fipscode to find county....if necessary,
		self.ssn := '';//l.taxids[1].value; //multiple ssns exist do you only want most recently reported name
		self.professionOrBoard := '';  //blank
		self.State := '';   
		self.licenseNumber := '' ; 
		self.licenseNumber4dedup := 0;
		self.licenseType := '';    //specialty[].SpecialtyName
		self.issueDate := [];  //effective date
		self.expirationDate := []; //terminate date
		self.status := '';     //blank
		self.TaxIds :=  l.taxids;
		Specialties2Use := dedup(sort(l.specialties,id,stringlib.stringToUppercase(name),groupid, -trim(groupname)),id,stringlib.stringToUppercase(name),groupid);
    self.Specialties := Specialties2Use;		
		self := [];
	end;	
	commonLayout  ms2Common(inMSRecs l) := transform
	  self.RecordType := 'ProfLicense';
	  self.name := l.name;
		self.address := l.address; //clean address
		self.phone := l.phone;
		self.county := l.address.county;    //we could use fipscode to find county....if necessary,
		self.ssn := '';       //blank
		self.professionOrBoard := l.BoardType; //blank
		self.State := l.state; 
		self.licenseNumber := l.SanctionLicenseNumber;   
		self.licenseNumber4dedup := (integer)stringlib.stringfilter(l.SanctionLicenseNumber, '0123456789');
		self.licenseType :=  l._type;     //blank
		self.issueDate := l.SanctionDate;
		self.expirationDate := l.SanctionDate; 
		self.status := 'SANCTION';     //blank
		self.TaxIds := [];
    self.Specialties := [];		
		self.DOB := l.dob; //added for med sanc
	  self.UPIN := l.UPIN; //added for med sanc
	  self.SanctionSource := l.source; //added for med sanc
	  self.SanctionState := l.State; //added for med sanc
	  self.SanctionType := l._type; //added for med sanc
	  self.SanctionDate := l.SanctionDate; //added for med sanc
	  self.ProviderType := l.ProviderType; //added for med sanc
	  self.LostOfLicense := map (l.LostOfLicenseIndicator = 'Y' => 'YES',
		                           l.LostOfLicenseIndicator = 'N' => 'NO',
		                           l.LostOfLicenseIndicator = 'U' => 'UNKNOWN',
		                           ''); //added for med sanc
	  self.FraudAbuse :=map (l.FraudAbuseFlag = 'Y' => 'YES',
		                       l.FraudAbuseFlag = 'N' => 'NO',
		                       l.FraudAbuseFlag = 'U' => 'UNKNOWN',
		                       ''); //added for med sanc
	  self.SanctionReason := l.reason; //added for med sanc
	end;
	//denormalize med provider to seperate LicenseState, LicenseNumber into seperate records.
	msRecs := project(inMSRecs, ms2Common(left));
	plRecs := project(inPLRecs, pl2Common(left));			
  mpRecs := normalize(inMPRecs, LEFT.LicenseInfos, mp2Common(left, right));		
  mpRecsNoNumber := inMPRecs(count(licenseInfos) =0);
  mpRecsNoCommon := project(mpRecsNoNumber, mp2NoCommon(LEFT));

	msRecsCommon := msRecs(trim(state) <> '' and licenseNumber4dedup > 0);
	plRecsCommon := plRecs(trim(state) <> '' and licenseNumber4dedup > 0);		
  mpRecsCommon := mpRecs(trim(state) <> '' and licenseNumber4dedup > 0);
	
	msRecsBlank := msRecs(trim(state) = '' or licenseNumber4dedup = 0);
	plRecsBlank := plRecs(trim(state) = '' or licenseNumber4dedup = 0);		
  mpRecsBlank := mpRecs(trim(state) = '' or licenseNumber4dedup = 0) + mpRecsNoCommon;												
	
	commonLayout  rollMP(commonLayout l, commonLayout r) := transform
	   //select fields to use, keeping min and max dates.
    lNameExists := length(trim(l.Name.first + l.Name.middle + l.Name.last)) > 0;	
    lAddressExists  := length(trim(l.address.streetnumber + l.address.streetname + l.address.zip5)) > 0;
    lCountyExists := length(trim(l.county)) > 0;
		lPhoneExists := length(trim(l.phone)) > 0;
    lProfessionOrBoardExists := length(trim(l.professionOrBoard)) > 0;
    lLicenseTypeExists := length(trim(l.licenseType)) > 0;	
		lSSNExists := length(trim(l.ssn)) > 0;
		lStatusExists := length(trim(l.Status)) > 0;
		self.ssn := if (lSSNExists, l.ssn, r.ssn);
		self.status :=  if (lStatusExists, l.Status, r.Status);
		self.professionOrBoard := if (lprofessionOrBoardExists , l.professionOrBoard, r.professionOrBoard);
		self.name := if (lnameExists , l.name, r.name);
		self.address := if (laddressExists , l.address, r.address);
		self.county := if (lcountyExists , l.county, r.county);
		self.Phone := if (lPhoneExists,l.phone, r.phone);
		self.LicenseType := if (lLicenseTypeExists , l.LicenseType, r.LicenseType);
	  Taxids2use := dedup(sort(l.taxids+r.taxids,value),value);
		Specialties2Use := dedup(sort(l.specialties+r.specialties,id,stringlib.stringToUppercase(name),groupid, -trim(groupname)),id,stringlib.stringToUppercase(name),groupid);
		self.TaxIds :=  choosen(Taxids2use,iesp.Constants.PROFLIC.MAX_TAXIDS);
    self.Specialties := choosen(Specialties2Use,iesp.Constants.PROFLIC.MAX_SPECIALTIES);		 
		SmartRollup.mac_roll_DFS_tdate(issueDate);
		SmartRollup.mac_roll_DLS_tdate(expirationDate);
		self.licenseNumber := if (length(trim(l.licenseNumber)) >length(trim(r.licenseNumber)), l.licenseNumber, r.licenseNumber);
		self := l;
	end;
	//combine and rollup Prof License and Med Provider by State and LicenseNumber
	plmpSorted := sort(plRecsCommon + mpRecsCommon,state, licenseNumber4dedup, -iesp.ECL2ESP.DateToInteger(expirationDate), -iesp.ECL2ESP.DateToInteger(issueDate)) ;
  plmpRolled := rollup(plmpSorted, LEFT.state = RIGHT.state AND LEFT.licenseNumber4dedup = RIGHT.licenseNumber4dedup, rollMP(LEFT, RIGHT));
	
	//rollup med sanctions by date (issueDate, state, licensenumber) 												
	commonLayout  rollMs(commonLayout l, commonLayout r)  := transform
     lNameExists := length(trim(l.Name.first + l.Name.middle + l.Name.last)) > 0;	
     lAddressExists  := length(trim(l.address.streetnumber + l.address.streetname + l.address.zip5)) > 0;
     lCountyExists := length(trim(l.county)) > 0;
     lPhoneExists := length(trim(l.phone)) > 0;
     lProfessionOrBoardExists := length(trim(l.professionOrBoard)) > 0;
     lLicenseTypeExists := length(trim(l.licenseType)) > 0;
     lUPINExists := length(trim(l.UPIN)) > 0;
     lSanctionSourceExists := length(trim(l.SanctionSource)) > 0;
     lSanctionStateExists := length(trim(l.SanctionState)) > 0;
     lSanctionTypeExists := length(trim(l.SanctionType)) > 0;
     lProviderTypeExists := length(trim(l.ProviderType)) > 0;
     lLostOfLicenseExists := length(trim(l.LostOfLicense )) > 0;
     lFraudAbuseExists := length(trim(l.FraudAbuse)) > 0;
     lSanctionReasonExists := length(trim(l.SanctionReason)) > 0;
     lIssueDateExists := iesp.ECL2ESP.DateToInteger(l.issueDate) > 0;	
     lExpirationDateExists := iesp.ECL2ESP.DateToInteger(l.expirationDate) > 0;
     lDOBExists := iesp.ECL2ESP.DateToInteger(l.DOB) > 0;
		 lSSNExists := length(trim(l.ssn)) > 0;
     lSanctionDateExists := iesp.ECL2ESP.DateToInteger(l.SanctionDate) > 0;
		 self.ssn := if (lSSNExists, l.ssn, r.ssn);
     self.name := if (lNameExists, l.name, r.name); 
		 self.Address := if (lAddressExists ,l.address, r.address);
     self.County := if (lCountyExists ,l.County, r.County);
		 self.Phone := if (lPhoneExists,l.phone, r.phone);
     self.ProfessionOrBoard := if (lProfessionOrBoardExists ,l.ProfessionOrBoard, r.ProfessionOrBoard);	
     self.LicenseType := if (lLicenseTypeExists ,l.LicenseType, r.LicenseType);
     self.UPIN := if (lUPINExists ,l.UPIN, r.UPIN);
     self.SanctionSource := if (lSanctionSourceExists ,l.SanctionSource, r.SanctionSource);
     self.SanctionState := if (lSanctionStateExists ,l.SanctionState, r.SanctionState);
     self.SanctionType := if (lSanctionTypeExists ,l.SanctionType, r.SanctionType);
     self.ProviderType := if (lProviderTypeExists ,l.ProviderType, r.ProviderType);
     self.LostOfLicense := if (lLostOfLicenseExists ,l.LostOfLicense, r.LostOfLicense);
     self.FraudAbuse	:= if (lFraudAbuseExists ,l.FraudAbuse, r.FraudAbuse);
     self.SanctionReason := if (lSanctionReasonExists ,l.SanctionReason, r.SanctionReason);
     self.IssueDate := if (lIssueDateExists ,l.IssueDate, r.IssueDate);
     self.ExpirationDate := if (lExpirationDateExists ,l.ExpirationDate, r.ExpirationDate);
     self.DOB := if (lDOBExists ,l.DOB, r.DOB);
     self.SanctionDate := if (lSanctionDateExists ,l.SanctionDate, r.SanctionDate);
		 self.licenseNumber := if (length(trim(l.licenseNumber)) >length(trim(r.licenseNumber)), l.licenseNumber, r.licenseNumber);
		 self := l;
 	end;
	msSorted := sort(msRecsCommon, -iesp.ECL2ESP.DateToInteger(expirationDate), state, licenseNumber4dedup);
	msRolled := rollup(msSorted, left.expirationDate = right.expirationDate and
	                             left.state = right.state and
															 left.licenseNumber4dedup = right.licenseNumber4dedup, rollMs(left,right));
  //combine all output records together for final sort by date.															 
  finalRecs := plmpRolled + msRolled + mpRecsBlank + plRecsBlank + msRecsBlank;	
	finalSort  := sort(finalRecs, -iesp.ECL2ESP.DateToInteger(expirationDate)); 
	outRecs := project(finalSort,iesp.smartlinxreport.t_SLRProfLicenseAndSanctionAndProvider);
	
	RETURN outRecs;
end;