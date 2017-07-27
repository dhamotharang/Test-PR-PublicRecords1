import Healthcare_Shared,STD,UT; 
export Functions_Score := module
	// alias 
	shared MatchStat := Healthcare_Shared.Layouts.MatchStat;

	EXPORT integer licenseScore(Healthcare_Shared.layouts_commonized.std_record_struct rec,Healthcare_Shared.Layouts.userInputCleanMatch userinput) := function
				input_lic_num := userinput.license_number;
				input_lic_state := IF(userinput.license_state <> '', userinput.license_state, userinput.st);
				input_lic_type := userinput.license_type;
				input_prac_state := userinput.st;
				
				rawRec_lic_num := rec.Lic1.lic_num;
				rawRec_lic_state := rec.Lic1.lic_state;
				rawRec_lic_type := rec.Lic1.lic_type;
				rawRec_prac_state:= rec.prac1.state;
			// Set NA flags for use in scoring	
				lic_num_NA := IF(input_lic_num = '',TRUE,FALSE);
				lic_state_NA := IF(input_lic_state = '' and input_prac_state = '',TRUE,FALSE);
				lic_type_NA := IF(input_lic_type = '',TRUE,FALSE);
				
			 // Penalty of 5 if a state was passed in from practice address or config file.  Only penalize if it is different than the parsed state result.
				state_sub_penalty := IF(input_lic_state = '' and input_prac_state <> '',5,0);

			 // Parsed input license number matches DB lic1_num exactly
				lic_num_EXACT := IF(lic_num_NA = FALSE AND input_lic_num = rawRec_lic_num,TRUE,FALSE);

			 // If the DB lic_1_type is embedded in the parsed lic_num, and the remainder of the parsed lic_num (after removing the type) matches the DB lic1_num, 
						// AND we couldn't initially parse out a lic_type from input
				lic_num_FUZZY := IF(lic_num_NA = FALSE AND REGEXFIND(rawRec_lic_type,input_lic_num) AND REGEXREPLACE(rawRec_lic_type,input_lic_num,'') = rawRec_lic_num and lic_type_NA = TRUE,TRUE,FALSE);

			 // Parsed License state matches DB lic1_state exactly OR no parsed state was found and prac state matched DB lic1_state (5 point penalty will apply)
				lic_state_EXACT:= IF((lic_state_NA = FALSE AND input_lic_state = rawRec_lic_state) 
													or (lic_state_NA = FALSE and input_lic_state = '' and input_prac_state = rawRec_lic_state),TRUE, FALSE);
			 // Parsed License type matches DB lic1_state exactly 
				lic_type_EXACT := IF(lic_type_NA = FALSE AND input_lic_type = rawRec_lic_type, TRUE, FALSE);
				lic_type_NOMATCH := IF(lic_type_NA = FALSE AND input_lic_type <> rawRec_lic_type,TRUE,FALSE);

			 // Scoring
				return MAP(lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_EXACT = TRUE 				=> 100 - state_sub_penalty,
											 		 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 90 - state_sub_penalty,
													 lic_num_FUZZY = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 85 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NOMATCH = TRUE 			=> 75 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_EXACT = TRUE 					=> 60 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_NA = TRUE 							=> 50 - state_sub_penalty,
													 0);
	end;
	EXPORT Healthcare_Shared.Layouts.MatchStat matchLicense(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
			ds := PROJECT(rec.RecordsRaw,transform(MatchStat,
				input_lic_num := rec.userinput.license_number;
				input_lic_state := IF(rec.userinput.license_state <> '', rec.userinput.license_state, rec.userinput.st);
				input_lic_type := rec.userinput.license_type;
				input_prac_state := rec.userinput.st;
				
				rawRec_lic_num := LEFT.Lic1.lic_num;
				rawRec_lic_state := LEFT.Lic1.lic_state;
				rawRec_lic_type := LEFT.Lic1.lic_type;
				rawRec_prac_state:= LEFT.prac1.state;
			// Set NA flags for use in scoring	
				lic_num_NA := IF(input_lic_num = '',TRUE,FALSE);
				lic_state_NA := IF(input_lic_state = '' and input_prac_state = '',TRUE,FALSE);
				lic_type_NA := IF(input_lic_type = '',TRUE,FALSE);
				
			 // Penalty of 5 if a state was passed in from practice address or config file.  Only penalize if it is different than the parsed state result.
				state_sub_penalty := IF(input_lic_state = '' and input_prac_state <> '',5,0);

			 // Parsed input license number matches DB lic1_num exactly
				lic_num_EXACT := IF(lic_num_NA = FALSE AND input_lic_num = rawRec_lic_num,TRUE,FALSE);

			 // If the DB lic_1_type is embedded in the parsed lic_num, and the remainder of the parsed lic_num (after removing the type) matches the DB lic1_num, 
						// AND we couldn't initially parse out a lic_type from input
				lic_num_FUZZY := IF(lic_num_NA = FALSE AND REGEXFIND(rawRec_lic_type,input_lic_num) AND REGEXREPLACE(rawRec_lic_type,input_lic_num,'') = rawRec_lic_num and lic_type_NA = TRUE,TRUE,FALSE);

			 // Parsed License state matches DB lic1_state exactly OR no parsed state was found and prac state matched DB lic1_state (5 point penalty will apply)
				lic_state_EXACT:= IF((lic_state_NA = FALSE AND input_lic_state = rawRec_lic_state) 
													or (lic_state_NA = FALSE and input_lic_state = '' and input_prac_state = rawRec_lic_state),TRUE, FALSE);
			 // Parsed License type matches DB lic1_state exactly 
				lic_type_EXACT := IF(lic_type_NA = FALSE AND input_lic_type = rawRec_lic_type, TRUE, FALSE);
				lic_type_NOMATCH := IF(lic_type_NA = FALSE AND input_lic_type <> rawRec_lic_type,TRUE,FALSE);

			 // Scoring
				self.score :=  MAP(lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_EXACT = TRUE 				=> 100 - state_sub_penalty,
											 		 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 90 - state_sub_penalty,
													 lic_num_FUZZY = TRUE AND lic_state_EXACT = TRUE AND lic_type_NA = TRUE 					=> 85 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_EXACT = TRUE AND lic_type_NOMATCH = TRUE 			=> 75 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_EXACT = TRUE 					=> 60 - state_sub_penalty,
													 lic_num_EXACT = TRUE AND lic_state_NA = TRUE AND lic_type_NA = TRUE 							=> 50 - state_sub_penalty,
													 0);
				SELF.matchType := -1;
				SELF.fuzzyInfo := -1;
				SELF.numPossibleFatFingers := -1;
				SELF.extendedInfo := -1;));
		return sort(ds,-score)[1];
		end;

		EXPORT MAC_Match(function_name, childset, child_fieldname, input_fieldname) := MACRO
	
		EXPORT Healthcare_Shared.Layouts.MatchStat function_name(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function

			ds := project(rec.childset(child_fieldname != ''), transform(Healthcare_Shared.Layouts.MatchStat, self := Healthcare_Shared.Functions.getMatchStat(rec.input_fieldname, left.child_fieldname)));
			ds_sorted := sort(ds, -score);
			return ds_sorted[1];
		end;
		
	endmacro;
	/* example: 
	MAC_Match(MatchNpi, npis, npi, npi); 
			expands to:

	shared MatchStat MatchNpi(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		ds := project(rec.npis(npi != ''), transform(MatchStat, self := getMatchStat(rec.userinput.npi, left.npi)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	*/
	// Generate some simple matching functions from macro template above...
	MAC_Match(MatchDea, RecordsRaw, dea1.dea_num, userinput.DEA);
	MAC_Match(MatchNcpdp, RecordsRaw, ncpdp_id, userinput.NCPDPNumber);
	MAC_Match(MatchDob, RecordsRaw, birthdate, userinput.DOB);
	MAC_Match(MatchNpi, RecordsRaw, npi_num, userinput.NPI);
	MAC_Match(MatchSsn, ssns, ssn, userinput.ssn);
	MAC_Match(MatchTin, RecordsRaw, tin1.tin, userinput.taxid);
	MAC_Match(MatchUpin, RecordsRaw, upin, userinput.upin);
	MAC_Match(MatchTaxonomy, RecordsRaw, taxonomy, userinput.Taxonomy1Verification);
	MAC_Match(MatchCLIA, RecordsRaw, clia_num, userinput.CLIANumber);
	MAC_Match(MatchMedicare, RecordsRaw, medicare_fac_num, userinput.MedicareNumber);
	MAC_Match(MatchMedicaid, RecordsRaw, medicaid_fac_num, userinput.MedicaidNumber);
	MAC_Match(MatchMedSchool, RecordsRaw, medschool1.medschool, userinput.MedicalSchoolNameVerification);

	
	EXPORT MatchStat ScorePhone(string phone1, string phone2) := function
		MatchStat createRow := TRANSFORM
			self.score									:= map(phone1='' or phone2=''     => 0, 
																				 phone1 = phone2 						=> 100,	// exact phone match
																				 phone1[3..] = phone2[3..] 	=> 99, 	// all but area code
																				 0);																// default
																				 
			self.matchType							:= map(	self.score = 100 	=> Healthcare_Shared.Constants.MatchType.MT_EXACT,
																					self.score = 99 	=> Healthcare_Shared.Constants.MatchType.MT_FUZZY,
																					Healthcare_Shared.Constants.MatchType.MT_NO_MATCH); // default
			self.fuzzyInfo							:= 0;
			self.numPossibleFatFingers	:= 0;
			self.extendedInfo 					:= 0;
		end;
		
		return row(createRow);
	end;
	
	MatchStat MatchPhone(Healthcare_Shared.Layouts.CombinedHeaderResults rec, Healthcare_Shared.layouts_commonized.std_record_struct p1) := function
		return ScorePhone(rec.userinput.workphone, p1.prac_phone1.phone);
	end;
	
	MatchStat MatchPhones(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		ds := project(rec.RecordsRaw(prac_phone1.phone<>''), transform(MatchStat, self := MatchPhone(rec, left)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	
	// Name Matching
	MatchStat MatchOneName(Healthcare_Shared.layouts_commonized.std_record_struct n1, Healthcare_Shared.Layouts.userInputCleanMatch userinput) := function

		Healthcare_Shared.Layouts.NameScoreResult match_result := Healthcare_Shared.Functions.NameScoreMatch
												(userinput.name_title, userinput.name_first, userinput.name_middle, userinput.name_last,
												 userinput.name_suffix, userinput.clnName.name_prefered, (integer1)userinput.clnName.name_gender,
												 n1.pre_name, n1.first_name, n1.middle_name, n1.last_name,
												 n1.maturity_suffix, n1.preferred_name, (integer1)n1.gender);
												 
		MatchStat createRow := TRANSFORM
			SELF.score									:= match_result.NameScore;
			SELF.matchType							:= map(	match_result.NameScore = 100 	=> Healthcare_Shared.Constants.MatchType.MT_EXACT,
																					match_result.NameScore > 0 		=> Healthcare_Shared.Constants.MatchType.MT_FUZZY,
																					Healthcare_Shared.Constants.MatchType.MT_NO_MATCH); // default
			SELF.fuzzyInfo							:= 0;
			SELF.numPossibleFatFingers	:= 0;
			SELF.extendedInfo 					:= match_result.NameExtendedMatchInfo;
		end;
		
		return row(createRow);
	end;
	
	MatchStat MatchAllNames(Healthcare_Shared.Layouts.CombinedHeaderResults rec, STRING matchName = '') := FUNCTION
		ds := PROJECT(rec.RecordsRaw, TRANSFORM(MatchStat, 
												bestProcess := matchName <> '';
												SELF := MAP(bestProcess AND LEFT.first_name = matchName => MatchOneName(LEFT, rec.userinput),
															NOT bestProcess => MatchOneName(LEFT, rec.userinput),
															ROW({0,Healthcare_Shared.Constants.MatchType.MT_NO_MATCH,0,0,0},MatchStat))));
		ds_sorted := SORT(ds, -score);
		RETURN ds_sorted[1];
	END;
	
	// Company name matching
	MatchStat MatchOneCompanyName(Healthcare_Shared.Layouts.CombinedHeaderResults rec, Healthcare_Shared.layouts_commonized.std_record_struct n1) := function
	
		score := Healthcare_Shared.Functions.CompareBusinessNameConfidence(rec.userinput.comp_name, n1.prac_company1.company_name); // there is also bill_company_name on input.
												 
		MatchStat createRow := TRANSFORM
			SELF.score									:= score;
			SELF.matchType							:= map(	score = 100 	=> Healthcare_Shared.Constants.MatchType.MT_EXACT,
																					score > 0 		=> Healthcare_Shared.Constants.MatchType.MT_FUZZY,
																					Healthcare_Shared.Constants.MatchType.MT_NO_MATCH); // default
			SELF.fuzzyInfo							:= 0;
			SELF.numPossibleFatFingers	:= 0;
			SELF.extendedInfo 					:= 0;
		end;
		
		return row(createRow);
	end;
	
	MatchStat MatchAllCompanyNames(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		ds := project(rec.RecordsRaw, transform(MatchStat, self := MatchOneCompanyName(rec, left)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	getBusNameUsage(string taxonomy, string filecode) := function
		useThisName := map (taxonomy[1..2] = '25' and filecode[1..3] in ['NPI','MCH', 'OSC', 'LIC']=>'D',
												taxonomy[1..2] = '26' and filecode[1..3] ='MCH'=>'D',
												taxonomy[1..2] = '27' and filecode[1..3] in ['NPI','OSC', 'LIC','DEA']=>'D',
												taxonomy[1..2] = '28' and filecode[1..3] ='FAC_AHD'=>'D',
												taxonomy[1..2] = '29' and filecode[1..3] in ['NPI','OSC','FAC','LIC','DEA']=>'D',
												taxonomy[1..2] = '30' and filecode[1..3] in ['NPI','MCH', 'OSC', 'SKA']=>'D',
												taxonomy[1..2] = '31' and filecode[1..3] in ['NPI','MCH', 'OSC', 'SKA']=>'D',
												//taxonomy[1..2] = '32' and filecode[1..3] in ['NPI','MCH', 'OSC', 'LIC']=>'D'
												taxonomy[1..2] = '33' and filecode[1..3] in ['DEA','MCH', 'NPI', 'SKA']=>'D',
												taxonomy[1..2] = '34' and filecode[1..3] in ['NPI','MCH', 'OSC', 'SKA']=>'D',
												taxonomy[1..2] not in['25','26','27','28','29','30','33','34'] and filecode[1..3] in ['NPI','SKA']=>'D',
												'X');
		return useThisName;
	end;
	
	getNameInfo(DATASET(Healthcare_Shared.layouts_commonized.std_record_struct) allRows, Healthcare_Shared.Layouts.userInputCleanMatch userinput) := FUNCTION
		//Filecodes to ignore (non important sources)
		excludedCodes := ['CMS_PCD',
						  'CMS_ENR',
						  'ABM_IDV',
						  'CAM',
						  ''];
				  
		filteredRows := allRows(filesource = '64' AND filecode NOT IN excludedCodes); //Filter rows to only include filesource 64 and exclude filecodes

		//File sources that should not have duplicates
		excludedDupes := ['CMS_UPIN',
						  'DEA'];

		//Remove duplicate records
		singleUPIN 	:= CHOOSEN(SORT(filteredRows(filecode = 'CMS_UPIN'), -last_update_date),1); //Get most recent CMS_UPIN
		singleDEA 	:= CHOOSEN(SORT(filteredRows(filecode = 'DEA'), -last_update_date),1); 		//Get most recent DEA
		rowsNoDupes := filteredRows(filecode NOT IN excludedDupes);								//Get all records without CMS_UPIN or DEA
		dedupRows 	:= rowsNoDupes + singleUPIN(filecode <> '') + singleDEA(filecode <> ''); 	//Combine to get records without duplicates

		//Get most recent FKA last name and the FKA pair record last name (if there is one)
		fkaRec 	:= SORT(dedupRows(filecode[..3] = 'FKA'), -last_update_date)[1];
		fkaCode := IF(fkaRec.filecode  <> '', fkaRec.filecode,  'NO FKA');
		fkaName := IF(fkaRec.last_name <> '', fkaRec.last_name, 'NO FKA');
		fkaPair := MAP(fkaCode[5..] = 'NPI' => SORT(dedupRows(filecode[..3] = 'NPI'), -last_update_date)[1].last_name,
					   fkaCode[5..] = 'DEA' => SORT(dedupRows(filecode[..3] = 'DEA'), -last_update_date)[1].last_name,
					   'NO FKA');
		
		//Standardize the last names
		lnFKA 	  := STD.Str.ToUpperCase(TRIM(fkaName));
		lnPairFKA := STD.Str.ToUpperCase(TRIM(fkaPair));

		//Filecodes that count as self reported sources
		srSrcFiles := [Healthcare_Shared.SourceTools.set_FC_NPI,
					   Healthcare_Shared.SourceTools.src_CMS_UPIN,
					   Healthcare_Shared.SourceTools.set_License,
					   Healthcare_Shared.SourceTools.set_FKA,
					   Healthcare_Shared.SourceTools.set_DEA];
		
		//Set first name variables
		normRowsFirst := PROJECT(dedupRows, TRANSFORM(Healthcare_Shared.Layouts.NameComplete, 
			SELF.name 			:= STD.Str.ToUpperCase(LEFT.first_name);
			SELF.self_reported 	:= IF(LEFT.filecode IN srSrcFiles OR LEFT.filecode[..3] = 'LIC', LEFT.filecode, '');  
			SELF.isInit 		:= IF(LEFT.first_name[2] = '.' OR LENGTH(LEFT.first_name) < 1, TRUE, FALSE);
			SELF.isBlank 		:= IF(LEFT.first_name = '', TRUE, FALSE);
			SELF 				:= LEFT;
			SELF 				:= [];
		));
		
		//Set middle name variables
		normRowsMiddle := PROJECT(dedupRows, TRANSFORM(Healthcare_Shared.Layouts.NameComplete, 
			SELF.name 		   := STD.Str.ToUpperCase(LEFT.middle_name);
			SELF.self_reported := IF(LEFT.filecode IN srSrcFiles OR LEFT.filecode[..3] = 'LIC', LEFT.filecode, '');
			SELF.isInit 	   := IF(LEFT.middle_name[2] = '.' OR LENGTH(LEFT.middle_name) < 1, TRUE, FALSE);
			SELF.isBlank 	   := IF(LEFT.middle_name = '', TRUE, FALSE);
			SELF 			   := LEFT;
			SELF 			   := [];
		));
		
		//Set last name variables
		normRowsLast := PROJECT(dedupRows, TRANSFORM(Healthcare_Shared.Layouts.NameComplete, 
			SELF.name 		   := STD.Str.ToUpperCase(LEFT.last_name);
			SELF.self_reported := IF(LEFT.filecode IN srSrcFiles OR LEFT.filecode[..3] = 'LIC', LEFT.filecode, '');
			SELF.isInit 	   := IF(LEFT.last_name[2] = '.' OR LENGTH(LEFT.last_name) < 1, TRUE, FALSE);
			SELF.isBlank 	   := IF(LEFT.last_name = '', TRUE, FALSE);
			SELF.fka 		   := IF(LEFT.filecode IN Healthcare_Shared.SourceTools.set_FKA, 1, 0); //last name only
			SELF 			   := LEFT;
			SELF 			   := [];
		));
		
		Healthcare_Shared.Layouts.NameComplete rollit(Healthcare_Shared.Layouts.NameComplete L, dataset(Healthcare_Shared.Layouts.NameComplete) allNames) := TRANSFORM
			self.name := L.name;
			self.cnt := count(allNames); //total count of (first/middle/last) names
			self.cntSR := count(allNames(self_reported <> ''));
			self.cnt_fka := count(allNames(fka > 0));
			self.cnt_full := count(allNames(isInit <> TRUE AND isBlank <> TRUE));
			self.cnt_fullSR := count(allNames(self_reported <> '' AND isInit <> TRUE AND isBlank <> TRUE));;
			SELF := L; //move like-named fields across
		END;
		
		//Sort, Group, and Roll (first/middle/last) by acctno and name
		normFirstName  := ROLLUP(GROUP(SORT(normRowsFirst,		acctno, name), acctno, name), GROUP, rollit(LEFT, ROWS(LEFT)));
		normMiddleName := ROLLUP(GROUP(SORT(normRowsMiddle, 	acctno, name), acctno, name), GROUP, rollit(LEFT, ROWS(LEFT)));
		normLastName   := ROLLUP(GROUP(SORT(normRowsLast,		acctno, name), acctno, name), GROUP, rollit(LEFT, ROWS(LEFT)));

		recDenom   := COUNT(dedupRows); 													//Get total record count
		recDenomSR := COUNT(dedupRows(filecode IN srSrcFiles or filecode[..3] = 'LIC'));	//Get total self reported record count

		//Calculates and returns the aggregate name weight for (first/middle/last) names (all records)
		fnWeight := Healthcare_Shared.Fn_do_CalculateNameScore.aggWeight(normFirstName,		recDenom, recDenomSR, 'No FKA');
		mnWeight := Healthcare_Shared.Fn_do_CalculateNameScore.aggWeight(normMiddleName, 	recDenom, recDenomSR, 'No FKA');
		lnWeight := Healthcare_Shared.Fn_do_CalculateNameScore.aggWeight(normLastName, 		recDenom, recDenomSR, lnFKA);

		//Get favorite names by priority of weight, self reported, and then length
		fnFav 	:= SORT(fnWeight, -weight, -cntSR, -LENGTH(name))[1];
		mnFav 	:= SORT(mnWeight, -weight, -cntSR, -LENGTH(name))[1];
		lnFav 	:= SORT(lnWeight, -weight, -cntSR, -LENGTH(name))[1];
		mnFavSR := IF(mnFav.cntSR > 0, 'Y', 'N'); //Is the favorite middle name self reported?

		getNames := PROJECT(dedupRows, TRANSFORM(Healthcare_Shared.Layouts.layout_nameinfo, 
			validGender   := LEFT.gender IN ['0','1','2','3','4','5'];
			isBus		  := LENGTH(TRIM(LEFT.prac_company1.company_name, LEFT, RIGHT)) > 0;
			useBusName 	  := LEFT.prac_company1.company_name;
			isBusNameBest := 'P';
			
			preferredFilecode := LEFT.filecode IN Healthcare_Shared.SourceTools.set_NPI;
			conf := Healthcare_Shared.Functions.CompareBusinessNameConfidence(useBusName, userinput.comp_name);
			BusConf := IF(isBus, IF(preferredFilecode, conf*1.25, conf*.75), 0);
						   
			//Give score based on source of name
			sourceScore := MAP(LEFT.filecode[..3] = 'LIC' => 90,
							   LEFT.filecode IN [Healthcare_Shared.SourceTools.set_FC_NPI, Healthcare_Shared.SourceTools.src_CMS_UPIN]       => 90,
							   LEFT.filecode IN [Healthcare_Shared.SourceTools.set_INACT_ENC, Healthcare_Shared.SourceTools.set_CHOICEPOINT] => 40,
							   LEFT.filecode IN [Healthcare_Shared.SourceTools.set_SKA]  => 50,
							   LEFT.filecode IN [Healthcare_Shared.SourceTools.set_DEA]  => 25,
							   LEFT.filecode = Healthcare_Shared.SourceTools.src_FKA_NPI => 25,
							   LEFT.filecode = Healthcare_Shared.SourceTools.src_FKA_DEA => 10,
							   75);
			
			//Calculate the weight for (first/middle/last) name (per record)
			fnScore :=   Healthcare_Shared.Fn_do_CalculateNameScore.calcWeight(normFirstName, 	STD.Str.ToUpperCase(left.first_name), 	recDenom, recDenomSR, 'No FKA');
			mnScore :=   Healthcare_Shared.Fn_do_CalculateNameScore.calcWeight(normMiddleName, 	STD.Str.ToUpperCase(left.middle_name), 	recDenom, recDenomSR, 'No FKA');
			lnScore :=   Healthcare_Shared.Fn_do_CalculateNameScore.calcWeight(normLastName, 	STD.Str.ToUpperCase(left.last_name), 	recDenom, recDenomSR, lnFKA);	
			
			//Final weight calculations for first name
			fnFinalScore := PROJECT(fnScore, TRANSFORM(Healthcare_Shared.Layouts.NameComplete, 
				//Standardize input
				trimInputName 	 := STD.Str.ToUpperCase(TRIM(LEFT.name,  RIGHT));
				trimFavoriteName := STD.Str.ToUpperCase(TRIM(mnFav.name, RIGHT));
						
				//Flags used to determine deductions
				isFavNameSR 	  := IF(mnFavSR = 'Y',  TRUE, FALSE);
				isSelfReported 	  := IF(LEFT.cntSR > 0, TRUE, FALSE);
				hasMultipleTokens := STD.Str.WordCount(trimInputName) > 1;
				hasFavorite 	  := STD.Str.Contains(trimInputName, trimFavoriteName, TRUE);
				hasHyphen 		  := STD.Str.Contains(trimInputName, '-',			   TRUE);
				
				//Deductions
				scoreAdj1 := IF(NOT isSelfReported, 25, 0);
				scoreAdj2 := IF(NOT isSelfReported AND hasMultipleTokens, 25, 0);
				scoreAdj3 := IF(NOT isSelfReported AND hasFavorite, 25, 0);
				scoreAdj4 := IF(isSelfReported AND hasFavorite AND isFavNameSR AND isFavNameSR > isSelfReported, 25, 0);	
				scoreAdj5 := IF(isSelfReported AND hasMultipleTokens AND hasFavorite AND isFavNameSR AND NOT hasHyphen, 25, 0);
				scoreAdj  := (scoreAdj1 + scoreAdj2 + scoreAdj3 + scoreAdj4 + scoreAdj5)/100;
				
				//Apply final weight deductions/adjustments
				SELF.qa_adj1	 := scoreAdj1;
				SELF.qa_adj2	 := scoreAdj2;
				SELF.qa_adj3 	 := scoreAdj3;
				SELF.qa_adj4	 := scoreAdj4;
				SELF.qa_adj5 	 := scoreAdj5;
				SELF.finalWeight := TRUNCATE(LEFT.weight * (1-scoreAdj));
				SELF 			 := LEFT;
			));
				
			//Final weight calculations for middle name
			mnFinalScore := PROJECT(mnScore, TRANSFORM(Healthcare_Shared.Layouts.NameComplete,
				//Apply final weight deductions/adjustments
				SELF.finalWeight := LEFT.weight;
				SELF 			 := LEFT;
			));
			
			//Final weight calculations for last name
			lnFinalScore := PROJECT(lnScore, TRANSFORM(Healthcare_Shared.Layouts.NameComplete,
				finalWeight := IF(LEFT.name = lnPairFKA, 100, LEFT.weight); //If name matches pair FKA name, increase weight
				
				//Alpha only
				nameClean := Healthcare_Shared.Functions.cleanOnlyCharacters(LEFT.name);
				favClean  := Healthcare_Shared.Functions.cleanOnlyCharacters(lnFav.name);
				
				//Apply final weight deductions/adjustments
				SELF.finalWeight := IF(nameClean = favClean OR finalWeight = lnWeight(name = lnFav.name)[1].weight, finalWeight, 0);
				SELF 			 := LEFT;
			));
			
			//Get complete score
			completeScore  := Healthcare_Shared.Fn_do_CalculateNameScore.getCompleteNameScore(left.pre_name,left.first_name,left.middle_name,left.last_name,left.maturity_suffix,left.other_suffix);
			
			//Calculate composite score (average)
			compositeScore := (fnFinalScore[1].finalWeight + mnFinalScore[1].finalWeight + lnFinalScore[1].finalWeight)/3;
			
			//Aggregate weight calculations
			SELF.qa_fnWeight 		:= fnWeight;
			SELF.qa_mnWeight 		:= mnWeight;
			SELF.qa_lnWeight		:= lnWeight;
			
			//FKA names
			SELF.qa_lnFKA 	 		:= lnFKA;
			SELF.qa_lnPairFKA 		:= lnPairFKA;
			
			//Favorite names
			SELF.qa_fnFavName 		:= fnFav.name;
			SELF.qa_mnFavName 		:= mnFav.name;
			SELF.qa_lnFavName 		:= lnFav.name;
			SELF.qa_mnFavSR   		:= mnFavSR;
			
			//Final Scores
			//SELF.qa_adj1 			:= fnFinalScore[1].qa_adj1;
			//SELF.qa_adj2 			:= fnFinalScore[1].qa_adj2;
			//SELF.qa_adj3 			:= fnFinalScore[1].qa_adj3;
			//SELF.qa_adj4 			:= fnFinalScore[1].qa_adj4;
			//SELF.qa_adj5 			:= fnFinalScore[1].qa_adj5;
			SELF.source 			:= LEFT.filecode;
			SELF.fScore 			:= fnFinalScore[1].finalWeight;
			SELF.mScore 			:= mnFinalScore[1].finalWeight;
			SELF.lScore 			:= lnFinalScore[1].finalWeight;
			SELF.compositeScore 	:= compositeScore;
			SELF.completeScore  	:= completeScore;
			SELF.sourceScore		:= sourceScore;
			SELF.nameBusConfidence	:= busConf;
			SELF.Gender 			:= MAP((INTEGER)LEFT.Gender IN [1,2] => 'Male',
										   (INTEGER)LEFT.Gender IN [4,5] => 'Female',
											'');
			SELF.GenderCd 			:= IF(validGender, (INTEGER)LEFT.Gender, 0);
			SELF.male_female 		:= IF(validGender, LEFT.male_female, '');
			SELF.nameKey 			:= LEFT.name_key;
			SELF.FullName 			:= LEFT.full_name;
			SELF.Title 				:= LEFT.pre_name;
			SELF.FirstName 			:= LEFT.first_name;
			SELF.PreferredFirst		:= LEFT.preferred_name;
			SELF.MiddleName 		:= LEFT.middle_name;
			SELF.LastName 			:= LEFT.last_name;
			SELF.Suffix 			:= LEFT.maturity_suffix;
			SELF.Prof_Suffix 		:= LEFT.other_suffix;
			SELF.BusNameBest		:= isBusNameBest;
			SELF.CompanyName 		:= useBusName;
			SELF.name_stat 			:= LEFT.name_st;
			SELF.Company_stat 		:= LEFT.prac_company1.company_st;
			SELF.Gender_stat 		:= LEFT.male_female_st;
			SELF.sources 			:= DATASET([{LEFT.filesource, LEFT.filecode}], Healthcare_Shared.Layouts.layout_FileSource);
			SELF 					:= LEFT;
		));
		
		getDBANames := PROJECT(allRows(dba_name <> ''), TRANSFORM(Healthcare_Shared.Layouts.layout_nameinfo, 
			useBusName 		  := IF(LEFT.dba_name <> '', LEFT.dba_name, LEFT.prac_company1.company_name);
			isBusNameBest 	  := getBusNameUsage(LEFT.taxonomy, LEFT.filecode);
			preferredFilecode := LEFT.filecode IN Healthcare_Shared.SourceTools.set_NPI;
			conf 			  := Healthcare_Shared.Functions.CompareBusinessNameConfidence(useBusName, userinput.comp_name);
			BusConf 		  := IF(useBusName <> '' OR isBusNameBest = 'D', IF(preferredFilecode, conf * 1.25, conf * .75), 25);
			
			SELF.nameConfidence    := 0;
			SELF.nameBusConfidence := busConf;
			SELF.CompanyName 	   := useBusName;
			SELF.BusNameBest	   := isBusNameBest;
			SELF.isDBAName 		   := TRUE;
			SELF.Company_stat 	   := LEFT.dba_st;
			SELF.sources 		   := DATASET([{LEFT.filesource,LEFT.filecode}], Healthcare_Shared.Layouts.layout_FileSource);
			SELF 				   := LEFT;
		));
												 
		getBillingNames:=project(allRows(bill_company1.company_name <> ''), TRANSFORM(Healthcare_Shared.Layouts.layout_nameinfo, 
			useBusName 		  := LEFT.bill_company1.company_name;
			preferredFilecode := LEFT.filecode IN Healthcare_Shared.SourceTools.set_NPI;
			conf 			  := Healthcare_Shared.Functions.CompareBusinessNameConfidence(useBusName, userinput.comp_name);
			BusConf 		  := IF(preferredFilecode, conf * 1.25, conf * .75);
			
			SELF.nameConfidence    := 0;
			SELF.nameBusConfidence := busConf;
			SELF.CompanyName 	   := useBusName;
			SELF.BusNameBest	   := 'B';
			SELF.isBillingName	   := TRUE;
			SELF.Company_stat 	   := LEFT.bill_company1.company_st;
			SELF.sources 		   := DATASET([{LEFT.filesource, LEFT.filecode}], Healthcare_Shared.Layouts.layout_FileSource);
			SELF 				   := LEFT;
		));

		//grpNames := group(sort(getNames+getDBANames+getBillingNames,acctno,InternalID,CompanyName,-nameBusConfidence,FirstName,MiddleName,LastName,Suffix,Prof_Suffix,Title,-nameConfidence),acctno,InternalID,CompanyName,FirstName,MiddleName,LastName,Suffix,Prof_Suffix,Title);
		apdNames := getNames + getDBANames + getBillingNames;
		srtNames := SORT(apdNames, acctno, InternalID, CompanyName, FirstName, MiddleName, LastName, Suffix, Prof_Suffix, Title);
		grpNames := GROUP(srtNames, acctno, InternalID, CompanyName, FirstName, MiddleName, LastName, Suffix, Prof_Suffix, Title); 			
		
		//Sort by score and best score and Dedupe Name and rollup gender and other flags.
		Healthcare_Shared.Layouts.layout_nameinfo rollUnique(Healthcare_Shared.Layouts.layout_nameinfo L, DATASET(Healthcare_Shared.Layouts.layout_nameinfo) allRows) := TRANSFORM
			allNames   := SORT(allrows, -nameBusConfidence, IF(EXISTS(sources(filecode[1..7]='FKA_NPI')), 1, 0), -nameConfidence);
			indivScore := MAX(allNames, nameConfidence);
			busScore   := MAX(allNames, nameBusConfidence);
			
			SELF.nameConfidence    := indivScore;
			SELF.nameBusConfidence := busScore;
			SELF.nameBest 		   := MAX(allNames, nameBest);
			SELF.nameKey 		   := allNames(nameKey <> '')[1].nameKey;
			SELF.FullName 		   := allNames(FullName <> '')[1].FullName;
			SELF.PreferredFirst    := allNames(PreferredFirst <> '')[1].PreferredFirst;
			SELF.Gender 		   := allNames(Gender <> '')[1].Gender;
			SELF.GenderCd 		   := allNames(GenderCd > 0)[1].GenderCd;
			SELF.male_female 	   := allNames(male_female <> '')[1].male_female;
			SELF.isDBAName 		   := EXISTS(allNames(isDBAName = TRUE));
			SELF.isBillingName 	   := EXISTS(allNames(isBillingName = TRUE));
			SELF.FacilityType 	   := allNames(FacilityType <> '')[1].FacilityType;
			SELF.FacilityType_stat := MAX(allNames, FacilityType_stat);
			SELF.last_update_date  := SORT(allNames(last_update_date <> '' AND (INTEGER)last_update_date > 0), last_update_date)[1].last_update_date;
			SELF.name_stat 	 	   := SORT(allNames, -name_stat)[1].name_stat;
			SELF.Company_stat 	   := SORT(allNames, -Company_stat)[1].Company_stat;
			SELF.Gender_stat 	   := SORT(allNames, -Gender_stat)[1].Gender_stat;
			SELF.Provider_stat 	   := SORT(allNames, -Provider_stat)[1].Provider_stat;
			SELF.sources 	  	   := DEDUP(NORMALIZE(allRows, L.Sources, TRANSFORM(Healthcare_Shared.Layouts.layout_FileSource, SELF := RIGHT)), RECORD, ALL);
			SELF 				   := L; //Move like-named fields across
		END;
		
		rollNames := ROLLUP(grpNames, GROUP, rollUnique(LEFT, ROWS(LEFT)));
		
		//RETURN SORT(rollNames, acctno, -nameConfidence, -nameBest);
		RETURN SORT(apdNames, acctno, -nameConfidence, -nameBest);
	END; //END getNameInfo
	
	export Healthcare_Shared.Layouts.score_result score_person(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := transform
		nameInfo 					:= getNameInfo(rec.RecordsRaw, rec.userinput);
		bestName 					:= SORT(nameInfo, -compositeScore, -completeScore, -LENGTH(firstname), -LENGTH(middlename), -sourceScore, lastname, firstname, middlename)[1];
		self.acctno 				:= rec.acctno;
		self.internalid				:= rec.internalid;
		self.bestName 	  			:= bestName; // was supposed to be sorted to top. This kind of bugs me. How do I know it was done properly by the caller?
		self.allNames				:= nameInfo;
		self.msPracAddr				:= [];
		self.msBillAddr				:= [];
		self.msCompany				:= MatchAllCompanyNames(rec); //uses CompareBusinessNameConfidence 
		self.msDea					:= MatchDea(rec);
		self.msNcpdp				:= MatchNcpdp(rec);
		self.msLicense				:= MatchLicense(rec);
		self.msAuthorityLicense		:= [];
		self.msBestName				:= MatchAllNames(rec,BestName.FirstName);
		self.msClosestName			:= MatchAllNames(rec);
		self.msNPI					:= MatchNpi(rec);
		self.msCLIA					:= MatchCLIA(rec);
		self.msMedSchool			:= [];
		self.msPhone				:= MatchPhones(rec);
		self.msSsn					:= MatchSsn(rec);
		self.msTin					:= MatchTin(rec);
		self.msUpin					:= MatchUpin(rec);
		self.msTaxonomy				:= MatchTaxonomy(rec);
		self.msMedicareFacNum		:= MatchMedicare(rec);
		self.msDob					:= MatchDob(rec);
	
		self.bConfirmedCallReturnId 		:= false; // TODO
		self.bConfirmedCompanyName			:= false;	// TODO
		self.bConfirmedDea					:= self.msDea.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedNcpdp				:= self.msNcpdp.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedLicense 				:= false; // TODO
		self.bConfirmedLicenseAuthority 	:= false; // TODO
		self.bConfirmedMedSchool 			:= self.msMedSchool.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedNpi 					:= self.msNpi.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedOccupation 			:= false; // TODO
		self.bConfirmedPhone 				:= self.msPhone.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedSsn 					:= self.msSsn.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedTin 					:= self.msTin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedUpin 				:= self.msUpin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bLicenseStatusConflict 		:= false; // TODO
		self.bOccupationConflict 			:= false; // TODO
		
		// Demographic score
		self.demoScore := map(self.msDob.score >= 80		=>	80,
							  self.msMedSchool.score = 100 	=>	60,
							  0); //default
	
		// Compute Firmagraphic score
		self.firmaExact := if(self.msPracAddr.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) +
						   if(self.msBillAddr.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) +
						   if(self.msCompany.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) +
						   if(self.msPhone.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) +
						   if(self.msTin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0);
		
		self.firmaScore := map(self.firmaExact > 1	=> 100,
							   self.firmaExact > 0 => 80,
							   0); //default
														
		// Compute Geographic Score												
		self.geoScore := max(self.msPracAddr.score, self.msBillAddr.score);
		
		// Compute Type1 score. (Type1 ids are the "belly button" type provider identifiers.)
		self.type1Exact	:= if(self.bConfirmedDea, 1, 0) +
													if (self.bConfirmedNcpdp, 1, 0) +
													if (self.bConfirmedLicense, 1, 0) +
													if (self.bConfirmedNpi, 1, 0) +
													if (self.bConfirmedSsn, 1, 0)	+
													if (self.bConfirmedUpin, 1, 0);
												
		self.type1Misses := if(self.msDea.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
							if(self.msNcpdp.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
							if(self.msLicense.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
							if(self.msNpi.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
							if(self.msSsn.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
							if(self.msUpin.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0);
													
		self.type1Score	:= map(self.type1Exact > 1 	=> 100,
							   self.type1Exact = 1  => 80,
							   0); // default


		self.OccupationScore := 33; // TODO
				
		self.best_nmxi 		:= Healthcare_Shared.Functions.GetNameExtendedMatchInfo(self.msBestName.extendedInfo);
		self.closest_nmxi	:= Healthcare_Shared.Functions.GetNameExtendedMatchInfo(self.msClosestName.extendedInfo);
	
		// alias some constants for readability
		NoWay 					:= Healthcare_Shared.Constants.NameScoreStrength.NoWay;
		VeryWeak 				:= Healthcare_Shared.Constants.NameScoreStrength.VeryWeak;
		Weak 					:= Healthcare_Shared.Constants.NameScoreStrength.Weak;
		Strong 					:= Healthcare_Shared.Constants.NameScoreStrength.Strong;
		VeryStrong 				:= Healthcare_Shared.Constants.NameScoreStrength.VeryStrong;
		best_nmxi				:= self.best_nmxi;
		closest_nmxi			:= self.closest_nmxi;
		best_name_strength		:= self.best_nmxi.strength;
		closest_name_strength 	:= self.closest_nmxi.strength;

		
		boolean bSuspectScrambledName := (best_name_strength <= VeryWeak
										  AND (closest_name_strength >= Weak OR best_nmxi.stuff_was_transposed
											   OR best_nmxi.name_rearrangement_match OR closest_nmxi.name_rearrangement_match
											   OR best_nmxi.name_rearrangement_fuzzy_match OR closest_nmxi.name_rearrangement_fuzzy_match));

		// Need a temp record to store 2 part result (matchrule, score) from rules map
		rule_score_rec := record
			integer matchrule := 0;
			real score := 0.0;
		end;

		rule_score_rec create_row(irule, iscore) := transform
			self.matchrule := irule;
			self.score := iscore;
		end;

		rule_score(irule, iscore) := row(create_row(irule, iscore));
		
		boolean bRefSourcing := false; // need to avoid some rules.
		boolean bFuzzyPracAddr := false; // TODO
		
		// Assign rules and compute final score.
		rule_score_rec rule_score_result := map (
		
				//
				// 1000 series rules deal with type1 ISN matches
				//
				
				// More than 1 type1 ISN matches and the name is better than Weak
				// 100.
				(self.type1Score = 100 AND best_name_strength >= Weak)	
					=> rule_score(1001, 100),
				
				// Type 1 ISN(s) and "BestName" is acceptable.	
				(self.type1Score >= 80 AND best_name_strength >= Weak)	
				// [86 .. 96]
					=> rule_score(1002, 86.0 
															+ (self.msClosestName.score * 0.1)					// 0 - 5 name bonus
												),
												
				// Type1 ISN matches with poor "BestName" match, but "ClosestName" is good.
				(self.type1Exact > 0 AND best_name_strength <= VeryWeak AND closest_name_strength >= Strong)	
				// [86 .. 97.2]
					=> rule_score(1003, 86 
															+	if(self.type1Exact > 1, 5, 0)							// 0 - 5		more than 1 type1 exacts
															+ ((self.msClosestName.score - 69) * 0.1)		// 0 - 6.2	name bonus
												),																								// 0 - 11.2
												
				// Type 1 ISN matches with poor "BestName" match, but we suspect the name is scrambled.
				(self.type1Exact > 0 AND best_name_strength <= VeryWeak AND bSuspectScrambledName AND closest_name_strength > NoWay)	
				// [86 .. 96]
					=> rule_score(1004, 86 															
															+ (self.msClosestName.score * 0.1)					// 0 - 10	name bonus
												),					
												
				//  Type1 ISN matches with female first name match, no middle name conflict, but last conflict and strong DOB.
				(self.type1Exact > 0 AND best_name_strength <= VeryWeak AND best_nmxi.first_name_match AND best_nmxi.last_name_conflict 
														 AND best_nmxi.middle_name_conflict = false AND self.msDob.score >= 80)
				// [75 .. 85]
					=> rule_score(1005, 75 															
															+ (self.msDob.score * .05)					// 0 - 5	dob bonus
															+ ((self.type1Exact-1) * .05)				// 0 - 5	multiple type1 bonuses
												),																				// 0 - 10
												
				//  Type1 ISN matches with poor "BestName" match, but no scrambled name indicator
				(self.type1Exact > 0 AND best_name_strength <= VeryWeak AND closest_name_strength > NoWay)
				// [76 .. 86]
					=> rule_score(1007, 76 															
															+ (self.msClosestName.score * .1)		// 0 - 10	name bonus
												),		
				//
				// 2000 series rules deal with geographics
				//
				
				//  Strong Geographic and Strong Name
				(self.geoScore >= 99 AND (best_name_strength >= Strong OR closest_name_strength >= VeryStrong) AND best_nmxi.maturity_suffix_conflict = false)
				// [86 .. 95.1]
					=> rule_score(2000, 86.0															
															+ ((self.msBestName.score - 69) * .1)						// 0 - 3.1	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.firmaScore * .025)											// 0 - 2.5	firma
															+ (self.geoScore - 99 )													// 0 - 2.5	geo bonus
												),																										// 0 - 9.1 	total
												
				//  Strong Geographic and Strong FKA Name
				(self.geoScore >= 99 AND closest_nmxi.fka_name_match AND closest_name_strength >= Strong AND best_nmxi.maturity_suffix_conflict = false)
				// [86 .. 95.1]
					=> rule_score(2100, 86.0															
															+ ((self.msClosestName.score - 69) * .1)				// 0 - 3.1	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.firmaScore * .025)											// 0 - 2.5	firma
															+ (self.geoScore - 99 )													// 0 - 2.5	geo bonus
												),																										// 0 - 9.1 	total												
												
				//  Geo strong enough to consider that a correction may in the works and strong name.
				(self.geoScore >= 90 AND self.geoScore < 99 AND best_name_strength >= Strong AND best_nmxi.maturity_suffix_conflict = false)
				// [84 .. 95.2]
					=> rule_score(2001, 84.0															
															+ ((self.msBestName.score - 69) * .2)						// 0 - 6.2	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.firmaScore * .025)											// 0 - 2.5	firma
															- if (self.bOccupationConflict, 10, 0)
															- if (self.type1Misses > 0, 5, 0)
												),																																					
									
				//  as above, but with FKA
				(self.geoScore >= 90 AND self.geoScore < 99 AND closest_nmxi.fka_name_match AND closest_name_strength >= Strong AND best_nmxi.maturity_suffix_conflict = false)
				// [84 .. 95.2]
					=> rule_score(2101, 84.0															
															+ ((self.msClosestName.score - 69) * .1)				// 0 - 3.1	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.firmaScore * .025)											// 0 - 2.5	firma
															- if (self.bOccupationConflict, 10, 0)
															- if (self.type1Misses > 0, 5, 0)
												),		
									
				// Great geo/firma, but part of name messed up. -- Typical SKA name screw up.
				(self.geoScore >= 95 
				AND self.firmaScore = 100 
				AND self.msPhone.matchType = Healthcare_Shared.Constants.MatchType.MT_EXACT 
				AND best_name_strength >= Weak 
				AND best_nmxi.maturity_suffix_conflict = false)
				// [84 .. 95.2]
					=> rule_score(2003, 84.0															
															+ (self.msBestName.score * .062)								// 0 - 6.2	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.demoScore * .025)												// 0 - 2.5	demo
															- if (self.bOccupationConflict, 10, 0)
															- if (self.type1Misses > 0, 5, 0)
												),		
												
				// Great geo but part of name messed up. -- Typical SKA name screw up. 2 parts fuzzy, 1 part missing
				// don't do for ref sourcing.
				(bRefSourcing = false 
				AND self.geoScore >= 100 
				AND best_name_strength >= VeryWeak 
				AND best_nmxi.first_name_conflict = false 
				AND best_nmxi.last_name_conflict = false
				AND best_nmxi.maturity_suffix_conflict = false )
				// [75 .. 86.2]
					=> rule_score(2004, 75.0															
															+ (self.msBestName.score * .062)								// 0 - 6.2	name bonus
															+ ((self.occupationScore - 33) * .025)					// 0 - 2.5	occupation
															+ (self.demoScore * .025)												// 0 - 2.5	demo
															- if (self.bOccupationConflict, 10, 0)
															- if (self.type1Misses > 0, 5, 0)
												),		
									
				//
				// 3000 series - 
				//
				
				// Strong firma and strong name
				(self.firmaScore = 100 AND best_name_strength >= Strong AND best_nmxi.maturity_suffix_conflict = false)
				// [75 .. 83.7]
					=> rule_score(3000, 75
															+ ((self.msBestName.score - 69) * .2)							// 0 - 6.2	name bonus
															+ (self.occupationScore * .025)										// 0 - 2.5	occupation
															- if (self.bOccupationConflict, 10, 0)	
												),
												
					
				// Strong firma and strong name and decent occupation
				(best_name_strength >= Strong AND self.firmaScore >= 80 AND best_nmxi.maturity_suffix_conflict = false AND self.occupationScore >= 50)
				// [75 .. 79]
					=> rule_score(3001, 75
															+ ((self.occupationScore - 50) * .05)					
															+ ((self.firmaScore - 80) * .05)	
												),
												
				// Strong firma and strong name 
				(best_name_strength >= Strong AND self.firmaScore >= 80 AND best_nmxi.maturity_suffix_conflict = false AND self.bOccupationConflict = false)
				// [72.5 .. 82.5]
					=> rule_score(3002, 75
															+ ((self.occupationScore - 50) * .05)						// -2.5 - 2.5 occupation bonus/penalty
															+ ((self.firmaScore - 80) * .05)								// 0 - 1
															+ (self.demoScore * .05)												// 0 - 4
												),																										// -2.5 - 7.5
												
				// Other individual demographic (DOB) and strong name
				(best_name_strength >= Strong AND self.demoScore >= 80 AND best_nmxi.maturity_suffix_conflict = false AND self.bOccupationConflict = false)
				// [75 .. 79]
					=> rule_score(4000, 75
															+ ((self.msBestName.score - 69) * .2)						// 0 - 6.2 name bonus
															+ (self.occupationScore  * .025)								// 0 - 2.5
												),																										// 0 - 8.7
												
				// Here we are challenged with a suspect name but other strong criteria.
				(best_name_strength >= Weak 
				AND (best_nmxi.last_name_conflict OR best_nmxi.stuff_was_transposed) 
				AND	best_nmxi.maturity_suffix_conflict = false 
				AND self.geoScore >= 99 
				AND self.firmaScore >= 80
				AND self.bOccupationConflict = false
				AND self.msBestName.score >= 50
				)
				// [75 .. 83.5]
					=> rule_score(5000, 75
															+ (self.msBestName.score * .1)									// 0 - 5   name bonus
															+ (self.occupationScore  * .025)								// 0 - 2.5 occupation
															+ (self.geoScore - 99)													// 0 - 1 	 geo bonus
												),																										// 0 - 8.5 total
												
				// Here we are challenged with a suspect name with a messed up address
				(best_name_strength >= Strong
				AND	best_nmxi.maturity_suffix_conflict = false 
				AND self.geoScore >= 75
				AND bFuzzyPracAddr
				AND self.bOccupationConflict = false
				)
				// [75 .. 80.6]
					=> rule_score(5001, 75
															+ ((self.msBestName.score - 60)* .1)						// 0 - 3.1 name bonus
															+ (self.occupationScore  * .025)								// 0 - 2.5 occupation
												),																										// 0 - 5.6 total
				
				// Weak name, strong firma/geo, with perfect last name, no conflicts, closest name ok (name variations)
				(self.geoScore >= 99 
				AND self.firmaScore >= 80 
				AND	best_nmxi.first_name_conflict = false 
				AND	best_nmxi.middle_name_conflict = false 
				AND	best_nmxi.last_name_conflict = false 
				AND best_name_strength = Weak
				AND	best_nmxi.last_name_match
				AND	self.msClosestName.score >= 50
				)
				// [65 .. 73.5]
					=> rule_score(5002, 65
															+ (self.msBestName.score * .1)						// 0 - 5   name bonus
															+ (self.occupationScore  * .025)					// 0 - 2.5 occupation
															+ (self.geoScore - 99)										// 0 - 1   geo bonus
												),																							// 0 - 8.5 total
												
				// Weak name, but no conflicts (probably some fuzziness)
				(self.geoScore >= 99 
				AND self.firmaScore >= 80 
				AND self.bOccupationConflict = false
				AND best_nmxi.maturity_suffix_conflict = false
				AND	best_nmxi.first_name_conflict = false 
				AND	best_nmxi.middle_name_conflict = false 
				AND	best_nmxi.last_name_conflict = false 
				AND best_name_strength = Weak
				)
				// [55 .. 63.5]
					=> rule_score(5003, 55.0
															+ (self.msBestName.score * .1)						// 0 - 5   name bonus
															+ (self.occupationScore  * .025)					// 0 - 2.5 occupation
															+ (self.geoScore - 99)										// 0 - 1   geo bonus
												),																							// 0 - 8.5 total
												
				// Weak name, but no conflicts in first or last (probably middle name funkyness)
				(self.geoScore >= 99 
				AND self.firmaScore >= 80 
				AND self.bOccupationConflict = false
				AND best_nmxi.maturity_suffix_conflict = false
				AND	best_nmxi.first_name_conflict = false 
				AND	best_nmxi.last_name_conflict = false 
				AND best_name_strength = Weak
				)
				// [55 .. 63.5]
					=> rule_score(5004, 55.0
															+ (self.msBestName.score * .1)						// 0 - 5   name bonus
															+ (self.occupationScore  * .025)					// 0 - 2.5 occupation
															+ (self.geoScore - 99)										// 0 - 1   geo bonus
												),																							// 0 - 8.5 total
												
				// NoWay best name (but last name ok-ish), strong firma/geo, with perfect last name, no conflicts, closest name strong
				(self.geoScore >= 99 
				AND self.firmaScore >= 80 
				AND self.bOccupationConflict = false
				AND best_nmxi.maturity_suffix_conflict = false
				AND	best_nmxi.last_name_conflict = false 
				AND	best_name_strength = NoWay
				AND	closest_name_strength >= Strong
				)
				// [65 .. 78.5]
					=> rule_score(5005, 65.0
															+ (self.msClosestName.score * .1)					// 0 - 10   name bonus
															+ (self.occupationScore  * .025)					// 0 - 2.5 occupation
															+ (self.geoScore - 99)										// 0 - 1   geo bonus
												),			
												
				// type1 match but name bad
				(self.type1Exact > 0)
				// [50 .. 90]
					=> rule_score(5006, 50.0
															+ ((self.type1Exact - 1) * 10)						// 0 - 40  for each type 1 beyond 1
															+ (self.msClosestName.score * .1)					// 0 - 10  name bonus
															+ (self.geoScore * .05)										// 0 - 5   geo bonus
															+ (self.firmaScore * .05)									// 0 - 5   firma bonus
															+ (self.occupationScore  * .025)					// 0 - 2.5 occupation
															
												),		
												
				// Strong name, but weak firma, geo, type1
				(best_name_strength >= Strong 
				AND best_nmxi.maturity_suffix_conflict = false
				AND self.geoScore < 75 
				AND self.bOccupationConflict = false)
        // With a strong name
        // and occupation ~ 30
        //  +5  for strong occupation
        // geoScore   - state 30, county 40, city 50,  > 50 more than just city (like fuzzy primary range, etc. )
        // firmaScore - 80 = 1 firma exact, 100 = > 1 firma exact
        // occupationScore = >50 is good enough to confirm the occupation.
        // examples                                                                     with occupation + 5
        // namestrength >= strong (69 - 100)  geo 0 (not in state)      = [50 .. 56.2]  [55 .. 61.2]
        // namestrength >= strong (69 - 100)  geo 30 (in state)         = [53 .. 59.2]  [58 .. 64.2]
        // namestrength >= strong (69 - 100)  geo 50 (in city)          = [55 .. 61.2]  [60 .. 66.2]
        // namestrength >= strong (69 - 100)  geo 74 (in city)          = [57.4 .. 63.6]    [60 .. 68.6]
				// [50 .. 68.6]
					=> rule_score(6000, 50
															+ ((self.msBestName.score -69) * .2)    		// 0 - 6.2  name bonus
															+ (self.geoScore * .1)                      // 0 - 7.4 geo bonus (could only be up to 74 for city match + fuzzy range/name)
															+ (self.occupationScore * .05)              // 0 - 5    occupation bonus
												),                                  							// 0 - 16.2  total
    
				 // Weak or VeryWeak name, and in state or in city/state
				((best_name_strength >= Weak OR closest_name_strength >= Weak)
				AND best_nmxi.maturity_suffix_conflict = false
				AND self.geoScore >= 30 
				AND self.geoScore <= 50 
				AND self.bOccupationConflict = false)
        //  +5  for strong occupation
        // geoScore   - state 30, county 40, city 50,  > 50 more than just city (like fuzzy primary range, etc. )
        // occupationScore = >50 is good enough to confirm the occupation.
        // examples                                                                     with occupation + 5
        // namestrength < strong (0 - 66)  geo 30 (in state)            = [23 .. 36.2]
        // namestrength < strong (0 - 66)  geo 50 (in city)             = [25 .. 38.2]
        // [15 .. 56.2]
					=> rule_score(6001, 15
															+ (self.msBestName.score * .4)        				// 0 - 26.2  name bonus (max ~66)
															+ ((self.geoScore - 30) * .5)         				// 0 - 10 geo bonus (could only be up to 50 for city match + fuzzy range/name)
															+ (self.occupationScore * .05)               	// 0 - 5    occupation bonus
												),                                          				// 0 - 41.2  total

				 // Rule to handle partial license match without name
				(/*proc_info->run_mode == realtime_person*/
         self.msLicense.matchType = Healthcare_Shared.Constants.MatchType.MT_FUZZY
         AND self.msLicense.score >= 85 /*License::VERIFICATION_THRESHOLD*/ // TODO, put in Perek's constant.
         AND best_name_strength = NoWay
				) 
        // [32.5 .. 57.5] mostly will be 45 via license state + license number match (90 licScore).
						=> rule_score(7000, (self.msLicense.score *.5)          // 32.5 - 50    really 45 max most likely
																+ (self.geoScore * .05)             // 0    - 5     most likely 0 from realtime/baxter
																+ (self.firmaScore *.05)            // 0    - 5     most likely 0 from realtime/baxter
																+ (self.occupationScore * .025)     // 0    - 2.5   occupation
                         ),                          								  // 32.5 - 57.5

				// default		 
				rule_score(0, (self.msBestName.score + self.firmaScore + self.geoScore + self.type1Score + self.occupationScore)
											/ // building the denominator here...
												(	5 
													+ if (best_name_strength <= Weak, 1, 0) 
													+ if (best_name_strength <= VeryWeak, 1, 0)
													+ if (self.type1Misses > 0, 1, 0)
													+ if (best_nmxi.maturity_suffix_conflict, 1, 0)
												)
				)			 
				
		); // end map
		
		self.score := rule_score_result.score;
		self.matchrule := rule_score_result.matchrule;
		
		self := [];
	end;
End;