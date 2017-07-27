import iesp;
export fn_smart_rollup_hunting(dataset(iesp.huntingfishing.t_HuntFishRecord) inRecs):= function
  // Used to replace spaces in date strings with zeroes so cast to integer works Ok
	shared fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');
			
  sRecs := sort(inRecs, LicenseState, licenseNumber, LicenseType, -iesp.ECL2ESP.DateToInteger(LicenseDate));
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.LicenseState = RIGHT.LicenseState and 
	                         LEFT.licenseNumber=RIGHT.licenseNumber and
	                         LEFT.LicenseType = RIGHT.LicenseType,
	                      loadit(LEFT,RIGHT));
  outRecs := sort(rRecs, -iesp.ECL2ESP.DateToInteger(LicenseDate), LicenseState, licenseNumber, LicenseType);
	RETURN outRecs; 
end;