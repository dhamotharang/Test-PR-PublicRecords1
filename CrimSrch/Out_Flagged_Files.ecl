import Hygenics_search, corrections, hygenics_crim;

corrections.layout_offender tGetFlaggedOffenders(corrections.layout_offender pOffender, CrimSrch.Layout_FCRA_Flag pFlag)
 :=
  transform
	self	:= pOffender;
  end
 ;

set_Traff := ['T','I','V','C'];
corrections.layout_Offense tGetFlaggedOffenses(hygenics_crim.Layout_Base_Offenses_with_OffenseCategory pOffenses, corrections.layout_offender pOffender)
 :=
  transform
    self.fcra_traffic_flag	:= if(pOffenses.offense_score in set_Traff,'Y',poffenses.fcra_traffic_flag);
	self	:= pOffenses;
  end
 ; 

corrections.layout_CourtOffenses tGetFlaggedCOffenses(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pCOffenses, corrections.layout_offender pOffender)
 :=
  transform
    self.fcra_traffic_flag	:= if(pCOffenses.offense_score in set_Traff,'Y',pCoffenses.fcra_traffic_flag);
	self	:= pCOffenses;
  end
 ;
 
hygenics_crim.Layout_CrimPunishment tGetFlaggedPunishment(hygenics_crim.Layout_CrimPunishment pPunishment, corrections.layout_offender pOffender)
 :=
  transform
	self	:= pPunishment;
  end
 ;

dDevOffenderDistFlagged	:= join(Hygenics_search.File_Moxie_Offender_Dev,CrimSrch.File_FCRA_Flag((unsigned8)did <> 0),
														left.DID=right.DID,
														tGetFlaggedOffenders(left,right),
														lookup
														 );

// dDevOffensesDist				:= distribute(Hygenics_search.File_Moxie_Offenses_Dev,hash(Offender_Key));
// dDevCOffensesDist				:= distribute(Hygenics_search.File_Moxie_CourtOffenses_Dev,hash(Offender_Key));
// dDevPunishmentDist			:= distribute(Hygenics_search.File_Moxie_Punishment_Dev,hash(Offender_Key));

dDevOffensesDist				:= Hygenics_search.File_Moxie_Offenses_Dev;
dDevCOffensesDist				:= Hygenics_search.File_Moxie_CourtOffenses_Dev;
dDevPunishmentDist			:= Hygenics_search.File_Moxie_Punishment_Dev;

dDevOffensesFlagged			:= join(dDevOffensesDist,dDevOffenderDistFlagged,
														left.Offender_Key=right.Offender_Key,
														tGetFlaggedOffenses(left,right),
														lookup
														 );

dDevCOffensesFlagged			:= join(dDevCOffensesDist,dDevOffenderDistFlagged,
															left.Offender_Key=right.Offender_Key,
															tGetFlaggedCOffenses(left,right),
															lookup
															 );
														 
dDevPunishmentFlagged		:= join(dDevPunishmentDist,dDevOffenderDistFlagged,
															left.Offender_Key=right.Offender_Key,
															tGetFlaggedPunishment(left,right),
															lookup
															 );

oOffender		:= output(dDevOffenderDistFlagged	,,'base::fcra_criminal_offender_flagged_' 	+ trim(CrimSrch.Version.Development),overwrite);
oOffenses		:= output(dDevOffensesFlagged		,,'base::fcra_criminal_offenses_flagged_' 	+ trim(CrimSrch.Version.Development),overwrite);
oCOffenses	:= output(dDevCOffensesFlagged		,,'base::fcra_criminal_courtoffenses_flagged_' 	+ trim(CrimSrch.Version.Development),overwrite);
oPunishment	:= output(dDevPunishmentFlagged	,,'base::fcra_criminal_punishment_flagged_'	+ trim(CrimSrch.Version.Development),overwrite);

export Out_Flagged_Files
 :=
	parallel(
			  oOffender
			 ,oOffenses
			 ,oCOffenses
			 ,oPunishment
			 )
 ;