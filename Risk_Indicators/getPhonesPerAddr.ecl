import risk_indicators;

export getPhonesPerAddr(GROUPED DATASET(risk_indicators.layout_output) iid) := FUNCTION


// risk_indicators.layout_output count_phones_per_addr(risk_indicators.layout_output le, risk_indicators.layout_output rt) := transform
	// self.phones_per_addr := le.phones_per_addr+IF(le.phone_from_addr[1..7]=rt.phone_from_addr[1..7],0,rt.phones_per_addr);  
	// self.phones_per_addr_created_6months := le.phones_per_addr_created_6months + if(le.phone_from_addr[1..7]=rt.phone_from_addr[1..7] and le.phones_per_addr_created_6months>0, 0 , rt.phones_per_addr_created_6months);
	// self := rt;
// end;
// rolled_phone_by_addr := rollup(sort(iid, seq, phone_from_addr, -phones_per_addr_created_6months), true, count_phones_per_addr(left,right));
		
counts_per_phone := table(iid, {seq, phonefromaddr := phone_from_addr[1..7],
															_phones_per_addr := count(group, phones_per_addr>0),
															_phones_per_addr_current := count(group, phones_per_addr_current>0),
															_phones_per_addr_created_6months := count(group, phones_per_addr_created_6months>0)
															}, seq, phone_from_addr[1..7], few);									

rolled_phone_by_addr := table(counts_per_phone, {seq,  
															phones_per_addr := count(group, _phones_per_addr>0),
															phones_per_addr_current := count(group, _phones_per_addr_current>0),
															phones_per_addr_multiple_use := count(group, _phones_per_addr>1),
															phones_per_addr_created_6months := count(group, _phones_per_addr_created_6months>0)}, 
															seq, few);
							
risk_indicators.Layout_Output joinEm(iid le, rolled_phone_by_addr ri) := transform
	self.phones_per_addr := iid_constants.capVelocity(ri.phones_per_addr);
	self.phones_per_addr_current := iid_constants.capVelocity(ri.phones_per_addr_current);
	self.phones_per_addr_multiple_use := iid_constants.capVelocity(ri.phones_per_addr_multiple_use);
	self.phones_per_addr_created_6months := iid_constants.capVelocity(ri.phones_per_addr_created_6months);
	self := le;
END;
rolled_Phones := join(iid, rolled_phone_by_addr, left.seq=right.seq, joinEm(left,right), left outer);

RETURN group(Rolled_Phones, seq);

END;