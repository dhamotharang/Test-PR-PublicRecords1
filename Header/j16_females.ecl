import watchdog,ut;

//join females with the same name+ssn
//throw in a couple of conditions to safeguard us a little
//1) try and recognize & discard bogus ssn's (don't link on ssn=001010001)
//2) see if the 2 ADL's live somewhat close together

//use header instead of match_candidates
//match_candidates introduces greater likelihood of a mis-parsed lname (in the fname) field throwing off the threshold for concluding
//the ADL is a female
export j16_females(dataset(recordof(header.layout_header)) hdr) := function

r1 := record
 hdr;
 string20  p_fname;
 string1   gender;
 unsigned6 did2;
end;

r1 x1(hdr le)   := transform
 self.p_fname   := datalib.PreferredFirstNew(le.fname,false);
 self.gender    := datalib.gender(self.p_fname);
 self.did2      := 0;
 self           := le;
end;

j1 := project(hdr,x1(left));

r2 := record
 j1.did;
 f_cnt   := count(group,j1.gender='F');
 tot_cnt := count(group);
end;

ta1        := table(j1(length(p_fname)>1),r2,did);
all_female := ta1(f_cnt=tot_cnt);

r1 x2(j1 le, all_female ri) := transform
 self := le;
end;

j2      := join(distribute(j1,hash(did)),distribute(all_female,hash(did)),left.did=right.did,x2(left,right),local);

//filter for full ssn's here rather than in the beginning so we can make sure all records in the ADL are female
has_ssn := distribute(j2(ut.full_ssn(ssn)=true),hash(ssn,lname,fname));

r1 x3(has_ssn le, has_ssn ri) := transform
 self.did2      := ri.did;
 self           := le;
end;

j3 := join(has_ssn,has_ssn,left.ssn=right.ssn and left.fname=right.fname and left.lname=right.lname and left.did>right.did
                           and (ut.fn_count_unique_numbers_in_an_ssn(left.ssn)>2
						        or
								(left.prim_range=right.prim_range and left.prim_name=right.prim_name)),x3(left,right),local);

f1 := j3;

//
//for sanity checking
//uncomment the OUTPUT and set the return value to j4 (instead of j5)
//
r3 := record
 unsigned6 did;
 integer   dob;
 string9   ssn;
 string20  fname;
 string20  lname;
 string10  prim_range;
 string28  prim_name;
 string25  city_name;
 string2   st;
 string5   zip;
end;

r3 x4(hdr le, f1 ri) := transform
 self := le;
end;

j4 := join(distribute(hdr,hash(ssn,lname,fname)),f1,left.ssn=right.ssn and left.lname=right.lname and left.fname=right.fname,x4(left,right),local);

//output(choosen(sort(j4,ssn,fname,lname,did,prim_range,prim_name,zip),10000));
//
//end of sanity check
//

header.layout_pairmatch x5(f1 le) := transform
 self.old_rid := le.did;
 self.new_rid := le.did2;
 self.pflag   := 40;
end;
  
j5 := dedup(project(f1,x5(left)),record,all);

return j5;

end;