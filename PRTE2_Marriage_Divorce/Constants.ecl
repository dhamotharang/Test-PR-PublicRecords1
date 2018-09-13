IMPORT PRTE2_Marriage_Divorce;

EXPORT Constants := MODULE
		
		//Base/Input/Key Prefix
		EXPORT IN_PREFIX 		:= '~prte::in::mar_div::';
		EXPORT BASE_PREFIX	:= '~prte::base::mar_div::';
		EXPORT KEY_PREFIX		:= '~prte::key::mar_div::';
		
		// autokey
		EXPORT	ak_keyname 									:= KEY_PREFIX + 'autokey::';
		EXPORT	ak_logical(string filedate) := KEY_PREFIX + filedate + '::autokey::';
		EXPORT	ak_qa_keyname 							:= KEY_PREFIX + 'qa::autokey::';
		EXPORT	ak_skipSet	:= ['P','S','B','Q','F'];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

		EXPORT ak_typeStr := 'BC';
		
	//DF-21803:FCRA Consumer Data Fields Depreciation
		EXPORT key_main_id := 'divorce_docket_volume,divorce_filing_dt,filing_subtype,grounds_for_divorce,marriage_docket_volume,marriage_duration,' +
																								'marriage_duration_cd,marriage_filing_dt,number_of_children,place_of_marriage,type_of_ceremony';
																				
		EXPORT key_search_id := 'age,birth_state,how_marriage_ended,last_marriage_end_dt,party_county,previous_marital_status,race,times_married,title';
		
		
END;