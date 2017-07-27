import ut;

export j14_phone(
	dataset(recordof(header.layout_matchcandidates)) mc) := 
FUNCTION

meu0 := mc((unsigned8)phone>10000000,fname<>'',lname<>'');
meu := dedup(project(meu0, {meu0.phone, meu0.did, meu0.ssn, meu0.dob, meu0.name_suffix, meu0.good_nmaddr, meu0.fname, meu0.mname, meu0.lname, meu0.good_ssn}),
						 local, all);
d_meu := distribute(meu,hash(phone));
w_phone := record
  d_meu.phone;
  d_meu.did;
  end;

ta := dedup(sort(table(d_meu,w_phone),phone,did,local),phone,did,local);

p_count := record
  ta.phone;
  unsigned4 cnt := count(group);
  end;

b_phone := table(ta,p_count,phone,local);

common_phones := b_phone(cnt>25);

typeof(meu) take_l(meu le) := transform
  self := le;
  end;

p_cands := join(d_meu,common_phones,left.phone=right.phone,take_l(left),local,left only);

Header.Layout_PairMatch tra(p_cands l, p_cands r) := transform
  self.old_rid := l.did;
  self.new_rid := r.did;
  self.pflag := 14;
  end;


j14 := join(p_cands,p_cands,left.phone=right.phone and
				   left.did > right.did and
                   (
                     ut.NNEQ_ssn(left.ssn,right.ssn)
                   or
                     header.sig_near_dob(left.dob,right.dob)
                   ) and
                   header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) and 
                   (
                      ( left.good_nmaddr>=0 and right.good_nmaddr>=0 or header.sig_near_dob(left.dob,right.dob) ) and
                      header.date_value(left.dob,right.dob)
                    + IF ( left.good_nmaddr>=0 and right.good_nmaddr>=0, 1, -1 )
                    + header.suffix_value(left.name_suffix,right.name_suffix)
                    + IF(left.good_ssn and right.good_ssn,header.ssn_value(left.ssn,right.ssn),0) 
                    - ut.NameMatch(left.fname,left.mname,left.lname,
                                   right.fname,right.mname,right.lname) >= 0
					),
                   tra(left,right),atmost(left.phone=right.phone,1000),local);

return dedup(j14,old_rid,new_rid,all);

END;