IMPORT Address, ut, NID, AddrBest, BatchShare, DidVille, progressive_phone, BatchServices, Royalty,
       PhoneFinder_Services, Gateway, MemberPoint, iesp, Std;

	export BatchRecords(dataset(MemberPoint.Layouts.batchIn) rawBatchIn, MemberPoint.IParam.BatchParams BParams) := function
		//------------------------------------------------------------------------------------------------//
		// Check the processes that we are to run input on
		isIncludeAddress 				:= BParams.IncludeAddress; 
		isIncludePhone 					:= BParams.IncludePhone;
		isIncludeEmail 					:= BParams.IncludeEmail;
		isIncludeDeceased				:= BParams.IncludeDeceased;
		isIncludeGender 				:= BParams.IncludeGender;
		isIncludeSSN 						:= BParams.IncludeSSN;
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
		dsDeceasedInputMinorsPre 	:= MemberPoint.getDeceasedInfo(ClassifiedMinors, BParams,true);
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
		dsBestAddress 	:= MemberPoint.getBestAddress(dsBestGood, BParams);
		// Generate the "Address" and "Possible New Address" based on the address from Best & BestAddress  	
		dsAddressesPre	:= MemberPoint.selectAddress(dsBestGood,dsBestAddress,AdultsOrGuardiansBatchInter,BParams);
		dsAddresses 		:=  if(isIncludeAddress,dsAddressesPre, dataset([],MemberPoint.Layouts.AddressesRec)); 	
		//Run all adults except derived guardians thru deceased.
		dsDeceasedInputAdultsPre 			:= MemberPoint.getDeceasedInfo(dsInputGoodWithDIDAndScore(LN_search_name_type <> MemberPoint.Constants.LNSearchNameType.Derived), BParams);	
		dsDeceasedInputAdults 				:= if(isIncludeDeceased, dsDeceasedInputAdultsPre, dataset([],MemberPoint.Layouts.DeceasedOut ));
		// All deceased.
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
			SELF.dob := if((UNSIGNED)currDOB > 0 ,currDOB ,'');
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
			//Scores
			//MemberPoint Enhancements: For derived guardians (LN_Search_Name_Type = D) Name, SSN AND DOB score fields output should be null.
			isDerived:= adultsOrGuardians.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived;
			isPartial:= (LENGTH(TRIM(adultsOrGuardians.SSN)) < 5);
			SELF.name_score:= IF(isDerived, '', (STRING)rowBest.verify_best_name);
			SELF.ssn_score:= IF(~isPartial AND isIncludeSSN AND ~isDerived, (STRING)rowBest.verify_best_ssn, '');
			SELF.dob_score:= IF(isDerived, '', (STRING)rowBest.verify_best_dob);
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
			/* DEBUG */
			//OUTPUT(batchIn, named('batchIn'));
			//output(dsEmailsWholePre, named('dsEmailsWholePre'));
			//output(dsEmailsWhole, named('dsEmailsWhole'));
			//output(dsEmailsResults, named('dsEmailsResults'));
			//OUTPUT(isIncludeEmail, NAMED('isIncludeEmail'));
			//OUTPUT(commonBatchOut, NAMED('commonBatchOut'));
			//OUTPUT(waterfallBatchOut, NAMED('waterfallBatchOut'));
			//OUTPUT(phoneFinderBatchOut, NAMED('phoneFinderBatchOut'));
			//OUTPUT(AdultsOrGuardiansBatchOut, NAMED('AdultsOrGuardiansBatchOut'));
			//OUTPUT(dsEmailsWhole, NAMED('dsEmailsWhole'));
			//OUTPUT(wfResult, NAMED('wfResult'));
			// OUTPUT(dsPhonesPre, NAMED('dsPhonesPre'));
			// OUTPUT(connectedWFPhones, NAMED('wfConnected'));
			// OUTPUT(filteredWFPhones, NAMED('wfTypeFiltered'));
			// OUTPUT(BParams);
			//OUTPUT(dsPhonesPre);

		return finalRecords;
	end;