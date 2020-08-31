import VotersV2, Risk_Indicators;

EXPORT FN_inVotersState(STRING2 State, boolean isFCRA, STRING historydate) := FUNCTION
		get_Build_date := Risk_Indicators.get_Build_date((STRING)historydate);
		voterKeyInfo := choosen(VotersV2.Key_Voters_States(isFCRA)(keyed(state=State) and date_first_seen[1..6] < get_Build_date[1..6]), 1);
		
		voterInfo := count(voterKeyInfo) > 0;

	return voterInfo ;
end;
