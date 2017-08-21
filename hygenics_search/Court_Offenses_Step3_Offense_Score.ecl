import hygenics_crim, crimsrch, lib_stringlib;

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tBlankScoreIfNotConvicted(Court_Offenses_Step2_Conviction pInput) := transform
		self.offense_score	:= if(pInput.FCRA_Conviction_Flag <> 'Y',
														' ',
														pInput.Offense_Score);
		self								:= pInput;
	end;

dCourtOffensesOnlyConvictedScored := project(Court_Offenses_Step2_Conviction,tBlankScoreIfNotConvicted(left));

//***** START Set traffic-only offenses to traffic score first
	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tSetTrafficScoreIfTraffic(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pInput) := transform
		self.offense_score	:= if(pInput.FCRA_Traffic_Flag = 'Y' and pInput.FCRA_Conviction_Flag = 'Y',
														'T ',
														pInput.offense_score);
		self								:= pInput;
	end;

dCourtOffensesTrafficScored		:= project(dCourtOffensesOnlyConvictedScored,tSetTrafficScoreIfTraffic(left));
//***** END Set traffic offenses to traffic score first

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tTranslateOffenseLevel(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pInput) := transform
		self.offense_score	:= if(pInput.fcra_conviction_flag = 'Y' /*and pInput.offense_score <> 'T '*/, //expose the offense score even when it is traffic
														fStandard_Offense_Level_From_Orig(pInput.vendor, pInput.court_off_lev),
														' ');
		self								:= pInput;
	end;

dCourtOffensesTranslatedLevel	:= project(dCourtOffensesTrafficScored,tTranslateOffenseLevel(left));

hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tScoreOffenseCodes(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pInput) := transform
		self.offense_score	:= if(pInput.offense_score <> 'U ',
														pInput.offense_score,
														fOffense_Score_From_Offense_Code(pInput.Vendor,pInput.Court_Off_Code)
														);
		self								:= pInput;
	end;

dCourtOffensesScoredOffCode		:= project(dCourtOffensesTranslatedLevel,tScoreOffenseCodes(left));

//Set Traffic Flag
set_off := ['V',/*'I',*/'C','T']; //Removed I as Risk view doesn't want I records to be set as traffic.
		
				
	dCourtOffensesScoredOffCode trecs(dCourtOffensesScoredOffCode L) := transform
		self.fcra_traffic_flag 	:= if(L.offense_score in set_Off,
										'Y',
										L.fcra_traffic_flag );
		self 					:= L;
	end;

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Court_Offenses_Step3_Offense_Score := project(dCourtOffensesScoredOffCode,trecs(left)):persist('persist::CrimSrch_Offenses_Joined');
#else
	export Court_Offenses_Step3_Offense_Score := project(dCourtOffensesScoredOffCode,trecs(left));
#end