export mac_AddHRISSN(infile, outfile, justIssueInfo, max_num='20') := macro
import ut,codes,suppress, risk_indicators;

#uniquename(isCNSMR)
%isCNSMR% := ut.IndustryClass.is_Knowx;

#uniquename(recentRec)
%recentRec% := RECORD
  infile;
	boolean isRecentlyReported := true;
	boolean is_ITIN := false;   // SSN is in the range of ITINs
	boolean is_valid := false;   // SSN is valid as a number
	boolean is_random := false;  // potentially randomized
	boolean legacy_ssn := false; // for potentially randomized SSNs defines if SSN-DID pair was seen before
  string5 code_randomized := ''; // to keep HRI code for potentially randomized SSN
END;

key_prunning := doxie.Key_DID_SSN_Date ();
#uniquename(getRecent)
%recentRec% %getRecent%(infile l, key_prunning r) := TRANSFORM
   SELF.isRecentlyReported := IF(r.did = 0, true, false);
	 SELF := l;
END;

#uniquename(with_recent)
%with_recent% := join(infile, key_prunning, 
                      keyed ((unsigned6) LEFT.did = RIGHT.did) and 
                      keyed (LEFT.ssn = RIGHT.ssn),
                      %getRecent%(LEFT,RIGHT), LEFT OUTER, ATMOST (1));

// check if SSN was seen before randomization:
// TODO: making it after validation may be more efficient
#uniquename(ssn_w_legacy_info)
%ssn_w_legacy_info% := join (%with_recent%, doxie.key_legacy_ssn,
                             keyed (Left.ssn = Right.ssn) AND
                             ((unsigned6) Left.did = Right.did),
                             transform (%recentRec%, Self.legacy_ssn := Right.ssn != '', Self := Left),
                             LEFT OUTER, KEEP (1), limit (0)); //at most 1 : 1 relation

// get SSN validation data:
#uniquename(getValidation)
%recentRec% %getValidation% (%recentRec% L, doxie.Key_SSN_Map R) := transform
  m_validation := ut.GetSSNValidation (L.ssn);

	// bug 104381 -- ITINs should no longer be flagged as invalid, nor considered random/legacy
	is_ITIN := Risk_Indicators.rcSet.isCodeIT(L.ssn);
	self.is_ITIN := is_ITIN;
	
	// is_valid will be true, while is_random will be false, so code_randomized 
	// will be '' for ITINs 
	is_valid_SSN := m_validation.is_valid;
	Self.is_valid := is_valid_SSN or is_ITIN;
	Self.is_random := is_valid_SSN AND R.ssn5 = '';
  Self.code_randomized := m_validation.GetCode (Self.is_valid, Self.is_random and L.legacy_ssn, Self.is_random);
  Self := L;
end;

#uniquename(ssn_validity_info)
%ssn_validity_info% := join (%ssn_w_legacy_info%, doxie.Key_SSN_Map,
                        keyed (left.ssn[1..5] = Right.ssn5) AND
                        keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                        %getValidation% (Left, Right),
                        LEFT OUTER, KEEP (1), limit (0)); //1 : 1 relation

#uniquename(ssn_validity_supressed)
%ssn_validity_supressed%	:= Project(%ssn_w_legacy_info%, transform(%recentRec%, self := left, self := []));

#uniquename(ssn_validity)
%ssn_validity%	:= if(%isCNSMR%, %ssn_validity_supressed%, %ssn_validity_info%);					
				
