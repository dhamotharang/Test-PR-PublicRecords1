// Best phone ... per the header data
import gong,ut,watchdog;

hin := watchdog.file_header_filtered((unsigned8)phone<>0);

dig8 := 10000000;
hi := record
  hin.fname;
  hin.mname;
  hin.lname;
  hin.did;
  hin.zip;
  hin.dt_last_seen;
  hin.dt_first_seen;
  unsigned8 phone := (unsigned8)hin.phone;
  unsigned1 quality := 0;
  end;

h := table(hin,hi);

g := gong.File_Gong_full(name_last<>'');

gi := record
  unsigned8 gp := (unsigned8)g.phone10%dig8;
  unsigned8 phone10 := (unsigned8)g.phone10;
  g.name_first;
  g.name_last;
  g.name_middle;
  g.z5;
  end;

tgi := table(g,gi);

hi improve_quality(h le, tgi ri) := transform
  self.quality := MAP( le.phone=ri.phone10 => 4,
                       le.phone%dig8=ri.gp and 
							(le.phone < dig8 or ri.phone10 < dig8) and
							(le.zip = ri.z5) => 3,
                       le.phone>dig8 => 2,
                       1 );
  self.phone := IF ( le.phone<dig8 and ri.phone10<>0 
						and	le.zip = ri.z5, ri.phone10, le.phone );
  self := le;
  end;

dtgi := distribute(tgi(gp<>0),hash(gp));

dd1 := dedup(sort(dtgi,phone10,name_last,name_first,name_middle,z5,local),phone10,name_last,name_first,name_middle,z5,local);

ut.MAC_Remove_Withdups_Local(dd1,gp,500,dd)

jt := join(h,dd,left.phone%dig8=right.gp and
               (datalib.namesimilar(left.lname,right.name_last,1)<2 or
                ut.namematch(left.fname,left.mname,left.lname,
                             right.name_first,right.name_middle,right.name_last)<2),
               improve_quality(left,right),hash,left outer);

hs := dedup(sort(distribute(jt,did),did,-(dt_last_seen+quality),-quality,dt_first_seen,local),did,local);

his := record
  hs.did;
  hs.phone;
  hs.quality;
  end;


sl_t := table(hs,his);

hh_t := header.File_HHID_Current(ver = 1);

h_to_t := record
  hh_t.did;
  hh_t.hhid_relat;
  unsigned8 phone := '';
  unsigned1 quality := 0;
  end;

hhids_and_dids := table(hh_t,h_to_t);

res := record
  unsigned6 did;
  unsigned6 hhid;
  unsigned8 phone;
  unsigned1 quality;
  end;

res join_h_p(hhids_and_dids le,sl_t ri) := transform
  self.phone := ri.phone;
  self.quality := ri.quality;
  self.hhid := le.hhid_relat;
  self := le;
  end;

hhid_to_phone := join(hhids_and_dids,sl_t,left.did=right.did,join_h_p(left,right),hash,left outer);

hhid_tp_dist := group(sort(distribute(hhid_to_phone,hash(hhid)),hhid,-quality,-phone,local),hhid,local);

res move_down(res le, res ri) := transform
  self.phone := if ( ri.phone<>0,ri.phone,le.phone );
  self.quality := if ( ri.phone<>0,ri.quality,le.quality );
  self := ri;
  end;

i := iterate(hhid_tp_dist,move_down(left,right));

export BestPhone :=  group(i(quality<>0)) : persist('Header_BestPhone');