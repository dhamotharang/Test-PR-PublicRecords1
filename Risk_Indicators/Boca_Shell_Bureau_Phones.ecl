//nonFCRA only 
//grabs the verified phone info from Equifax - which we call bureau in case we change sources later on
import PhoneMart, riskwise, risk_indicators, doxie, Suppress;

EXPORT Boca_Shell_Bureau_Phones(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) ids_wide, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function

temp_layout := record
	unsigned seq;
	string2 phone_ver_bureau;
end;

temp_layout_CCPA := record
	unsigned6 did; // CCPA changes
  unsigned4 global_sid; // CCPA changes
  boolean skip_opt_out := false; // CCPA changes
	temp_layout;
end;

bureau_phonesearch_tmp_unsuppressed := join(ids_wide, PhoneMart.key_phonemart_did,
	left.did<>0 and 
	keyed(right.l_did=left.did) and
	((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)),					// check date
	transform(temp_layout_CCPA,
	self.phone_ver_bureau := 
				map(left.did=0 or left.shell_input.phone10='' or right.did=0 => '-1',
						left.shell_input.phone10 = right.phone => '1',
						'0');
	self.did := left.did;
	self.global_sid := right.global_sid;
	self := left;
		), left outer, atmost(riskwise.max_atmost), keep(100));
		
bureau_phonesearch_tmp_flagged := Suppress.CheckSuppression(bureau_phonesearch_tmp_unsuppressed, mod_access);

bureau_phonesearch_tmp := PROJECT(bureau_phonesearch_tmp_flagged, TRANSFORM(temp_layout, 
	self.phone_ver_bureau := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.phone_ver_bureau);
    SELF := LEFT;
)); 

bureau_phonesearch := sort(bureau_phonesearch_tmp, seq, (integer) phone_ver_bureau);
bureau_phonesearch_rolled := rollup(bureau_phonesearch, left.seq=right.seq, transform(temp_layout,
	self.phone_ver_bureau := if((integer)right.phone_ver_bureau > (integer)left.phone_ver_bureau,
																					right.phone_ver_bureau,
																					left.phone_ver_bureau),
	self := left));
//We don't need to check DRM 24 for this because we are not exposing the phone, just verifying it.
																									
return bureau_phonesearch_rolled;


end;
