import Votersv2_services, iesp;




export fn_smart_rollup_voter(dataset(iesp.voter.t_VoterReport2Record) inRecs) := function
  sRecs := sort(inRecs, RegistrateState, ResidentAddress.county, -iesp.ECL2ESP.DateToInteger(LastVoteDate) /*process_date*/);
	sRecs loadVoter(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.RegistrateState = RIGHT.RegistrateState and LEFT.ResidentAddress.county=RIGHT.ResidentAddress.county, loadVoter(LEFT,RIGHT));
  outRecs := sort(rRecs, -iesp.ECL2ESP.DateToInteger(LastVoteDate),  RegistrateState = '', RegistrateState, ResidentAddress.county = '',ResidentAddress.county);
	RETURN outRecs;
end;