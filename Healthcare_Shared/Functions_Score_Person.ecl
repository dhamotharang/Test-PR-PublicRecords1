import Healthcare_Shared,STD; 
export Functions_Score_Person := module
	// alias 
	shared MatchStat := Healthcare_Shared.Layouts.MatchStat;
	
	export person_match_result := record	// structure to hold person match result composite scores
		typeof(Healthcare_Shared.Layouts.searchKeyResults_plus_input.acctno) acctno;
		typeof(Healthcare_Shared.Layouts.searchKeyResults_plus_input.lnpid) lnpid;
		
		real     score;
		integer2 matchrule;
		integer2 type1Exact;
		integer2 type1Misses;
		integer2 type1Score;
		integer2 firmaExact;
		integer2 demoScore;
		integer2 firmaScore;
		integer2 geoScore;
		integer2 occupationScore;
	
		boolean bConfirmedCallReturnId := false;
		boolean bConfirmedCompanyName	:= false;
		boolean bConfirmedDea	:= false;
		boolean bConfirmedNcpdp	:= false;
		boolean bConfirmedLicense := false;
		boolean bConfirmedLicenseAuthority := false;
		boolean bConfirmedMedSchool := false;
		boolean bConfirmedNpi := false;
		boolean bConfirmedOccupation := false;
		boolean bConfirmedPhone := false;
		boolean bConfirmedSsn := false;
		boolean bConfirmedTin := false;
		boolean bConfirmedUpin := false;
		boolean bLicenseStatusConflict := false;
		boolean bOccupationConflict := false;

		// Address *closestPracAddr;
		// Address *closestBillAddr;
		//Healthcare_Shared.Layouts.layout_nameinfo 	closestName := layout_nameinfo[];
		Healthcare_Shared.Layouts.layout_nameinfo		bestName;
		Healthcare_Shared.Layouts.NameExtendedMatchInfo best_nmxi;
		Healthcare_Shared.Layouts.NameExtendedMatchInfo closest_nmxi;

		
		
		// MatchStats hold the results of the matching of elements.
		MatchStat msPracAddr;
		MatchStat msBillAddr;
		MatchStat msCompany;
		MatchStat msDea;
		MatchStat msNcpdp;
		MatchStat msLicense;
		MatchStat msAuthorityLicense;
		MatchStat msBestName;
		MatchStat msClosestName;
		MatchStat msNpi;
		MatchStat msMedSchool;
		MatchStat msPhone;
		MatchStat msSsn;
		MatchStat msTin;
		MatchStat msTaxonomy;
		MatchStat msUpin;
		MatchStat msMedicareFacNum;
		MatchStat msDob;
	end;
	
	EXPORT Healthcare_Shared.Layouts.MatchStat matchLicense(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
			ds := PROJECT(rec,transform(MatchStat,
		
				input_lic_num := LEFT.userinput.match_input.lic1.lic_num;
				input_lic_state := IF(LEFT.userinput.match_input.lic1.lic_state <> '', LEFT.userinput.match_input.lic1.lic_state, LEFT.userinput.match_input.prac1.state);
				input_lic_type := LEFT.userinput.match_input.lic1.lic_type;
				input_prac_state := LEFT.userinput.match_input.prac1.state;
				
				mprd_lic_num := LEFT.MPRDRaw[1].Lic1.lic_num;
				mprd_lic_state := LEFT.MPRDRaw[1].Lic1.lic_state;
				mprd_lic_type := LEFT.MPRDRaw[1].Lic1.lic_type;
				mprd_prac_state:= LEFT.MPRDRaw[1].prac1.state;
			// Set NA flags for use in scoring	
				lic_num_NA := IF(input_lic_num = '',TRUE,FALSE);
				lic_state_NA := IF(input_lic_state = '' and input_prac_state = '',TRUE,FALSE);
				lic_type_NA := IF(input_lic_type = '',TRUE,FALSE);
				
			 // Penalty of 5 if a state was passed in from practice address or config file.  Only penalize if it is different than the parsed state result.
				state_sub_penalty := IF(input_lic_state = '' and input_prac_state <> '',5,0);

			 // Parsed input license number matches DB lic1_num exactly
				lic_num_EXACT := IF(lic_num_NA = FALSE AND input_lic_num = mprd_lic_num,TRUE,FALSE);

			 // If the DB lic_1_type is embedded in the parsed lic_num, and the remainder of the parsed lic_num (after removing the type) matches the DB lic1_num, 
						// AND we couldn't initially parse out a lic_type from input
				lic_num_FUZZY := IF(lic_num_NA = FALSE AND REGEXFIND(mprd_lic_type,input_lic_num) AND REGEXREPLACE(mprd_lic_type,input_lic_num,'') = mprd_lic_num and lic_type_NA = TRUE,TRUE,FALSE);

			 // Parsed License state matches DB lic1_state exactly OR no parsed state was found and prac state matched DB lic1_state (5 point penalty will apply)
				lic_state_EXACT:= IF((lic_state_NA = FALSE AND input_lic_state = mprd_lic_state) 
													or (lic_state_NA = FALSE and input_lic_state = '' and input_prac_state = mprd_lic_state),TRUE, FALSE);
			 // Parsed License type matches DB lic1_state exactly 
				lic_type_EXACT := IF(lic_type_NA = FALSE AND input_lic_type = mprd_lic_type, TRUE, FALSE);
				lic_type_NOMATCH := IF(lic_type_NA = FALSE AND input_lic_type <> mprd_lic_type,TRUE,FALSE);

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
		return ds;
		end;

		EXPORT MAC_Match(function_name, childset, child_fieldname, input_fieldname) := MACRO
	
		EXPORT Healthcare_Shared.Layouts.MatchStat function_name(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function

			ds := project(rec.childset(child_fieldname != ''), transform(Healthcare_Shared.Layouts.MatchStat, self := Healthcare_Shared.Functions.getMatchStat(rec.userinput.match_input.input_fieldname, left.child_fieldname)));
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
	MAC_Match(MatchDea, deas, dea, dea1.dea_in);
	MAC_Match(MatchNcpdp, ncpdps, ncpdp_id, ncpdp_id_in);
	MAC_Match(MatchDob, dobs, dob, birthdate);
	// MAC_Match(MatchNpi, npis, npi, npi_num);
	MAC_Match(MatchNpi, MPRDRaw, npi_num, npi_num);
	MAC_Match(MatchSsn, ssns, ssn, ssn);
	MAC_Match(MatchTin, taxids, taxid, tin1.tin_in);
	MAC_Match(MatchUpin, MPRDRaw, upin, upin);
	MAC_Match(MatchTaxonomy, taxonomy, TaxonomyCode, taxonomy_in);
	MAC_Match(MatchCLIA, clianumbers, clianumber, clia_num_in);
	MAC_Match(MatchMedicare, MPRDRaw, medicare_fac_num, medicare_fac_num);
	MAC_Match(MatchMedicaid, MPRDRaw, medicaid_fac_num, medicaid_fac_num);
	MAC_Match(MatchMedSchool, MedSchools, MedSchoolName, medschool1.medschool);

	
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
	
	MatchStat MatchPhone(Healthcare_Shared.Layouts.CombinedHeaderResults rec, Healthcare_Shared.Layouts.layout_phone p1) := function
		return ScorePhone(rec.userinput.workphone, p1.phone);
	end;
	
	MatchStat MatchPhones(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		ds := project(rec.phones, transform(MatchStat, self := MatchPhone(rec, left)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	
	// Name Matching
	MatchStat MatchOneName(Healthcare_Shared.Layouts.CombinedHeaderResults rec, Healthcare_Shared.Layouts.layout_nameinfo n1) := function

		Healthcare_Shared.Layouts.NameScoreResult match_result := Healthcare_Shared.Functions.NameScoreMatch
												(rec.userinput.name_title, rec.userinput.name_first, rec.userinput.name_middle, rec.userinput.name_last,
												 /*rec.userinput.maturity_suffix*/ rec.userinput.name_suffix, /*rec.userinput.preferred_name*/ '', /*rec.userinput.gender*/ -1,
												 n1.title, n1.firstname, n1.middlename, n1.lastname,
												 n1.suffix, n1.preferredFirst, n1.gendercd);
												 
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
	
	MatchStat MatchAllNames(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		ds := project(rec.names, transform(MatchStat, self := MatchOneName(rec, left)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	
	
	// Company name matching
	MatchStat MatchOneCompanyName(Healthcare_Shared.Layouts.CombinedHeaderResults rec, Healthcare_Shared.Layouts.layout_addressinfo n1) := function
	
		score := Healthcare_Shared.Functions.CompareBusinessNameConfidence(rec.userinput.comp_name, n1.prac_company1_name); // there is also bill_company_name on input.
												 
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
		ds := project(rec.addresses, transform(MatchStat, self := MatchOneCompanyName(rec, left)));
		ds_sorted := sort(ds, -score);
		return ds_sorted[1];
	end;
	
	// License matching
	/* 
	MatchStat MatchLicense(Healthcare_Shared.Layouts.CombinedHeaderResults rec) := function
		// standardize, match
		Healthcare_ProviderPoint.Layouts_License.parsed_license_layout parsed_lic := 
		return MatchStat[];
	end; 
	*/

	export person_match_result score_person(Healthcare_Shared.Layouts.CombinedHeaderResults rec, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		self.acctno 			:= rec.acctno;
		self.lnpid 				:= rec.lnpid;
		
		self.bestName 	  := rec.names[1]; // was supposed to be sorted to top. This kind of bugs me. How do I know it was done properly by the caller?

		self.msPracAddr							:= [];
		self.msBillAddr							:= [];
		self.msCompany							:= MatchAllCompanyNames(rec); //uses CompareBusinessNameConfidence 
		self.msDea									:= MatchDea(rec);
		self.msNcpdp								:= MatchNcpdp(rec);
		self.msLicense							:= [];
		self.msAuthorityLicense			:= [];
		self.msBestName							:= MatchOneName(rec, self.bestName);
		self.msClosestName					:= MatchAllNames(rec);
		self.msNPI									:= MatchNpi(rec);
		self.msMedSchool						:= [];
		self.msPhone								:= MatchPhones(rec);
		self.msSsn									:= MatchSsn(rec);
		self.msTin									:= MatchTin(rec);
		self.msUpin									:= MatchUpin(rec);
		self.msTaxonomy							:= MatchTaxonomy(rec);
		self.msMedicareFacNum				:= MatchMedicare(rec);
		self.msDob									:= MatchDob(rec);

	
		self.bConfirmedCallReturnId 		:= false; // TODO
		self.bConfirmedCompanyName			:= false;	// TODO
		self.bConfirmedDea							:= self.msDea.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedNcpdp						:= self.msNcpdp.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedLicense 					:= false; // TODO
		self.bConfirmedLicenseAuthority := false; // TODO
		self.bConfirmedMedSchool 				:= self.msMedSchool.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedNpi 							:= self.msNpi.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedOccupation 			:= false; // TODO
		self.bConfirmedPhone 						:= self.msPhone.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedSsn 							:= self.msSsn.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedTin 							:= self.msTin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bConfirmedUpin 						:= self.msUpin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT;
		self.bLicenseStatusConflict 		:= false; // TODO
		self.bOccupationConflict 				:= false; // TODO
		
		// Demographic score
		self.demoScore := map( 	self.msDob.score >= 80 				=>	80,
														self.msMedSchool.score = 100 	=>	60,
														0); // default
	
		// Compute Firmagraphic score
		self.firmaExact := 		if (self.msPracAddr.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) 
												+ if (self.msBillAddr.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) 
												+ if (self.msCompany.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) 
												+ if (self.msPhone.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0) 
												+ if (self.msTin.MatchType = Healthcare_Shared.Constants.MatchType.MT_EXACT, 1, 0);
		
		self.firmaScore := map( self.firmaExact > 1		=> 100,
														self.firmaExact > 0		=> 80,
														0);	// default
														
		// Compute Geographic Score												
		self.geoScore		:= max(self.msPracAddr.score, self.msBillAddr.score);
		
		// Compute Type1 score. (Type1 ids are the "belly button" type provider identifiers.)
		self.type1Exact	:= 		if (self.bConfirmedDea, 1, 0) +
													if (self.bConfirmedNcpdp, 1, 0) +
													if (self.bConfirmedLicense, 1, 0) +
													if (self.bConfirmedNpi, 1, 0) +
													if (self.bConfirmedSsn, 1, 0)	+
													if (self.bConfirmedUpin, 1, 0);
												
		self.type1Misses := 	if (self.msDea.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
													if (self.msNcpdp.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
													if (self.msLicense.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
													if (self.msNpi.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
													if (self.msSsn.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0) +
													if (self.msUpin.MatchType = Healthcare_Shared.Constants.MatchType.MT_NO_MATCH, 1, 0);
													
		self.type1Score	:= 		map( 	self.type1Exact > 1 	=> 100,
																self.type1Exact = 1  	=> 80,
																0); // default


		self.OccupationScore := 33;		// TODO
				
		self.best_nmxi 						:= Healthcare_Shared.Functions.GetNameExtendedMatchInfo(self.msBestName.extendedInfo);
		self.closest_nmxi 					:= Healthcare_Shared.Functions.GetNameExtendedMatchInfo(self.msClosestName.extendedInfo);
	
		// alias some constants for readability
		NoWay 			:= Healthcare_Shared.Constants.NameScoreStrength.NoWay;
		VeryWeak 		:= Healthcare_Shared.Constants.NameScoreStrength.VeryWeak;
		Weak 				:= Healthcare_Shared.Constants.NameScoreStrength.Weak;
		Strong 			:= Healthcare_Shared.Constants.NameScoreStrength.Strong;
		VeryStrong 	:= Healthcare_Shared.Constants.NameScoreStrength.VeryStrong;
		best_nmxi							:= self.best_nmxi;
		closest_nmxi					:= self.closest_nmxi;
		best_name_strength		:= self.best_nmxi.strength;
		closest_name_strength := self.closest_nmxi.strength;

		
		boolean bSuspectScrambledName := (
						best_name_strength <= VeryWeak
            AND (closest_name_strength >= Weak OR best_nmxi.stuff_was_transposed
                OR best_nmxi.name_rearrangement_match OR closest_nmxi.name_rearrangement_match
                OR best_nmxi.name_rearrangement_fuzzy_match OR closest_nmxi.name_rearrangement_fuzzy_match)
								);

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
end;