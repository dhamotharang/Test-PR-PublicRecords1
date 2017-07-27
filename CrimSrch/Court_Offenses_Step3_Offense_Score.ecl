import CrimSrch, lib_stringlib;

CrimSrch.Layout_Moxie_Offenses_temp tBlankScoreIfNotConvicted(Court_Offenses_Step2_Conviction pInput)
 :=
  transform
	self.offense_score	:= if(pInput.FCRA_Conviction_Flag <> 'Y',' ',pInput.Offense_Score);
	self				:= pInput;
  end
 ;

dCourtOffensesOnlyConvictedScored := project(Court_Offenses_Step2_Conviction,tBlankScoreIfNotConvicted(left));

//***** START Set traffic-only offenses to traffic score first
CrimSrch.Layout_Moxie_Offenses_temp tSetTrafficScoreIfTraffic(CrimSrch.Layout_Moxie_Offenses_temp pInput)
 :=
  transform
	self.offense_score	:= if(pInput.FCRA_Traffic_Flag = 'Y' and pInput.FCRA_Conviction_Flag = 'Y',
							  'T ',
							  pInput.offense_score
							 );
	self				:= pInput;
  end
 ;

dCourtOffensesTrafficScored	:= project(dCourtOffensesOnlyConvictedScored,tSetTrafficScoreIfTraffic(left));
//***** END Set traffic offenses to traffic score first

CrimSrch.Layout_Moxie_Offenses_temp tTranslateOffenseLevel(CrimSrch.Layout_Moxie_Offenses_temp pInput)
 :=
  transform
	self.offense_score	:= if(pInput.fcra_conviction_flag = 'Y' and pInput.offense_score <> 'T ',
							  fStandard_Offense_Level_From_Orig(pInput.vendor, pInput.court_off_level),
							  ' '
							 );
	self				:= pInput;
  end
 ;

dCourtOffensesTranslatedLevel	:= project(dCourtOffensesTrafficScored,tTranslateOffenseLevel(left));

CrimSrch.Layout_Moxie_Offenses_temp tScoreOffenseCodes(CrimSrch.Layout_Moxie_Offenses_temp pInput)
 :=
  transform
	self.offense_score	:= if(pInput.offense_score <> 'U ',
							  pInput.offense_score,
							  fOffense_Score_From_Offense_Code(pInput.Vendor,pInput.Court_Off_Code)
							 );
	self				:= pInput;
  end
 ;

dCourtOffensesScoredOffCode		:= project(dCourtOffensesTranslatedLevel,tScoreOffenseCodes(left));

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Court_Offenses_Step3_Offense_Score
 := dCourtOffensesScoredOffCode
 : persist('Persist::CrimSrch_Court_Offenses_Scored')
 ;
#else
export Court_Offenses_Step3_Offense_Score
 := dCourtOffensesScoredOffCode
 ;
#end