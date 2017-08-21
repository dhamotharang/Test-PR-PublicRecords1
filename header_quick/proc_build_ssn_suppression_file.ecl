import header,watchdog,doxie,ut,suppress,PromoteSupers;

import suppress;

mask4    := [];
mask5    := ['MN'];
mask_all := [];

st_set   := mask4+mask5+mask_all;

full_ssn(string v_ssn) := function

 boolean is_valid := length(trim(v_ssn))=9 and v_ssn[1..5]<>'00000' and v_ssn not in ut.Set_BadSSN;
 
 return is_valid;
end;

qk_hdr    := header_quick.file_header_quick(full_ssn(ssn) and st in st_set and rec_type='1' );
wdog      := watchdog.File_Best            (full_ssn(ssn) and st in st_set);
wdog_filt := header_quick.fn_remove_watchdog_eq_ssns(wdog);
deaths    := dedup(sort(distribute(header.File_DID_Death_MasterV2(full_ssn(ssn)),hash(ssn)),ssn,record,local),ssn,record,local);

//output(count(wdog),named('watchdog_ssns_before'));
//output(count(wdog_filt),named('watchdog_ssns_after'));

r1 := record
 string9 ssn;
 string  ssn_mask;
 integer found_in;
 boolean deceased:=false;
 string  rc;
end;

r1 t1(qk_hdr le) := transform
 self.ssn      := le.ssn;
 self.ssn_mask := if(le.st in mask4,'LAST4',if(le.st in mask5,'FIRST5',if(le.st in mask_all,'ALL','')));
 self.found_in := 1;
 self.rc       := le.st;
end;

r1 t2(wdog_filt le) := transform
 self.rc       := le.rc;
 self.ssn      := le.ssn;
 self.ssn_mask := if(le.rc in mask4,'LAST4',if(le.rc in mask5,'FIRST5',if(le.rc in mask_all,'ALL','')));
 self.found_in := 2;
end;

p1 := project(qk_hdr,   t1(left));
p2 := project(wdog_filt,t2(left));

concat      := p1/*+p2*/;
concat_dist := distribute(concat,hash(ssn));
concat_sort := sort(concat_dist,ssn,rc,local);
concat_dupd := dedup(concat_sort,ssn,rc,record,local);

r1 t_rollup(concat_dupd le, concat_dupd ri) := transform
 self.ssn_mask := suppress.ssn_mask_math.add(le.ssn_mask,ri.ssn_mask);
 self.rc       := le.rc+','+ri.rc;
 self          := le;
end;

p_rollup := rollup(concat_dupd,left.ssn=right.ssn,t_rollup(left,right),local);

r1 t3(r1 le, deaths ri) := transform
 self.deceased := if(ri.ssn<>'',true,false);
 self          := le;
end;

j1 := join(p_rollup,deaths,left.ssn=right.ssn,t3(left,right),left outer,keep(1),local) : persist('persist::ssn_suppression');

f1 := j1(deceased=false);

r2 := record
 f1.ssn;
 f1.ssn_mask;
 f1.rc;
 string2 crlf := '\r\n';
end;

ta1 := table(f1,r2);

PromoteSupers.mac_sf_buildprocess(ta1, '~thor_data400::base::ssn_suppression', build_ssn_suppression, 2);

export proc_build_ssn_suppression_file := build_ssn_suppression;