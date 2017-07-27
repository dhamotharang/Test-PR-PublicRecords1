import DEAV2_Services, iesp;
export fn_smart_rollup_dea(dataset(iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record) inRecs) := function
   //the controlled substances are already in -expirataionDate order so get the first one
	sRecs := sort(inRecs, RegistrationNumber, -iesp.ECL2ESP.DateToInteger(controlledSubstancesInfo[1].expirationDate));
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.RegistrationNumber=RIGHT.RegistrationNumber, loadit(LEFT,RIGHT));
	s2Recs := sort(rRecs, -iesp.ECL2ESP.DateToInteger(controlledSubstancesInfo[1].expirationDate));
	//bug 101967 only keep first name per registration number.
	outrecs := project(s2Recs, transform(iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record, self.controlledSubstancesInfo := LEFT.controlledSubstancesInfo[1], self := left ));
	RETURN outRecs; 
end;