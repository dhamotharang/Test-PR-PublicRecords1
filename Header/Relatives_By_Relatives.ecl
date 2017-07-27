f := header.file_relatives;

tf := record
  unsigned6 person1;
  unsigned6 person2;
  end;

tf out_2(layout_relatives le,unsigned1 cnt) := transform
  self.person1 := IF(cnt=1,le.person1,le.person2);
  self.person2 := IF(cnt=1,le.person2,le.person1);
  end;

pairs := normalize(f(number_cohabits>8),2,out_2(left,counter));

dpairs := distribute(pairs,hash(person1));

Layout_Relatives put_out(tf le, tf ri) := transform
  self.person1 := le.person2;
  self.person2 := ri.person2;
  self.same_lname := false;
  self.zip:=-2;
  self.prim_range:=-2;
  self.number_cohabits := 4;
  self.recent_cohabit := 0;
  end;

j := join(dpairs,dpairs,left.person1=right.person1 and
                        left.person2>right.person2,put_out(left,right),local);

//these are pairs of people(le.person2, ri.person2) 
//who are related to the same third person (le.person1 = ri.person1)
export Relatives_By_Relatives := dedup(j,person1,person2,all) : persist('relatives_by_relatives');