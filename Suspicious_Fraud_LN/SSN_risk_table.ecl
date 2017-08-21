import header,ut,Inquiry_AccLogs,riskwise,doxie,risk_indicators,watchdog,doxie_files, doxie_build, mdr, header_quick;

export SSN_Risk_Table(boolean isFCRA) := function

//h_full := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(~risk_indicators.iid_constants.filtered_source(src, st));
//h_quick := project( header_quick.file_header_quick(src IN ['QH', 'WH']), transform(header.Layout_Header,  self.src := mdr.sourceTools.src_Equifax, self := left));
h_full := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(~risk_indicators.iid_constants.filtered_source(src, st) and LENGTH(TRIM(ssn))=9 and (unsigned)ssn >0 and ut.full_ssn(ssn));
h_quick := header_quick.file_header_quick (~risk_indicators.iid_constants.filtered_source(src, st) and LENGTH(TRIM(ssn))=9 and (unsigned)ssn >0 and ut.full_ssn(ssn));

suspicious_SSN_slim_rec := Suspicious_Fraud_LN.layouts.temp_SSN;

suspicious_SSN_final_rec := Suspicious_Fraud_LN.layouts.extract_SSN;

string8 sysdate := ut.getDate;

		// slim header and fast header

Suspicious_Fraud_LN.mac_slimheader(h_full, h_full_slim, false)
Suspicious_Fraud_LN.mac_slimheader(h_quick, h_quick_slim)

h_full_quick_slim := h_full_slim + h_quick_slim;

ssn_slim := RECORD
	h_full_quick_slim.did;
	h_full_quick_slim.ssn;
  dt_first_seen := min(group, if(h_full_quick_slim.dt_first_seen = 0,999999,h_full_quick_slim.dt_first_seen));
  dt_last_seen :=  max(group, h_full_quick_slim.dt_last_seen);
	
	cnt := COUNT(GROUP);
END;

d_ssn_did := TABLE(distribute(h_full_quick_slim(did > 0),hash(ssn)), ssn_slim, ssn, did, LOCAL): persist('~thor_data400::persist::d_full_ssn_did_dt_reported');

//d_ssn_did := dataset(ut.foreign_dataland + 'thor_data400::persist::d_full_ssn_did_dt_reported',ssn_slim,flat);

k_Inquiry_ssn := project((pull(Inquiry_AccLogs.Key_Inquiry_SSN) + pull(Inquiry_AccLogs.Key_Inquiry_SSN_Update))(bus_intel.vertical != 'PENDING ASSIGNMENT' AND bus_intel.industry != 'BLANK' 
and LENGTH(TRIM(ssn,left,right))=9 and (unsigned)ssn >0 and ut.full_ssn(ssn)),
transform(suspicious_SSN_slim_rec,
self.log_date := trim(left.search_info.datetime[1..8]),
self.good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.Valid_Suspicious_Fraud_Inquiry((unsigned3)ut.getdate[1..6], self.log_date, left.bus_intel.industry,left.search_info.function_description,left.bus_intel.use), 
self := left,self := []));

// use the v3 file, but only use the Death master records.  TN and EN death reside in the source permitted sections
valid_death_sources := 

//isFCRA => ['DE'], -- from social administraion
//VERSION='EN' => ['DE','EN'],
//VERSION='TN' => ['DE','TN'],
//VERSION='EQ' => ['DE'],  // equifax can see only SSA death records
//we have also D0,D1.. from the states, but they are not included in header. Probably they should be included in 
//once they go to header. 'TS' is not reliable. 
['DE','EN','TN'] // COMBO GETS ALL 3
;
deathmasterfile := header.File_DID_Death_MasterV3((LENGTH(TRIM(ssn))=9) and (unsigned)ssn > 0 and ut.full_ssn(ssn) AND TRIM(SRC) in valid_death_sources);

risk_ssnkey := pull(risk_indicators.key_ssn_table_v4_2)(ut.full_ssn(ssn));

