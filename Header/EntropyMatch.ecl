export EntropyMatch(infile,outfile) := macro

h := distribute(infile,hash(did));

rh := record
  h.did;
  end;

t := table(h,rh);

rht := record
  t.did;
  unsigned4 cnt := count(group);
  end;

ta := table(t,rht,did,local);

wh := record
  unsigned4 cnt;
  h;
  end;

wh add_cnt(h le,ta ri) := transform
  self := ri;
  self := le;
  end;

jb := join(h,ta,left.did=right.did,add_cnt(left,right),local);

rd(string le,string ri) := le=ri or ri='';
rdp(string le,string ri) := le=ri or ri='' or length(trim(ri))=1 and ri[1]=le[1];
dob_sub(unsigned4 le,unsigned4 ri) := le=ri or ri=0 or
                                      le div 100 = ri div 100 and ri % 100 = 0 or
                                      le div 10000 = ri div 10000 and ri % 10000 = 0;

lpe := record
  header.Layout_PairMatch;
  unsigned4 l_cnt;
  end;

lpe do_pair(jb le,jb ri) := transform
  self.old_rid := ri.did;
  self.new_rid := le.did;
  self.l_cnt := le.cnt;
  self.pflag := 11;
  end;

jb_dist := distribute(jb, hash(fname, lname, prim_range, prim_name, zip));

cj := join(jb_dist,jb_dist(cnt=1),
  left.fname=right.fname and
  left.lname=right.lname and
  left.prim_range=right.prim_range and
  left.prim_name=right.prim_name and
  rd(left.phone,right.phone) and
  rd(left.ssn,right.ssn) and
  dob_sub(left.dob,right.dob) and
  rd(left.title,right.title) and
  rdp(left.mname,right.mname) and
  rd(left.name_suffix,right.name_suffix) and
  rd(left.predir,right.predir) and
  rd(left.suffix,right.suffix) and
  rd(left.postdir,right.postdir) and
  rd(left.sec_range,right.sec_range) and
  left.city_name=right.city_name and
  left.did<>right.did and
  left.st=right.st and
  left.zip=right.zip and
  left.zip4=right.zip4,do_pair(left,right),local);

o1 := dedup(sort(distribute(cj,old_rid),old_rid,-l_cnt,new_rid,local),old_rid,local);

layout_pairmatch swinto(o1 le) := transform
  self.old_rid := IF(le.old_rid>le.new_rid,le.old_rid,le.new_rid);
  self.new_rid := IF(le.old_rid<le.new_rid,le.old_rid,le.new_rid);
  self := le;
  end;

outfile := dedup(project(o1,swinto(left)),old_rid,new_rid,all) : persist('persist::EntropyMatch');

  endmacro;