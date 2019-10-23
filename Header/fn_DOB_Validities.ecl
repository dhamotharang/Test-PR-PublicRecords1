import ut, mdr, watchdog, lib_datalib;

export fn_DOB_Validities (boolean isEN=false,string filedate) := function

h := distribute(header.fn_Apt_Patch(isEN,filedate)(dob>0),hash(did));

mac_best_dob(h,did,dob,best_dob);

//Join all DOB records to best to determine jflag1
dob_rec := record
 h.did;
 h.rid;
 h.dob;
 h.fname;
 h.mname;
 h.lname;
 h.prim_range;
 h.prim_name;
 h.sec_range;
 h.zip;
 h.jflag1;
end;

slim_header := table(h,dob_rec);

//Function to determine if left dob is equal to right but of lower quality
low_quality(integer4 l, integer4 r) := l div 10000=r div 10000 and
					(ut.date_quality(l) in [2,3] or ((l%10000) div 100 =(r%10000) div 100 
											and ut.date_quality(l) in [4,5]));
dob_rec setBest(dob_rec l, best_dob r) := transform
 self.jflag1 := map(r.dob=0 => 'U',
			    l.dob=r.dob and ut.date_quality(l.dob)=6 => 'C',
			    l.dob<18500000 or l.dob>20000000 => 'I',
			    l.dob=r.dob or low_quality(l.dob,r.dob) => 'L',
			    header.Date_Typos(l.dob,r.dob) => 'T','U');
 self := l;
end;

before_bad := join(slim_header,best_dob,left.did=right.did,setBest(left,right),left outer,local);

//Join typos and undetermines to all addresses to find another DID with same dob, same address, and similar name.
compare_us := before_bad(jflag1 in ['T','U']);

dob_rec setBad(dob_rec L, dob_rec R) := transform
 self.jflag1 := if(r.dob=0,l.jflag1,'B');
 self := l;
end;

with_bad := join(compare_us,slim_header,left.did>right.did and 
								left.dob=right.dob and
								left.prim_range=right.prim_range and 
								left.prim_name=right.prim_name and 
								left.zip=right.zip and 
								ut.NNEQ(left.sec_range,right.sec_range) and
                                datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,4) < 4,
								setBad(left,right),left outer,hash);

dup_bad := dedup(with_bad,rid,all);

ofile := dup_bad + before_bad(jflag1 not in ['T','U']) : persist('persist::'+if(isEN,'en_','')+'fcra_dob_validities');

return ofile;

end;