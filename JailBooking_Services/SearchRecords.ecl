import doxie, AutoStandardI, ut;

EXPORT SearchRecords(IParam.searchParams aInputData) := FUNCTION
	
	/* Search parameters */
	ssn := aInputData.ssn;
	fbiNumber := aInputData.fbiNumber;	
	STRING dlNumber := aInputData.dlValue;
	STRING14 didValue := aInputData.DIDValue;
	STRING stateId := aInputData.stateId;
	STRING lname := aInputData.lastname;
	STRING fname := aInputData.firstname;
	STRING addr := aInputData.addr;
	STRING city := aInputData.city;
	STRING state := aInputData.state;
	String zip := aInputData.zip;
	String phone10 := aInputData.phone;
	UNSIGNED ageLow := aInputData.ageLowValue;
	UNSIGNED agehigh := aInputData.ageHighValue;	
	UNSIGNED yearLow := aInputData.yearLow;
	UNSIGNED yearHigh := aInputData.yearHigh;
	UNSIGNED heightLow := aInputData.heightLow;
	UNSIGNED heightHigh := aInputData.heightHigh;
	UNSIGNED weightLow := aInputData.weightLow;
	UNSIGNED weightHigh := aInputData.weightHigh;
	STRING hairValue := aInputData.hair;
	STRING eyeValue :=  aInputData.eye;
	STRING raceValue := aInputData.race;
	String genderValue := aInputData.gender;
	UNSIGNED dob := aInputData.dob;

	STRING smt := aInputData.smt;
	STRING agencyCd := aInputData.agency;
	STRING jurisdiction := aInputData.jurisdiction;
		
	// hit autokeys for name, address, and ssn 
	byak := AutoKeyIds(aInputData);	
	
	// deep dive base on autokey params DIDs
	 deep_dids := project(limit(doxie.Get_Dids(,true),100,skip),
									  transform(doxie.layout_references, 									   								
										  self.did := left.did));
											 
	 // get more bookings based on dids.
	 by_deep_dids := project(if(aInputData.isDeepDive,Raw.getBookingsByDID(deep_dids)), 
	 TRANSFORM(Layouts.bookingId,
										self.isDeepDive := true, 
										self.booking_sid :=left.booking_sid));

  //drivers license search	
	dlnum := dataset([{dlNumber}],Layouts.DLNumber);
	bydlnum := Raw.getBookingsByDL(dlnum);
	
  // fbi number search
	fbiNum := dataset([{fbiNumber}], Layouts.FBINumber);
	byFbiNum := Raw.getBookingsByFBINumber(fbiNum);
	
	// state id search
	stateIdNum := dataset([{stateId}], Layouts.stateID);
	byStateIdNum := Raw.getBookingsByStateId(stateIdNum);
	
	// did search
	didNum := dataset([{didValue}], doxie.layout_references);
	byDidNum := Raw.getBookingsByDID(didNum);
		
	// demographic attributes search	
	attrs := dataset([{raceValue, genderValue, heightLow, heightHigh,
				weightLow, weightHigh, 
			 hairValue, eyeValue, yearLow, yearHigh}], Layouts.attributes);
	 
	byAttr := Raw.getBookingsByPhysicalAttr(attrs);

  // gang name search
	gangName := Functions.searchableGangName(aInputData.gangName);
	byGangName := Raw.getBookingsByGangName(gangName);
	
	// agency search
	agencyNum := dataset([{agencyCd, jurisdiction}], Layouts.agency);
	byAgency := Raw.getBookingsByAgency(agencyNum);
									
	// determine what kind of search based on parameters entered.
	boolean isFBINumber := fbiNumber <> '';
	boolean isDLNumber := dlNumber <> '';
	boolean isStateId := stateId <> '';
	boolean isSsn := ssn <> '';
	boolean isDidNumber := didValue <> '';
	boolean isGangName := gangName <> '';
	boolean isNameAddr := (lname<>'') or (addr <> '' and 
			((city <> '' and state <> '') or zip <> '')) or (phone10 <> '');
	boolean isPhysicalDesc := (raceValue <> '' and genderValue <> '' and (ageLow <> 0 
		and ageHigh <> 0) 
		and (heightLow > 0 or heightHigh > 0) and (weightLow > 0 or weightHigh > 0));
  boolean isAgency := agencyCd <> '' and jurisdiction <> '';

	// preference by ids search
	keys := map(isDidNumber => byDidNum,
					isFBINumber => byFbiNum, 
					isDLNumber => byDLNum, 
					isStateId => byStateIdNum,
					isSSN => byak + if(aInputData.isDeepDive, by_deep_dids),
					isNameAddr => byak + if(aInputData.isDeepDive, by_deep_dids),
					isGangName => byGangName,
					isPhysicalDesc => byAttr,
					isAgency => byAgency) ;
	
	bookRec1 := Raw.getBookings(dedup(keys, booking_sid, all));
	
	// gender and race are used as filter always not as penalty.
	bookRec2 := bookRec1(ut.NNEQ(key_gender, genderValue), (ut.NNEQ(key_race, raceValue)));
	
	// filter by agency and state_cd(jusrisdiction)
	bookRec3 := bookRec2((agencyCd = '') or agency_ori= agencyCd, 
												(jurisdiction = '') or (state_cd = jurisdiction));
	
	bookRec4 := Functions.apply_penalty(bookRec3, aInputData);		
	
	commonParam := PROJECT(aInputData, IParam.reportParams);
	bookRec5 := Functions.apply_restrictions(bookRec4, commonParam);		

	bookings := Functions.xform_BookingsIESP(bookRec5);
	outputRec := SORT(bookings, _Penalty, -CaseFilingDate, CaseNumber);		

	return outputRec;
END;