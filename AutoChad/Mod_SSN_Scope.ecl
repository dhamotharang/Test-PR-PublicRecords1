import header,doxie,ut;
export Mod_SSN_Scope(dataset(header.Layout_MatchCandidates) le) := module
  r := record
	  le.ssn;
	  end;
	t := dedup( table(le(ssn<>''),r), whole record, all );
  export values := t;
	ssn_didrecs := join(values,doxie.Key_Header_SSN,left.ssn[1]=right.s1 and
																						 left.ssn[2]=right.s2 and
																						 left.ssn[3]=right.s3 and
																						 left.ssn[4]=right.s4 and
																						 left.ssn[5]=right.s5 and
																						 left.ssn[6]=right.s6 and
																						 left.ssn[7]=right.s7 and
																						 left.ssn[8]=right.s8 and
																						 left.ssn[9]=right.s9,transform(right),
																						 limit(ut.limits.default, skip));
  ssn_recs := join(dedup(ssn_didrecs,did,all),doxie.Key_Header,left.did=right.s_did,transform(right),limit(ut.limits.HEADER_PER_DID, skip));
	ssn_recs_only := join(ssn_recs(valid_ssn<>'M'),values,left.ssn=right.ssn,transform(left));
	export records := ssn_recs_only;
  end;