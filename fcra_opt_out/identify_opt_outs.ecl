import _Control, risk_indicators, riskwise, ut, std;
onThor := _Control.Environment.OnThor;

export identify_opt_outs(dataset(risk_indicators.layout_input) indata) := function

flagrec := record
	boolean opt_out_hit := false;
	indata;
end;

// only consider a matching record a true hit if the following criteria are met
// otherwise act as the record didn't match at all
valid_hit(string1 opt_back_in, string1 permanent_flag, string8 date_yyyymmdd) := function
	today := (STRING8)Std.Date.Today();
	hit := opt_back_in='N' and
				 ( permanent_flag='Y' or (permanent_flag='N' and ut.DaysApart(today,date_yyyymmdd) < ut.DaysInNYears(5)) );
	return hit;				
end;

flagrec getDidKey(indata le, fcra_opt_out.key_did ri) := TRANSFORM
	self.opt_out_hit:= ri.l_did<>0 and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd);
	self := le;
END;

// search by did, and if a match found, flag it
didkey_roxie := join(indata, fcra_opt_out.key_did,
					left.did!=0 and 
					keyed(left.did = right.l_DID),
				  getDidKey(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(1));

didkey_thor := join(distribute(indata, hash64(did)), 
					distribute(pull(fcra_opt_out.key_did), hash64(l_DID)),
					left.did!=0 and 
					left.did = right.l_DID,
				  getDidKey(LEFT,RIGHT),
					left outer, atmost(left.did = right.l_DID, riskwise.max_atmost), keep(1), LOCAL);

#IF(onThor)
  didkey := didkey_thor;
#ELSE
 didkey := didkey_roxie;
#END

flagrec getSSNKey(didkey le, fcra_opt_out.key_ssn ri) := TRANSFORM
	namematch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.fname, ri.inname_first)) and 
																 risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.lname, ri.inname_last));
	self.opt_out_hit := le.opt_out_hit or (ri.l_ssn<>0 and namematch and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd));
	self := le;
END;

// search by ssn, and if a match found, check the names to make sure it's a match
ssnkey_roxie := join(didkey, fcra_opt_out.key_ssn,
					left.ssn!='' and ~left.opt_out_hit and
					keyed((unsigned)left.ssn = right.l_ssn),
				  getSSNKey(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(10));

ssnkey_thor := join(distribute(didkey, hash64(ssn)), 
					distribute(pull(fcra_opt_out.key_ssn), hash64(l_ssn)),
					left.ssn!='' and ~left.opt_out_hit and
					(unsigned)left.ssn = right.l_ssn,
				  getSSNKey(LEFT,RIGHT),
					left outer, atmost((unsigned)left.ssn = right.l_ssn, riskwise.max_atmost), keep(10), LOCAL);

#IF(onThor)
  ssnkey := ssnkey_thor;
#ELSE
 ssnkey := ssnkey_roxie;
#END

// search by address, and if a match found, check the names to make sure it's a match

flagrec getAddrKey(ssnkey le, fcra_opt_out.key_address ri) := TRANSFORM
	namematch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.fname, ri.inname_first)) and 
																 risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.lname, ri.inname_last));
	self.opt_out_hit := le.opt_out_hit or (ri.prim_name<>'' and namematch and valid_hit(ri.opt_back_in, ri.permanent_flag, ri.date_yyyymmdd));
	self := le;
END;

addrkey_roxie := join(ssnkey, fcra_opt_out.key_address,
					left.prim_name!='' and left.z5!='' and ~left.opt_out_hit and
					keyed(left.z5 = right.z5) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.sec_range = right.sec_range),
				  getAddrKey(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(1000));
					
addrkey_thor := join(distribute(ssnkey, hash64(z5, prim_range, prim_name, sec_range)), 
					distribute(pull(fcra_opt_out.key_address), hash64(z5, prim_range, prim_name, sec_range)),
					left.prim_name!='' and left.z5!='' and ~left.opt_out_hit and
					(left.z5 = right.z5) and
					(left.prim_range = right.prim_range) and
					(left.prim_name = right.prim_name) and
					(left.sec_range = right.sec_range),
				  getAddrKey(LEFT,RIGHT),
					left outer, atmost(riskwise.max_atmost), keep(1000), LOCAL);					

#IF(onThor)
  addrkey := addrkey_thor;
#ELSE
  addrkey := addrkey_roxie;
#END

// if any of the searches returns more than 1 record, keep the one that matched the opt_out file by sorting descending
opt_out_results := dedup(sort(addrkey, seq, -opt_out_hit), seq);

return opt_out_results;

end;