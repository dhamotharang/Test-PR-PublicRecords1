import Address, ut, NID, ChildIdentityFraudSolutionServices, STD;

export BatchRecords(dataset(ChildIdentityFraudSolutionServices.Layouts.batchIn) batchIn, ChildIdentityFraudSolutionServices.IParam.BatchParams configData) := function

	batchInDependents := batchIn(Identity_Type_Indicator = ChildIdentityFraudSolutionServices.Constants.IdentityTypeIndicator.DEPENDENT);

	//** The below fields are from the Deceased check.			
	dsDeath :=  ChildIdentityFraudSolutionServices.functions.getDeath(batchInDependents, configData);

	//** The below fields are from the Criminal - Department of Corrections check.			
	dsDoc := ChildIdentityFraudSolutionServices.functions.getCriminal(batchInDependents);  
		
	//** The below fields are from Consumer InstantID.
	 dsIID := ChildIdentityFraudSolutionServices.functions.getIID(batchIn); 
		
	//**The below fields are from the Header search.
	dsHeader := ChildIdentityFraudSolutionServices.functions.getHeader(batchInDependents);

	//** The OthersUsingSSN 
	dsOUSSN := ChildIdentityFraudSolutionServices.functions.getOUSSN(batchIn);

	//**The below fields are from the ADL_Best service.
	dsBest := ChildIdentityFraudSolutionServices.functions.getBest(batchInDependents);

	//Currently imposters are returned with blanked first name , last name and address fields. and also as filled fields. 

	dsBestMatchingPeople 	:=   join(dsBest, batchInDependents,
		((string) left.seq =  right.acctno AND 
		(left.best_ssn = right.ssn or (left.best_ssn = '' and  left.ssn = right.ssn) ) 
		AND left.best_fname <> '' ),
		transform(recordof(dsBest), self := left));
																						
	dsBestOtherPeople := dsBest - dsBestMatchingPeople;


	//** The below fields are from the Best Address service.			
	dsBestAddress := ChildIdentityFraudSolutionServices.functions.getBestAddress(batchInDependents,dsBestMatchingPeople);

	//** The below fields are from the Relatives & Associates check.			
	dsRAN := ChildIdentityFraudSolutionServices.functions.getRAN(dsHeader); 


	//** The below fields are from the Bankruptcy check.			
	dsBankruptcy := ChildIdentityFraudSolutionServices.functions.getBankruptcy(batchInDependents);

	//** The below fields are from the Lien/Judgment check.			
	dsLJ := ChildIdentityFraudSolutionServices.functions.getLJ(batchInDependents); 

	//** The below fields are from the Property check.			
	dsProperty := ChildIdentityFraudSolutionServices.functions.getProperty(batchInDependents);

	//** The below fields are from the Sexual Offender check.			
	dsSOF := ChildIdentityFraudSolutionServices.functions.getSOF(batchInDependents); 

	//** The below fields are from the People at Work check.			
	dsPAW := ChildIdentityFraudSolutionServices.functions.getPAW(batchInDependents);
	//** The below fields are from the Foreclosure check.			

	dsForeclosure := ChildIdentityFraudSolutionServices.functions.getForeclosure(batchInDependents, dsBestAddress); 
	// ** The below fields are from the Motor Vehicle check.			

	dsRTMV_Whole := ChildIdentityFraudSolutionServices.functions.getRTMV(batchInDependents,dsBestAddress); 
	dsRTMV := dsRTMV_Whole.Results;

	// ** The below fields are from the Professional License check.			
	dsPL :=  ChildIdentityFraudSolutionServices.functions.getPL(batchInDependents); 

	// ** The below fields are from the Watercraft check.			
	dsWC := ChildIdentityFraudSolutionServices.functions.getWC(batchInDependents); 

	// ** The below fields are from the Aircraft check.	
	dsFaaV2 := ChildIdentityFraudSolutionServices.functions.getFaaV2(batchInDependents);

	// ** The below fields are from the Business check.
	dsBusiness := ChildIdentityFraudSolutionServices.functions.getBusiness(batchInDependents); 

	DateSixMonthsAgoPre := ut.getDateOffset(-183, (string) STD.Date.Today());
	DateSixMonthsAgo := DateSixMonthsAgoPre[1..6]	;

	// Some useful transforms that will be used later: 
	//------------------------------------------------------------------------------------------------
	ChildIdentityFraudSolutionServices.Layouts.RelRecord xformRel(dsRAN le, unsigned1 C , typeof(ChildIdentityFraudSolutionServices.Layouts.batchIn.name_first) name_first, typeof(ChildIdentityFraudSolutionServices.Layouts.batchIn.name_last) name_last ) :=  transform
		self.idx := C;
		isAvailable := map(
										c = 1 and (le.rel_first_name_1 = name_first and le.rel_last_name_1 = name_last) => true,
										c = 2 and (le.rel_first_name_2 = name_first and le.rel_last_name_2 = name_last) => true,
										c = 3 and (le.rel_first_name_3 = name_first and le.rel_last_name_3 = name_last) => true,
										c = 4 and (le.rel_first_name_4 = name_first and le.rel_last_name_4 = name_last) => true,
										c = 5 and (le.rel_first_name_5 = name_first and le.rel_last_name_5 = name_last) => true,
										c = 6 and (le.rel_first_name_6 = name_first and le.rel_last_name_6 = name_last) => true,
										false
									);
		self.val := isAvailable;
		self.rel_first_name  := map (isAvailable and c = 1 => le.rel_first_name_1 ,
																 isAvailable and c = 2 => le.rel_first_name_2 ,
																 isAvailable and c = 3 => le.rel_first_name_3 ,
																 isAvailable and c = 4 => le.rel_first_name_4 ,
																 isAvailable and c = 5 => le.rel_first_name_5  ,
																 isAvailable and c = 6 => le.rel_first_name_6 ,'' );
		self.rel_last_name	:= map 	(isAvailable and c = 1 => le.rel_last_name_1 ,
																 isAvailable and c = 2 => le.rel_last_name_2 ,
																 isAvailable and c = 3 => le.rel_last_name_3 ,
																 isAvailable and c = 4 => le.rel_last_name_4 ,
																 isAvailable and c = 5 => le.rel_last_name_5  ,
																 isAvailable and c = 6 => le.rel_last_name_6 ,''); 
		self.rel_address	:= 	map 	(isAvailable and c = 1 => le.rel_address_1 ,
																 isAvailable and c = 2 => le.rel_address_2 ,
																 isAvailable and c = 3 => le.rel_address_3 ,
																 isAvailable and c = 4 => le.rel_address_4 ,
																 isAvailable and c = 5 => le.rel_address_5 ,
																 isAvailable and c = 6 => le.rel_address_6 ,'');
		self.rel_city	:= 				map( isAvailable and c = 1 => le.rel_city_1 ,
																 isAvailable and c = 2 => le.rel_city_2 ,
																 isAvailable and c = 3 => le.rel_city_3 ,
																 isAvailable and c = 4 => le.rel_city_4 ,
																 isAvailable and c = 5 => le.rel_city_5  ,
																 isAvailable and c = 6 => le.rel_city_6 ,'');
		self.rel_state	:=			map (isAvailable and c = 1 => le.rel_state_1 ,
																 isAvailable and c = 2 => le.rel_state_2 ,
																 isAvailable and c = 3 => le.rel_state_3 ,
																 isAvailable and c = 4 => le.rel_state_4 ,
																 isAvailable and c = 5 => le.rel_state_5  ,
																 isAvailable and c = 6 => le.rel_state_6 ,'');
		self.rel_zipcode	:=		 map(isAvailable and c = 1 => le.rel_zipcode_1 ,
																 isAvailable and c = 2 => le.rel_zipcode_2 ,
																 isAvailable and c = 3 => le.rel_zipcode_3 ,
																 isAvailable and c = 4 => le.rel_zipcode_4 ,
																 isAvailable and c = 5 => le.rel_zipcode_5  ,
																 isAvailable and c = 6 => le.rel_zipcode_6 ,'');
		self.rel_dob	:= 				map (isAvailable and c = 1 => le.rel_dob_1 ,
																 isAvailable and c = 2 => le.rel_dob_2 ,
																 isAvailable and c = 3 => le.rel_dob_3 ,
																 isAvailable and c = 4 => le.rel_dob_4 ,
																 isAvailable and c = 5 => le.rel_dob_5  ,
																 isAvailable and c = 6 => le.rel_dob_6 ,'');
		end;
						
	//------------------------------------------------------------------------------------------------
	//AssocRecord												
	ChildIdentityFraudSolutionServices.Layouts.AssoRecord xformAsso(dsRAN le, unsigned1 C , typeof(ChildIdentityFraudSolutionServices.Layouts.batchIn.name_first) name_first, typeof(ChildIdentityFraudSolutionServices.Layouts.batchIn.name_last) name_last) :=  transform
		self.idx := C;
		isAvailable := map(
										c = 1 and (le.asso_first_name_1 = name_first and le.asso_last_name_1 = name_last ) => true,
										c = 2 and (le.asso_first_name_2 = name_first and le.asso_last_name_2 = name_last ) => true,
										c = 3 and (le.asso_first_name_3 = name_first and le.asso_last_name_3 = name_last ) => true,
										c = 4 and (le.asso_first_name_4 = name_first and le.asso_last_name_4 = name_last ) => true,
										c = 5 and (le.asso_first_name_5 = name_first and le.asso_last_name_5 = name_last ) => true,
										c = 6 and (le.asso_first_name_6 = name_first and le.asso_last_name_6 = name_last ) => true,
										false
										);
		self.val := isAvailable;
		self.asso_first_name  := map (isAvailable and c = 1 => le.asso_first_name_1 ,
																 isAvailable and c = 2 => le.asso_first_name_2 ,
																 isAvailable and c = 3 => le.asso_first_name_3 ,
																 isAvailable and c = 4 => le.asso_first_name_4 ,
																 isAvailable and c = 5 => le.asso_first_name_5  ,
																 isAvailable and c = 6 => le.asso_first_name_6 ,'' );
		self.asso_last_name	:= map 	(isAvailable and c = 1 => le.asso_last_name_1 ,
																 isAvailable and c = 2 => le.asso_last_name_2 ,
																 isAvailable and c = 3 => le.asso_last_name_3 ,
																 isAvailable and c = 4 => le.asso_last_name_4 ,
																 isAvailable and c = 5 => le.asso_last_name_5  ,
																 isAvailable and c = 6 => le.asso_last_name_6 ,''); 
		self.asso_address	:= 	map 	(isAvailable and c = 1 => le.asso_address_1 ,
																 isAvailable and c = 2 => le.asso_address_2 ,
																 isAvailable and c = 3 => le.asso_address_3 ,
																 isAvailable and c = 4 => le.asso_address_4 ,
																 isAvailable and c = 5 => le.asso_address_5 ,
																 isAvailable and c = 6 => le.asso_address_6 ,'');
		self.asso_city	:= 				map( isAvailable and c = 1 => le.asso_city_1 ,
																 isAvailable and c = 2 => le.asso_city_2 ,
																 isAvailable and c = 3 => le.asso_city_3 ,
																 isAvailable and c = 4 => le.asso_city_4 ,
																 isAvailable and c = 5 => le.asso_city_5  ,
																 isAvailable and c = 6 => le.asso_city_6 ,'');
		self.asso_state	:=			map (isAvailable and c = 1 => le.asso_state_1 ,
																 isAvailable and c = 2 => le.asso_state_2 ,
																 isAvailable and c = 3 => le.asso_state_3 ,
																 isAvailable and c = 4 => le.asso_state_4 ,
																 isAvailable and c = 5 => le.asso_state_5  ,
																 isAvailable and c = 6 => le.asso_state_6 ,'');
		self.asso_zipcode	:=		 map(isAvailable and c = 1 => le.asso_zipcode_1 ,
																 isAvailable and c = 2 => le.asso_zipcode_2 ,
																 isAvailable and c = 3 => le.asso_zipcode_3 ,
																 isAvailable and c = 4 => le.asso_zipcode_4 ,
																 isAvailable and c = 5 => le.asso_zipcode_5  ,
																 isAvailable and c = 6 => le.asso_zipcode_6 ,'');
		self.asso_dob	:= 				map (isAvailable and c = 1 => le.asso_dob_1 ,
																 isAvailable and c = 2 => le.asso_dob_2 ,
																 isAvailable and c = 3 => le.asso_dob_3 ,
																 isAvailable and c = 4 => le.asso_dob_4 ,
																 isAvailable and c = 5 => le.asso_dob_5  ,
																 isAvailable and c = 6 => le.asso_dob_6 ,'');
	end;	

	//------------------------------------------------------------------------------------------------

	ChildIdentityFraudSolutionServices.Layouts.BatchOut TheXform(ChildIdentityFraudSolutionServices.Layouts.batchIn L) := transform
		self := L; 
		//**The below fields are from the Header search.		
		headerRecs := dsHeader(acctno = L.acctno);
		HeaderDID :=  headerRecs( ssn = L.ssn and valid_ssn = 'G')[1].did; 
		// find the possible imposter based on the DID.  
		imposterRec := headerRecs(did <> HeaderDID );
		countImposterDIDs := count(imposterRec);													
		OldestImposterDOB := sort(imposterRec,dob)[1].DOB;
		OldestImposterAge := ut.Age(OldestImposterDOB);
		CompromisedSince := (string)(sort(imposterRec,-dt_first_seen)[1].dt_first_seen);
						 
		//The date first seen on the earliest record within the identity cluster will be used to determine the timeframe of last 6 months from date batch is run
		self.Misrepresented_SSN := map( countImposterDIDs = 1 and OldestImposterAge >= 18  and 
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.DEPENDENT => 'Y',
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT => ' ',
																		'N');
		self.Newly_Compromised_SSN := map(CompromisedSince >= DateSixMonthsAgo and 
																			L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.DEPENDENT => 'Y',
																			L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT => ' ',
																			'N');
		self.Header_DID := HeaderDID;
			
		//**The below fields are from the ADL_Best service.
		dsBestPersons 		:=  dsBestMatchingPeople((string)seq = L.acctno);
		dsBestImposters 	:=  dsBestOtherPeople((string)seq = L.acctno); 
														 
		//lex_id_2 / BestDID 
		self.Best_Did 	:= 	dsBestPersons[1].Did;
		//best_ssn / BestSSN
		self.Best_SSN		:=	dsBestPersons[1].Best_ssn;
		//best_fname
		self.Best_Fname := dsBestPersons[1].Best_Fname; 
		//best_lname
		self.Best_Lname := dsBestPersons[1].Best_Lname; 
		//ssn / ImposterSSN
		self.Imposter_SSN	:= dsBestImposters[1].Best_SSN;
		//lex_id_3 / ImposterDID
		self.Imposter_Did	:= dsBestImposters[1].Did;

		//** The below fields are from the Best Address service.			
		dsBestAddressRecs := dsBestAddress(acctno=L.acctno);

		//best_addr1						 
		Best_Addr1 := Address.Addr1FromComponents( dsBestAddressRecs[1].prim_range , dsBestAddressRecs[1].predir	, 
									dsBestAddressRecs[1].prim_name	, dsBestAddressRecs[1].suffix	, dsBestAddressRecs[1].postdir , dsBestAddressRecs[1].unit_desig,dsBestAddressRecs[1].sec_range);	
		BOOLEAN isInputAddrMatch := dsBestAddressRecs[1].prim_range = l.prim_range and
			dsBestAddressRecs[1].prim_name = l.prim_name and
			dsBestAddressRecs[1].sec_range = l.sec_range and
			(dsBestAddressRecs[1].z5 = l.z5 or 
				(dsBestAddressRecs[1].st = l.st and dsBestAddressRecs[1].p_city_name = l.p_city_name));
		self.Best_Addr1 := if(isInputAddrMatch, '', Best_Addr1);
		//best_city
		self.Best_City := if(isInputAddrMatch, '', dsBestAddressRecs[1].p_city_name);
		//best_state
		self.Best_State := if(isInputAddrMatch, '', dsBestAddressRecs[1].st);
		//best_zip
		self.Best_Zip :=  if(isInputAddrMatch, '', dsBestAddressRecs[1].z5);
		//date_last_seen
		self.Best_Date_Last_Seen := if(isInputAddrMatch, '', dsBestAddressRecs[1].addr_dt_last_seen); 
		//latitude
		self.Latitude := dsBestAddressRecs[1].latitude;
		//longitude
		self.Longitude := dsBestAddressRecs[1].longitude;
		//state_code + county_fips
		self.Geocode := dsBestAddressRecs[1].fips_county;

		//**The below fields are from the OUSSN search.
		dsOUSSNRecs := dsOUSSN(acctno = L.acctno);
		countOUSSN  := map(
												dsOUSSNRecs[1].other_first_name_1 <> '' and dsOUSSNRecs[1].other_first_name_2 = '' => 1, 
												dsOUSSNRecs[1].other_first_name_2 <> '' and dsOUSSNRecs[1].other_first_name_3 = '' => 2, 
												dsOUSSNRecs[1].other_first_name_3 <> '' and dsOUSSNRecs[1].other_first_name_4 = '' => 3, 
												dsOUSSNRecs[1].other_first_name_4 <> '' and dsOUSSNRecs[1].other_first_name_5 = '' => 4, 
												dsOUSSNRecs[1].other_first_name_5 <> '' and dsOUSSNRecs[1].other_first_name_6 = '' => 5, 
												dsOUSSNRecs[1].other_first_name_6 <> '' and dsOUSSNRecs[1].other_first_name_7 = '' => 6, 
												dsOUSSNRecs[1].other_first_name_7 <> '' and dsOUSSNRecs[1].other_first_name_8 = '' => 7, 
												dsOUSSNRecs[1].other_first_name_8 <> '' and dsOUSSNRecs[1].other_first_name_9 = '' => 8, 
												dsOUSSNRecs[1].other_first_name_9 <> '' and dsOUSSNRecs[1].other_first_name_10 = '' => 9, 
												dsOUSSNRecs[1].other_first_name_10 <> ''  => 10,
												0 
											);
												
		self.Compromised_SSN	:= if(countOUSSN >= 1 and countOUSSN <= 3, 'Y','N'); 
		self.Highly_Compromised_SSN  := if(countOUSSN > 3, 'Y','N'); 
				
		//** The below fields are from the Deceased check.
						
		deathRecs := dsDeath(acctno = L.acctno);
		//deceased_indicator
		self.Deceased_Indicator := map(exists(deathRecs)and 
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.DEPENDENT => 'Y',
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT => ' ',
																		'N');
		//dod
		self.DOD	:= deathRecs[1].DOD8;
		//lname
		self.Deceased_Lname := deathRecs[1].lname;
		//fname
		self.Deceased_Fname	:= deathRecs[1].fname;
		//deceased_matchcode
		self.Deceased_Matchcode := deathRecs[1].matchcode;

		//** The below fields are from Consumer InstantID.
		RecsIID := dsIID(acctno = L.acctno);  
		//hri_1_code
		hri_MI_code :=  if(RecsIID[1].hri_1_indicator = 'MI' OR RecsIID[1].hri_2_indicator = 'MI' OR 
													RecsIID[1].hri_3_indicator = 'MI' OR RecsIID[1].hri_4_indicator = 'MI' OR
													RecsIID[1].hri_5_indicator = 'MI' OR RecsIID[1].hri_6_indicator = 'MI', 'MI','');
		self.Hri_1_Code := hri_MI_code;
		//hri_2_code
		hri_IT_code := if(RecsIID[1].hri_1_indicator = 'IT' OR RecsIID[1].hri_2_indicator = 'IT' OR
											RecsIID[1].hri_3_indicator = 'IT' OR RecsIID[1].hri_4_indicator = 'IT' OR
											RecsIID[1].hri_5_indicator = 'IT' OR RecsIID[1].hri_6_indicator = 'IT','IT','');
		self.Hri_2_Code := if(L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT, hri_IT_code,'');
		//ITIN Fraud Filer
		self.ITIN_FraudFiler := map(L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT and 
																hri_IT_code = 'IT'  and hri_MI_code = 'MI' => 'Y',
																L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.DEPENDENT => ' ',
																'N');

		//** The below fields are from the Criminal - Department of Corrections check.	
						
		docRecs := sort(dsDOC( acctno = L.acctno and 
													 lname = L.name_last and
													 ( 
														fname[1] = L.name_first[1]  or
														fname = NID.PreferredFirstNew(l.name_first)  or
														fname = l.name_first
													 )
												), - max(in_event_dt_1,in_event_dt_2,in_event_dt_3,
															 in_event_dt_4,in_event_dt_5,in_event_dt_6)
									);
						
		//doc_lname
		self.doc_lname := docRecs[1].lname; 
		//doc_fname
		self.doc_fname := docRecs[1].fname;
		//doc_dob
		self.doc_dob := docRecs[1].dob; 
		//doc_ssn
		self.doc_ssn := docRecs[1].ssn; 
		//doc_num
		self.doc_num := docRecs[1].doc_num; 
		//doc_state_origin
		self.doc_state_origin := docRecs[1].state_origin; 


		//** The below fields are from the Relatives & Associates check.
		/*We look not only at input SSN's relatives and associates , but also possible (SSN sharing)imposter's reletives and associates */					

		dsRANRecs := dsRAN(acctno = L.acctno);
						
		// Check out level 1 relatives that match input name.	
													
		Recs_rel_match  := dsRANRecs(
														(	(rel_depth_1 = '1') and rel_first_name_1 = L.name_first and rel_last_name_1 = L.name_last) OR	
														(	(rel_depth_2 = '1') and rel_first_name_2 = L.name_first and rel_last_name_2 = L.name_last) OR
														(	(rel_depth_3 = '1') and rel_first_name_3 = L.name_first and rel_last_name_3 = L.name_last) OR
														(	(rel_depth_4 = '1') and rel_first_name_4 = L.name_first and rel_last_name_4 = L.name_last) OR
														(	(rel_depth_5 = '1') and rel_first_name_5 = L.name_first and rel_last_name_5 = L.name_last) OR
														(	(rel_depth_6 = '1') and rel_first_name_6 = L.name_first and rel_last_name_6 = L.name_last)    );

						
		dsRelRecsNorm := NORMALIZE(Recs_rel_match, 6, XformRel(left,counter,L.name_first,L.name_last));
		dsRelRecsNormHitsOnly  			:=  dsRelRecsNorm(val = true);
		dsRelRecsNormHitsOnlyCount 	:= 	count(dsRelRecsNormHitsOnly);	
						
		// Check out associates that match input name.	
		Recs_asso_match  := dsRANRecs(							
									(asso_first_name_1 = L.name_first and asso_last_name_1 = L.name_last ) OR				
									(asso_first_name_2 = L.name_first and asso_last_name_2 = L.name_last ) OR							 
									(asso_first_name_3 = L.name_first and asso_last_name_3 = L.name_last ) OR							
									(asso_first_name_4 = L.name_first and asso_last_name_4 = L.name_last ) OR								 
									(asso_first_name_5 = L.name_first and asso_last_name_5 = L.name_last ) OR							 
									(asso_first_name_6 = L.name_first and asso_last_name_6 = L.name_last )	  );
									

		dsAssoRecsNorm := NORMALIZE(Recs_asso_match, 6, xformAsso(left,counter,L.name_first,L.name_last));
		dsAssoRecsNormHitsOnly  			:=  dsAssoRecsNorm(val = true);
		dsAssoRecsNormHitsOnlyCount 	:= 	count(dsAssoRecsNormHitsOnly);	

		boolean IsRiskyRelAsso := 	 dsRelRecsNormHitsOnlyCount + dsAssoRecsNormHitsOnlyCount  > 0 ;		
																												
		self.Input_Identities_With_Risky_Associates := map(IsRiskyRelAsso and 
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.DEPENDENT => 'Y',
																		L.Identity_Type_Indicator = Constants.IdentityTypeIndicator.ADULT => ' ',
																		'N');
		//rel first name 1
		self.rel_first_name_1			:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_first_name,''); 
		//rel last name 1
		self.rel_last_name_1			:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_last_name,'') ; 
		//rel address 1
		self.rel_address_1				:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_address,'') ;
		//rel city 1
		self.rel_city_1						:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_city,'') ;
		//rel state 1
		self.rel_state_1					:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_state,'' ) ;
		//rel zipcode 1
		self.rel_zipcode_1				:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_zipcode,'' ) ;
		//rel dob 1
		self.rel_dob_1						:=	if(dsRelRecsNormHitsOnlyCount > 0,dsRelRecsNormHitsOnly[1].rel_dob,'' ) ;
		//rel first name 2
		self.rel_first_name_2	 		:=	if(dsRelRecsNormHitsOnlyCount > 1,dsRelRecsNormHitsOnly[2].rel_first_name,'' ) ;
		//rel last name 2
		self.rel_last_name_2			:=	if(dsRelRecsNormHitsOnlyCount > 1,dsRelRecsNormHitsOnly[2].rel_last_name,'' ) ;
		//rel lexid 2
		self.rel_DID_2						:=	if(dsRelRecsNormHitsOnlyCount > 1 ,HeaderDID,0 ) ;
		//rel first name 3
		self.rel_first_name_3			:=	if(dsRelRecsNormHitsOnlyCount > 2,dsRelRecsNormHitsOnly[3].rel_first_name,'' ) ;
		//rel last name 3
		self.rel_last_name_3			:=	if(dsRelRecsNormHitsOnlyCount > 2,dsRelRecsNormHitsOnly[3].rel_last_name,'' ) ;
		//rel lexid 3
		self.rel_DID_3						:=	if(dsRelRecsNormHitsOnlyCount > 2,HeaderDID,0 ) ;

		//asso first name 1
		self.asso_first_name_1		:=	if(dsAssoRecsNormHitsOnlyCount > 0 ,dsAssoRecsNormHitsOnly[1].asso_first_name,'' ) ;
		//asso last name 1
		self.asso_last_name_1			:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_last_name,'' ) ;
		//asso address 1
		self.asso_address_1				:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_address,'' ) ;
		//asso city 1
		self.asso_city_1					:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_city,'' ) ;
		//asso state 1
		self.asso_state_1					:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_state,'' ) ;
		//asso zipcode 1
		self.asso_zipcode_1				:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_zipcode,'' ) ;
		//asso dob 1
		self.asso_dob_1						:=	if(dsAssoRecsNormHitsOnlyCount > 0,dsAssoRecsNormHitsOnly[1].asso_dob,'' ) ;
		//asso first name 2
		self.asso_first_name_2		:=	if(dsAssoRecsNormHitsOnlyCount > 1,dsAssoRecsNormHitsOnly[2].asso_first_name,'' ) ;
		//asso last name 2
		self.asso_last_name_2			:=	if(dsAssoRecsNormHitsOnlyCount > 1,dsAssoRecsNormHitsOnly[2].asso_last_name,'' ) ;
		//asso lexid 2
		self.asso_DID_2						:=	if(dsAssoRecsNormHitsOnlyCount > 1,HeaderDID,0 ) ;
		//asso first name 3
		self.asso_first_name_3		:=	if(dsAssoRecsNormHitsOnlyCount > 2,dsAssoRecsNormHitsOnly[3].asso_first_name,'' ) ;
		//asso last name 3
		self.asso_last_name_3			:=	if(dsAssoRecsNormHitsOnlyCount > 2,dsAssoRecsNormHitsOnly[3].asso_last_name,'' ) ;
		//asso lexid 3
		self.asso_DID_3						:=	if(dsAssoRecsNormHitsOnlyCount > 2,HeaderDID,0 ) ;

		//** The below fields are from the Bankruptcy check.
		BankruptcyRecs := sort(dsBankruptcy(acctno = L.acctno),-date_filed);
		//BK_count
		BK_count := count(BankruptcyRecs);
		self.BKcount		:=	BK_count;
		//debtor did 
		self.debtor_DID := if(BK_count >0,BankruptcyRecs[1].debtor_DID,'');
		//debtor 1 lname
		self.debtor_1_lname := if(BK_count >0,BankruptcyRecs[1].debtor_1_lname,'');
		//debtor 1 fname
		self.debtor_1_fname:= if(BK_count >0,BankruptcyRecs[1].debtor_1_fname,'');
		//debtor prim range
		self.debtor_prim_range := if(BK_count >0,BankruptcyRecs[1].debtor_prim_range,'');
		//debtor prim name
		self.debtor_prim_name := if(BK_count >0,BankruptcyRecs[1].debtor_prim_name,'');
		//debtor p city name
		self.debtor_p_city_name := if(BK_count >0,BankruptcyRecs[1].debtor_p_city_name,'');
		//debtor st
		self.debtor_st := if(BK_count >0,BankruptcyRecs[1].debtor_st,'');
		//debtor zip
		self.debtor_zip := if(BK_count >0,BankruptcyRecs[1].debtor_zip,'');
		//case number
		self.bk_case_number := if(BK_count >0,BankruptcyRecs[1].case_number,'');
		//court location
		self.court_location := if(BK_count >0,BankruptcyRecs[1].court_location,'');

		//** The below fields are from the Lien/Judgment check.			
		RecsLJ := sort(dsLJ(acctno = L.acctno),-orig_filing_date);
		//LJ count
		LJ_count := count(RecsLJ);
		self.LJ_count := LJ_count;
		//debtor 1 party 1 did
		self.debtor_1_party_1_did := if(LJ_count > 0 ,RecsLJ[1].debtor_1_party_1_did ,'');
		//debtor 1 party 1 lname
		self.debtor_1_party_1_lname := if(LJ_count > 0 ,RecsLJ[1].debtor_1_party_1_lname ,'');
		//debtor 1 party 1 fname
		self.debtor_1_party_1_fname := if(LJ_count > 0 ,RecsLJ[1].debtor_1_party_1_fname ,'');
		//creditor orig name
		self.creditor_orig_name := if(LJ_count > 0 ,RecsLJ[1].creditor_orig_name ,'');
		//case number
		self.LJ_case_number := if(LJ_count > 0 ,RecsLJ[1].case_number ,'');
		//orig filing date
		self.orig_filing_date := if(LJ_count > 0 ,RecsLJ[1].orig_filing_date ,'');
		//release date
		self.release_date := if(LJ_count > 0 ,RecsLJ[1].release_date ,'');

		//** The below fields are from the Property check.	
		RecsPropertyPre := dsProperty(acctno = L.acctno); 
		RecsProperty := sort(RecsPropertyPre, -assess_recording_date);
		//Prop_count
		PropCount := count(RecsProperty);
		self.Prop_count := PropCount ;
		// buyer 1 did
		self.buyer_1_did := if(PropCount > 0,RecsProperty[1].buyer_1_did,'' );
		// buyer 1 orig name
		self.buyer_1_orig_name := if(PropCount > 0,RecsProperty[1].buyer_1_orig_name, '' );
		// buyer 2 orig name
		self.buyer_2_orig_name := if(PropCount > 0,RecsProperty[1].buyer_2_orig_name,'' );
		// property address1
		property_address1 := if(PropCount > 0,RecsProperty[1].property_address1,'' );
		self.property_address1 := property_address1;
		// property p city name
		self.property_p_city_name := if(PropCount > 0,RecsProperty[1].property_p_city_name,'' );
		// property st
		self.property_st := if(PropCount > 0,RecsProperty[1].property_st,'' );
		// property zip
		self.property_zip := if(PropCount > 0,RecsProperty[1].property_zip,'' );
		// assess county name
		self.assess_county_name := if(PropCount > 0,RecsProperty[1].assess_county_name,'' );
		// assess apna or pin number
		self.assess_apna_or_pin_number := if(PropCount > 0,RecsProperty[1].assess_apna_or_pin_number,'' );
		// deed property address desc
		self.deed_property_address_desc := if(PropCount > 0,RecsProperty[1].deed_property_address_desc,'' );
		// owner 1 orig name
		self.owner_1_orig_name := if(PropCount > 0,RecsProperty[1].owner_1_orig_name,'' );
		// owner 2 orig name
		self.owner_2_orig_name := if(PropCount > 0,RecsProperty[1].owner_2_orig_name,'' );
		// seller 1 orig name
		self.seller_1_orig_name := if(PropCount > 0,RecsProperty[1].seller_1_orig_name,'' );
		// deed apnt or pin number
		self.deed_apnt_or_pin_number := if(PropCount > 0,RecsProperty[1].deed_apnt_or_pin_number,'' );
		// property county name
		self.property_county_name := if(PropCount > 0,RecsProperty[1].property_county_name,'' ); 
		// deed recording date
		self.deed_recording_date := if(PropCount > 0,RecsProperty[1].deed_recording_date,'' );

		//** The below fields are from the Sexual Offender check.			
		RecsSOF := sort(dsSOF.records(acctno = L.acctno), -date_last_seen); 
		// SOF_count
		SOFcount := count(dsSOF.offenses(acctno = L.acctno));
		self.SOF_count := SOFcount;
		// Unique Id
		//self.SOF_DID := if(SOFcount > 0 ,RecsSOF[1].seisint_primary_key , '');
		// name_first
		self.SOF_name_first := if(SOFcount > 0 ,RecsSOF[1].first_name  ,'');
		// name_last
		self.SOF_name_last := if(SOFcount > 0 ,RecsSOF[1].last_name  ,'');
		// Street_Address1
		SOF_StreetAddress1 := if(SOFcount > 0 ,RecsSOF[1].prim_range + ' ' + 	RecsSOF[1].predir + ' ' + 
																				 RecsSOF[1].prim_name+ ' ' + RecsSOF[1].addr_suffix + ' ' + RecsSOF[1].postdir,'' );
																				 
		self.SOF_Street_Address1 := SOF_StreetAddress1;
		// City
		self.SOF_City := if(SOFcount > 0 ,RecsSOF[1].p_city_name  ,'');
		// State
		self.SOF_State := if(SOFcount > 0 ,RecsSOF[1].st  ,'');
		// Zip5
		self.SOF_Zip5 := if(SOFcount > 0 ,RecsSOF[1].Zip5  ,'');
		// date last seen
		self.SOF_date_last_seen := if(SOFcount > 0 ,RecsSOF[1].date_last_seen  ,'');
		// dob
		self.SOF_dob := if(SOFcount > 0 ,RecsSOF[1].dob  ,'');

		//** The below fields are from the People at Work check.			
		PAWRecs := sort(dsPAW(acctno = L.acctno), - max(pawk_1_last_seen , pawk_2_last_seen, pawk_3_last_seen, pawk_4_last_seen, pawk_5_last_seen));
		max_pawk_last_seen := max(PAWRecs[1].pawk_1_last_seen,  PAWRecs[1].pawk_2_last_seen, PAWRecs[1].pawk_3_last_seen, 
														PAWRecs[1].pawk_4_last_seen, PAWRecs[1].pawk_5_last_seen);

		pawk_to_take :=  map(
													max_pawk_last_seen = PAWRecs[1].pawk_1_last_seen => 1,
													max_pawk_last_seen = PAWRecs[1].pawk_2_last_seen => 2,
													max_pawk_last_seen = PAWRecs[1].pawk_3_last_seen => 3,
													max_pawk_last_seen = PAWRecs[1].pawk_4_last_seen => 4,
													5
												); 
		// PAW_count
		PAW_count := count(PAWRecs);
		self.PAWK_count := PAW_count;
		// pawk 1 did
		self.pawk_1_did := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_did,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_did,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_did,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_did,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_did,
														''
													);
		// pawk 1 first
		self.pawk_1_first := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_first,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_first,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_first,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_first,
														pawk_to_take = 5 =>	PAWRecs[1].pawk_5_first,
														''
													);
		// pawk 1 last
		self.pawk_1_last := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_last,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_last,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_last,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_last,
														pawk_to_take = 5 =>	PAWRecs[1].pawk_5_last,
														''
													);
		// pawk 1 company name
		self.pawk_1_company_name := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_company_name,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_company_name,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_company_name,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_company_name,
														pawk_to_take = 5 =>	PAWRecs[1].pawk_5_company_name,
														''
													);
		// pawk 1 address
		self.pawk_1_address := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_address,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_address,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_address,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_address,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_address,
														''
													);
		// pawk 1 city
		self.pawk_1_city := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_city,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_city,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_city,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_city,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_city,
														''
													);
		// pawk 1 state
		self.pawk_1_state := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_state,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_state,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_state,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_state,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_state,
														''
														);
		// pawk 1 zip5
		self.pawk_1_zip5 := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_zip5,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_zip5,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_zip5,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_zip5,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_zip5,
														''
														);
		//pawk 1 fein
		self.pawk_1_fein :=  map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_fein,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_fein,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_fein,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_fein,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_fein,
														''
														);
		//pawk 1 phone
		self.pawk_1_phone := map(
														pawk_to_take = 1 => PAWRecs[1].pawk_1_phone10,
														pawk_to_take = 2 => PAWRecs[1].pawk_2_phone10,
														pawk_to_take = 3 => PAWRecs[1].pawk_3_phone10,
														pawk_to_take = 4 => PAWRecs[1].pawk_4_phone10,
														pawk_to_take = 5 => PAWRecs[1].pawk_5_phone10,
														''
														);

		//** The below fields are from the Foreclosure check.	
		RecsForeclosure := sort(dsForeclosure(acctno = L.acctno) ,-CP_RECORDING_DT );
		// FC_count
		FC_count := count(RecsForeclosure);
		self.FC_count := FC_count;
		// fc unique id
		//self.fc_did;
		// plntff1 name
		self.plntff1_name := if(FC_count > 0, RecsForeclosure[1].plntff1_name ,'' );
		// plntff2 name
		self.plntff2_name := if(FC_count > 0, RecsForeclosure[1].plntff2_name ,'' );
		// ownr 1 first name
		self.ownr_1_first_name := if(FC_count > 0, RecsForeclosure[1].ownr_1_first_name ,'' );
		// ownr 1 last name
		self.ownr_1_last_name := if(FC_count > 0, RecsForeclosure[1].ownr_1_last_name ,'' );
		// ownr 2 first name
		self.ownr_2_first_name := if(FC_count > 0, RecsForeclosure[1].ownr_2_first_name ,'' );
		// ownr 2 last name
		self.ownr_2_last_name := if(FC_count > 0, RecsForeclosure[1].ownr_2_last_name ,'' );
		// p city name
		self.fc_p_city_name := if(FC_count > 0, RecsForeclosure[1].p_city_name ,'' );
		// st
		self.fc_st := if(FC_count > 0, RecsForeclosure[1].st ,'' );
		// zip
		self.fc_zip := if(FC_count > 0, RecsForeclosure[1].zip ,'' );
		// deed recording date
		self.fc_deed_recording_date := if(FC_count > 0, RecsForeclosure[1].deed_recording_date ,'' );

		// ** The below fields are from the Motor Vehicle check.
		RecsRTMV := sort(dsRTMV(acctno = L.acctno),-reg_latest_expiration_date, -reg_latest_effective_date);
		// MV_count
		MVCount := count(RecsRTMV);
		self.MV_count := MVCount;
		// reg license plate
		self.reg_license_plate := if(MVCount > 0 ,RecsRTMV[1].reg_license_plate ,'');
		// vin
		self.vin_out := if(MVCount > 0 ,RecsRTMV[1].vin ,'');
		// own 1 did
		self.own_1_did := if(MVCount > 0 ,RecsRTMV[1].own_1_did ,'');
		// reg 1 did
		self.reg_1_did := if(MVCount > 0 ,RecsRTMV[1].reg_1_did ,'');
		// reg latest effective date
		self.reg_latest_effective_date := if(MVCount > 0 ,RecsRTMV[1].reg_latest_effective_date ,'');

		// ** The below fields are from the Professional License check.
		RecsPL := sort(dsPL (acctno = L.acctno),-date_last_seen);
		// PL_count
		PL_count := count(RecsPL);
		self.PL_count := PL_count;
		// did
		self.PL_did := (integer) if(PL_count > 0 ,RecsPL[1].did ,'');
		// orig name
		self.orig_name := if(PL_count > 0 ,RecsPL[1].orig_name ,'');
		// orig addr 1
		self.orig_addr_1 := if(PL_count > 0 ,RecsPL[1].orig_addr_1 ,'');
		// orig city
		self.orig_city := if(PL_count > 0 ,RecsPL[1].orig_city ,'');
		// orig st
		self.orig_st := if(PL_count > 0 ,RecsPL[1].orig_st ,'');
		// orig zip
		self.orig_zip := if(PL_count > 0 ,RecsPL[1].orig_zip ,'');
		// source st
		self.source_st := if(PL_count > 0 ,RecsPL[1].source_st ,'');
		// orig license number
		self.orig_license_number := if(PL_count > 0 ,RecsPL[1].orig_license_number ,'');
		// license type
		self.license_type := if(PL_count > 0 ,RecsPL[1].license_type ,'');
		// issue date
		self.issue_date := if(PL_count > 0 ,RecsPL[1].issue_date ,'');

		// ** The below fields are from the Watercraft check.			
		RecsWC  := sort(dsWC (acctno = L.acctno), -registration_date);
		// WC_count
		WC_count := count(RecsWC);
		self.WC_count := WC_count;
		// did 1
		self.wc_did_1 := (integer) if(WC_count > 0 ,RecsWC[1].did_1,'');
		// fname 1
		self.fname_1 := if(WC_count > 0 ,RecsWC[1].fname_1,'');
		// lname 1
		self.lname_1 := if(WC_count > 0 ,RecsWC[1].lname_1,'');
		// hull number
		self.hull_number := if(WC_count > 0 ,RecsWC[1].hull_number,'');
		// registration date
		self.registration_date := if(WC_count > 0 ,RecsWC[1].registration_date,'');

		// ** The below fields are from the Aircraft check.
		RecsFaaV2 :=  sort(dsFaaV2(acctno = L.acctno),- max(last_action_date_1 , last_action_date_2 ,
																			last_action_date_3 , last_action_date_4 ,
																			last_action_date_5));
		AC_count := count(RecsFaaV2);

		max_last_action_date := if(AC_count > 0  ,max(	RecsFaaV2[1].last_action_date_1 , 
																										RecsFaaV2[1].last_action_date_2 ,
																										RecsFaaV2[1].last_action_date_3 , 
																										RecsFaaV2[1].last_action_date_4 ,
																										RecsFaaV2[1].last_action_date_5
																															 ),'');
																			
		last_action_date_index := map(max_last_action_date = RecsFaaV2[1].last_action_date_1 =>1,
																	max_last_action_date = RecsFaaV2[1].last_action_date_2 =>2,
																	max_last_action_date = RecsFaaV2[1].last_action_date_3 =>3,
																	max_last_action_date = RecsFaaV2[1].last_action_date_4 =>4,
																	max_last_action_date = RecsFaaV2[1].last_action_date_5 =>5,
																	0);
		// AC_count
		self.AC_count := AC_count;
		// did out
		self.did_out := (integer) if(AC_count > 0  ,RecsFaaV2[1].did_out, '' );
		// name
		self.name  :=  if(AC_count > 0  ,RecsFaaV2[1].name, '' );
		// serial number 1
		self.serial_number  :=  map(
																	AC_count > 0 and last_action_date_index = 1 => RecsFaaV2[1].serial_number_1,
																	AC_count > 0 and last_action_date_index = 2 => RecsFaaV2[1].serial_number_2,
																	AC_count > 0 and last_action_date_index = 3 => RecsFaaV2[1].serial_number_3,
																	AC_count > 0 and last_action_date_index = 4 => RecsFaaV2[1].serial_number_4,
																	AC_count > 0 and last_action_date_index = 5 => RecsFaaV2[1].serial_number_5,
																	'' );
		// last action date 1
		self.last_action_date :=  map(
																	AC_count > 0 and last_action_date_index = 1 => RecsFaaV2[1].last_action_date_1,
																	AC_count > 0 and last_action_date_index = 2 => RecsFaaV2[1].last_action_date_2,
																	AC_count > 0 and last_action_date_index = 3 => RecsFaaV2[1].last_action_date_3,
																	AC_count > 0 and last_action_date_index = 4 => RecsFaaV2[1].last_action_date_4,
																	AC_count > 0 and last_action_date_index = 5 => RecsFaaV2[1].last_action_date_5,
																	'' );
																	
		// BIP 
		RecsBiz := sort(dsBusiness(acctno = L.acctno),-dt_last_seen,dt_first_seen);
		// Biz_count
		BizCount := count(RecsBiz);
		self.Biz_count := BizCount;
		// bdid
		self.bdid_out := if(BizCount > 0, RecsBiz[1].company_bdid,0);
		// ContactID 
		//self.biz_contactID:= '', 
		// company name
		self.company_name := if(BizCount > 0, RecsBiz[1].company_name,'');
		// street
		street := if(BizCount > 0, RecsBiz[1].prim_range+' '+ RecsBiz[1].predir + ' '+ 
															 RecsBiz[1].prim_name + ' '+ RecsBiz[1].addr_suffix + ' '+  
															 RecsBiz[1].postdir+ ' '+ RecsBiz[1].unit_desig+ ' '+ 
															 RecsBiz[1].sec_range ,'');
		self.biz_street  := street;
		// city
		self.biz_city := if(BizCount > 0, RecsBiz[1].p_city_name,'');
		// state
		self.biz_state := if(BizCount > 0, RecsBiz[1].st,'');
		// zip
		self.biz_zip  := if(BizCount > 0, RecsBiz[1].zip,'');	

		self:= []; 
						
	END;
			
	dsOutput := project(batchIn,TheXform(left));	
	//dsOutput := dataset([],Layouts.BatchOut); // DEBUG

	ds_CIFS_recs := dsOutput;

	ds_recs := ds_CIFS_recs;

	/*
	We now need to send results and royalties
	*/
	finalRec := record
		dataset(recordof(ds_recs)) Records;
		dataset(recordof(dsRTMV_Whole.Royalties)) Royalties;
	end;	

	finalRecords := dataset([{ds_recs ,dsRTMV_Whole.Royalties}],finalRec);

	return finalRecords;
	
end;