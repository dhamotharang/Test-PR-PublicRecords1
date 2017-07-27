/***
 ** Function takes doxie Drivers Licence dataset and project/transform to desired format
***/

IMPORT DriversV2_Services, iesp;

out_rec := iesp.identitymanagementreport.t_IdmDriverLicenseRecord;
EXPORT out_rec format_dl (dataset(DriversV2_Services.layouts.result_narrow) dls) := FUNCTION

	out_rec toOut (DriversV2_Services.layouts.result_narrow L) := TRANSFORM
    SELF.UniqueId := (STRING)L.did;
		SELF.HairColor := L.hair_color_name;
    SELF.EyeColor := L.eye_color_name;
		SELF.Height := L.height;
		SELF.LicenseNumber := L.dl_number;
		SELF.DOB 			:= iesp.ECL2ESP.toDate ((INTEGER) L.dob);
		SELF.ExpirationDate := iesp.ECL2ESP.toDate ((INTEGER) L.expiration_date);
		SELF.IssueState := L.orig_state;
		SELF.IssueDate := iesp.ECL2ESP.toDate ((INTEGER) L.lic_issue_date);
	END;

	drivers := PROJECT(dls, toOut(LEFT));
	// Bug: 167483- Added DriverLicense dataset of distiguished DLs, picked latest from header
	dl_recs := DEDUP(SORT(drivers,LicenseNumber,-ExpirationDate,-IssueDate),LicenseNumber);


/*******
	// DEBUG
	OUTPUT(drivers,NAMED('drivers'));
	OUTPUT(rolled_drivers, NAMED('rolled_drivers'));
*******/

RETURN dl_recs;

END;