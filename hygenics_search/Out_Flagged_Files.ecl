import crimSrch;

Layout_Moxie_Offender tGetFlaggedOffenders(Layout_Moxie_Offender pOffender, Layout_FCRA_Flag pFlag) := transform
	self					:= pOffender;
end;

set_Traff := ['T','I','V','C'];

Layout_Moxie_Offenses tGetFlaggedOffenses(crimsrch.Layout_Moxie_Offenses pOffenses, Layout_Moxie_Offender pOffender) := transform
    self.fcra_traffic_flag	:= if(pOffenses.offense_score in set_Traff,
									'Y',
									poffenses.fcra_traffic_flag);
	self					:= pOffenses;
end;

Layout_Moxie_Punishment tGetFlaggedPunishment(Layout_Moxie_Punishment pPunishment, Layout_Moxie_Offender pOffender) := transform
	self					:= pPunishment;
end;

dDevOffenderDistFlagged		:= join(File_Moxie_Offender_Dev, File_FCRA_Flag((unsigned8)did <> 0),
									left.DID=right.DID,
									tGetFlaggedOffenders(left,right),
									lookup);

dDevOffensesDist			:= distribute(File_Moxie_Offenses_Dev, hash(Offender_Key));
dDevPunishmentDist			:= distribute(File_Moxie_Punishment_Dev, hash(Offender_Key));
dDevOffensesFlagged			:= join(dDevOffensesDist,dDevOffenderDistFlagged,
									left.Offender_Key=right.Offender_Key,
									tGetFlaggedOffenses(left,right),
									lookup);
									
dDevPunishmentFlagged		:= join(dDevPunishmentDist,dDevOffenderDistFlagged,
									left.Offender_Key=right.Offender_Key,
									tGetFlaggedPunishment(left,right),
									lookup);

oOffender					:= output(dDevOffenderDistFlagged	,,'base::fcra_criminal_offender_flagged_' 	+ trim(Version.Development),overwrite);
oOffenses					:= output(dDevOffensesFlagged		,,'base::fcra_criminal_offenses_flagged_' 	+ trim(Version.Development),overwrite);
oPunishment					:= output(dDevPunishmentFlagged		,,'base::fcra_criminal_punishment_flagged_'	+ trim(Version.Development),overwrite);

export Out_Flagged_Files := 
	parallel(oOffender
			 ,oOffenses
			 ,oPunishment);