Suspicious_Fraud_LN.fn_SSN_S01(d_ssn_did, out_S01_dates);
Suspicious_Fraud_LN.fn_SSN_S02(d_ssn_did, out_S02_dates);
Suspicious_Fraud_LN.fn_SSN_S03(d_ssn_did, out_S03_dates);
Suspicious_Fraud_LN.fn_SSN_S04(d_ssn_did, out_S04_dates);
Suspicious_Fraud_LN.fn_SSN_S05(deathmasterfile, out_S05_dates);
Suspicious_Fraud_LN.fn_SSN_S06_S07(k_Inquiry_ssn, out_S06_07_dates);
out_S10_dates := Suspicious_Fraud_LN.fn_SSN_S10(h_full_quick_slim);
Suspicious_Fraud_LN.fn_SSN_S11(risk_ssnkey,out_S11_dates);
Suspicious_Fraud_LN.fn_SSN_S12(d_ssn_did, out_S12_dates);
out_S13_dates := Suspicious_Fraud_LN.fn_SSN_S13(h_full_quick_slim);

//combine all risk files 
h_SSN_S01_02_03_04_05_06_07_10_11_12_13_dates := out_S01_dates + out_S02_dates + out_S03_dates + out_S04_dates + 
out_S05_dates + out_S06_07_dates  + out_S10_dates + out_S11_dates + out_S12_dates + out_S13_dates: persist('~thor_data400::persist::d_ssn_all_risk_codes');

h_SSN_combine_dist := distribute(h_SSN_S01_02_03_04_05_06_07_10_11_12_13_dates,hash(ssn));
h_SSN_combine_sort := sort(h_SSN_combine_dist,SSN,local);

Suspicious_Fraud_LN.layouts.temp_SSN trollup_all(h_SSN_combine_sort ri, h_SSN_combine_sort le) := transform
	
self.dt_first_seen_DIDcnt := ut.min2(le.dt_first_seen_DIDcnt, ri.dt_first_seen_DIDcnt);
self.dt_first_seen_DIDcnt_c6 := ut.min2(le.dt_first_seen_DIDcnt_c6, ri.dt_first_seen_DIDcnt_c6);
self.dt_first_seen_multiple_use := ut.min2(le.dt_first_seen_multiple_use, ri.dt_first_seen_multiple_use);
self.dt_first_seen_non_relative_multiple_use := ut.min2(le.dt_first_seen_non_relative_multiple_use, ri.dt_first_seen_non_relative_multiple_use);
self.dt_first_deceased := ut.min2(le.dt_first_deceased, ri.dt_first_deceased);
self.dt_first_seen_searchcountyear := ut.min2(le.dt_first_seen_searchcountyear, ri.dt_first_seen_searchcountyear);
self.dt_first_seen_searchcountmonth := ut.min2(le.dt_first_seen_searchcountmonth, ri.dt_first_seen_searchcountmonth);
self.dt_first_seen_not_in_bearue := ut.min2(le.dt_first_seen_not_in_bearue, ri.dt_first_seen_not_in_bearue);
self.dt_first_seen_official := ut.min2(le.dt_first_seen_official, ri.dt_first_seen_official);
self.dt_first_seen_minors := ut.min2(le.dt_first_seen_minors, ri.dt_first_seen_minors);
self.dt_first_seen_recentADDRcnt := ut.min2(le.dt_first_seen_recentADDRcnt, ri.dt_first_seen_recentADDRcnt);

self.dt_last_seen_DIDcnt := ut.max2(le.dt_last_seen_DIDcnt, ri.dt_last_seen_DIDcnt);
self.dt_last_seen_DIDcnt_c6 := ut.max2(le.dt_last_seen_DIDcnt_c6, ri.dt_last_seen_DIDcnt_c6);
self.dt_last_seen_multiple_use := ut.max2(le.dt_last_seen_multiple_use, ri.dt_last_seen_multiple_use);
self.dt_last_seen_non_relative_multiple_use := ut.max2(le.dt_last_seen_non_relative_multiple_use, ri.dt_last_seen_non_relative_multiple_use);
self.dt_last_deceased := ut.max2(le.dt_last_deceased, ri.dt_last_deceased);
self.dt_last_seen_searchcountyear := ut.max2(le.dt_last_seen_searchcountyear, ri.dt_last_seen_searchcountyear);
self.dt_last_seen_searchcountmonth := ut.max2(le.dt_last_seen_searchcountmonth, ri.dt_last_seen_searchcountmonth);
self.dt_last_seen_not_in_bearue := ut.max2(le.dt_last_seen_not_in_bearue, ri.dt_last_seen_not_in_bearue);
self.dt_last_seen_official := ut.max2(le.dt_last_seen_official, ri.dt_last_seen_official);
self.dt_last_seen_minors := ut.max2(le.dt_last_seen_minors, ri.dt_last_seen_minors);
self.dt_last_seen_recentADDRcnt := ut.max2(le.dt_last_seen_recentADDRcnt, ri.dt_last_seen_recentADDRcnt);

