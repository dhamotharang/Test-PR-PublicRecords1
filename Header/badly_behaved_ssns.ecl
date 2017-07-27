import ut;

export badly_behaved_ssns(
	dataset(header.Layout_MatchCandidates) h 
	):=
FUNCTION

r := record
  h.ssn;
  h.dob;
  h.fname;
  h.mname;
  h.lname;
  end;
	
//***** CREATE SOME ADDITIONAL SSN RECS TO FEED INTO JBAD TO ADDRESS OVERUSED SSNS WITHOUT DOB
slimrec := record
	r;
	h.did
end;

addrs := dedup(sort(distribute(project(h, slimrec),
															 hash(did)),
										record, local),
							 record, local);
					     
moreSSNs := join(addrs(dob > 0), addrs(ssn <> ''),
								 left.ssn < right.ssn and
								 left.did = right.did,
								 transform(slimrec, 
													 self.ssn := right.ssn,
													 self := left),
								 local,
								 limit(100, skip)) +
					   join(addrs(ssn <> ''), addrs(dob > 0),
								 left.ssn < right.ssn and
								 left.did = right.did,
								 transform(slimrec, 
													 self.ssn := left.ssn,
													 self := right),
								 local,
								 limit(100, skip));

hr := distribute(project(h((unsigned8)ssn<>0),r),
								 hash(ssn));

t1 := distribute(project(moreSSNs((unsigned8)ssn<>0,dob<>0),r),
								 hash(ssn)) +
			hr(dob <> 0);

t_dups := dedup(sort(t1,ssn,dob,fname,mname,lname,local),ssn,dob,fname,mname,lname,local);

ut.MAC_Split_Withdups_Local(t_dups,ssn,1000,t,rest_ssn)

r1 := record
  string9 ssn;
	typeof(t1.fname) fname;
  end;

r2 := record
	r1;
	typeof(t1.mname) mname;
	typeof(t1.lname) lname;
  end;

r1 take_ssn(t le) := transform
  self.ssn := le.ssn;
	self.fname := '';
  end;
	
r1 take_ssn_fname(t le) := transform
  self := le;
  end;
	
r2 take_ssn_name(t le) := transform
  self := le;
  end;

set_ok := ['18','19','20'];
jbad1 := join(t,t,left.ssn=right.ssn and
                 header.date_value(left.dob,right.dob)<0 and
								 ((string8) left.dob)[1..2] in set_ok and
								 ((string8)right.dob)[1..2] in set_ok and
                 ( left.fname=right.fname or
                   datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,4) < 4
   
                 )
                 ,
                 take_ssn_name(left),local);
								 
//***** SINCE WE ARE INCLUDING FNAME NOW, WE NEED TO JOIN THE BAD ONES BACK BY SSN AND NAME 
//		  IN ORDER TO PICK UP THOSE NAMES THAT DO NOT HAVE A DOB BUT STILL MATCH A BAD NAME SSN COMBO
jbad2 := join(dedup(jbad1, 			 ssn, fname, mname, lname, all, local),
							dedup(hr(dob = 0), ssn, fname, mname, lname, all, local),
							left.ssn=right.ssn and
							 ( left.fname=right.fname or
                   datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,4) < 4
   
                 )
                 ,
							take_ssn_fname(right),local);
					
							
jbad := project(jbad1, r1) + jbad2;

bad_ssn := project(rest_ssn,take_ssn(left));

return dedup(sort(jbad + bad_ssn,ssn,fname,local),ssn,fname,local);

END;