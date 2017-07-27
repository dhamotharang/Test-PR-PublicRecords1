import iesp;
export fn_smart_rollup_cweapons(dataset(iesp.concealedweapon.t_WeaponRecord) inRecs) := function
  sRecs := sort(inRecs, StateCode, Permit.PermitNumber, Permit.PermitType, -iesp.ECL2ESP.DateToInteger(Permit.ExpirationDate));
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.StateCode = RIGHT.StateCode and 
	                         LEFT.Permit.PermitNumber=RIGHT.Permit.PermitNumber AND 
	                         LEFT.Permit.PermitType=RIGHT.Permit.PermitType, 
	                         loadit(LEFT,RIGHT));
  outRecs := sort(rRecs, -iesp.ECL2ESP.DateToInteger(Permit.ExpirationDate), StateCode, Permit.PermitNumber, Permit.PermitType = '',Permit.PermitType);
	RETURN outRecs; 
end;