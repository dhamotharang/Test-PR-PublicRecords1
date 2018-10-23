IMPORT doxie, Property, ut;

EXPORT fn_getForeclosures(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs) := FUNCTION

	workRec:=RECORD
		HomesteadExemptionV2_Services.Layouts.propIdRec;
		HomesteadExemptionV2_Services.Layouts.foreclosureRec;
	END;

	raw_foreclosures:=JOIN(ds_srch_recs,Property.Key_Foreclosures_Addr,
		KEYED(LEFT.z5=RIGHT.situs1_zip) AND
		KEYED(LEFT.prim_range=RIGHT.situs1_prim_range) AND
		KEYED(LEFT.prim_name=RIGHT.situs1_prim_name) AND
		KEYED(LEFT.addr_suffix=RIGHT.situs1_addr_suffix) AND
		KEYED(LEFT.predir=RIGHT.situs1_predir) AND
		LEFT.sec_range=RIGHT.situs1_sec_range AND RIGHT.deed_category='U',
		TRANSFORM(workRec,SELF:=LEFT,SELF:=RIGHT),
		LEFT OUTER,LIMIT(ut.limits.Foreclosure_MAX,SKIP));

	HomesteadExemptionV2_Services.Layouts.foreclosureRec filterRecs(workRec L) := TRANSFORM
		// FILTER RECORDS BY INPUT TAX YEAR + 3 PREVIOUS YEARS
		taxYears:=SET(HomesteadExemptionV2_Services.Functions.previousYears(L.inputTaxYear,HomesteadExemptionV2_Services.Constants.FORECLOSURE_YEARS),year);
		SELF.foreclosure_id:=IF(L.recording_date[1..4] IN taxYears,L.foreclosure_id,SKIP);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propForeclosureRec foreclosureRecords(ds_srch_recs L,DATASET(workRec) R) := TRANSFORM
		SELF.foreclosures:=PROJECT(R,filterRecs(LEFT));
		SELF:=L;
	END;

	// APPLY FARES RESTRICTION
	fares_foreclosures:=IF(NOT doxie.DataRestriction.Fares,raw_foreclosures,PROJECT(ds_srch_recs,TRANSFORM(workRec,SELF:=LEFT,SELF:=[])));

	RETURN DENORMALIZE(ds_srch_recs,fares_foreclosures,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,foreclosureRecords(LEFT,ROWS(RIGHT)));
END;