#uniquename(addSsnRisk)
infile %addSsnRisk%(%recentRec% le, risk_indicators.key_ssn_table_v4_2 ri) :=
TRANSFORM
	// similar to Risk_Indicators/iid_getSSNFlags and other examples of usage of ssn table.
	_ri := map(~doxie.DataRestriction.ECH and ~doxie.DataRestriction.EQ and ~doxie.DataRestriction.TCH => ri.combo,
							~doxie.DataRestriction.EQ => ri.eq,
							~doxie.DataRestriction.ECH => ri.en,
							ri.tn);

	// choose deceased indicator according to the restrictions
	bureau_decs_permitted := ~doxie.DataRestriction.BureauDeceasedRecords;
	_isDeceased := if(bureau_decs_permitted, _ri.isDeceased, ri.eq.isDeceased);

	// recent(0089) means issued in the last 3 years (using official_first_seen date for the comparison)
  recent := ut.DaysApart(stringlib.getDateYYYYMMDD(),ri.official_first_seen+'01') < ut.DaysInNYears(3);

	valid_ssn_code := MAP(
					   le.valid_ssn='R'		=>	'0115',
					   le.valid_ssn='O' AND ri.official_last_seen<>0		=>	'0003',
					   '');
	dcNeeded := Suppress.dateCorrect.do(le.ssn).needed;
	isIncomplete := LENGTH(TRIM(le.ssn,LEFT,RIGHT)) < 9 OR le.ssn[1..5] = '00000' OR le.ssn[6..9] = '0000';
	random_ssn_code := le.code_randomized;
	isInvalid := ~le.is_valid;
	isLegacy := le.is_random and le.legacy_ssn;	
	
	SELF.valid_ssn := IF(isIncomplete,'X',IF(isInvalid OR isLegacy,'B',le.valid_ssn));
	SELF.ssn_issue_early	:= Suppress.dateCorrect.sdate_u3(le.ssn, ri.official_first_seen);
  SELF.ssn_issue_last		:= Suppress.dateCorrect.edate_u3(le.ssn, ri.official_last_seen);
  SELF.ssn_issue_place	:= Suppress.dateCorrect.st(le.ssn, ri.issue_state);
	SELF.hri_ssn := IF(le.ssn='' OR justIssueInfo OR dcNeeded, DATASET([],Risk_Indicators.Layout_Desc),
				 // if the SSN is incomplete, none of the other HRIs are applicable
				 IF(isIncomplete, DATASET([{'2387',codes.VARIOUS_HRI_FILES.HRI_CODE('2387')}],Risk_Indicators.Layout_Desc), 
				 choosen(
				 IF(le.valid_ssn='F', DATASET([{'0029',codes.VARIOUS_HRI_FILES.HRI_CODE('0029')}],Risk_Indicators.Layout_Desc))&	 
				 IF(random_ssn_code<>'', DATASET([{random_ssn_code,codes.VARIOUS_HRI_FILES.HRI_CODE(random_ssn_code)}],Risk_Indicators.Layout_Desc))&
				 IF(_isDeceased, DATASET([{'0002',codes.VARIOUS_HRI_FILES.HRI_CODE('0002')}],Risk_Indicators.Layout_Desc))&
				 IF(ri.isBankrupt, DATASET([{'0042',codes.VARIOUS_HRI_FILES.HRI_CODE('0042')}],Risk_Indicators.Layout_Desc)) &
				 IF(recent,DATASET([{'0089',codes.VARIOUS_HRI_FILES.HRI_CODE('0089')}],Risk_Indicators.Layout_Desc))&
				 IF(ri.ssn='', DATASET([{'0071',codes.VARIOUS_HRI_FILES.HRI_CODE('0071')}],Risk_Indicators.Layout_Desc))&
				 IF((doxie.keep_old_ssns_val and _ri.BestCount>4) or (~doxie.keep_old_ssns_val and _ri.RecentCount > 1), DATASET([{'0125',codes.VARIOUS_HRI_FILES.HRI_CODE('0125')}],Risk_Indicators.Layout_Desc))&
				 IF(le.valid_ssn IN ['B'], DATASET([{'0135',codes.VARIOUS_HRI_FILES.HRI_CODE('0135')}],Risk_Indicators.Layout_Desc))&
				 IF(valid_ssn_code<>'', DATASET([{valid_ssn_code,codes.VARIOUS_HRI_FILES.HRI_CODE(valid_ssn_code)}],Risk_Indicators.Layout_Desc)) &
				 IF(~le.isRecentlyReported, DATASET([{'0150',codes.VARIOUS_HRI_FILES.HRI_CODE('0150')}],Risk_Indicators.Layout_Desc)) &
				 IF(ri.issue_state='EE', DATASET([{'0085',codes.VARIOUS_HRI_FILES.HRI_CODE('0085')}],Risk_Indicators.Layout_Desc)) &
				 IF(le.is_ITIN, DATASET([{'2388',codes.VARIOUS_HRI_FILES.HRI_CODE('2388')}],Risk_Indicators.Layout_Desc)),
				 ut.min2(maxHriPer_value,ut.limits.HRI_MAX))));
	
	SELF := le;
END;

#uniquename(via_key1)
%via_key1% := JOIN (%ssn_validity%, risk_indicators.key_ssn_table_v4_2,
                 (LEFT.ssn <> '') AND KEYED(LEFT.ssn=RIGHT.ssn),
                 %addssnRisk%(LEFT,RIGHT),
                 LEFT OUTER, keep (1)); // m:1 relation

// In the previous version of a suppression index we also checked if SSN is associated with 'MN' state.
// This isn't a requirement anymore.
outfile := %via_key1%;

endmacro;