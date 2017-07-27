CrimSrch.Layout_Moxie_Offender tGetFlaggedOffenders(CrimSrch.Layout_Moxie_Offender pOffender, CrimSrch.Layout_FCRA_Flag pFlag)
 :=
  transform
	self	:= pOffender;
  end
 ;

CrimSrch.Layout_Moxie_Offenses tGetFlaggedOffenses(CrimSrch.Layout_Moxie_Offenses pOffenses, CrimSrch.Layout_Moxie_Offender pOffender)
 :=
  transform
	self	:= pOffenses;
  end
 ;

CrimSrch.Layout_Moxie_Punishment tGetFlaggedPunishment(CrimSrch.Layout_Moxie_Punishment pPunishment, CrimSrch.Layout_Moxie_Offender pOffender)
 :=
  transform
	self	:= pPunishment;
  end
 ;

dDevOffenderDistFlagged		:= join(CrimSrch.File_Moxie_Offender_Dev,CrimSrch.File_FCRA_Flag,
									left.DID=right.DID,
									tGetFlaggedOffenders(left,right),
									lookup
								   );

dDevOffensesDist			:= distribute(CrimSrch.File_Moxie_Offenses_Dev,hash(Offender_Key));
dDevPunishmentDist			:= distribute(CrimSrch.File_Moxie_Punishment_Dev,hash(Offender_Key));
dDevOffensesFlagged			:= join(dDevOffensesDist,dDevOffenderDistFlagged,
									left.Offender_Key=right.Offender_Key,
									tGetFlaggedOffenses(left,right),
									lookup
								   );
dDevPunishmentFlagged		:= join(dDevPunishmentDist,dDevOffenderDistFlagged,
									left.Offender_Key=right.Offender_Key,
									tGetFlaggedPunishment(left,right),
									lookup
								   );

oOffender	:= output(dDevOffenderDistFlagged	,,'base::fcra_criminal_offender_flagged_' 	+ trim(CrimSrch.Version.Development),overwrite);
oOffenses	:= output(dDevOffensesFlagged		,,'base::fcra_criminal_offenses_flagged_' 	+ trim(CrimSrch.Version.Development),overwrite);
oPunishment	:= output(dDevPunishmentFlagged	,,'base::fcra_criminal_punishment_flagged_'	+ trim(CrimSrch.Version.Development),overwrite);

export Out_Flagged_Files
 :=
	parallel(
			  oOffender
			 ,oOffenses
			 ,oPunishment
			 )
 ;