self := le;

end;

h_ssn_combine_rollup := rollup(h_ssn_combine_sort,left.ssn = right.ssn,trollup_all(left,right),local) : persist('~thor_data400::persist::d_ssn_all_risk_codes_rollup');
//h_ssn_combine_rollup := dataset('~thor_data400::persist::d_ssn_all_risk_codes_rollup', Suspicious_Fraud_LN.layouts.temp_ssn, flat);
 
string		lRegEx			:=	'\\,[ ]*$';

fn_remove_ending_comma(string lTestString) := regexreplace(lRegEx, lTestString, '');


outf_SSN := project(h_ssn_combine_rollup, transform(suspicious_SSN_final_rec, 
self.ssn := left.ssn,
self.suspicious_risk_code := 
 fn_remove_ending_comma(trim(if(left.dt_first_seen_DIDcnt not in [0,999999] ,'S01' + ',', '') +
 if(left.dt_first_seen_DIDcnt_c6 not in [0,999999],'S02' +  ',' , '') + 
 if(left.dt_first_seen_multiple_use not in [0,999999],'S03' +  ',' , '') + 
 if(left.dt_first_seen_non_relative_multiple_use not in [0,999999],'S04' +  ',' , '') +
 if(left.dt_first_deceased not in [0,999999],'S05' + ',', '')  +
 if(left.dt_first_seen_SearchCountYear not in [0,999999], 'S06' +  ',' , '') + 
 if(left.dt_first_seen_SearchCountMonth not in [0,999999], 'S07' +  ',' , '') + 
 if(left.dt_first_seen_not_in_bearue not in [0,999999], 'S10' +  ',' , '') + 
 if(left.dt_first_seen_official not in [0,999999], 'S11' +  ',' , '') +
 if(left.dt_first_seen_minors not in [0,999999], 'S12' +  ',' , '') + 
 if(left.dt_first_seen_recentADDRcnt not in [0,999999],'S13' +  ',' , '')
, left,right)),
self.dt_first_seen := (unsigned3)ut.min2( 
ut.Min2(ut.Min2(ut.Min2(left.dt_first_seen_DIDcnt,left.dt_first_seen_DIDcnt_c6),
ut.Min2(left.dt_first_seen_multiple_use,left.dt_first_seen_non_relative_multiple_use)),
ut.Min2(ut.Min2(left.dt_first_seen_not_in_bearue,left.dt_first_seen_official),
left.dt_first_seen_minors)),
ut.Min2(ut.Min2(left.dt_first_seen_recentADDRcnt,left.dt_first_deceased),
ut.Min2(left.dt_first_seen_SearchCountYear,left.dt_first_seen_SearchCountMonth))
),
self.dt_last_seen := (unsigned3)ut.MAX2( 
ut.max2(ut.max2(ut.max2(left.dt_last_seen_DIDcnt,left.dt_last_seen_DIDcnt_c6),
ut.max2(left.dt_last_seen_multiple_use,left.dt_last_seen_non_relative_multiple_use)),
ut.max2(ut.max2(left.dt_last_seen_not_in_bearue,left.dt_last_seen_official),
left.dt_last_seen_minors)),
ut.max2(ut.max2(left.dt_last_seen_recentADDRcnt,left.dt_last_deceased),
ut.max2(left.dt_last_seen_SearchCountYear,left.dt_last_seen_SearchCountMonth))
),self := left));

 outf_final :=  dedup(sort(outf_ssn(suspicious_risk_code <> '' and dt_last_seen >= dt_first_seen),ssn,local), ssn,local);
 
 return outf_final;
 
 end;