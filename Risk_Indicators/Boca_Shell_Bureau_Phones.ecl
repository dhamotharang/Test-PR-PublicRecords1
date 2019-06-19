//nonFCRA only 
//grabs the verified phone info from Equifax - which we call bureau in case we change sources later on
import PhoneMart, riskwise, Phone_Shell, risk_indicators;

EXPORT Boca_Shell_Bureau_Phones(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide) := function

temp_layout := record
	unsigned seq;
	string2 phone_ver_bureau;
end;

bureau_phonesearch_tmp := join(ids_wide, PhoneMart.key_phonemart_did,
	left.did<>0 and 
	keyed(right.l_did=left.did) and
	((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)),					// check date
	transform(temp_layout,
	self.phone_ver_bureau := 
				map(left.did=0 or left.shell_input.phone10='' or right.did=0 => '-1',
						left.shell_input.phone10 = right.phone => '1',
						'0');
	self := left;
		), left outer, atmost(riskwise.max_atmost), keep(100));
		
bureau_phonesearch := sort(bureau_phonesearch_tmp, seq, (integer) phone_ver_bureau);
bureau_phonesearch_rolled := rollup(bureau_phonesearch, left.seq=right.seq, transform(temp_layout,
	self.phone_ver_bureau := if((integer)right.phone_ver_bureau > (integer)left.phone_ver_bureau,
																					right.phone_ver_bureau,
																					left.phone_ver_bureau),
	self := left));
//We don't need to check DRM 24 for this because we are not exposing the phone, just verifying it.
return bureau_phonesearch_rolled;


end;
