﻿IMPORT PublicRecords_KEL, PhoneMart;

EXPORT FnRoxie_get_bureau_phones(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput) := FUNCTION

	bureau_phonesearch_tmp := JOIN(PersonInput, PhoneMart.key_phonemart_did,
														KEYED(LEFT.P_LexID = RIGHT.l_did) AND
														(UNSIGNED)((STRING)RIGHT.dt_first_seen)[1..8] < (UNSIGNED)left.P_InpClnArchDt[1..8], // check date
														TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
																			SELF.PhoneVerificationBureau := 
																					MAP(LEFT.P_LexID=0 OR LEFT.P_InpClnPhoneHome='' OR RIGHT.did=0 => '-1',
																							LEFT.P_InpClnPhoneHome = RIGHT.phone 											 => '1',
																																																						'0');			
																			SELF := LEFT),
																			LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT), KEEP(100));
				
	bureau_phonesearch := SORT(bureau_phonesearch_tmp, G_ProcUID, (INTEGER) PhoneVerificationBureau);
	
	bureau_phonesearch_rolled := ROLLUP(bureau_phonesearch, 
														LEFT.G_ProcUID=RIGHT.G_ProcUID, 
														TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
																			SELF.PhoneVerificationBureau := 
																					IF((INTEGER)RIGHT.PhoneVerificationBureau > (INTEGER)LEFT.PhoneVerificationBureau,
																						RIGHT.PhoneVerificationBureau,
																						LEFT.PhoneVerificationBureau),
																			SELF := LEFT));
	
	ds_phoneout := PROJECT(bureau_phonesearch_rolled, 
														TRANSFORM({PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII},
																			SELF := LEFT; 
																			SELF := []));
	
	//We don't need to check DRM 24 for this because we are not exposing the phone, just verifying it.
	RETURN ds_phoneout;
END;