/***
 ** Function takes doxie Insurance DL dataset and project/transform to desired format
***/

IMPORT iesp, InsuranceHeader_PostProcess, ut, DriversV2_Services, STD;

out_rec := iesp.identitymanagementreport.t_IdmInsuranceDriverLicenseRecord;
EXPORT out_rec format_insurance_dl (dataset(InsuranceHeader_PostProcess.layouts.DL) ins_dls) := FUNCTION
	dup_ins_dls := dedup(sort(ins_dls, did, -dt_last_seen), did)(ut.DaysApart((string)dt_last_seen, (string) STD.Date.Today()) <= DriversV2_Services.Constants.INS_MAX_DAYS_SINCE_DT_LAST_SEEN);
	
	out_rec toOut (InsuranceHeader_PostProcess.layouts.DL L) := TRANSFORM
    SELF.UniqueId := (STRING)L.did;
		SELF.LicenseNumber := L.dl_nbr;
		SELF.IssueState := L.dl_state;
		SELF.DateFirstSeen := iesp.ECL2ESP.toDate ((INTEGER) L.dt_first_seen);
		SELF.DateLastSeen := iesp.ECL2ESP.toDate ((INTEGER) L.dt_last_seen);
		SELF.Source	:= L.src;
	END;

	ins_dl_recs := PROJECT(dup_ins_dls, toOut(LEFT));

RETURN ins_dl_recs;

END;
