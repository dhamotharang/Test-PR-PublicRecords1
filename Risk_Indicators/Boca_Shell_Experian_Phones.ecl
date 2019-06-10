import experian_phones, riskwise, risk_indicators;

EXPORT Boca_Shell_Experian_Phones(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, boolean isFCRA, 
integer glb, string50 DataRestriction) := function

temp_layout := record
	unsigned seq;
	string2 Experian_Phone_Verification;
end;

experian_phonesearch := join(ids_wide, Experian_Phones.Key_Did_Digits,
	left.did<>0 and 
	keyed(right.did=left.did) and
	((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)),					// check date
	transform(temp_layout,
	self.Experian_Phone_Verification := 
				map(left.did=0 or left.shell_input.phone10='' or right.did=0 => '-1',
						left.shell_input.phone10[8..10]=right.phone_digits => '1',
						'0');
	self := left;
		), left outer, atmost(riskwise.max_atmost), keep(100));
		

experian_phonesearch_rolled := rollup(experian_phonesearch, left.seq=right.seq, transform(temp_layout,
	self.Experian_Phone_Verification := if((integer)right.Experian_Phone_Verification > (integer)left.Experian_Phone_Verification,
																					right.Experian_Phone_Verification,
																					left.Experian_Phone_Verification),
	self := left));

// output(experian_phonesearch, named('experian_phonesearch'));	
// output(experian_phonesearch_rolled, named('experian_phonesearch_rolled'));

// don't do the search at all without GLB purpose
glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);
no_search := group(dataset([], temp_layout), seq);

drm_ok := DataRestriction[risk_indicators.iid_constants.posExperianPhonesRestriction]<>'1';

return if(glb_ok and drm_ok, experian_phonesearch_rolled, no_search);

end;
