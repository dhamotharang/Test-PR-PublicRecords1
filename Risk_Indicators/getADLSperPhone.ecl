import risk_indicators;

export getADLSperPhone(GROUPED DATASET(risk_indicators.layout_output) iid) := FUNCTION


risk_indicators.layout_output roll_phone_dids(risk_indicators.layout_output le, risk_indicators.layout_output rt) := transform
	self.adls_per_phone := le.adls_per_phone+IF(le.p_did=rt.p_did,0,rt.adls_per_phone);  // don't increment if the DID is a duplicate
	self.adls_per_phone_created_6months := le.adls_per_phone_created_6months + if(le.p_did=rt.p_did and le.adls_per_phone_created_6months>0, 0, rt.adls_per_phone_created_6months); // don't increment if the DID is a duplicate
	self := rt;
end;
rolled_adls_per_phone := rollup( group(sort(iid, seq, p_did, -adls_per_phone_created_6months),seq), true, roll_phone_dids(left,right));							
							
risk_indicators.Layout_Output joinEm(iid le, rolled_adls_per_phone ri) := transform
	self.adls_per_phone := ri.adls_per_phone;
	self.adls_per_phone_created_6months := ri.adls_per_phone_created_6months;
	self := le;
END;
rolled_adls := join(iid, rolled_adls_per_phone, left.seq=right.seq, joinEm(left,right), left outer, many lookup);

RETURN Rolled_adls;

END;