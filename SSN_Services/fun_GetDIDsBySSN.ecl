import dx_Header;

rec := ssn_services.layout_ssn;
export fun_GetDIDsBySSN(grouped dataset(rec) ssns) := 
FUNCTION	

k := dx_Header.key_SSN();

rec get_dds(ssns l, k r) := transform
	self.seq := l.seq;
	self.ssn := l.ssn;
	self.did := r.did;
end;

wdid := join(ssns,k,
									 left.ssn[1]=right.s1 and
								   left.ssn[2]=right.s2 and
								   left.ssn[3]=right.s3 and
								   left.ssn[4]=right.s4 and
								   left.ssn[5]=right.s5 and
								   left.ssn[6]=right.s6 and
								   left.ssn[7]=right.s7 and
								   left.ssn[8]=right.s8 and
								   left.ssn[9]=right.s9,get_dds(left, right), left outer, atmost(500));
									 
return dedup(wdid, all);

END;
