/* ****************************************************************************
 * This function searches the Equifax Key.	  												        *
 * This key is only searched if the Data restriction mask (24) is not set *
 * and the UsePremiumSource_A is set to true.
 * :: Source: EQP																													   *
 ************************************************************************ */

IMPORT Phone_Shell, PhoneMart, RiskWise, risk_indicators;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Equifax (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, 
					DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) foundPhones, 
					STRING50 DataRestrictionMask, 
					UNSIGNED1 PhoneRestrictionMask,
					BOOLEAN UsePremiumSource_A = FALSE) := FUNCTION
	
	EquifaxAllowed :=	UsePremiumSource_A = true and Phone_Shell.Constants.EquiaxDRMCheck(DataRestrictionMask);

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getEquiFax(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PhoneMart.key_phonemart_did ri) := TRANSFORM
		SELF.Gathered_Phone := ri.phone;
		
		// Equifax doesn't return names/dob, we can attempt to match the c and DID that were on the Experian flat file used to get the Experian PIN above
		 matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, 
		 le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, 
		 le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
							ri.Fname,	ri.Lname, ri.address, '', '',	'', ri.city, ri.state, ri.zipcode, '', ri.ssn, ri.did, ri.phone);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(EquifaxAllowed and Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, '', isGatewayResult := FALSE), 'EQP', '');	
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);
	  SELF.Sources.Source_Owner_DID := (string) ri.DID;
		SELF.Sources.Source_Owner_Name_First 	:=  ri.Fname; 
		SELF.Sources.Source_Owner_Name_Middle := ri.Mname;
		SELF.Sources.Source_Owner_Name_Last 	:=  ri.Lname;
		SELF.Sources.Source_Owner_Name_Suffix :=  ri.name_Suffix;	

		//No relative data in the PhoneMart key...it's all for the subject only
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := Phone_Shell.Constants.Phone_Subject_Level.Subject;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := 'Subject';
		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode; 
		SELF.Royalties.EFXDataMart_Royalty := IF(ri.phone <> '', 1, 0);
		SELF := le;

	END;
	//get Equifax data
	WithPhoneMart := JOIN(Input, PhoneMart.key_phonemart_did, 
			LEFT.DID <> 0 AND KEYED(RIGHT.l_DID = LEFT.DID) and RIGHT.phone != '',
			getEquiFax(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
	//only look for Equifax if we didn't find at LN
	NonLNbutEquifax := JOIN(WithPhoneMart(TRIM(Sources.Source_List) <> ''), foundPhones, 
			LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND 
			LEFT.DID = RIGHT.DID AND
			RIGHT.Gathered_phone = LEFT.Gathered_phone,
					TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, 
						SELF := LEFT), LEFT ONLY, ATMOST(RiskWise.max_atmost));
	//if don't have the right permissions then don't allow
	EquifaxPhones := if(EquifaxAllowed, NonLNbutEquifax, DATASET([], Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus));

	EquifaxPhones_dpd := DEDUP(SORT(EquifaxPhones, Clean_Input.seq, Gathered_Phone, Sources.Source_List,
		- (integer) Sources.Source_List_Last_Seen, 
		- (integer) Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), 
		Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	//resort in case the limit is 1 then take the most recent last seen record
	final := TOPN(EquifaxPhones_dpd, Phone_Shell.Constants.Default_MaxPhones, Clean_Input.seq,Sources.Source_List,
		-Sources.Source_List_Last_Seen, 
		-Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)));
	
	// OUTPUT(final, NAMED('final'));
	// OUTPUT(EquifaxPhones_dpd, NAMED('EquifaxPhones_dpd'));
	// OUTPUT(EquifaxPhones, NAMED('EquifaxPhones'));
	// OUTPUT(CHOOSEN(NonLNbutEquifax, 100), NAMED('NonLNbutEquifax'));
  // OUTPUT(CHOOSEN(WithPhoneMart, 100), NAMED('WithPhoneMart'));
	// output(foundPhones, named('foundPhones'));

	RETURN(final);
END;