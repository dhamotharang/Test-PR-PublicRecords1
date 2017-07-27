Import STD;
EXPORT Transforms_License := module
	EXPORT Healthcare_shared.Layouts_License.lic_skinny_ranked rank_and_verify_with_ustat_xform(Healthcare_shared.Layouts.layout_licenseinfo L, unsigned2 cfg_grace) := TRANSFORM
		// 65 is grace period for now, change to constant
			isExpired := IF(Healthcare_Shared.Functions.isExpiredWithGraceMonths(REGEXREPLACE('[-]',L.termination_date,''),cfg_grace), TRUE, FALSE);
		SELF.license_rank := MAP(L.licensestatus = 'A' and NOT isExpired =>	1,
														 L.licensestatus = ''  and NOT isExpired =>	2,
														 L.licensestatus = 'T' and NOT isExpired =>	3,
														 L.licensestatus = 'S' and NOT isExpired =>	4,
														 L.licensestatus = 'R' and NOT isExpired =>	5,
														 L.licensestatus = 'I' and NOT isExpired =>	6,
														 L.licensestatus = 'A' and isExpired 		 =>	7,
														 L.licensestatus = ''  and isExpired 		 =>	8,
														 L.licensestatus = 'T' and isExpired 		 =>	9,
														 L.licensestatus = 'S' and isExpired 		 =>	10,
														 L.licensestatus = 'R' and isExpired 		 =>	11,
														 L.licensestatus = 'I' and isExpired 		 =>	12,
														 L.licensestatus = 'D' and NOT isExpired =>	13,
														 L.licensestatus = 'D' and isExpired 		 =>	14, 99);
												 
		verified := MAP(L.licensestatus in ['A','','T'] and NOT isExpired => 8,0);
		restricted := IF(L.licensestatus = 'T',131072,0);										
		suspended := IF(L.licensestatus = 'S',16384,0);
		inactive := IF(L.licensestatus in ['R','I','D'],32768,0);
		expired := IF(isExpired and L.licensestatus in ['','A','T'],65536,0);
		SELF.lic_ustat :=  verified + restricted + suspended + inactive + expired;
		SELF := L;
	END;		
	EXPORT	Healthcare_shared.Layouts_License.lic_skinny_ranked license_score_xform(Healthcare_shared.Layouts_License.parsed_license_layout L,Healthcare_shared.Layouts_License.lic_skinny_ranked R) := TRANSFORM
			// Set NA flags for use in scoring
				lic_num_NA := IF(L.parsed_input_license_num = '',TRUE,FALSE);
				lic_state_NA := IF(L.parsed_input_license_state = '' and L.prac_state = '',TRUE,FALSE);
				lic_type_NA := IF(L.parsed_input_license_type = '' or R.licensetype = '',TRUE,FALSE);
				
			 // Penalty of 5 if a state was passed in from practice address or config file.  Only penalize if it is different than the parsed state result.
				state_sub_penalty := IF(L.parsed_input_license_state = '' and L.prac_State <> '',5,0);

			 // Parsed input license number matches DB lic1_num exactly
				lic_num_EXACT := IF(lic_num_NA = FALSE AND L.parsed_input_license_num = R.licensenumber,TRUE,FALSE);

			 // If the DB lic_1_type is embedded in the parsed lic_num, and the remainder of the parsed lic_num (after removing the type) matches the DB lic1_num, 
						// AND we couldn't initially parse out a lic_type from input
				lic_num_FUZZY := IF(lic_num_NA = FALSE AND REGEXFIND(R.licensetype,L.parsed_input_license_num) AND REGEXREPLACE(R.licensetype,L.parsed_input_license_num,'') = R.licensenumber and lic_type_NA = TRUE,TRUE,FALSE);

			 // Parsed License state matches DB lic1_state exactly OR no parsed state was found and prac state matched DB lic1_state (5 point penalty will apply)
				lic_state_EXACT:= IF((lic_state_NA = FALSE AND L.parsed_input_license_state = R.licensestate) 
													or (lic_state_NA = FALSE and L.parsed_input_license_state = '' and L.prac_state = R.licensestate),TRUE, FALSE);
			 // Parsed License type matches DB lic1_state exactly 
				lic_type_EXACT := IF(lic_type_NA = FALSE AND L.parsed_input_license_type = R.licensetype, TRUE, FALSE);
				lic_type_NOMATCH := IF(lic_type_NA = FALSE AND L.parsed_input_license_type <> R.licensetype,TRUE,FALSE);

			 // Scoring
				score := MAP(lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_EXACT = TRUE 				=> 100 - state_sub_penalty,
										 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 90 - state_sub_penalty,
										 lic_num_FUZZY = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 85 - state_sub_penalty,
										 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NOMATCH = TRUE 			=> 75 - state_sub_penalty,
										 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_EXACT = TRUE 					=> 60 - state_sub_penalty,
										 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_NA = TRUE 							=> 50 - state_sub_penalty,
											0);
			 // Decode for testing/qa purposes only
				score_decode := MAP(lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_EXACT = TRUE	 	=>  'EXACT_EXACT_EXACT',
													 	lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 			=> 'EXACT_EXACT_NA',
														lic_num_FUZZY = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 			=> 'FUZZY_EXACT_NA',
														lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NOMATCH = TRUE =>  'EXACT_EXACT_NOMATCH',
														lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_EXACT = TRUE 			=>  'EXACT_NA_EXACT',
														lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_NA = TRUE					=>  'EXACT_NA_NA',
														 'NoMatch');
				
				SELF.score := score;
				SELF.score_decode := score_decode;
				SELF := L;
				SELF := R;
	END;


	EXPORT Healthcare_shared.layouts_License.layout_std_license_rank rankLicenses(Healthcare_Shared.layouts_commonized.std_record_struct L,unsigned2 cfg_grace,Healthcare_Shared.Layouts.userInputCleanMatch userinput) := TRANSFORM
// 65 is grace period for now, change to constant
			isExpired := IF(Healthcare_Shared.Functions.isExpiredWithGrace(REGEXREPLACE('[-]',L.lic1.lic_end_date,''),cfg_grace), TRUE, FALSE);
		SELF.surrogate_key := L.surrogate_key;
		SELF.license_rank := MAP(L.lic1.lic_status = 'A' and NOT isExpired =>	1,
														 L.lic1.lic_status = ''  and NOT isExpired =>	2,
														 L.lic1.lic_status = 'T' and NOT isExpired =>	3,
														 L.lic1.lic_status = 'S' and NOT isExpired =>	4,
														 L.lic1.lic_status = 'R' and NOT isExpired =>	5,
														 L.lic1.lic_status = 'I' and NOT isExpired =>	6,
														 L.lic1.lic_status = 'A' and isExpired 		 =>	7,
														 L.lic1.lic_status = ''  and isExpired 		 =>	8,
														 L.lic1.lic_status = 'T' and isExpired 		 =>	9,
														 L.lic1.lic_status = 'S' and isExpired 		 =>	10,
														 L.lic1.lic_status = 'R' and isExpired 		 =>	11,
														 L.lic1.lic_status = 'I' and isExpired 		 =>	12,
														 L.lic1.lic_status = 'D' and NOT isExpired =>	13,
														 L.lic1.lic_status = 'D' and isExpired 		 =>	14, 99);			
		SELF.lic_filedate := L.lic_filedate;
		self.msLicense_score := Healthcare_Shared.Functions_Score.licenseScore(l,userinput);
		SELF := L.lic1;

	END;
end;