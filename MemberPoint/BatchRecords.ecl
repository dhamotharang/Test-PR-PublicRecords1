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
		isPhoneInfoAlternative	:= Std.Str.ToUpperCase(BParams.StrTransactionType) <> MemberPoint.Constants.PhoneTransactionType.WaterfallPhones;
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
		 dsAddresses 		:=  if(isIncludeAddress,riskindicator_addressjoined, dataset([],MemberPoint.Layouts.AddressesRec_extended)); 	
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
		 wfResult 					:= MemberPoint.getPhoneInfo(dsBestGood, BParams);
		 dsPhonesPre				:=	map ( BParams.PhonesReturnCutoff = 'H' => wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.HighMin), 
																BParams.PhonesReturnCutoff = 'L' => wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.LowMin),
																																		wfResult((UNSIGNED)phone_score >= MemberPoint.Constants.PhoneScore.MidMin));//'M' and default
		ungroupedWFPhones	:= ungroup(dsPhonesPre);
		connectedWFPhones	:= MemberPoint.ConnectedPhones.getConnectedWaterfall(ungroupedWFPhones, BParams);
		filteredWFPhones	:= MAP( BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.CellPhones => connectedWFPhones(switch_type=MemberPoint.Constants.WFPhoneType.CellPhones),
															BParams.PhoneFilter = MemberPoint.Constants.PhoneFilterType.Landlines => connectedWFPhones(switch_type=MemberPoint.Constants.WFPhoneType.Landlines),
															connectedWFPhones);
		dsPhones 						:= if(isIncludePhone AND EXISTS(ungroupedWFPhones), 
															filteredWFPhones, 
															DATASET([],progressive_phone.layout_progressive_phone_common));
		// Phone Info (PhoneFinder)
		pfPhones						:= IF(isIncludePhone AND EXISTS(dsBestGood), 
															MemberPoint.getAlternatePhoneInfo(dsBestGood, BParams), 
															DATASET([], PhoneFinder_Services.Layouts.PhoneFinder.BatchOut));
		dsEmailsWholePre 		:= MemberPoint.getEmailInfo(dsBestGood, BParams);
		dsEmailsWhole				:= if(isIncludeEmail,dsEmailsWholePre, dataset([],MemberPoint.Layouts.EmailRec));
		// dsEmailsResults 		:= ungroup(dsEmailsWhole.Records);
		dsEmailsResults 		:= dsEmailsWhole.Records;

		//Common BatchOut Transformation
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
		MemberPoint.Layouts.BatchOut buildCommonBatchOut(MemberPoint.Layouts.batchInter adultsOrGuardians) := TRANSFORM
			rowBest := dsBestGood(seq = (UNSIGNED)adultsOrGuardians.acctno)[1];
			rowAddress := dsAddresses(acctno = adultsOrGuardians.acctno)[1];
			rowDeceased := dsDeceased(acctno = adultsOrGuardians.acctno)[1];
			rowsEmails := dsEmailsResults(acctno = adultsOrGuardians.acctno); 
			
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
			SELF.name_score:= IF(isDerived, '', (STRING)rowBest.verify_best_name);
			SELF.ssn_score:= IF(~isPartial AND isIncludeSSN AND ~isDerived, (STRING)rowBest.verify_best_ssn, '');
			SELF.dob_score:= IF(~isDerived AND isIncludeDOB, (STRING)rowBest.verify_best_dob, '');
			// Death
			SELF.Date_of_death := rowDeceased.DOD8;
			SELF.dcd_match_code := rowDeceased.matchcode; // this will be death match code + 1 string for 'D' or DOB matches
			// Email
			SELF.Email1 := rowsEmails[1].orig_email;
			SELF.Email2 := rowsEmails[2].orig_email;
			SELF.Email3 := rowsEmails[3].orig_email;
			SELF.Email4 := rowsEmails[4].orig_email;
			SELF.Email5 := rowsEmails[5].orig_email;
			SELF.Email6 :=rowsEmails[6].orig_email;
		  SELF.Email7 :=rowsEmails[7].orig_email;
		  SELF.Email8 :=rowsEmails[8].orig_email;  
		  SELF.Email9 :=rowsEmails[9].orig_email;
		  SELF.Email10 :=rowsEmails[10].orig_email;
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
		
		commonBatchOut						:= PROJECT(AdultsOrGuardiansBatchInter, buildCommonBatchOut(LEFT));
		waterfallBatchOut					:= JOIN(AdultsOrGuardiansBatchInter, 
																			commonBatchOut, 
																			LEFT.acctno = RIGHT.acctno, 
																			attachWaterfallPhones(LEFT, RIGHT));
		phoneFinderBatchOut				:= JOIN(AdultsOrGuardiansBatchInter, 
																			commonBatchOut, 
																			LEFT.acctno = RIGHT.acctno, 
																			attachPhoneFinderPhones(LEFT, RIGHT));
		AdultsOrGuardiansBatchOut	:= IF(isPhoneInfoAlternative, phoneFinderBatchOut, waterfallBatchOut);
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
   
   		finalRecords := dataset([{dsOutput ,dsEmailsWhole.Royalties}],finalRec);
		
					
				
		return finalRecords;
	end;
  