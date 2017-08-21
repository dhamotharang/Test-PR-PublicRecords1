export EntropyMatch(infile,outfile,outfile_amb) := macro

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
rdi(unsigned le,unsigned ri) := le=ri or ri=0;	//same idea, but accounts for 0 as a null
rdp(string le,string ri) := le=ri or ri='' or length(trim(ri))=1 and ri[1]=le[1];
dob_sub(unsigned4 le,unsigned4 ri) := le=ri or ri=0 or
                                      le div 100 = ri div 100 and ri % 100 = 0 or
                                      le div 10000 = ri div 10000 and ri % 10000 = 0;

lpe := record
  header.Layout_PairMatch;
  unsigned4 l_cnt;
	boolean is_amb := false;
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
  rdi((unsigned)left.phone,(unsigned)right.phone) and		//account for 0000000000.  essentially a workaround for data bug 31571 
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

o1_pre := dedup(sort(distribute(cj,old_rid),old_rid,new_rid,local),old_rid,new_rid,local);

lpe roll_ent(lpe le, lpe ri) :=
TRANSFORM
	SELF.is_amb := true;
	SELF := le;
END;

o1 := nofold(rollup(sort(o1_pre,old_rid,-l_cnt,new_rid,local),
						LEFT.old_rid=RIGHT.old_rid,roll_ent(LEFT,RIGHT),local)
						) : independent;  //nofold is a bug workaround (31565) and independent just makes the graph consolidate some work

hlpmp := record
	header.layout_pairmatch;
	boolean didswitch;
end;

hlpmp swinto(o1 le) := transform
	boolean toswitch := le.old_rid<le.new_rid;
  self.old_rid := IF(toswitch,le.new_rid,le.old_rid);
  self.new_rid := IF(toswitch,le.old_rid,le.new_rid);
  self.didswitch := toswitch;
  self := le;
  end;

 proj := distribute(project(o1(~is_amb),swinto(left)), hash(old_rid));
 ddpd := dedup(sort(proj, old_rid, if(didswitch, 1, 0), local),old_rid,local);
 outfile0 := project(ddpd, header.layout_pairmatch);
 
 typeof(outfile0) take_left(outfile0 le) := transform
  self := le;
  end;

outfile := join(outfile0,outfile0,left.new_rid=right.old_rid,take_left(left),hash,left only) : persist('persist::EntropyMatch');
 
outfile_amb := o1(is_amb);


  endmacro;