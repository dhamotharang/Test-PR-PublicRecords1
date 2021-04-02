import _Control, ProfileBooster, Doxie, Suppress, STD;
onThor := _Control.Environment.OnThor;

export V2_getEmergence(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Slim) PBslim,
							  doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

// https://confluence.rsi.lexisnexis.com/display/MS/Emerging+ID
// EmrgAge
// EmrgAtOrAfter21Flag
// EmrgRecordType
// EmrgAddressHRIndex
// EmrgLexIDsAtEmrgAddrCnt1Y
// EmrgAge25to59Flag
// string8 proflic_build_date := Risk_Indicators.get
// Person: => EmrgDate := MIN(DataSources, HeaderHitFlag:DateFirstSeen);
// ABSYEARSBETWEEN()
// reported_age := risk_indicators.years_apart((unsigned)myGetDate, (unsigned)dob);
// 				self.age_from_reported_dob := reported_age;
    EXPORT Layout_PB2_Slim_emergence := RECORD
		ProfileBooster.V2_Layouts.Layout_PB2_Slim;
		unsigned3	emrg_dt_first_seen;
        STRING8		emrg_dob;
        STRING2     emrg_src;
        dx_ProfileBooster.Layouts.ProspectEmergence;
	END;
    
    PBheader := dx_header.key_header();
    PL_EmrgAge := MAP(P_LexIDSeenFlag = '0' => Person.MISSING_INPUT_DATA_INT,
												NOT BestDOB:Null => BOUNDSFOLD(ABSYEARSBETWEEN(EmrgDate, BestDOB), 0, 62),
												NOT PII.P_InpClnDOB:Null => BOUNDSFOLD(ABSYEARSBETWEEN(EmrgDate, PII.P_InpClnDOB), 0, 62),
												Person.NO_DATA_FOUND_INT);

// _Build_date('proflic_build_version');

// checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

// key_did := prof_licenseV2.key_proflic_did(false);




 // output(PBslim, named('PBslim'));
 // output(license_recs_original, named('license_recs_original'));
 // output(mari_recs, named('mari_recs'));
 // output(license_recs, named('license_recs'));
 // output(rolled_licenses, named('rolled_licenses'));
 // output(rolled_licenses2, named('rolled_licenses2'));
    output(choosen(with_category_v5,100), named('V2_getProfLic'));

    return with_category_v5;

end;