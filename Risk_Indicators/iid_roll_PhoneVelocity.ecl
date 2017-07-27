import risk_indicators;

export iid_roll_PhoneVelocity(GROUPED DATASET(risk_indicators.layout_output) iid) := FUNCTION 


// risk_indicators.layout_output roll_phone_dids(risk_indicators.layout_output le, risk_indicators.layout_output rt) := transform
	// self.adls_per_phone := le.adls_per_phone+IF(le.p_did=rt.p_did,0,rt.adls_per_phone);  // don't increment if the DID is a duplicate
	// self.adls_per_phone_created_6months := le.adls_per_phone_created_6months + if(le.p_did=rt.p_did and le.adls_per_phone_created_6months>0, 0, rt.adls_per_phone_created_6months); // don't increment if the DID is a duplicate
	// self := rt;
// end;
// rolled_adls_per_phone := rollup( group(sort(iid, seq, p_did, -adls_per_phone_created_6months),seq), true, roll_phone_dids(left,right));							
		
counts_per_phonedid := table(iid, {seq, p_did,
															_adls_per_phone := count(group, adls_per_phone>0),
															_adls_per_phone_current := count(group, adls_per_phone_current>0),
															_adls_per_phone_created_6months := count(group, adls_per_phone_created_6months>0)
															}, seq, p_did, few);									

rolled_adls_per_phone := table(counts_per_phonedid, {seq,  
															adls_per_phone := count(group, _adls_per_phone>0),
															adls_per_phone_current := count(group, _adls_per_phone_current>0),
															adls_per_phone_multiple_use := count(group, _adls_per_phone>1),
															adls_per_phone_created_6months := count(group, _adls_per_phone_created_6months>0)}, 
															seq, few);
															
risk_indicators.Layout_Output joinEm(iid le, rolled_adls_per_phone ri) := transform
	self.adls_per_phone := iid_constants.capVelocity(ri.adls_per_phone);
	self.adls_per_phone_current := iid_constants.capVelocity(ri.adls_per_phone_current);
	self.adls_per_phone_multiple_use := iid_constants.capVelocity(ri.adls_per_phone_multiple_use);
	self.adls_per_phone_created_6months := iid_constants.capVelocity(ri.adls_per_phone_created_6months);
	self := le;
END;

rolled_adls := join(iid, rolled_adls_per_phone, left.seq=right.seq, joinEm(left,right), left outer);


counts_per_phoneaddr := table(iid, {seq, p_street,
															_addrs_per_phone := count(group, addrs_per_phone>0),
															_addrs_per_phone_created_6months := count(group, addrs_per_phone_created_6months>0)
															}, seq, p_street, few);									

rolled_addrs_per_phone := table(counts_per_phoneaddr, {seq,  
															addrs_per_phone := count(group, _addrs_per_phone>0),
															addrs_per_phone_created_6months := count(group, _addrs_per_phone_created_6months>0)}, 
															seq, few);
															
risk_indicators.Layout_Output add_addrs_per_phone(rolled_adls le, rolled_addrs_per_phone ri) := transform
	self.addrs_per_phone := iid_constants.capVelocity(ri.addrs_per_phone);
	self.addrs_per_phone_created_6months := iid_constants.capVelocity(ri.addrs_per_phone_created_6months);
	self := le;
END;

rolled_addrs_from_phone := join(rolled_adls, rolled_addrs_per_phone, left.seq=right.seq, add_addrs_per_phone(left,right), left outer);

RETURN group(rolled_addrs_from_phone, seq);

END;