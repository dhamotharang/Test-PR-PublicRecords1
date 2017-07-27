import iesp;
export fn_smart_rollup_atf(dataset(iesp.firearm.t_FirearmRecord) inRecs) := function
  sRecs := sort(inRecs, LicenseIssueState, LicenseNumber, -LicenseExpireDate);
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.LicenseIssueState = RIGHT.LicenseIssueState and LEFT.LicenseNumber=RIGHT.LicenseNumber, loadit(LEFT,RIGHT));
  OutRecs := sort(rRecs, -LicenseExpireDate, LicenseIssueState, LicenseNumber);
	RETURN outRecs; 
end;