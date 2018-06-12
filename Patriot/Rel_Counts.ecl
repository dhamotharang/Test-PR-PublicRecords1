import header,relationship;
r := relationship.file_relative;

rp := record
  unsigned6 person1;
  unsigned6 person2;
  end;

r1 := project(r,transform(rp,Self.person1:=Left.did1;Self.person2:=Left.did2;));

rp switch(r1 le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  end;

p := project(r1,switch(left));

bth := r1 + p;

rt := record
  unsigned6 did := bth.person1;
  unsigned2 cnt := count(group);
  end;

ta := table(bth,rt,person1);

export Rel_Counts := ta :persist('patriot_relative_counts');