/* ************************************************************************
 * This function searches the Experian Gateway.	  												*
 * -This gateway is only searched if the access rules are met             *
 * -There is a cost associated with use of this gateway									  *
 * -- As of 6-13-2013 Cost: 1-3m annual min paid, 3-4m $0.15, 4m+ $0.12   *
 * :: Source: EXP																													*
 ************************************************************************ */

IMPORT Doxie, Experian_Phones, Gateway, Phone_Shell, Progressive_Phone, RiskWise, UT,Header;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Gateway_Experian (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, 
	DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) foundPhones, 
	DATASET(Gateway.Layouts.Config) Gateways, UNSIGNED1 DPPAPurpose, UNSIGNED1 GLBPurpose, 
	STRING50 DataRestrictionMask, BOOLEAN isBatch, UNSIGNED1 PhoneRestrictionMask, 
	UNSIGNED3 ExperianScoreThreshold, UNSIGNED1 ExperianMaxMetronetPhones, BOOLEAN ExperianAllowBatchUse, 
	BOOLEAN BlankOutDuplicatePhones, BOOLEAN DedupAgainstInputPhones, BOOLEAN Confirmation_GoToGateway, BOOLEAN UsePremiumSource_A=FALSE) := FUNCTION
	 /* ***************************************************************
		*      Find the Experian PINS and potential phone numbers	      *
	  *************************************************************** */
	layoutExperian := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		STRING15 ExperianPIN := '';
		STRING3 Phone_Last3Digits := '';
		STRING4 Phone_Score := '';
		// While we are gathering Experian PINS we should get the Experian Attributes just to avoid hitting the key twice
		BOOLEAN Experian_Verified := FALSE;
		STRING1 Experian_Type := '';
		STRING1 Experian_Source := '';
		STRING8 Experian_Last_Update := '';
		UNSIGNED8 Experian_Pin_DID := 0;
		STRING25 Experian_Pin_FName := '';
	  STRING20 Experian_Pin_MName := '';
		STRING25 Experian_Pin_LName := '';
	  STRING5 Experian_Pin_NameSuffix := '';
		STRING2 Experian_Rec_Type := '';
