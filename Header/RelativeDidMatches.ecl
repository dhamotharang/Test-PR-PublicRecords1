import ut,did_add,lib_datalib;
export RelativeDidMatches(
	dataset(header.Layout_MatchCandidates) h) :=

FUNCTION
r := header.File_Relatives_v3(number_cohabits>=4
										,relative_matches[1..2]<>'IR' // exclude pure iRelatives pairs
										,(relatives_match_score[1..2]<>'IR' or number_cohabits > 11) //exclude pairs boosted by iRelatives
										);

layout_relatives swap(r le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

swappe := project(r,swap(left));

both_ways := r+swappe;

hslim := record
  h.did;
  h.lname;
  h.fname;
  h.mname;
  h.ssn;
  h.dob;
  h.name_suffix;
  end;

hdd := distribute(table(h(h.dob<>0),hslim),hash((integer8)did));
shdd := sort(hdd,did,lname,fname,mname,ssn,dob,name_suffix,local);

grd := group(shdd,did,local);

hred := dedup(grd,did,lname,fname,mname,ssn,dob,name_suffix);

match_lay := record
  unsigned6 person1;
  unsigned6 person2;
  qstring20 lname;
  qstring20 fname;
  qstring20 mname;
  qstring9 ssn;
  unsigned4 dob;
  qstring5 name_suffix;
  end;

match_lay tag(both_ways le, hred ri) := transform
  self := le;
  self := ri;
  end;

tagged := join(distribute(both_ways,hash((integer8)person2)),hred,left.person2=right.did,tag(left,right),local);

Layout_PairMatch equal(tagged le, tagged ri) := transform
  self.new_rid := ri.person2;
  self.old_rid := le.person2;
  self.pflag := 6;
  end;

result1 := join(tagged,tagged,left.person1=right.person1 and
                              left.person2>right.person2 and
  header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) and
  did_add.DOB_Match_Score(left.dob,right.dob)>=75 and
  left.fname=right.fname and left.lname=right.lname and ut.Firstname_Match(left.mname,right.mname)>0
							 ,equal(left,right));

result2 := join(tagged,tagged,left.person1=right.person1 and
                              left.person2>right.person2 and
  header.gens_ok(left.name_suffix,left.dob,right.name_suffix,right.dob) and
  left.dob=right.dob and 
  datalib.DoNamesMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname,2) < 2
							 ,equal(left,right));



resd := dedup(result1+result2,old_rid,new_rid,all);

return resd; 

END;