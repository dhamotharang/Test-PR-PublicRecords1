// R	Requirement: Insurance Phone Verification
// The Insurance Phone File created as part of the Phone Score v2.0 project shall be used to create a new Modeling Shell 5.0 field that indicates whether or not the input phone is associated with the LexID selected by the Modeling Shell.  The following response value shall be supported for this new field:

// â€¢	-1 â€“ Input phone not provided or DID = 0.
// â€¢	0 â€“ Neither DID nor input phone found in Insurance Phone File
// â€¢	1 â€“ DID not found in Insurance Phone File and input phone is associated with a different DID
// â€¢	2 â€“ DID found in Insurance Phone File but with a different phone and input phone not found 
// â€¢	3 â€“ DID found in Insurance Phone File but with a different phone and input phone associated with a different DID
// â€¢	4 â€“ DID found in Insurance Phone File with the input phone

// Development Comments: There is a dependency on the data team building the keys as part of the Phone Shell v2.0 project prior to implementing this requirement. 

import Phonesplus_v2, riskwise, risk_indicators, doxie, Suppress;

EXPORT Boca_Shell_Insurance_Phones(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function

rtemp := record
	risk_indicators.Layout_Input;
	risk_indicators.layouts.layout_insurance_phones_verification;
end;

rtemp_CCPA := RECORD
unsigned4 global_sid; // CCPA changes
boolean skip_opt_out := false; // CCPA changes
rtemp;
END;

phonesearch_unsuppressed := join(ids_wide, Phonesplus_v2.Keys_Iverification().phone.qa,
	left.shell_input.phone10<>'' and 
	keyed(right.phone=left.shell_input.phone10) and
	right.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
	transform(rtemp_CCPA,
    self.global_sid := right.global_sid;
	self.insurance_phones_phone_hit := right.phone<>'';
	self.insurance_phones_phonesearch_didmatch := right.did <> 0 and left.did=right.did;
	self := left.shell_input;
	self.historydate := left.historydate;
	self := [];
		), left outer, atmost(riskwise.max_atmost), keep(100));

phonesearch_flagged := Suppress.CheckSuppression(phonesearch_unsuppressed, mod_access);

phonesearch := PROJECT(phonesearch_flagged, TRANSFORM(rtemp, 
	self.insurance_phones_phone_hit := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.insurance_phones_phone_hit);
	self.insurance_phones_phonesearch_didmatch := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.insurance_phones_phonesearch_didmatch);
    SELF := LEFT;
)); 
		
phonesearch_rolled := rollup(phonesearch, left.seq=right.seq, transform(rtemp, 
	self.insurance_phones_phonesearch_didmatch := left.insurance_phones_phonesearch_didmatch or right.insurance_phones_phonesearch_didmatch,
	self := left));

didsearch := join(phonesearch_rolled, Phonesplus_v2.Keys_Iverification().did_phone.qa,
	left.did<>0 and ~left.insurance_phones_phonesearch_didmatch and  // don't bother searching if we don't have a DID on input or we already know the DID matched the phone
	(keyed(left.did=right.did) ) and
	right.dt_first_seen <= (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
	transform(rtemp,
	self.insurance_phones_did_hit := right.did<>0;
	self.insurance_phones_didsearch_phonematch :=  right.phone <> '' and right.phone=left.phone10;
	self.Insurance_Phone_Verification := 
		map(left.did=0 or left.phone10='' => '-1',
				left.insurance_phones_phonesearch_didmatch => '4',
				right.did<>0 and left.phone10<>right.phone and left.insurance_phones_phone_hit => '3',
				right.did<>0 and left.phone10<>right.phone and not left.insurance_phones_phone_hit => '2',
				right.did=0 and left.insurance_phones_phone_hit => '1',
				'0');
	self := left),
	left outer, atmost(riskwise.max_atmost), keep(100));


didsearch_rolled := rollup(didsearch, left.seq=right.seq, transform(rtemp,
	self.Insurance_Phone_Verification := if((integer)right.Insurance_Phone_Verification > (integer)left.Insurance_Phone_Verification,
																					right.Insurance_Phone_Verification,
																					left.Insurance_Phone_Verification),
	self := left));
                                                  
// output(phonesearch_rolled, named('phonesearch_rolled'));
// output(didsearch, named('didsearch'));	
// output(didsearch_rolled, named('didsearch_rolled'));

return didsearch_rolled;

end;