END;
	
	layoutExperian getExperianPINS(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Experian_Phones.Key_Did_Digits ri) := TRANSFORM
		SELF.ExperianPIN := ri.Encrypted_Experian_PIN;
		SELF.Phone_Last3Digits := ri.Phone_Digits;
		SELF.Phone_Score := (STRING)ri.Score;
		SELF.Experian_Verified := TRUE; // We have a hit on Experian, this number is verified
		SELF.Experian_Type := TRIM(ri.Phone_Type);
		SELF.Experian_Source := TRIM(ri.Phone_Source);
		SELF.Experian_Last_Update := TRIM(ri.Phone_Last_Updt);
		SELF.Experian_Pin_DID := ri.pin_did;
		SELF.Experian_Pin_FName := ri.pin_fname;
		SELF.Experian_Pin_LName := ri.pin_lname;
	  SELF.Experian_Rec_Type := ri.rec_type;
	  SELF.Experian_Pin_MName := ri.pin_mname;
		SELF.Experian_Pin_NameSuffix := ri.pin_name_suffix;
		SELF := le;
	END;
	
	withPINS := JOIN(Input, Experian_Phones.Key_Did_Digits, LEFT.Clean_Input.DID <> 0 AND KEYED(LEFT.Clean_Input.DID = RIGHT.DID), getExperianPINS(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost)) (TRIM(Phone_Last3Digits) <> '');

	/* ***************************************************************
	 * Find the unique phones - we will need to hit the Gateway for  *
   * these to retreive the full number. Sequence each so we can    *
	 * the standard Gateway function but still join back to the      *
	 * original dataset.                                             *
	 *************************************************************** */
	// Only send the inputs to the Gateway that have the Gateway turned on
	keepPINS := withPINS (Clean_Input.ExperianGatewayEnabled = TRUE);
	uniqueExperianTemp := JOIN(keepPINS, foundPhones, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Phone_Last3Digits = RIGHT.Gathered_Phone[8..10],
																								TRANSFORM(layoutExperian, SELF := LEFT), LEFT ONLY, ATMOST(RiskWise.max_atmost));
	Set_Equifax_Seqs := SET(foundPhones(Sources.Source_List=Phone_Shell.Constants.Src_Equifax), Clean_Input.Seq);
	
	uniqueExperianTemp_Filtered := uniqueExperianTemp(Clean_Input.Seq NOT IN Set_Equifax_Seqs);
	
	uniqueExperianTemp1 := IF(UsePremiumSource_A, uniqueExperianTemp_Filtered, uniqueExperianTemp);
	// Filter out input phones provided by user:
	layout_userinputph := Phone_Shell.Layout_Phone_Shell.Layout_Dedup_Hist_Phone;
	
  layout_userinputph getHistPhones(layout_userinputph ri) := transform
		SELF := ri;
  END;
  f_hist_phone_list :=  NORMALIZE(Input,LEFT.Raw_Input.InputPhoneList,getHistPhones(RIGHT));
	//get unique ids on all records since later we may add back records we filter off of uniqueExperian
	unique_all_Experian := PROJECT(uniqueExperianTemp1, TRANSFORM(layoutExperian, SELF.Unique_Record_Sequence := COUNTER; SELF := LEFT));
	//hits to send to gateway	
	uniqueExperian := JOIN(unique_all_Experian, f_hist_phone_list, 
		                           LEFT.Clean_Input.AcctNo = RIGHT.acctno AND LEFT.Phone_Last3Digits = RIGHT.phone10[8..10],
															 TRANSFORM(layoutExperian, SELF := LEFT), LEFT ONLY, ATMOST(RiskWise.max_atmost));													 

	//keep these experian hits...make look like metronet input for below's join
	FakeMetronetInput := JOIN(unique_all_Experian, f_hist_phone_list, 
		                           LEFT.Clean_Input.AcctNo = RIGHT.acctno AND LEFT.Phone_Last3Digits = RIGHT.phone10[8..10],
															 TRANSFORM(layoutExperian, SELF.ExperianPIN := ''; SELF := LEFT), ATMOST(RiskWise.max_atmost));	
	
	//keep these hits...make look like experian hits coming from metronet
	FakeMetronetHits := JOIN(unique_all_Experian, f_hist_phone_list, 
		                           LEFT.Clean_Input.AcctNo = RIGHT.acctno AND LEFT.Phone_Last3Digits = RIGHT.phone10[8..10],
															 TRANSFORM(Progressive_Phone.layout_progressive_phones.Layout_EXP_Multiple_Phones, 
															  SELF.subj_phone10 := RIGHT.phone10;
																SELF.ExperianPIN := ''; // Using this to check for a Royalties hit, only real Gateway hits will have this populated.
																SELF.Seq := (STRING)LEFT.Unique_Record_Sequence;
																SELF := LEFT;
																SELF := [];), ATMOST(RiskWise.max_atmost));	
	// Get the Gateway Information - Only go to the Gateway if we have permission
	ExperianFlatFileOK := UT.PermissionTools.GLB.OK(GLBPurpose) AND DataRestrictionMask[15] <> '1';
	MetronetOK := ExperianFlatFileOK AND ((isBatch AND ExperianAllowBatchUse) OR ~isBatch);
	MetronetGateway := Gateways(Gateway.Configuration.IsMetronet(servicename) and MetronetOK)[1];

	// If it is batch but batch is allowed, or isn't batch go ahead and figure out which PINS to send to the gateway, otherwise send nothing
  //if Confirmation_GoToGateway, SEND fake mentronet hits to gateway for confirmation they are really hits
	sendToGatewayTemp := IF(MetronetOK, SORT(if(Confirmation_GoToGateway = FALSE, uniqueExperian, unique_all_Experian), Clean_Input.seq, -((INTEGER)Phone_Score)), 
																																			 DATASET([], layoutExperian));

	// We only want to call the Experian gateway once per input, keeping the highest scoring phone number that is over the threshold
	sendToGateway := ROLLUP(sendToGatewayTemp ((INTEGER)Phone_Score >= (INTEGER)ExperianScoreThreshold), LEFT.Clean_Input.seq = RIGHT.Clean_Input.seq, TRANSFORM(layoutExperian, SELF := LEFT));
	
	// Form the Gateway Input
	Progressive_Phone.Layout_Progressive_Phones.Layout_EXP_Multiple_Phones intoGateway(layoutExperian le) := TRANSFORM
		SELF.Seq := (STRING)le.Unique_Record_Sequence;
		SELF.ExperianPIN := le.ExperianPIN;
		SELF.Phone_Last3Digits := le.Phone_Last3Digits;
		SELF.DID := le.DID;
		SELF.AcctNo := le.Clean_Input.AcctNo;
		SELF.Subj_First := le.Clean_Input.FirstName;
		SELF.Subj_Middle := le.Clean_Input.MiddleName;
		SELF.Subj_Last := le.Clean_Input.LastName;
		SELF.Phone_Score := le.Phone_Score;
  	self.Phones_Last3Digits := dataset([{(le.Phone_Last3Digits)}], progressive_phone.layout_progressive_phones.Phone_Last3Digits);
		SELF := le;
		SELF := [];
	END;
	gatewayInput := PROJECT(sendToGateway, intoGateway(LEFT));
	//if Confirmation_GoToGateway, don't give fake results but real gateway results
	gatewayResults := IF(MetronetOK, Gateway.SoapCall_Metronet(gatewayInput, MetronetGateway, /*timeout =*/ 2, /*retries =*/ 0 /*Don't retry because of SLAs*/, ExperianMaxMetronetPhones),
																	 DATASET([], progressive_phone.layout_progressive_phones.layout_exp_multiple_phones));
	
	// Combine the Gateway Results with the Input we sent to the Gateway
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getMetronet(layoutExperian le, Progressive_Phone.layout_progressive_phones.Layout_EXP_Multiple_Phones ri) := TRANSFORM
		SELF.Gathered_Phone := TRIM(ri.Subj_Phone10);
		
		// The Experian (Metronet) Gateway doesn't return addresses/ssn/dob, we can attempt to match the name and DID that were on the Experian flat file used to get the Experian PIN above
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											le.Experian_Pin_FName,		le.Experian_Pin_LName, 		'', 													'',						 							'',						 						'',						 							'',									'',										'',						 				'',						 							'',						 		 le.Experian_Pin_DID, '');
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, '', isGatewayResult := TRUE), 'EXP', '');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_first);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_phone_date_last);
		
	  SELF.Sources.Source_Owner_DID := IF(le.Experian_Pin_DID <> 0 , (STRING)le.Experian_Pin_DID, (STRING)le.DID);
		SELF.Sources.Source_Owner_Name_First 	:= IF(le.Experian_Pin_LName <> '', le.Experian_Pin_FName, ri.subj_first); 
		SELF.Sources.Source_Owner_Name_Middle := IF(le.Experian_Pin_LName <> '', le.Experian_Pin_MName, ri.subj_middle);
		SELF.Sources.Source_Owner_Name_Last 	:= IF(le.Experian_Pin_LName <> '', le.Experian_Pin_LName, ri.subj_last);
		SELF.Sources.Source_Owner_Name_Suffix := IF(le.Experian_Pin_LName <> '', le.Experian_Pin_NameSuffix,ri.subj_suffix);
		
		// The Experian Gateway is searched by DID, so this is for the Subject or Spouse
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := IF(le.Experian_Rec_Type <> 'SP',
		                                                         Phone_Shell.Constants.Phone_Subject_Level.Subject,
																														 Phone_Shell.Constants.Phone_Subject_Level.FirstDegreeRelative);
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := IF(le.Experian_Rec_Type <> 'SP', 
		                                                         Header.relative_titles.fn_get_str_title(Header.relative_titles.num_Subject), 
																														 Header.relative_titles.fn_get_str_title(Header.relative_titles.num_Spouse));

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;
		
		// If we hit the Gateway we owe Royalties. Fake gateway hits we don't owe royalties on.
		// Only real gateway hits will have ExperianPIN populated.
		SELF.Royalties.Metronet_Royalty := IF(TRIM(le.ExperianPIN) <> '', 1, 0);
		
		// We also have the Experian Flat File Attributes to populate for this phone
		SELF.Experian_File_One_Verification.Experian_Verified := le.Experian_Verified;
		SELF.Experian_File_One_Verification.Experian_Type := le.Experian_Type;
		SELF.Experian_File_One_Verification.Experian_Source := le.Experian_Source;
		SELF.Experian_File_One_Verification.Experian_Last_Update := le.Experian_Last_Update;
		SELF.Experian_File_One_Verification.Experian_Phone_Score_V1 := le.Phone_Score;
		
		SELF := le;
	END;
	//if Confirmation_GoToGateway, don't give fake results but real gateway results
	gatewayCombined := gatewayResults + if(DedupAgainstInputPhones = FALSE and MetronetOK and Confirmation_GoToGateway = false, FakeMetronetHits); //real gateway + fake gateway hits (Only return fake gateway if we aren't completely removing the duplicate phone record - no point in doing extra work)
	SentCombined := sendToGateway + if(DedupAgainstInputPhones = FALSE and MetronetOK and Confirmation_GoToGateway = false, FakeMetronetInput); //gateway input + fake gateway hits
	
	withMetronetTemp := JOIN(SentCombined, gatewayCombined, (STRING)LEFT.Unique_Record_Sequence = RIGHT.Seq, getMetronet(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));

	// If the Gateway Fails there will be no phone found, eliminate those failed records, also make sure we are only returning the requested number of Experian Phones per input.
	withMetronet := UNGROUP(TOPN(GROUP(withMetronetTemp (TRIM(Gathered_Phone) <> '' AND TRIM(Sources.Source_List) <> ''), Clean_Input.Seq), ExperianMaxMetronetPhones, Clean_Input.Seq, -(INTEGER)Experian_File_One_Verification.Experian_Phone_Score_V1, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))));

	/* ***************************************************************
	 * Append the attributes to the phones we already found in house *
	 *************************************************************** */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getAttributes(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, layoutExperian ri) := TRANSFORM
		SELF.Experian_File_One_Verification.Experian_Verified := ri.Experian_Verified;
		SELF.Experian_File_One_Verification.Experian_Type := ri.Experian_Type;
		SELF.Experian_File_One_Verification.Experian_Source := ri.Experian_Source;
		SELF.Experian_File_One_Verification.Experian_Last_Update := ri.Experian_Last_Update;
		SELF.Experian_File_One_Verification.Experian_Phone_Score_V1 := ri.Phone_Score;
		SELF := le;
	END;
	withExperianAttributes := JOIN(foundPhones, withPINS, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone[8..10] = RIGHT.Phone_Last3Digits,
																												getAttributes(LEFT, RIGHT), LEFT OUTER, KEEP(500), ATMOST(RiskWise.max_atmost));
	
	/* ***************************************************************
	 *         Append the Experian Subject Level attributes          *
	 *************************************************************** */
	// First retreive a count of unique Experian phone numbers that we didn't retreive because they were below the score threshold
	uniqueExperianAttrTemp := JOIN(withPINS, foundPhones, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Phone_Last3Digits = RIGHT.Gathered_Phone[8..10],
																								TRANSFORM(layoutExperian, SELF.Subject_Level.Experian_Num_Insufficient_Score := 1; SELF := LEFT), LEFT ONLY, ATMOST(RiskWise.max_atmost)) ((INTEGER)Phone_Score < ExperianScoreThreshold);
	
	layoutExperian rollUniqueAttr(layoutExperian le, layoutExperian ri) := TRANSFORM
		SELF.Subject_Level.Experian_Num_Insufficient_Score := le.Subject_Level.Experian_Num_Insufficient_Score + ri.Subject_Level.Experian_Num_Insufficient_Score;
		SELF := le;
	END;
	uniqueExperianAttr := ROLLUP(uniqueExperianAttrTemp, LEFT.Clean_Input.seq = RIGHT.Clean_Input.seq, rollUniqueAttr(LEFT, RIGHT));
	
	// Second retreive a count of Experian phone numbers that we didn't retreive because they were already found in house
	inHouseExperianAttrTemp := JOIN(withPINS, foundPhones, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Phone_Last3Digits = RIGHT.Gathered_Phone[8..10],
																								TRANSFORM(layoutExperian, SELF.Subject_Level.Experian_Num_Duplicate := 1; SELF.Gathered_Phone := RIGHT.Gathered_Phone; SELF := LEFT), KEEP(500), ATMOST(RiskWise.max_atmost));
																				
	sortedInHouseExperian := DEDUP(SORT(inHouseExperianAttrTemp, Clean_Input.Seq, Gathered_Phone), Clean_Input.Seq, Gathered_Phone);
																				
	layoutExperian rollDuplicateAttr(layoutExperian le, layoutExperian ri) := TRANSFORM
		SELF.Subject_Level.Experian_Num_Duplicate := le.Subject_Level.Experian_Num_Duplicate + ri.Subject_Level.Experian_Num_Duplicate;
		SELF := le;
	END;
	inHouseExperianAttr := ROLLUP(sortedInHouseExperian, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, rollDuplicateAttr(LEFT, RIGHT));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus addInsufficient(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, layoutExperian ri) := TRANSFORM
		SELF.Subject_Level.Experian_Num_Insufficient_Score := ri.Subject_Level.Experian_Num_Insufficient_Score;
		SELF := le;
	END;
	withInsufficient := JOIN(withExperianAttributes, uniqueExperianAttr, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, addInsufficient(LEFT, RIGHT), LEFT OUTER, KEEP(500), ATMOST(RiskWise.max_atmost));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus addDuplicate(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, layoutExperian ri) := TRANSFORM
		SELF.Subject_Level.Experian_Num_Duplicate := ri.Subject_Level.Experian_Num_Duplicate;
		SELF := le;
	END;
	withDuplicate := JOIN(withInsufficient, inHouseExperianAttr, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, addDuplicate(LEFT, RIGHT), LEFT OUTER, KEEP(500), ATMOST(RiskWise.max_atmost));
	/* ***************************************************************
	 *                    Combine it all together	                   *
	 *************************************************************** */
	combined := IF(MetronetOK, withMetronet, DATASET([], Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus)) + 
							IF(ExperianFlatFileOK, withDuplicate, foundPhones);
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus rollSubjectLevel(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		SELF.Subject_Level.Experian_Num_Duplicate := IF(le.Subject_Level.Experian_Num_Duplicate = 0, ri.Subject_Level.Experian_Num_Duplicate, le.Subject_Level.Experian_Num_Duplicate);
		SELF.Subject_Level.Experian_Num_Insufficient_Score := IF(le.Subject_Level.Experian_Num_Insufficient_Score = 0, ri.Subject_Level.Experian_Num_Insufficient_Score, le.Subject_Level.Experian_Num_Insufficient_Score);
	
		SELF := le;
	END;
	getSubjectLevels := ROLLUP(combined, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, rollSubjectLevel(LEFT, RIGHT));
	
	withSubjectLevels := JOIN(combined, getSubjectLevels, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.Subject_Level.Experian_Num_Duplicate := RIGHT.Subject_Level.Experian_Num_Duplicate; 
																																																																																				SELF.Subject_Level.Experian_Num_Insufficient_Score := RIGHT.Subject_Level.Experian_Num_Insufficient_Score; 
																																																																																				SELF := LEFT), 
																																																			LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	final := DEDUP(SORT(withSubjectLevels, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	// OUTPUT(metronetOK, NAMED('metronetOK'));
	// OUTPUT(ExperianFlatFileOK, NAMED('ExperianFlatFileOK'));
	// OUTPUT(MetronetGateway, NAMED('MetronetGateway'));
	// OUTPUT(CHOOSEN(withPINS, 100), NAMED('ExpwithPINS'));
	// OUTPUT(CHOOSEN(keepPINS, 100), NAMED('ExpkeepPINS'));
	// OUTPUT(CHOOSEN(uniqueExperian, 100), NAMED('ExpuniqueExperian'));
	// OUTPUT(CHOOSEN(sendToGatewayTemp, 100), NAMED('ExpsendToGatewayTemp'));
	// OUTPUT(CHOOSEN(sendToGateway, 100), NAMED('ExpsendToGateway'));
	// OUTPUT(CHOOSEN(gatewayInput, 100), NAMED('ExpgatewayInput'));
	// OUTPUT(CHOOSEN(gatewayResults, 100), NAMED('ExpgatewayResults'));
	// OUTPUT(CHOOSEN(withMetronetTemp, 100), NAMED('ExpwithMetronetTemp'));
	// OUTPUT(CHOOSEN(withMetronet, 100), NAMED('ExpwithMetronet'));
	// OUTPUT(CHOOSEN(withExperianAttributes, 100), NAMED('ExpwithExperianAttributes'));
	// OUTPUT(CHOOSEN(uniqueExperianAttrTemp, 100), NAMED('ExpuniqueExperianAttrTemp'));
	// OUTPUT(CHOOSEN(uniqueExperianAttr, 100), NAMED('ExpuniqueExperianAttr'));
	// OUTPUT(CHOOSEN(inHouseExperianAttrTemp, 100), NAMED('ExpinHouseExperianAttrTemp'));
	// OUTPUT(CHOOSEN(sortedInHouseExperian, 100), NAMED('ExpsortedInHouseExperian'));
	// OUTPUT(CHOOSEN(inHouseExperianAttr, 100), NAMED('ExpinHouseExperianAttr'));
	// OUTPUT(CHOOSEN(withInsufficient, 100), NAMED('ExpwithInsufficient'));
	// OUTPUT(CHOOSEN(withDuplicate, 100), NAMED('ExpwithDuplicate'));
	// OUTPUT(CHOOSEN(foundPhones, 100), NAMED('foundPhones'));
	// OUTPUT(CHOOSEN(combined, 100), NAMED('Expcombined'));
	// OUTPUT(CHOOSEN(withSubjectLevels, 100), NAMED('ExpwithSubjectLevels'));
	// OUTPUT(CHOOSEN(final, 100), NAMED('Expfinal'));
	// output(FakeMetronetHits, named('FakeMetronetHits'));
	// output(MetronetOK, named('MetronetOK'));
  // output(withMetronetTemp, named('withMetronetTemp'));
  // output(gatewayResults, named('gatewayResults'));
	// output(uniqueExperianTemp1, named('uniqueExperianTemp1'));
	// output(keepPINS, named('keepPINS'));
	// output(MetronetOK, named('MetronetOK'));
	// output(ExperianFlatFileOK, named('ExperianFlatFileOK'));
	RETURN(final);
END;