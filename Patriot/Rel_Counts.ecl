import header;
r := header.File_Relatives;

rp := record
  r.person1;
  r.person2;
  end;

r1 := table(r,rp);

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