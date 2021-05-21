import VotersV2, Risk_Indicators;

EXPORT FN_inVotersState(STRING2 InState, STRING historydate) := FUNCTION
	IsFCRA := FALSE : STORED('isFCRA');	
		voterKeyInfo := choosen(VotersV2.Key_Voters_States(isFCRA)(keyed(state=InState) and date_first_seen < historydate), 1);
		
		voterInfo := count(voterKeyInfo) > 0;

	return voterInfo ;
end;
