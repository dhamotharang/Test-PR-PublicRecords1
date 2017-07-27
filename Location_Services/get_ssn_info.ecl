IMPORT risk_indicators, doxie, ut, suppress;

EXPORT get_ssn_info(STRING9 ssn, STRING9 ssn_unmasked, STRING1 valid_ssn, UNSIGNED4 dob, UNSIGNED6 did) := FUNCTION

ssnDidRec := RECORD
	STRING9   ssn;
	STRING9   ssn_unmasked;
	STRING1   valid_ssn;
	UNSIGNED4 dob;	
	UNSIGNED6 did;	
END;

YYYYMM := IF(dob > 999999, dob div 100, dob);
ssnDid := DATASET([{ssn,ssn_unmasked,valid_ssn,YYYYMM,did}],ssnDidRec);
maxHriPer_Value := consts.max_hri_ssn;

ssn_hri_rec := RECORD (ssnDidRec)
	UNSIGNED  cnt := 0;
	UNSIGNED4 ssn_issue_early := 0;
	UNSIGNED4 ssn_issue_last := 0;
	STRING2   ssn_issue_place := '';
	DATASET(risk_indicators.layout_desc) hri_ssn {MAXCOUNT(maxHriPer_Value)} := DATASET([],risk_indicators.layout_desc);
END;

ssnDidRecs := PROJECT(ssnDid,TRANSFORM(ssn_hri_rec,SELF:=LEFT));

doxie.mac_AddHRISSN(ssnDidRecs,ssnDidRecsHRI,FALSE);

layout_person_ssn addXtraInfo(ssn_hri_rec L,risk_indicators.key_ssn_table_v4_2 R) := TRANSFORM
	isRecent := ut.DaysApart(stringlib.getDateYYYYMMDD(),R.official_first_seen+'01') < ut.DaysInNYears(3);
	dcNeeded := suppress.dateCorrect.do(L.ssn).needed;

	// similar to Risk_Indicators/iid_getSSNFlags and other examples of usage of ssn table.
	_ri := map(~doxie.DataRestriction.ECH and ~doxie.DataRestriction.EQ and ~doxie.DataRestriction.TCH => R.combo,
							~doxie.DataRestriction.EQ => R.eq,
							~doxie.DataRestriction.ECH => R.en,
							R.tn);

	SELF.deceased := if(~doxie.DataRestriction.BureauDeceasedRecords, _ri.isDeceased, R.eq.isDeceased);
	SELF.recently_issued := IF(dcNeeded, FALSE, isRecent);
	SELF.last_reported := IF(dcNeeded, 0, R.official_last_seen);
	SELF.issued_prior_to_dob := IF((L.dob > L.ssn_issue_last) AND NOT dcNeeded, TRUE, FALSE);
	SELF := L;
END;

RETURN JOIN(ssnDidRecsHRI,risk_indicators.key_ssn_table_v4_2,
				KEYED(RIGHT.ssn=LEFT.ssn_unmasked) AND LEFT.ssn_unmasked!='', 
				addXtraInfo(LEFT,RIGHT),LEFT OUTER,KEEP(maxHriPer_value));
END;