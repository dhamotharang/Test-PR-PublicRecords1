IMPORT PublicRecords_KEL, dx_fcra_opt_out, Std, ut, risk_indicators;

EXPORT FnRoxie_get_optouts(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) indata,
																		PublicRecords_KEL.Interface_Options Options) := FUNCTION
																		

//this was copied from the boca shell logic, we are going to continue to use the old 'score' method to match to address and ssn opt out keys. 
//1) it works, noone has complained about it being broken
//2) mas uses kel for levenshtein distances which isn't really doable here

flagrec := record
recordof(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII);
end;

// only consider a matching record a true hit if the following criteria are met
// otherwise act as the record didn't match at all
valid_hit(string1 opt_back_in, string1 permanent_flag, string8 date_yyyymmdd) := function
	today := (STRING8)Std.Date.Today();
	hit := opt_back_in='N' and
				 ( permanent_flag='Y' or (permanent_flag='N' and ut.DaysApart(today,date_yyyymmdd) < ut.DaysInNYears(5)) );
	return hit;
end;

flagrec getDidKey(indata le, dx_fcra_opt_out.key_did ri) := TRANSFORM
	self.PL_PrescreenOptOutFlag:= ri.l_did<>0 and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd);
	self := le;
END;

// search by did, and if a match found, flag it
didkey_roxie := join(indata, dx_fcra_opt_out.key_did,
					left.P_lexid!=0 and
					keyed(left.P_lexid = right.l_DID),
				  getDidKey(LEFT,RIGHT),
					left outer, atmost(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), keep(1));


 didkey := didkey_roxie;

flagrec getSSNKey(didkey le, dx_fcra_opt_out.key_ssn ri) := TRANSFORM
	namematch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.P_InpClnNameFirst, ri.inname_first)) and
																 risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.P_InpClnNameLast, ri.inname_last));
	self.PL_PrescreenOptOutFlag := le.PL_PrescreenOptOutFlag or (ri.l_ssn<>0 and namematch and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd));
	self := le;
END;

// search by ssn, and if a match found, check the names to make sure it's a match
ssnkey_roxie := join(didkey, dx_fcra_opt_out.key_ssn,
					left.P_InpClnSSN!='' and ~left.PL_PrescreenOptOutFlag and
					keyed((unsigned)left.P_InpClnSSN = right.l_ssn),
				  getSSNKey(LEFT,RIGHT),
					left outer, atmost(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), keep(10));

 ssnkey := ssnkey_roxie;


// search by address, and if a match found, check the names to make sure it's a match

flagrec getAddrKey(ssnkey le, dx_fcra_opt_out.key_address ri) := TRANSFORM
	namematch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.P_InpClnNameFirst, ri.inname_first)) and
																 risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.P_InpClnNameLast, ri.inname_last));
	self.PL_PrescreenOptOutFlag := le.PL_PrescreenOptOutFlag or (ri.prim_name<>'' and namematch and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd));
	self := le;
END;

addrkey_roxie := join(ssnkey, dx_fcra_opt_out.key_address,
					left.P_InpClnAddrPrimName!='' and left.P_InpClnAddrZip5!='' and ~left.PL_PrescreenOptOutFlag and
					keyed(left.P_InpClnAddrZip5 = right.z5) and
					keyed(left.P_InpClnAddrPrimRng = right.prim_range) and
					keyed(left.P_InpClnAddrPrimName = right.prim_name) and
					keyed(left.P_InpClnAddrSecRng = right.sec_range),
				  getAddrKey(LEFT,RIGHT),
					left outer, atmost(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), keep(1000));


  addrkey := addrkey_roxie;

// if any of the searches returns more than 1 record, keep the one that matched the opt_out file by sorting descending
opt_out_results := dedup(sort(addrkey, G_ProcUID, -PL_PrescreenOptOutFlag), G_ProcUID);

return opt_out_results;					
																		
	
end;																			