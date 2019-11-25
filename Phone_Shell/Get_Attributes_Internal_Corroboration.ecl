/* ************************************************************************
 * 		 This function gathers the Internal_Corroboration attributes.				*
 ************************************************************************ */

IMPORT Phonesplus_v2, Phone_Shell, RiskWise, UT, STD, Doxie, Suppress;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Internal_Corroboration (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED3 InsuranceVerificationAgeLimit, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	internalVerificationKey := Phonesplus_v2.Keys_Iverification().did_phone.qa;
	
	layoutInternalCorroboration := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		STRING8 dt_last_seen := '';
	END;
	
	{layoutInternalCorroboration, unsigned4 global_sid} getInternalCorroboration(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, internalVerificationKey ri) := TRANSFORM
	SELF.global_sid := ri.global_sid;
		// Only populate these fields if the Insurance "Gateway" is turned on
		InternalVerificationTurnedOn := IF(le.Clean_Input.InsuranceGatewayEnabled, TRUE, FALSE);

		SELF.Internal_Corroboration.Internal_Verification := IF(InternalVerificationTurnedOn, TRUE, FALSE); // We have a hit on this DID/Phone combination
		SELF.Internal_Corroboration.Internal_Verification_First_Seen := IF(InternalVerificationTurnedOn, Phone_Shell.Common.parseDate((STRING)ri.dt_first_ver, TRUE), '');
		SELF.Internal_Corroboration.Internal_Verification_Last_Seen := IF(InternalVerificationTurnedOn, Phone_Shell.Common.parseDate((STRING)ri.dt_last_ver, TRUE), '');
		// All records should for sure have a tie back to the Subject since we are searching by DID/Phone, so just add the other type in
		// Rec_Type: 1 = Subject, 2 = Spouse, 3 = Household
		SELF.Internal_Corroboration.Internal_Verification_Match_Types := MAP(ri.rec_type = 1 AND InternalVerificationTurnedOn => '1,', 
																																				 ri.rec_type = 2 AND InternalVerificationTurnedOn => '1,2,',
																																														 InternalVerificationTurnedOn => '1,3,',
																																																															'');
		SELF.dt_last_seen := IF(InternalVerificationTurnedOn, TRIM((STRING)ri.dt_last_ver), '');
		
		SELF := le;
	END;
	internalCorroborationTemp_unsuppressed := JOIN(Input, internalVerificationKey, LEFT.Clean_Input.DID <> 0 AND TRIM(LEFT.Gathered_Phone) NOT IN ['', '0'] AND
																																KEYED(LEFT.Clean_Input.DID = RIGHT.did AND LEFT.Gathered_Phone = RIGHT.phone), 
																				getInternalCorroboration(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));
	internalCorroborationTemp := Suppress.Suppress_ReturnOldLayout(internalCorroborationTemp_unsuppressed, mod_access, layoutInternalCorroboration);																			
	internalCorroborationFiltered := internalCorroborationTemp ((INTEGER)dt_last_seen >= (INTEGER)(ut.date_math((string)STD.Date.Today(), -1 * InsuranceVerificationAgeLimit)));
	
	internalCorroboration := PROJECT(internalCorroborationFiltered, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF := LEFT));

	RETURN(internalCorroboration);
END;