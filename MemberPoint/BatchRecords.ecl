IMPORT Address, ut, progressive_phone, Royalty,
       PhoneFinder_Services, MemberPoint, Std,iesp,risk_indicators,Gateway,riskwise,patriot,OFAC_XG5,doxie,AutoStandardI;

	export BatchRecords(dataset(MemberPoint.Layouts.batchIn) rawBatchIn, MemberPoint.IParam.BatchParams BParams) := function
		//------------------------------------------------------------------------------------------------//
		// Check the processes that we are to run input on
			boolean IIDVersionOverride := false : STORED('IIDVersionOverride');		
			isIncludeAddress 				:= BParams.IncludeAddress; 
			isIncludePhone 					:= BParams.IncludePhone;
			isIncludeEmail 					:= BParams.IncludeEmail;
			isIncludeDeceased				:= BParams.IncludeDeceased;
			isIncludeGender 				:= BParams.IncludeGender;
			isIncludeDOB 						:= BParams.IncludeDOB;
			isIncludeSSN 						:= BParams.IncludeSSN;
			boolean IncludeAllRiskIndicators:=true;
			unsigned1 lowestAllowedVersion := 1;
			string1 IIDVersion := '1';
			unsigned1 maxAllowedVersion := 1;
			boolean IsInstantID := true;
			boolean EnableEmergingID := false;
			string5 	 IndustryClassVal := ''; 	
			industryClassValue := STD.Str.ToUpperCase(IndustryClassVal);		
			unsigned3 HistoryDate := 999999 	;	
			boolean   UseDobFilter := false; 		
			integer2  DobRadius := 2; 		
			string    ModelIn := ''; 		
			boolean   IncludeDLverification := false; 		
			string15  DOBMatchType := '';		
			unsigned1 DOBMatchYearRadius := 0;		
			string    DataRestriction := bparams.DataRestrictionMask;		
			string50 DataPermission := bparams.DataPermissionMask;		
			// new options for CIID project summer 2013		
			string20 CompanyID := '';		
			unsigned3 LastSeenThreshold := risk_indicators.iid_constants.oneyear;// : STORED('LastSeenThreshold');		
			boolean IncludeDriverLicenseInCVI := false;//	: STORED('IncludeDriverLicenseInCVI');	
			boolean DisableInquiriesInCVI := false;		
			boolean DisallowInsurancePhoneHeaderGateway := false;	
			boolean IncludeEmailverification:=false;		
			boolean disablenongovernmentdldata := false ; //to exclude non government data in DL Verification		
			boolean IncludeDigitalIdentity  := false;	
			boolean suppressNearDups := false;
			boolean require2ele := false;
			boolean fromBiid := false;
			boolean isFCRA := false;
			boolean runSSNCodes:= true;
			boolean runBestAddrCheck:= true;
			boolean runChronoPhoneLookup:= true;
			boolean runAreaCodeSplitSearch:= true;
			boolean fromIT1O := false;
			boolean allowCellPhones := false;
			string1 CustomDataFilter := '';  // this only for Phillip Morris in Identifier2
			boolean OfacOnly := true ;
			boolean ExcludeWatchLists := false ;
			unsigned1 OFACVersion :=1 ;
			boolean IncludeAdditionalWatchlists := FALSE;
			boolean IncludeOfac := FALSE;
			real GlobalWatchListThreshold_temp := 0 ;
     // CCPA Fields
			unsigned1 LexIdSourceOptout := 1 ;
			string TransactionID := '';
			string BatchUID := '' ;
			unsigned6 GlobalCompanyId := 0 ;
			string10 ExactMatchLevel := '0';
			unsigned2 EverOccupant_PastMonths := 0;
			unsigned4 EverOccupant_StartDate  := 99999999;
			unsigned1 AppendBest := 1;		// search best file
			boolean AllowInsuranceDL := true;
			ModelName := STD.STR.ToLowerCase( ModelIn );

			boolean OFAC := true;	// used in cviScore override, FlexID has been hardcoded to TRUE, so I am doing that here now
			actualIIDVersion := map((unsigned)IIDVersion > maxAllowedVersion => 99,	// they asked for a version that doesn't exist
															IIDVersionOverride = false => MIN(MAX((unsigned)IIDversion, lowestAllowedVersion), maxAllowedVersion),	// choose the higher of the allowed or asked for because they can't override lowestAllowedVersion, however, don't let them pick a version that is higher than the highest one we currently support
															(unsigned)IIDversion); // they can override, give them whatever they asked for
			if(actualIIDVersion=99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));
      		boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND
															actualIIDVersion=1;
 
      		watchlists_request := dataset([], iesp.share.t_StringArrayItem);
			GlobalWatchListThreshold := Map( 
																		OFACVersion >= 4	and GlobalWatchListThreshold_temp = 0	 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFACVersion < 4  and GlobalWatchListThreshold_temp = 0  => OFAC_XG5.Constants.DEF_THRESHOLD_REAL,
																		GlobalWatchListThreshold_temp);
		
			isUtility := Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(IndustryClassVal));
      		DobRadiusUse := if(UseDobFilter,DobRadius,-1);
			NumReasons := 20;
			DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);
			integer BSVersion := MAP (
													ModelName in ['fp1109_0', 'fp1109_9']  =>  4, 
													ModelName in ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'] => 51,	
													51);  //for the Emerging Identities project, default BS version to 51

			enableEquifaxPhoneMart:= DataRestriction[Risk_indicators.iid_constants.enableEquifaxPhoneMart]=Risk_indicators.iid_constants.sFalse;

			reasoncode_settings := dataset([{IsInstantID,actualIIDVersion,EnableEmergingID,false,false,false,false,false,includeemailverification}],riskwise.layouts.reasoncode_settings);

			unsigned8 BSOptions := 	if(doInquiries, risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
															if(~DisallowInsurancePhoneHeaderGateway and actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0) +
															if(actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0) +
															if(modelname in ['fp1303_2', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'],  
																												risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
																												risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																	0) +
															if(AllowInsuranceDL, risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo, 0) +  //Allows use of Insurance DL information
															if(EnableEmergingID, Risk_Indicators.iid_constants.BSOptions.EnableEmergingID,0) +
															if(bsversion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0)+	//Invokes additional DID append logic
															if(IncludeDigitalIdentity,Risk_indicators.iid_constants.BSOptions.runthreatmetrix,0)+
															if(disablenongovernmentdldata, risk_indicators.iid_constants.BSOptions.disablenongovernmentdldata, 0) + //check to disable use of Non Governmental DL information
															if(enableEquifaxPhoneMart,Risk_indicators.iid_constants.BSOptions.enableEquifaxPhoneMart,0);
 

		//Alternate to PhoneFinder
		// isPhoneInfoAlternative	:= MemberPoint.IParam.IsPhoneFinderOperation;
		isPhoneInfoAlternative	:= Std.Str.ToUpperCase(BParams.StrTransactionType) NOT IN [ MemberPoint.Constants.PhoneTransactionType.ContactPlusPhones, MemberPoint.Constants.PhoneTransactionType.WaterfallPhones ];
		//------------------------------------------------------------------------------------------------//
		//Set partial fields if no full value supplied
		batchIn := PROJECT(rawBatchIn, TRANSFORM(MemberPoint.Layouts.batchIn,
																						SELF.SSN					:= IF(LEFT.SSN<>'', LEFT.SSN, LEFT.SSNLast4),
																						SELF.guardian_SSN	:= IF(LEFT.guardian_SSN<>'', LEFT.guardian_SSN, LEFT.GuardianSSNLast4),
																						SELF							:= LEFT));
		//------------------------------------------------------------------------------------------------//
		//Project input to inter  and classify based on LN_search_name_type of M,G or S 
		ClassifiedBatchInter := MemberPoint.makeClassifiedBatchInter(batchIn);
		ClassifiedMinors 		 := ClassifiedBatchInter(LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Minor);
		ClassifiedNonMinors  := ClassifiedBatchInter(LN_search_name_type <> MemberPoint.Constants.LNSearchNameType.Minor);
		//------------------------------------------------------------------------------------------------//
		// Run deceased on all input minors without guardian information.	
	  	dsbestClassifiedMinors:=MemberPoint.getBest(ClassifiedMinors, BParams);
		dsbestGoodClassifiedMinors:=dsbestClassifiedMinors(score  >= BParams.UniqueIdScoreThreshold);
		dsbestClassifiedMinorprojected:=join(dsbestGoodClassifiedMinors,ClassifiedMinors,LEFT.SEQ=(INTEGER)RIGHT.ACCTNO,transform(MemberPoint.Layouts.BatchInter,
		                                                          self.acctno:=RIGHT.acctno;
                                                              self.name_first:=if(LEFT.best_fname <> '',LEFT.best_fname,RIGHT.name_FIRST);
																															self.name_middle:=if(LEFT.best_mname <> '',LEFT.best_mname,right.name_MIDDLE);
																															self.name_last:=if(LEFT.best_lname <> '',LEFT.best_lname,right.name_LAST);
																															self.name_suffix:=if(LEFT.best_name_suffix<>'',LEFT.best_name_suffix,RIGHT.NAME_suffix);
                                                              self.prim_range:=if(LEFT.c_best_prim_range<>'',LEFT.c_best_prim_range,RIGHT.PRIM_RANGE);																															
                                                              self.addr_suffix:=if(LEFT.c_best_addr_suffix<>'',LEFT.c_best_addr_suffix,RIGHT.addr_suffix);																													
                                                              self.postdir:=IF(LEFT.c_best_postdir<>'',LEFT.c_best_postdir,RIGHT.postdir);																															
																															self.p_city_name:=IF(LEFT.C_best_p_city_name<>'',LEFT.C_best_p_city_name,RIGHT.p_city_name);
																															self.st:=IF(LEFT.C_best_st<>'',LEFT.C_best_st,RIGHT.st);
																															self.z5:=IF(LEFT.C_best_z5<>'',LEFT.C_BEST_Z5,RIGHT.Z5);
																															self.zip4:=IF(LEFT.C_best_zip4<>'',LEFT.C_best_zip4,LEFT.ZIP4);
																															self.dob:=IF(LEFT.best_dob<>'',LEFT.BEST_DOB,RIGHT.DOB);
																															SELF.SSN:=IF(LEFT.BEST_SSN<>'',LEFT.BEST_SSN,RIGHT.SSN);
																															self.LN_search_name_type:=RIGHT.LN_search_name_type;
																															self:=RIGHT;self:=LEFT;self:=[];),LEFT OUTER);

		
		//		dsbestClassifiedMinorprojected:=project(ClassifiedMinors,dsbestGoodClassifiedMinors,transform(MemberPoint.Layouts.BatchInter,self:=left;self:=[];));
		dsDeceasedInputMinorsPre 	:= MemberPoint.getDeceasedInfo(dsbestClassifiedMinorprojected, BParams,true);
		dsDeceasedInputMinors 		:= if(isIncludeDeceased, dsDeceasedInputMinorsPre , dataset([],MemberPoint.Layouts.DeceasedOut ));
		//-------------------------------------------------------------------------------------------------//
		//Further try to find the guardians and set relevant inter fields including LN_search_name = D.
		AfterAttemptGuardiansBatchInter		:= MemberPoint.deriveGuardiansFromReverseAddress(ClassifiedMinors,BParams); 
		AfterDerivingMinors  							:= AfterAttemptGuardiansBatchInter(LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Minor);
		derivedGuardiansFromReverseAddress:= AfterAttemptGuardiansBatchInter(LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived);
		//-------------------------------------------------------------------------------------------------//
		//PhonesPlus: Augment the existing minor process by adding a reverse phone lookup
		reversePhonesResult						:= MemberPoint.PhoneLookup.deriveGuardiansFromPhonesPlus(AfterDerivingMinors, BParams);
		minorsWithoutGuardians				:= reversePhonesResult(LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Minor);
		derivedGuardiansFromPhonesPlus:= reversePhonesResult(LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived);
		//-------------------------------------------------------------------------------------------------//
		//Meet all adults
		derivedGuardians							:= derivedGuardiansFromReverseAddress + derivedGuardiansFromPhonesPlus;
		AdultsOrGuardiansBatchInterPre:= derivedGuardians + ClassifiedNonMinors;
		//Get ADL_Best service.
		dsBestExt 		:= MemberPoint.getBest(AdultsOrGuardiansBatchInterPre, BParams);
		// filter out the lesser than 80 DIDs, might be a fake identity.  
		dsBestGood    := dsBestExt(score  >= BParams.UniqueIdScoreThreshold);
		// All the derived guardians with score less than threshold (80) to become pure minors back again
		BadDerivedTurnedbackToMinors := join(	derivedGuardians, dsBestGood, 
													left.acctno = (string) right.seq,
													transform(MemberPoint.Layouts.BatchInter ,
																self.LN_search_name_type := 	MemberPoint.Constants.LNSearchNameType.Minor,
																self.Guardian_name_first :=   '',
																self.Guardian_name_last	 :=	  '',
																self.Guardian_DOB				 :=	  '',
																self.Guardian_SSN 			 :=   '',
																self 										 := 	left),left only);
		//Add minors with low score derived guardians back to minors	
		MinorsOnlyBatchInter 				:= 	minorsWithoutGuardians + BadDerivedTurnedbackToMinors;
		// Subtract minors with low score derived guardians back from adults
		AdultsOrGuardiansBatchInter := join (AdultsOrGuardiansBatchInterPre, BadDerivedTurnedbackToMinors, 
																					 left.acctno = right.acctno, 
																					 transform(MemberPoint.Layouts.batchInter, self := left),
																					 left only );
		//------------------------------------------------------------------------------------------------//
		// Processes Adults, Guardians and Derived Guardians   
		MemberPoint.Layouts.BatchInter xformToInter(  MemberPoint.Layouts.BatchInter L , MemberPoint.Layouts.BestExtended R ) := transform
																					self.computed_did := R.did;
																					self.computed_did_score := R.score;
																					self := L ;
																				end;	
																					
		dsInputGoodWithDIDAndScore  := join( AdultsOrGuardiansBatchInter ,dsBestGood ,
																					right.seq = (integer)left.acctno, 
																					xformToInter(left,right), left outer); 
		// Get BestAddress			


		MemberPoint.Layouts.batch_in_extended into_seq(rawBatchIn L, integer C) := transform
			self.seq := C;
			self := l;
		end;
		FS := project(rawBatchIn, into_seq(LEFT,COUNTER));		
		
		rawBatchProjected:=project(FS,transform(risk_indicators.layout_input,
			dob_val := riskwise.cleandob(left.dob);
			history_date := Std.Date.Today();
  	  		self.historydate :=  history_date;
	    	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp('', history_date);
			self.seq:=left.seq;
	    	self.ssn := left.ssn;
	    	self.dob := dob_val;
	  		self.phone10 := left.primary_phone_number;
			self.fname := STD.STR.ToUpperCase(left.Name_First);
			self.lname := STD.STR.ToUpperCase(left.Name_Last);
			self.mname := STD.STR.ToUpperCase(left.Name_Middle);
			self.suffix := STD.STR.ToUpperCase(left.Name_Suffix);	
  	  		street_address := risk_indicators.MOD_AddressClean.street_address(LEFT.PRIM_RANGE+''+LEFT.PRIM_NAME+''+LEFT.ADDR_SUFFIX,LEFT.prim_range, LEFT.predir, LEFT.prim_name,  LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
      		clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, leFT.p_City_name, leFT.St, leFT.Z5 );
			SELF.in_streetAddress := street_address;
			SELF.in_city := left.p_City_name;
			SELF.in_state := left.St;
			SELF.in_zipCode := left.Z5;
			self.prim_range := clean_a2[1..10];
			self.predir := clean_a2[11..12];
			self.prim_name := clean_a2[13..40];
			self.addr_suffix := clean_a2[41..44];
			self.postdir := clean_a2[45..46];
			self.unit_desig := clean_a2[47..56];
			self.sec_range := clean_a2[57..65];
			self.p_city_name := clean_a2[90..114];
			self.st := clean_a2[115..116];
			self.z5 := clean_a2[117..121];
			self.zip4 := clean_a2[122..125];
			self.lat := clean_a2[146..155];
			self.long := clean_a2[156..166];
			self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139],clean_a2[126..129]);
			self.addr_status := clean_a2[179..182];
			self.county := clean_a2[143..145];
			self.geo_blk := clean_a2[171..177];
			self.email_address := left.email;
			self:=[];
			));

			

			// calculate the actual iidVersion that will be used.  To start, versions 0 and 1 will be supported.  0 will represent the historical iid, while version 1 will
			// represent the new logic implemented for 1/28/2014 release (new cvi, phones plus, inquiries, insurance header, reason codes etc).  A new input tag will allow the customer
			// to choose the version they want to use.  This version cannot be lower than the lowest allowed version unless the override tag is set to true, in which case
			// the customer can choose any version and if no version is passed in, it will be considered version 0.


			risk_indicator_instantid:=risk_indicators.InstantID_Function(
 	                                                                 rawBatchProjected,
																																	 BParams.gateways, BParams.DPPA, BParams.GLB, isUtility, bparams.ln_branded, 
																																	 OFACOnly, suppressNearDups, require2ele, fromBiid, isFCRA, ExcludeWatchLists,
                                                                   fromIT1O, OFACVersion, IncludeOFAC, IncludeAdditionalWatchlists, 
                                                                   GlobalWatchListThreshold, DobRadiusUse, BSVersion, runSSNCodes, runBestAddrCheck, 
                                                                   runChronoPhoneLookup, runAreaCodeSplitSearch, allowCellPhones, ExactMatchLevel, 
                                                                   DataRestriction, CustomDataFilter, IncludeDLverification, watchlists_request, DOBMatchOptions,
                                                                   EverOccupant_PastMonths, EverOccupant_StartDate, AppendBest, BSoptions, LastSeenThreshold, 
                                                                   CompanyID, DataPermission,
                                                                   LexIdSourceOptout := LexIdSourceOptout, 
																																	 TransactionID := TransactionID, 
																																	 BatchUID := BatchUID, 
																																	 GlobalCompanyID := GlobalCompanyID,
																																	 in_industryClass := industryClassValue
																																	 );
		
		
		  MemberPoint.Layouts.AddressesRec_extended format_out(risk_indicator_instantid le, fs ri) := TRANSFORM
																											SELF.seq := ri.seq;
																											SELF.acctNo := ri.acctno;
																											RiskIndicators := memberpoint.reasonCodes(le, NumReasons, reasoncode_settings);
																											RiskIndicatorsfiltered:=RiskIndicators(hri<>'');
																											SELF.addressdescriptioncode1 := if (count(RiskIndicatorsfiltered) >= 1, RiskIndicatorsfiltered[1].hri, '');
																											SELF.addressDescription1 := if (count(RiskIndicatorsfiltered) >= 1, RiskIndicatorsfiltered[1].desc, '');
																											SELF.addressdescriptioncode2 := if (count(RiskIndicatorsfiltered) >= 2, RiskIndicatorsfiltered[2].hri, '');
																											SELF.addressDescription2 := if (count(RiskIndicatorsfiltered) >= 2, RiskIndicatorsfiltered[2].desc, '');
																											SELF.addressdescriptioncode3 := if (count(RiskIndicatorsfiltered) >= 3, RiskIndicatorsfiltered[3].hri, '');
																											SELF.addressDescription3 := if (count(RiskIndicatorsfiltered) >= 3, RiskIndicatorsfiltered[3].desc, '');
																											SELF.addressdescriptioncode4 := if (count(RiskIndicatorsfiltered) >= 4, RiskIndicatorsfiltered[4].hri, '');
																											SELF.addressDescription4 := if (count(RiskIndicatorsfiltered) >= 4, RiskIndicatorsfiltered[4].desc, '');
																											SELF.addressdescriptioncode5 := if (count(RiskIndicatorsfiltered) >= 5, RiskIndicatorsfiltered[5].hri, '');
																											SELF.addressDescription5 := if (count(RiskIndicatorsfiltered) >= 5, RiskIndicatorsfiltered[5].desc, '');
																											SELF.addressdescriptioncode6 := if (count(RiskIndicatorsfiltered) >= 6, RiskIndicatorsfiltered[6].hri, '');
																											SELF.addressDescription6 := if (count(RiskIndicatorsfiltered) >= 6, RiskIndicatorsfiltered[6].desc, '');
																											SELF.addressdescriptioncode7 := if (count(RiskIndicatorsfiltered) >= 7, RiskIndicatorsfiltered[7].hri, '');
																											SELF.addressDescription7 := if (count(RiskIndicatorsfiltered) >= 7, RiskIndicatorsfiltered[7].desc, '');
																											SELF.addressdescriptioncode8 := if (count(RiskIndicatorsfiltered) >= 8, RiskIndicatorsfiltered[8].hri, '');
																											SELF.addressDescription8 := if (count(RiskIndicatorsfiltered) >= 8, RiskIndicatorsfiltered[8].desc, '');
																											SELF.addressdescriptioncode9 := if (count(RiskIndicatorsfiltered) >= 9, RiskIndicatorsfiltered[9].hri, '');
																											SELF.addressDescription9 := if (count(RiskIndicatorsfiltered) >= 9, RiskIndicatorsfiltered[9].desc, '');
																											SELF.addressdescriptioncode10 := if (count(RiskIndicatorsfiltered) >= 10, RiskIndicatorsfiltered[10].hri, '');
																											SELF.addressDescription10 := if (count(RiskIndicatorsfiltered) >= 10, RiskIndicatorsfiltered[10].desc, '');
																											self:=le;
																											self:=[];
																											end;
	
		risk_indicatorsFINAL := join(risk_indicator_instantid, fs, left.seq = right.seq, format_out(LEFT, RIGHT));																																																	
	   	dsBestAddress 	:= MemberPoint.getBestAddress(dsBestGood, BParams);
		// Generate the "Address" and "Possible New Address" based on the address from Best & BestAddress  	
		dsAddressesPre	:= MemberPoint.selectAddress(dsBestGood,dsBestAddress,AdultsOrGuardiansBatchInter,BParams);
		dsAddressesPreprojected:=project(dsAddressesPre,transform(MemberPoint.Layouts.AddressesRec_extended,
		                                                            self:=left;self:=[];
	                                                             	));
		 riskindicator_addressjoined:=join(dsAddressesPreprojected,risk_indicatorsFINAL,left.acctno=right.acctno,              
		                                                         TRANSFORM(MemberPoint.Layouts.AddressesRec_extended, 
																																				SELF.addressdescriptioncode1:=right.addressdescriptioncode1;
																																				SELF.addressdescription1:=right.addressdescription1;
																																				SELF.addressdescriptioncode2:=right.addressdescriptioncode2;
																																				SELF.addressdescription2:=right.addressdescription2;
																																				SELF.addressdescriptioncode3:=right.addressdescriptioncode3;
																																				SELF.addressdescription3:=right.addressdescription3;
																																				SELF.addressdescriptioncode4:=right.addressdescriptioncode4;
																																				SELF.addressdescription4:=right.addressdescription4;
																																				SELF.addressdescriptioncode5:=right.addressdescriptioncode5;
																																				SELF.addressdescription5:=right.addressdescription5;
																																				SELF.addressdescriptioncode6:=right.addressdescriptioncode6;
																																				SELF.addressdescription6:=right.addressdescription6;
																																				SELF.addressdescriptioncode7:=right.addressdescriptioncode7;
																																				SELF.addressdescription7:=right.addressdescription7;
																																				SELF.addressdescriptioncode8:=right.addressdescriptioncode8;
																																				SELF.addressdescription8:=right.addressdescription8;
																																				SELF.addressdescriptioncode9:=right.addressdescriptioncode9;
																																				SELF.addressdescription9:=right.addressdescription9;
																																				SELF.addressdescriptioncode10:=right.addressdescriptioncode10;
																																				SELF.addressdescription10:=right.addressdescription10;
																																				self:=left;self:=[];));
		 dsAddresses :=  if(isIncludeAddress,riskindicator_addressjoined, dataset([],MemberPoint.Layouts.AddressesRec_extended)); 
		//Run all adults except derived guardians thru deceased.
		dsbestAdults:=MemberPoint.getBest(dsInputGoodWithDIDAndScore, BParams);
		dsBestGoodAdults    := dsbestAdults(score  >= BParams.UniqueIdScoreThreshold);
	  	dsbestAdultsprojected:=join(dsBestGoodAdults,dsInputGoodWithDIDAndScore,LEFT.SEQ=(INTEGER)RIGHT.ACCTNO,transform(MemberPoint.Layouts.BatchInter,
		                                                          self.acctno:=RIGHT.acctno;
                                                              self.name_first:=if(LEFT.best_fname <> '',LEFT.best_fname,RIGHT.name_FIRST);
																															self.name_middle:=if(LEFT.best_mname <> '',LEFT.best_mname,right.name_MIDDLE);
																															self.name_last:=if(LEFT.best_lname <> '',LEFT.best_lname,right.name_LAST);
																															self.name_suffix:=if(LEFT.best_name_suffix<>'',LEFT.best_name_suffix,RIGHT.NAME_suffix);
                                                              self.prim_range:=if(LEFT.c_best_prim_range<>'',LEFT.c_best_prim_range,RIGHT.PRIM_RANGE);																															
                                                              self.addr_suffix:=if(LEFT.c_best_addr_suffix<>'',LEFT.c_best_addr_suffix,RIGHT.addr_suffix);																													
                                                              self.postdir:=IF(LEFT.c_best_postdir<>'',LEFT.c_best_postdir,RIGHT.postdir);																															
																															self.p_city_name:=IF(LEFT.C_best_p_city_name<>'',LEFT.C_best_p_city_name,RIGHT.p_city_name);
																															self.st:=IF(LEFT.C_best_st<>'',LEFT.C_best_st,RIGHT.st);
																															self.z5:=IF(LEFT.C_best_z5<>'',LEFT.C_BEST_Z5,RIGHT.Z5);
																															self.zip4:=IF(LEFT.C_best_zip4<>'',LEFT.C_best_zip4,LEFT.ZIP4);
																															self.dob:=IF(LEFT.best_dob<>'',LEFT.BEST_DOB,RIGHT.DOB);
																															SELF.SSN:=IF(LEFT.BEST_SSN<>'',LEFT.BEST_SSN,RIGHT.SSN);
																															self.LN_search_name_type:=RIGHT.LN_search_name_type;
																															self:=RIGHT;self:=LEFT;self:=[];),LEFT OUTER);

		dsDeceasedInputAdultsPre 			:= MemberPoint.getDeceasedInfo(dsbestAdultsprojected(LN_search_name_type <> MemberPoint.Constants.LNSearchNameType.Derived), BParams);	
		dsDeceasedInputAdults 				:= if(isIncludeDeceased, dsDeceasedInputAdultsPre, dataset([],MemberPoint.Layouts.DeceasedOut ));		// All deceased.
		dsDeceased := dsDeceasedInputMinors + dsDeceasedInputAdults;
		// Phone Info (Waterfall Phones)
		wfResult_pre	:= MemberPoint.getPhoneInfo(dsBestGood, BParams);
		wfResult 		:= wfResult_pre.Records;
		wfResult_royalties 	:= if(isIncludePhone AND EXISTS(wfResult), 
									wfResult_pre.royalties, 
									DATASET([],Royalty.Layouts.RoyaltyForBatch) );	

		dsPhonesPre	:= map ( BParams.PhonesReturnCutoff = 'H' => wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.HighMin), 
							 BParams.PhonesReturnCutoff = 'L' => wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.LowMin),
																 wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.MidMin));//'M' and default
		ungroupedWFPhones	:= ungroup(dsPhonesPre);
		connectedWFPhones	:= MemberPoint.ConnectedPhones.getConnectedWaterfall(ungroupedWFPhones, BParams);
		filteredWFPhones	:= MAP( BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.CellPhones => connectedWFPhones(switch_type=MemberPoint.Constants.WFPhoneType.CellPhones),
									BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.Landlines => connectedWFPhones(switch_type=MemberPoint.Constants.WFPhoneType.Landlines),
															connectedWFPhones);
		dsPhones := if(isIncludePhone AND EXISTS(ungroupedWFPhones), 
									filteredWFPhones, 
									DATASET([],progressive_phone.layout_progressive_phone_common));

		// Phone Info (PhoneFinder)
		pfPhones := IF(isIncludePhone AND EXISTS(dsBestGood), 
									MemberPoint.getAlternatePhoneInfo(dsBestGood, BParams), 
									DATASET([], PhoneFinder_Services.Layouts.PhoneFinder.BatchOut));

		dsEmailsWholePre 		:= MemberPoint.getEmailInfo(dsBestGood, BParams);
		dsEmailsWhole				:= if(isIncludeEmail,dsEmailsWholePre, dataset([],MemberPoint.Layouts.EmailRec));
		// dsEmailsResults 		:= ungroup(dsEmailsWhole.Records);
		dsEmailsResults 		:= dsEmailsWhole.Records;

		//Common BatchOut Transformation
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
		MemberPoint.Layouts.BatchOut buildCommonBatchOut(MemberPoint.Layouts.batchInter adultsOrGuardians,MemberPoint.Layouts.batchIn batchin) := TRANSFORM
			rowBest := dsBestGood(seq = (UNSIGNED)adultsOrGuardians.acctno)[1];
			rowAddress := dsAddresses(acctno = adultsOrGuardians.acctno)[1];
			rowDeceased := dsDeceased(acctno = adultsOrGuardians.acctno)[1];
			rowsEmails := dsEmailsResults(acctno = adultsOrGuardians.acctno); 
			rowsEmailStatus := dsEmailsWhole.emailstatus(acctno = adultsOrGuardians.acctno);
			
			SELF.acctno := adultsOrGuardians.acctno; // get guardian info AND classification 
			BestName := address.NameFromComponents(rowBest.best_fname ,rowBest.best_mname ,rowBest.best_lname,rowBest.best_name_suffix );
			BestInputName := address.NameFromComponents(rowBest.fname ,rowBest.mname ,rowBest.lname,rowBest.suffix );
			Name := if(BestName = '' ,BestInputName ,BestName);
			SELF.LN_search_name := Name; 
			SELF.LN_search_name_type := adultsOrGuardians.LN_search_name_type; // here it can be only D,S or G 
			// Best 
			SELF.did := rowBest.did;
			SELF.did_score := rowBest.score;
			SELF.gender := if(isIncludeGender,rowBest.gender,'');
			SELF.name:= Name;
			currentSSN:= IF(rowBest.best_ssn <>'', rowBest.best_ssn, rowBest.ssn);
			paddedSSN:= INTFORMAT((UNSIGNED)currentSSN,9,1);
			SELF.ssn:= IF(isIncludeSSN AND (paddedSSN <> '000000000'), paddedSSN, '');
			currDOB := if(rowBest.best_dob <> '' AND rowBest.best_dob <> '0',rowBest.best_dob ,rowBest.dob );
			SELF.dob := if(isIncludeDOB AND (UNSIGNED)currDOB > 0 ,currDOB ,'');
			// Computed Address 
			SELF.address := rowAddress.address;
			SELF.city := rowAddress.city;
			SELF.st := rowAddress.st;
			SELF.z5 := rowAddress.z5;
			SELF.zip4 := rowAddress.zip4;
			SELF.county_name := rowAddress.county_name;
			SELF.addr_dt_last_seen := rowAddress.addr_dt_last_seen;
			SELF.addr_dt_first_seen := rowAddress.addr_dt_first_seen;
			// MemberPoint Enhancements
			// Since we often return a single address, it should always be considered High confidence, so we are going to remove the scoring for addresses
			self.addr_confidence := rowAddress.addr_confidence;
			SELF.latitude := rowAddress.latitude;
			SELF.longitude := rowAddress.longitude;
			SELF.address_match_codes := rowAddress.address_match_codes;
			addr_older_than_90_days := ((string)ut.IntDate_To_YYYYMM((UNSIGNED) ut.getDateOffset(-90),false)) > rowAddress.addr_dt_last_seen;
			SELF.addr_older_than_90_days := MAP(rowAddress.addr_dt_last_seen = '0' => 'U', 
																					rowAddress.addr_dt_last_seen <> '' AND addr_older_than_90_days = true => 'Y',
																					rowAddress.addr_dt_last_seen <> '' AND not addr_older_than_90_days = true => 'N',
																					' ');
			// Computed Address New
			SELF.address_new := rowAddress.address_new;
			SELF.city_new := rowAddress.city_new;
			SELF.st_new := rowAddress.st_new;
			SELF.z5_new := rowAddress.z5_new;
			SELF.zip4_new := rowAddress.zip4_new;
			SELF.county_name_new := rowAddress.county_name_new;
			SELF.addr_dt_last_seen_new := rowAddress.addr_dt_last_seen_new;
			SELF.addr_dt_first_seen_new := rowAddress.addr_dt_first_seen_new;
			self.addr_confidence_new := rowAddress.addr_confidence_new;
			SELF.latitude_new := rowAddress.latitude_new;
			SELF.longitude_new := rowAddress.longitude_new;
			SELF.address_new_match_codes := rowAddress.address_new_match_codes;
			self.addressdescriptioncode1:=rowaddress.addressdescriptioncode1;
			self.addressDescription1:=rowaddress.addressDescription1;
			self.addressdescriptioncode2:=rowaddress.addressdescriptioncode2;
			self.addressDescription2:=rowaddress.addressDescription2;
			self.addressdescriptioncode3:=rowaddress.addressdescriptioncode3;
			self.addressDescription3:=rowaddress.addressDescription3;
			self.addressdescriptioncode4:=rowaddress.addressdescriptioncode4;
			self.addressDescription4:=rowaddress.addressDescription4;
			self.addressdescriptioncode5:=rowaddress.addressdescriptioncode5;
			self.addressDescription5:=rowaddress.addressDescription5;
			self.addressdescriptioncode6:=rowaddress.addressdescriptioncode6;
			self.addressDescription6:=rowaddress.addressDescription6;
			self.addressdescriptioncode7:=rowaddress.addressdescriptioncode7;
			self.addressDescription7:=rowaddress.addressDescription7;
			self.addressdescriptioncode8:=rowaddress.addressdescriptioncode8;
			self.addressDescription8:=rowaddress.addressDescription8;
			self.addressdescriptioncode9:=rowaddress.addressdescriptioncode9;
			self.addressDescription9:=rowaddress.addressDescription9;
			self.addressdescriptioncode10:=rowaddress.addressdescriptioncode10;
			self.addressDescription10:=rowaddress.addressDescription10;

			//Scores
			//MemberPoint Enhancements: For derived guardians (LN_Search_Name_Type = D) Name, SSN AND DOB score fields output should be null.
			isDerived:= adultsOrGuardians.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived;
			isPartial:= (LENGTH(TRIM(adultsOrGuardians.SSN)) < 5);
      		SELF.name_score:= map(	isDerived =>'',
			                      	isIncludeGender=true and rowBest.verify_best_name=0 and StringLib.StringToUpperCase(batchin.name_first[1..3])=StringLib.StringToUpperCase(rowBest.best_fname[1..3]) and StringLib.StringToUpperCase(batchIn.name_last)!=StringLib.StringToUpperCase(rowBest.best_lname) and StringLib.StringToUpperCase(rowBest.gender)='M'=>'30',
                            	   	isIncludeGender=true  and rowBest.verify_best_name=0 and StringLib.StringToUpperCase(batchin.name_first[1..3])=StringLib.StringToUpperCase(rowBest.best_fname[1..3]) and StringLib.StringToUpperCase(batchin.name_last)!=StringLib.StringToUpperCase(rowBest.best_lname) and StringLib.StringToUpperCase(rowBest.gender)='F'=>'40',
								            (string) rowBest.verify_best_name);
			SELF.ssn_score:= IF(~isPartial AND isIncludeSSN AND ~isDerived, (STRING)rowBest.verify_best_ssn, '');
			SELF.dob_score:= IF(~isDerived AND isIncludeDOB, (STRING)rowBest.verify_best_dob, '');
			// Death
			SELF.Date_of_death := rowDeceased.DOD8;
			SELF.dcd_match_code := rowDeceased.matchcode; // this will be death match code + 1 string for 'D' or DOB matches
			// Email
			self.Email1:=rowsEmails[1].orig_email;
			self.email1_email_src:=rowsEmails[1].email_src;
			self.email1_email_username:=rowsEmails[1].email_username;
			self.email1_email_domain:=rowsEmails[1].email_domain;
			self.email1_did:=rowsEmails[1].did;
			self.email1_did_score:=rowsEmails[1].did_score;
			self.email1_date_first_seen:=rowsEmails[1].date_first_seen;
			self.email1_date_last_seen:=rowsEmails[1].date_last_seen;
			self.email1_ln_date_first:=rowsEmails[1].ln_date_first;
			self.email1_ln_date_last:=rowsEmails[1].ln_date_last;
			self.email1_date_vendor_first_reported:=rowsEmails[1].date_vendor_first_reported;
			self.email1_date_vendor_last_reported:=rowsEmails[1].date_vendor_last_reported;
			self.email1_process_date:=rowsEmails[1].process_date;
			self.email1_activecode:=rowsEmails[1].activecode;
			self.email1_is_current:=rowsEmails[1].is_current;
			self.email1_rules:=rowsEmails[1].rules;
			self.email1_isdeepdive:=rowsEmails[1].isdeepdive;
			self.email1_subject_lexid:=rowsEmails[1].subject_lexid;
			self.email1_orig_CompanyName:=rowsEmails[1].orig_CompanyName;
			self.email1_cln_CompanyName:=rowsEmails[1].cln_CompanyName;
			self.email1_CompanyTitle:=rowsEmails[1].CompanyTitle;
			self.email1_DotID:=rowsEmails[1].DotID;
			self.email1_EmpID:=rowsEmails[1].EmpID;
			self.email1_POWID:=rowsEmails[1].POWID;
			self.email1_ProxID:=rowsEmails[1].ProxID;
			self.email1_SELEID:=rowsEmails[1].SELEID;
			self.email1_OrgID:=rowsEmails[1].OrgID;
			self.email1_UltID:=rowsEmails[1].UltID;
			self.email1_email_status:=rowsEmails[1].email_status;
			self.email1_email_status_reason:=rowsEmails[1].email_status_reason;
			self.email1_additional_status_info:=rowsEmails[1].additional_status_info;
			self.email1_date_last_verified:=rowsEmails[1].date_last_verified;
			self.email1_relationship:=rowsEmails[1].relationship;
			self.email1_record_err_msg:=rowsEmails[1].record_err_msg;
			self.email1_record_err_code:=rowsEmails[1].record_err_code;
			self.email1_is_rejected_rec:=rowsEmails[1].is_rejected_rec;
			self.email1_isRoyaltySource:=rowsEmails[1].isRoyaltySource;
			self.email1_num_sources:=rowsEmails[1].num_sources;
			self.email1_latest_orig_login_date:=rowsEmails[1].latest_orig_login_date;
			self.email1_num_email_per_did:=rowsEmails[1].num_email_per_did;
			self.email1_num_did_per_email:=rowsEmails[1].num_did_per_email;
			self.email2:=rowsEmails[2].orig_email;
			self.email2_email_src:=rowsEmails[2].email_src;
			self.email2_email_username:=rowsEmails[2].email_username;
			self.email2_email_domain:=rowsEmails[2].email_domain;
			self.email2_did:=rowsEmails[2].did;
			self.email2_did_score:=rowsEmails[2].did_score;
			self.email2_date_first_seen:=rowsEmails[2].date_first_seen;
			self.email2_date_last_seen:=rowsEmails[2].date_last_seen;
			self.email2_ln_date_first:=rowsEmails[2].ln_date_first;
			self.email2_ln_date_last:=rowsEmails[2].ln_date_last;
			self.email2_date_vendor_first_reported:=rowsEmails[2].date_vendor_first_reported;
			self.email2_date_vendor_last_reported:=rowsEmails[2].date_vendor_last_reported;
			self.email2_process_date:=rowsEmails[2].process_date;
			self.email2_activecode:=rowsEmails[2].activecode;
			self.email2_is_current:=rowsEmails[2].is_current;
			self.email2_rules:=rowsEmails[2].rules;
			self.email2_isdeepdive:=rowsEmails[2].isdeepdive;
			self.email2_subject_lexid:=rowsEmails[2].subject_lexid;
			self.email2_orig_CompanyName:=rowsEmails[2].orig_CompanyName;
			self.email2_cln_CompanyName:=rowsEmails[2].cln_CompanyName;
			self.email2_CompanyTitle:=rowsEmails[2].CompanyTitle;
			self.email2_DotID:=rowsEmails[2].DotID;
			self.email2_EmpID:=rowsEmails[2].EmpID;
			self.email2_POWID:=rowsEmails[2].POWID;
			self.email2_ProxID:=rowsEmails[2].ProxID;
			self.email2_SELEID:=rowsEmails[2].SELEID;
			self.email2_OrgID:=rowsEmails[2].OrgID;
			self.email2_UltID:=rowsEmails[2].UltID;
			self.email2_email_status:=rowsEmails[2].email_status;
			self.email2_email_status_reason:=rowsEmails[2].email_status_reason;
			self.email2_additional_status_info:=rowsEmails[2].additional_status_info;
			self.email2_date_last_verified:=rowsEmails[2].date_last_verified;
			self.email2_relationship:=rowsEmails[2].relationship;
			self.email2_record_err_msg:=rowsEmails[2].record_err_msg;
			self.email2_record_err_code:=rowsEmails[2].record_err_code;
			self.email2_is_rejected_rec:=rowsEmails[2].is_rejected_rec;
			self.email2_isRoyaltySource:=rowsEmails[2].isRoyaltySource;
			self.email2_num_sources:=rowsEmails[2].num_sources;
			self.email2_latest_orig_login_date:=rowsEmails[2].latest_orig_login_date;
			self.email2_num_email_per_did:=rowsEmails[2].num_email_per_did;
			self.email2_num_did_per_email:=rowsEmails[2].num_did_per_email;
			SELF.Email3 := rowsEmails[3].orig_email;
			self.email3_email_src:=rowsEmails[3].email_src;
			self.email3_email_username:=rowsEmails[3].email_username;
			self.email3_email_domain:=rowsEmails[3].email_domain;
			self.email3_did:=rowsEmails[3].did;
			self.email3_did_score:=rowsEmails[3].did_score;
			self.email3_date_first_seen:=rowsEmails[3].date_first_seen;
			self.email3_date_last_seen:=rowsEmails[3].date_last_seen;
			self.email3_ln_date_first:=rowsEmails[3].ln_date_first;
			self.email3_ln_date_last:=rowsEmails[3].ln_date_last;
			self.email3_date_vendor_first_reported:=rowsEmails[3].date_vendor_first_reported;
			self.email3_date_vendor_last_reported:=rowsEmails[3].date_vendor_last_reported;
			self.email3_process_date:=rowsEmails[3].process_date;
			self.email3_activecode:=rowsEmails[3].activecode;
			self.email3_is_current:=rowsEmails[3].is_current;
			self.email3_rules:=rowsEmails[3].rules;
			self.email3_isdeepdive:=rowsEmails[3].isdeepdive;
			self.email3_subject_lexid:=rowsEmails[3].subject_lexid;
			self.email3_orig_CompanyName:=rowsEmails[3].orig_CompanyName;
			self.email3_cln_CompanyName:=rowsEmails[3].cln_CompanyName;
			self.email3_CompanyTitle:=rowsEmails[3].CompanyTitle;
			self.email3_DotID:=rowsEmails[3].DotID;
			self.email3_EmpID:=rowsEmails[3].EmpID;
			self.email3_POWID:=rowsEmails[3].POWID;
			self.email3_ProxID:=rowsEmails[3].ProxID;
			self.email3_SELEID:=rowsEmails[3].SELEID;
			self.email3_OrgID:=rowsEmails[3].OrgID;
			self.email3_UltID:=rowsEmails[3].UltID;
			self.email3_email_status:=rowsEmails[3].email_status;
			self.email3_email_status_reason:=rowsEmails[3].email_status_reason;
			self.email3_additional_status_info:=rowsEmails[3].additional_status_info;
			self.email3_date_last_verified:=rowsEmails[3].date_last_verified;
			self.email3_relationship:=rowsEmails[3].relationship;
			self.email3_record_err_msg:=rowsEmails[3].record_err_msg;
			self.email3_record_err_code:=rowsEmails[3].record_err_code;
			self.email3_is_rejected_rec:=rowsEmails[3].is_rejected_rec;
			self.email3_isRoyaltySource:=rowsEmails[3].isRoyaltySource;
			self.email3_num_sources:=rowsEmails[3].num_sources;
			self.email3_latest_orig_login_date:=rowsEmails[3].latest_orig_login_date;
			self.email3_num_email_per_did:=rowsEmails[3].num_email_per_did;
			self.email3_num_did_per_email:=rowsEmails[3].num_did_per_email;
			SELF.Email4 := rowsEmails[4].orig_email;
			self.email4_email_src:=rowsEmails[4].email_src;
			self.email4_email_username:=rowsEmails[4].email_username;
			self.email4_email_domain:=rowsEmails[4].email_domain;
			self.email4_did:=rowsEmails[4].did;
			self.email4_did_score:=rowsEmails[4].did_score;
			self.email4_date_first_seen:=rowsEmails[4].date_first_seen;
			self.email4_date_last_seen:=rowsEmails[4].date_last_seen;
			self.email4_ln_date_first:=rowsEmails[4].ln_date_first;
			self.email4_ln_date_last:=rowsEmails[4].ln_date_last;
			self.email4_date_vendor_first_reported:=rowsEmails[4].date_vendor_first_reported;
			self.email4_date_vendor_last_reported:=rowsEmails[4].date_vendor_last_reported;
			self.email4_process_date:=rowsEmails[4].process_date;
			self.email4_activecode:=rowsEmails[4].activecode;
			self.email4_is_current:=rowsEmails[4].is_current;
			self.email4_rules:=rowsEmails[4].rules;
			self.email4_isdeepdive:=rowsEmails[4].isdeepdive;
			self.email4_subject_lexid:=rowsEmails[4].subject_lexid;
			self.email4_orig_CompanyName:=rowsEmails[4].orig_CompanyName;
			self.email4_cln_CompanyName:=rowsEmails[4].cln_CompanyName;
			self.email4_CompanyTitle:=rowsEmails[4].CompanyTitle;
			self.email4_DotID:=rowsEmails[4].DotID;
			self.email4_EmpID:=rowsEmails[4].EmpID;
			self.email4_POWID:=rowsEmails[4].POWID;
			self.email4_ProxID:=rowsEmails[4].ProxID;
			self.email4_SELEID:=rowsEmails[4].SELEID;
			self.email4_OrgID:=rowsEmails[4].OrgID;
			self.email4_UltID:=rowsEmails[4].UltID;
			self.email4_email_status:=rowsEmails[4].email_status;
			self.email4_email_status_reason:=rowsEmails[4].email_status_reason;
			self.email4_additional_status_info:=rowsEmails[4].additional_status_info;
			self.email4_date_last_verified:=rowsEmails[4].date_last_verified;
			self.email4_relationship:=rowsEmails[4].relationship;
			self.email4_record_err_msg:=rowsEmails[4].record_err_msg;
			self.email4_record_err_code:=rowsEmails[4].record_err_code;
			self.email4_is_rejected_rec:=rowsEmails[4].is_rejected_rec;
			self.email4_isRoyaltySource:=rowsEmails[4].isRoyaltySource;
			self.email4_num_sources:=rowsEmails[4].num_sources;
			self.email4_latest_orig_login_date:=rowsEmails[4].latest_orig_login_date;
			self.email4_num_email_per_did:=rowsEmails[4].num_email_per_did;
			self.email4_num_did_per_email:=rowsEmails[4].num_did_per_email;
      		SELF.Email5 := rowsEmails[5].orig_email;
      		self.email5_email_src:=rowsEmails[5].email_src;
			self.email5_email_username:=rowsEmails[5].email_username;
			self.email5_email_domain:=rowsEmails[5].email_domain;
			self.email5_did:=rowsEmails[5].did;
			self.email5_did_score:=rowsEmails[5].did_score;
			self.email5_date_first_seen:=rowsEmails[5].date_first_seen;
			self.email5_date_last_seen:=rowsEmails[5].date_last_seen;
			self.email5_ln_date_first:=rowsEmails[5].ln_date_first;
			self.email5_ln_date_last:=rowsEmails[5].ln_date_last;
			self.email5_date_vendor_first_reported:=rowsEmails[5].date_vendor_first_reported;
			self.email5_date_vendor_last_reported:=rowsEmails[5].date_vendor_last_reported;
			self.email5_process_date:=rowsEmails[5].process_date;
			self.email5_activecode:=rowsEmails[5].activecode;
			self.email5_is_current:=rowsEmails[5].is_current;
			self.email5_rules:=rowsEmails[5].rules;
			self.email5_isdeepdive:=rowsEmails[5].isdeepdive;
			self.email5_subject_lexid:=rowsEmails[5].subject_lexid;
			self.email5_orig_CompanyName:=rowsEmails[5].orig_CompanyName;
			self.email5_cln_CompanyName:=rowsEmails[5].cln_CompanyName;
			self.email5_CompanyTitle:=rowsEmails[5].CompanyTitle;
			self.email5_DotID:=rowsEmails[5].DotID;
			self.email5_EmpID:=rowsEmails[5].EmpID;
			self.email5_POWID:=rowsEmails[5].POWID;
			self.email5_ProxID:=rowsEmails[5].ProxID;
			self.email5_SELEID:=rowsEmails[5].SELEID;
			self.email5_OrgID:=rowsEmails[5].OrgID;
			self.email5_UltID:=rowsEmails[5].UltID;
			self.email5_email_status:=rowsEmails[5].email_status;
			self.email5_email_status_reason:=rowsEmails[5].email_status_reason;
			self.email5_additional_status_info:=rowsEmails[5].additional_status_info;
			self.email5_date_last_verified:=rowsEmails[5].date_last_verified;
			self.email5_relationship:=rowsEmails[5].relationship;
			self.email5_record_err_msg:=rowsEmails[5].record_err_msg;
			self.email5_record_err_code:=rowsEmails[5].record_err_code;
			self.email5_is_rejected_rec:=rowsEmails[5].is_rejected_rec;
			self.email5_isRoyaltySource:=rowsEmails[5].isRoyaltySource;
			self.email5_num_sources:=rowsEmails[5].num_sources;
			self.email5_latest_orig_login_date:=rowsEmails[5].latest_orig_login_date;
			self.email5_num_email_per_did:=rowsEmails[5].num_email_per_did;
			self.email5_num_did_per_email:=rowsEmails[5].num_did_per_email;
			SELF.Email6 := rowsEmails[6].orig_email;
			self.email6_email_src:=rowsEmails[6].email_src;
			self.email6_email_username:=rowsEmails[6].email_username;
			self.email6_email_domain:=rowsEmails[6].email_domain;
			self.email6_did:=rowsEmails[6].did;
			self.email6_did_score:=rowsEmails[6].did_score;
			self.email6_date_first_seen:=rowsEmails[6].date_first_seen;
			self.email6_date_last_seen:=rowsEmails[6].date_last_seen;
			self.email6_ln_date_first:=rowsEmails[6].ln_date_first;
			self.email6_ln_date_last:=rowsEmails[6].ln_date_last;
			self.email6_date_vendor_first_reported:=rowsEmails[6].date_vendor_first_reported;
			self.email6_date_vendor_last_reported:=rowsEmails[6].date_vendor_last_reported;
			self.email6_process_date:=rowsEmails[6].process_date;
			self.email6_activecode:=rowsEmails[6].activecode;
			self.email6_is_current:=rowsEmails[6].is_current;
			self.email6_rules:=rowsEmails[6].rules;
			self.email6_isdeepdive:=rowsEmails[6].isdeepdive;
			self.email6_subject_lexid:=rowsEmails[6].subject_lexid;
			self.email6_orig_CompanyName:=rowsEmails[6].orig_CompanyName;
			self.email6_cln_CompanyName:=rowsEmails[6].cln_CompanyName;
			self.email6_CompanyTitle:=rowsEmails[6].CompanyTitle;
			self.email6_DotID:=rowsEmails[6].DotID;
			self.email6_EmpID:=rowsEmails[6].EmpID;
			self.email6_POWID:=rowsEmails[6].POWID;
			self.email6_ProxID:=rowsEmails[6].ProxID;
			self.email6_SELEID:=rowsEmails[6].SELEID;
			self.email6_OrgID:=rowsEmails[6].OrgID;
			self.email6_UltID:=rowsEmails[6].UltID;
			self.email6_email_status:=rowsEmails[6].email_status;
			self.email6_email_status_reason:=rowsEmails[6].email_status_reason;
			self.email6_additional_status_info:=rowsEmails[6].additional_status_info;
			self.email6_date_last_verified:=rowsEmails[6].date_last_verified;
			self.email6_relationship:=rowsEmails[6].relationship;
			self.email6_record_err_msg:=rowsEmails[6].record_err_msg;
			self.email6_record_err_code:=rowsEmails[6].record_err_code;
			self.email6_is_rejected_rec:=rowsEmails[6].is_rejected_rec;
			self.email6_isRoyaltySource:=rowsEmails[6].isRoyaltySource;
			self.email6_num_sources:=rowsEmails[6].num_sources;
			self.email6_latest_orig_login_date:=rowsEmails[6].latest_orig_login_date;
			self.email6_num_email_per_did:=rowsEmails[6].num_email_per_did;
			self.email6_num_did_per_email:=rowsEmails[6].num_did_per_email;
			SELF.Email7 := rowsEmails[7].orig_email;
			self.email7_email_src:=rowsEmails[7].email_src;
			self.email7_email_username:=rowsEmails[7].email_username;
			self.email7_email_domain:=rowsEmails[7].email_domain;
			self.email7_did:=rowsEmails[7].did;
			self.email7_did_score:=rowsEmails[7].did_score;
			self.email7_date_first_seen:=rowsEmails[7].date_first_seen;
			self.email7_date_last_seen:=rowsEmails[7].date_last_seen;
			self.email7_ln_date_first:=rowsEmails[7].ln_date_first;
			self.email7_ln_date_last:=rowsEmails[7].ln_date_last;
			self.email7_date_vendor_first_reported:=rowsEmails[7].date_vendor_first_reported;
			self.email7_date_vendor_last_reported:=rowsEmails[7].date_vendor_last_reported;
			self.email7_process_date:=rowsEmails[7].process_date;
			self.email7_activecode:=rowsEmails[7].activecode;
			self.email7_is_current:=rowsEmails[7].is_current;
			self.email7_rules:=rowsEmails[7].rules;
			self.email7_isdeepdive:=rowsEmails[7].isdeepdive;
			self.email7_subject_lexid:=rowsEmails[7].subject_lexid;
			self.email7_orig_CompanyName:=rowsEmails[7].orig_CompanyName;
			self.email7_cln_CompanyName:=rowsEmails[7].cln_CompanyName;
			self.email7_CompanyTitle:=rowsEmails[7].CompanyTitle;
			self.email7_DotID:=rowsEmails[7].DotID;
			self.email7_EmpID:=rowsEmails[7].EmpID;
			self.email7_POWID:=rowsEmails[7].POWID;
			self.email7_ProxID:=rowsEmails[7].ProxID;
			self.email7_SELEID:=rowsEmails[7].SELEID;
			self.email7_OrgID:=rowsEmails[7].OrgID;
			self.email7_UltID:=rowsEmails[7].UltID;
			self.email7_email_status:=rowsEmails[7].email_status;
			self.email7_email_status_reason:=rowsEmails[7].email_status_reason;
			self.email7_additional_status_info:=rowsEmails[7].additional_status_info;
			self.email7_date_last_verified:=rowsEmails[7].date_last_verified;
			self.email7_relationship:=rowsEmails[7].relationship;
			self.email7_record_err_msg:=rowsEmails[7].record_err_msg;
			self.email7_record_err_code:=rowsEmails[7].record_err_code;
			self.email7_is_rejected_rec:=rowsEmails[7].is_rejected_rec;
			self.email7_isRoyaltySource:=rowsEmails[7].isRoyaltySource;
			self.email7_num_sources:=rowsEmails[7].num_sources;
			self.email7_latest_orig_login_date:=rowsEmails[7].latest_orig_login_date;
			self.email7_num_email_per_did:=rowsEmails[7].num_email_per_did;
			self.email7_num_did_per_email:=rowsEmails[7].num_did_per_email;
			SELF.Email8 := rowsEmails[8].orig_email;
			self.Email8_email_src:=rowsEmails[8].email_src;
			self.Email8_email_username:=rowsEmails[8].email_username;
			self.Email8_email_domain:=rowsEmails[8].email_domain;
			self.Email8_did:=rowsEmails[8].did;
			self.Email8_did_score:=rowsEmails[8].did_score;
			self.Email8_date_first_seen:=rowsEmails[8].date_first_seen;
			self.Email8_date_last_seen:=rowsEmails[8].date_last_seen;
			self.Email8_ln_date_first:=rowsEmails[8].ln_date_first;
			self.Email8_ln_date_last:=rowsEmails[8].ln_date_last;
			self.Email8_date_vendor_first_reported:=rowsEmails[8].date_vendor_first_reported;
			self.Email8_date_vendor_last_reported:=rowsEmails[8].date_vendor_last_reported;
			self.Email8_process_date:=rowsEmails[8].process_date;
			self.Email8_activecode:=rowsEmails[8].activecode;
			self.Email8_is_current:=rowsEmails[8].is_current;
			self.Email8_rules:=rowsEmails[8].rules;
			self.Email8_isdeepdive:=rowsEmails[8].isdeepdive;
			self.Email8_subject_lexid:=rowsEmails[8].subject_lexid;
			self.Email8_orig_CompanyName:=rowsEmails[8].orig_CompanyName;
			self.Email8_cln_CompanyName:=rowsEmails[8].cln_CompanyName;
			self.Email8_CompanyTitle:=rowsEmails[8].CompanyTitle;
			self.Email8_DotID:=rowsEmails[8].DotID;
			self.Email8_EmpID:=rowsEmails[8].EmpID;
			self.Email8_POWID:=rowsEmails[8].POWID;
			self.Email8_ProxID:=rowsEmails[8].ProxID;
			self.Email8_SELEID:=rowsEmails[8].SELEID;
			self.Email8_OrgID:=rowsEmails[8].OrgID;
			self.Email8_UltID:=rowsEmails[8].UltID;
			self.Email8_email_status:=rowsEmails[8].email_status;
			self.Email8_email_status_reason:=rowsEmails[8].email_status_reason;
			self.Email8_additional_status_info:=rowsEmails[8].additional_status_info;
			self.Email8_date_last_verified:=rowsEmails[8].date_last_verified;
			self.Email8_relationship:=rowsEmails[8].relationship;
			self.Email8_record_err_msg:=rowsEmails[8].record_err_msg;
			self.Email8_record_err_code:=rowsEmails[8].record_err_code;
			self.Email8_is_rejected_rec:=rowsEmails[8].is_rejected_rec;
			self.Email8_isRoyaltySource:=rowsEmails[8].isRoyaltySource;
			self.Email8_num_sources:=rowsEmails[8].num_sources;
			self.Email8_latest_orig_login_date:=rowsEmails[8].latest_orig_login_date;
			self.Email8_num_email_per_did:=rowsEmails[8].num_email_per_did;
			self.Email8_num_did_per_email:=rowsEmails[8].num_did_per_email;
			SELF.Email9 := rowsEmails[9].orig_email;
			self.Email9_email_src:=rowsEmails[9].email_src;
			self.Email9_email_username:=rowsEmails[9].email_username;
			self.Email9_email_domain:=rowsEmails[9].email_domain;
			self.Email9_did:=rowsEmails[9].did;
			self.Email9_did_score:=rowsEmails[9].did_score;
			self.Email9_date_first_seen:=rowsEmails[9].date_first_seen;
			self.Email9_date_last_seen:=rowsEmails[9].date_last_seen;
			self.Email9_ln_date_first:=rowsEmails[9].ln_date_first;
			self.Email9_ln_date_last:=rowsEmails[9].ln_date_last;
			self.Email9_date_vendor_first_reported:=rowsEmails[9].date_vendor_first_reported;
			self.Email9_date_vendor_last_reported:=rowsEmails[9].date_vendor_last_reported;
			self.Email9_process_date:=rowsEmails[9].process_date;
			self.Email9_activecode:=rowsEmails[9].activecode;
			self.Email9_is_current:=rowsEmails[9].is_current;
			self.Email9_rules:=rowsEmails[9].rules;
			self.Email9_isdeepdive:=rowsEmails[9].isdeepdive;
			self.Email9_subject_lexid:=rowsEmails[9].subject_lexid;
			self.Email9_orig_CompanyName:=rowsEmails[9].orig_CompanyName;
			self.Email9_cln_CompanyName:=rowsEmails[9].cln_CompanyName;
			self.Email9_CompanyTitle:=rowsEmails[9].CompanyTitle;
			self.Email9_DotID:=rowsEmails[9].DotID;
			self.Email9_EmpID:=rowsEmails[9].EmpID;
			self.Email9_POWID:=rowsEmails[9].POWID;
			self.Email9_ProxID:=rowsEmails[9].ProxID;
			self.Email9_SELEID:=rowsEmails[9].SELEID;
			self.Email9_OrgID:=rowsEmails[9].OrgID;
			self.Email9_UltID:=rowsEmails[9].UltID;
			self.Email9_email_status:=rowsEmails[9].email_status;
			self.Email9_email_status_reason:=rowsEmails[9].email_status_reason;
			self.Email9_additional_status_info:=rowsEmails[9].additional_status_info;
			self.Email9_date_last_verified:=rowsEmails[9].date_last_verified;
			self.Email9_relationship:=rowsEmails[9].relationship;
			self.Email9_record_err_msg:=rowsEmails[9].record_err_msg;
			self.Email9_record_err_code:=rowsEmails[9].record_err_code;
			self.Email9_is_rejected_rec:=rowsEmails[9].is_rejected_rec;
			self.Email9_isRoyaltySource:=rowsEmails[9].isRoyaltySource;
			self.Email9_num_sources:=rowsEmails[9].num_sources;
			self.Email9_latest_orig_login_date:=rowsEmails[9].latest_orig_login_date;
			self.Email9_num_email_per_did:=rowsEmails[9].num_email_per_did;
			self.Email9_num_did_per_email:=rowsEmails[9].num_did_per_email;
			SELF.Email10 := rowsEmails[10].orig_email;
			self.Email10_email_src:=rowsEmails[10].email_src;
			self.Email10_email_username:=rowsEmails[10].email_username;
			self.Email10_email_domain:=rowsEmails[10].email_domain;
			self.Email10_did:=rowsEmails[10].did;
			self.Email10_did_score:=rowsEmails[10].did_score;
			self.Email10_date_first_seen:=rowsEmails[10].date_first_seen;
			self.Email10_date_last_seen:=rowsEmails[10].date_last_seen;
			self.Email10_ln_date_first:=rowsEmails[10].ln_date_first;
			self.Email10_ln_date_last:=rowsEmails[10].ln_date_last;
			self.Email10_date_vendor_first_reported:=rowsEmails[10].date_vendor_first_reported;
			self.Email10_date_vendor_last_reported:=rowsEmails[10].date_vendor_last_reported;
			self.Email10_process_date:=rowsEmails[10].process_date;
			self.Email10_activecode:=rowsEmails[10].activecode;
			self.Email10_is_current:=rowsEmails[10].is_current;
			self.Email10_rules:=rowsEmails[10].rules;
			self.Email10_isdeepdive:=rowsEmails[10].isdeepdive;
			self.Email10_subject_lexid:=rowsEmails[10].subject_lexid;
			self.Email10_orig_CompanyName:=rowsEmails[10].orig_CompanyName;
			self.Email10_cln_CompanyName:=rowsEmails[10].cln_CompanyName;
			self.Email10_CompanyTitle:=rowsEmails[10].CompanyTitle;
			self.Email10_DotID:=rowsEmails[10].DotID;
			self.Email10_EmpID:=rowsEmails[10].EmpID;
			self.Email10_POWID:=rowsEmails[10].POWID;
			self.Email10_ProxID:=rowsEmails[10].ProxID;
			self.Email10_SELEID:=rowsEmails[10].SELEID;
			self.Email10_OrgID:=rowsEmails[10].OrgID;
			self.Email10_UltID:=rowsEmails[10].UltID;
			self.Email10_email_status:=rowsEmails[10].email_status;
			self.Email10_email_status_reason:=rowsEmails[10].email_status_reason;
			self.Email10_additional_status_info:=rowsEmails[10].additional_status_info;
			self.Email10_date_last_verified:=rowsEmails[10].date_last_verified;
			self.Email10_relationship:=rowsEmails[10].relationship;
			self.Email10_record_err_msg:=rowsEmails[10].record_err_msg;
			self.Email10_record_err_code:=rowsEmails[10].record_err_code;
			self.Email10_is_rejected_rec:=rowsEmails[10].is_rejected_rec;
			self.Email10_isRoyaltySource:=rowsEmails[10].isRoyaltySource;
			self.Email10_num_sources:=rowsEmails[10].num_sources;
			self.Email10_latest_orig_login_date:=rowsEmails[10].latest_orig_login_date;
			self.Email10_num_email_per_did:=rowsEmails[10].num_email_per_did;
			self.Email10_num_did_per_email:=rowsEmails[10].num_did_per_email;
			self.input_email_invalid:=rowsEmailStatus[1].input_email_invalid;
			self.input_email_invalid_reason:=rowsEmailStatus[1].input_email_invalid_reason;
			SELF := [];
		END;
		//Waterfall BatchOut Transformation
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
		MemberPoint.Layouts.BatchOut attachWaterfallPhones(MemberPoint.Layouts.batchInter adultsOrGuardians, MemberPoint.Layouts.BatchOut common):= TRANSFORM
			phonesRows:= dsPhones(acctno = adultsOrGuardians.acctno);
			choosenRecs:= CHOOSEN(phonesRows, BParams.MaxPhoneCount);
			SELF.Phone1_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[1].subj_phone10, adultsOrGuardians.primary_phone_number);
			SELF.Phone1_Number:= choosenRecs[1].subj_phone10;
			SELF.Phone1_Number_Listing_Name:= choosenRecs[1].subj_name_dual;
			SELF.Phone1_Possible_Relation:= choosenRecs[1].subj_phone_relationship;
			SELF.Phone1_First_Seen_Date:= choosenRecs[1].subj_date_first;
			SELF.Phone1_Last_Seen_Date:= choosenRecs[1].subj_date_last;
			SELF.Phone1_Type:= choosenRecs[1].phpl_phones_plus_type;
			SELF.Phone1_Line_Type:= choosenRecs[1].switch_type;// Cell . Landline
			SELF.Phone1_Carrier := choosenRecs[1].phpl_phone_carrier;
			SELF.Phone1_Carrier_City := choosenRecs[1].phpl_carrier_city;
			SELF.Phone1_Carrier_State := choosenRecs[1].phpl_carrier_state;
			SELF.Phone1_Score:= IF(BParams.ReturnScore, choosenRecs[1].phone_score, '');
			SELF.Phone1_Score_confidence:= MemberPoint.Confidence.getConfidencePhoneScore(choosenRecs[1].phone_score);
			SELF.Phone1_Score_confidence_star:= MemberPoint.Confidence.getStarRate((UNSIGNED)choosenRecs[1].phone_score);
			
			SELF.Phone2_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[2].subj_phone10, adultsOrGuardians.primary_phone_number);
			SELF.Phone2_Number:= choosenRecs[2].subj_phone10;
			SELF.Phone2_Number_Listing_Name:= choosenRecs[2].subj_name_dual; 
			SELF.Phone2_Possible_Relation:= choosenRecs[2].subj_phone_relationship;
			SELF.Phone2_First_Seen_Date:= choosenRecs[2].subj_date_first;
			SELF.Phone2_Last_Seen_Date:= choosenRecs[2].subj_date_last;
			SELF.Phone2_Type:= choosenRecs[2].phpl_phones_plus_type;
			SELF.Phone2_Line_Type:= choosenRecs[2].switch_type; // Cell . Landline
			SELF.Phone2_Carrier := choosenRecs[2].phpl_phone_carrier;
			SELF.Phone2_Carrier_City := choosenRecs[2].phpl_carrier_city;
			SELF.Phone2_Carrier_State := choosenRecs[2].phpl_carrier_state;
			SELF.Phone2_Score:= IF(BParams.ReturnScore, choosenRecs[2].phone_score, '');
			SELF.Phone2_Score_confidence:= MemberPoint.Confidence.getConfidencePhoneScore(choosenRecs[2].phone_score);
			SELF.Phone2_Score_confidence_star:= MemberPoint.Confidence.getStarRate((UNSIGNED)choosenRecs[2].phone_score);
			
			SELF.Phone3_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[3].subj_phone10, adultsOrGuardians.primary_phone_number);
			SELF.Phone3_Number:= choosenRecs[3].subj_phone10;
			SELF.Phone3_Number_Listing_Name:= choosenRecs[3].subj_name_dual; 
			SELF.Phone3_Possible_Relation:= choosenRecs[3].subj_phone_relationship;
			SELF.Phone3_First_Seen_Date:= choosenRecs[3].subj_date_first;
			SELF.Phone3_Last_Seen_Date:= choosenRecs[3].subj_date_last;
			SELF.Phone3_Type:= choosenRecs[3].phpl_phones_plus_type;
			SELF.Phone3_Line_Type:= choosenRecs[3].switch_type; // Cell . Landline
			SELF.Phone3_Carrier := choosenRecs[3].phpl_phone_carrier;
			SELF.Phone3_Carrier_City := choosenRecs[3].phpl_carrier_city;
			SELF.Phone3_Carrier_State := choosenRecs[3].phpl_carrier_state;
			SELF.Phone3_Score:= IF(BParams.ReturnScore, choosenRecs[3].phone_score, '');
			SELF.Phone3_Score_confidence:= MemberPoint.Confidence.getConfidencePhoneScore(choosenRecs[3].phone_score);
			SELF.Phone3_Score_confidence_star:= MemberPoint.Confidence.getStarRate((UNSIGNED)choosenRecs[3].phone_score);
			SELF:= common;
		END;
		//PhoneFinder BatchOut Transformation
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
		MemberPoint.Layouts.BatchOut attachPhoneFinderPhones(MemberPoint.Layouts.batchInter adultsOrGuardians, MemberPoint.Layouts.BatchOut common):= TRANSFORM
			rowsPhones := pfPhones(acctno = adultsOrGuardians.acctno);
			deserializedPhones := MemberPoint.deserializeOtherPhones(rowsPhones[1]);
			concatenatedPhones := MemberPoint.concatenatePrimaryData(deserializedPhones, rowsPhones[1]);
			connectedPhones := MemberPoint.ConnectedPhones.getConnectedPhoneFinder(concatenatedPhones, BParams);
			filteredRecs:= MAP( BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.CellPhones => connectedPhones(PhoneType=PhoneFinder_Services.Constants.PhoneType.Wireless),
													BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.Landlines => connectedPhones(PhoneType=PhoneFinder_Services.Constants.PhoneType.Landline),
													connectedPhones);
			choosenRecs:= CHOOSEN(filteredRecs, BParams.MaxPhoneCount);
			SELF.Phone1_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[1].PhoneNumber, adultsOrGuardians.primary_phone_number);
			SELF.Phone1_Number := choosenRecs[1].PhoneNumber;
			SELF.Phone1_Number_Listing_Name := choosenRecs[1].ListingName;
			SELF.Phone1_First_Seen_Date := choosenRecs[1].DateFirstSeen;
			SELF.Phone1_Last_Seen_Date := choosenRecs[1].DateLastSeen;
			SELF.Phone1_Type := choosenRecs[1].ListingType;
			SELF.Phone1_Line_Type := choosenRecs[1].PhoneType;
			SELF.Phone1_Carrier := choosenRecs[1].Carrier;
			SELF.Phone1_Carrier_City := choosenRecs[1].CarrierCity;
			SELF.Phone1_Carrier_State := choosenRecs[1].CarrierState;
			SELF.Phone1_Phone_Status := choosenRecs[1].PhoneStatus;
			
			SELF.Phone2_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[2].PhoneNumber, adultsOrGuardians.primary_phone_number);
			SELF.Phone2_Number := choosenRecs[2].PhoneNumber;
			SELF.Phone2_Number_Listing_Name := choosenRecs[2].ListingName; 
			SELF.Phone2_First_Seen_Date := choosenRecs[2].DateFirstSeen;
			SELF.Phone2_Last_Seen_Date := choosenRecs[2].DateLastSeen;
			SELF.Phone2_Line_Type := choosenRecs[2].PhoneType;
			SELF.Phone2_Carrier := choosenRecs[2].Carrier;
			SELF.Phone2_Carrier_City := choosenRecs[2].CarrierCity;
			SELF.Phone2_Carrier_State := choosenRecs[2].CarrierState;
			SELF.Phone2_Phone_Status := choosenRecs[2].PhoneStatus;

			SELF.Phone3_Match_Codes:= MemberPoint.Util.getMatchCode(choosenRecs[3].PhoneNumber, adultsOrGuardians.primary_phone_number);
			SELF.Phone3_Number := choosenRecs[3].PhoneNumber;
			SELF.Phone3_Number_Listing_Name := choosenRecs[3].ListingName; 
			SELF.Phone3_First_Seen_Date := choosenRecs[3].DateFirstSeen;
			SELF.Phone3_Last_Seen_Date := choosenRecs[3].DateLastSeen;
			SELF.Phone3_Line_Type := choosenRecs[3].PhoneType;
			SELF.Phone3_Carrier := choosenRecs[3].Carrier;
			SELF.Phone3_Carrier_City := choosenRecs[3].CarrierCity;
			SELF.Phone3_Carrier_State := choosenRecs[3].CarrierState;
			SELF.Phone3_Phone_Status := choosenRecs[3].PhoneStatus;

			SELF:= common;
		END;
		
   		commonBatchOut	:= join(AdultsOrGuardiansBatchInter, rawbatchin,
		                   		LEFT.acctno = RIGHT.acctno,buildCommonBatchOut(LEFT,right));
		
		waterfallBatchOut	:= JOIN(AdultsOrGuardiansBatchInter, 
									commonBatchOut, 
									LEFT.acctno = RIGHT.acctno, 
									attachWaterfallPhones(LEFT, RIGHT));

		phoneFinderBatchOut	:= JOIN(AdultsOrGuardiansBatchInter, 
									commonBatchOut, 
									LEFT.acctno = RIGHT.acctno, 
									attachPhoneFinderPhones(LEFT, RIGHT));
		
		AdultsOrGuardiansBatchOut := IF(isPhoneInfoAlternative, phoneFinderBatchOut, waterfallBatchOut);
		// AdultsOrGuardiansBatchOut := PROJECT(AdultsOrGuardiansBatchInter,TheXform(LEFT));

		//------------------------------------------------------------------------------------------------//
		// Conditionally Process Minors who have no input guardian or (no/no-good)derived guardian data 	
		 MinorsOnlyBatchOutPre 	:= MemberPoint.appendConfirmedPhone(MinorsOnlyBatchInter,BParams,true);

 		 MinorsOnlyBatchOut := join(MinorsOnlyBatchOutPre, dsDeceasedInputMinors , 
   																left.acctno = right.acctno, 
   																transform(MemberPoint.Layouts.batchOut,
   																					self.Date_of_death := right.DOD8 ,
   																					self.dcd_match_code := right.matchcode,
   																					self := left),
   																left outer);
   
   		//------------------------------------------------------------------------------------------------//
   		// Combine MinorsOnly and AdultsOrGuardians		
   		dsOutput := MinorsOnlyBatchOut + AdultsOrGuardiansBatchOut;
   		//------------------------------------------------------------------------------------------------//
   		//We now need to combine and send results and royalties
   		
   		finalRec := record
   			dataset(MemberPoint.Layouts.BatchOut) Records;
   			dataset(Royalty.Layouts.RoyaltyForBatch) Royalties;
   		end;

   		finalRecords := dataset([{dsOutput ,dsEmailsWhole.Royalties + wfResult_royalties}],finalRec);
		return finalRecords;
	end;
  