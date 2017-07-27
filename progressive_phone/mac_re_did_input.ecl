import didville;

export mac_re_did_input(f_rt_in, f_rt_out) := macro

#uniquename(f_rt_slim)
%f_rt_slim% := project(f_rt_in, transform(didville.Layout_BestInfo_BatchIn, 
                                          self.name_first := left.fname,
																				  self.name_middle := left.mname,
	                                        self.name_last := left.lname,
																					self.name_suffix := left.suffix,
																					self.acctno := (string20)left.seq,
																					self.suffix := left.addr_suffix,
                                          self := left, self := []));

#uniquename(rt_out_rec)
%rt_out_rec% := record
  string20 acctno;
	unsigned6 did;
	unsigned1 match_type;
end;

#uniquename(f_rt_by_ssn)
#uniquename(f_rt_by_addr)
%f_rt_by_ssn% := project(didville.Did_From_SSN_Batch(%f_rt_slim%,true,10,false), transform(%rt_out_rec%, self.match_type:=1, self:=left));							
%f_rt_by_addr% := project(didville.Did_From_Address_Batch(%f_rt_slim%,true,true,1), transform(%rt_out_rec%, self.match_type:=2, self:=left)); 

#uniquename(f_rt_dids_raw)
%f_rt_dids_raw% := dedup(sort(%f_rt_by_ssn% + %f_rt_by_addr%, acctno, did, match_type), acctno, did);

#uniquename(f_rt_dids)
%f_rt_dids% := dedup(sort(%f_rt_dids_raw%, acctno, match_type, did), acctno, keep 2);
                            
#uniquename(get_rt_dids)														 
f_rt_in %get_rt_dids%(f_rt_in l, %f_rt_dids% r) := transform
   self.did := r.did;
	 self := l;
end;															 
															 
f_rt_out := join(f_rt_in, %f_rt_dids%,
                 left.seq = (unsigned4)right.acctno,
 			  %get_rt_dids%(left, right), left outer);													 

endmacro;