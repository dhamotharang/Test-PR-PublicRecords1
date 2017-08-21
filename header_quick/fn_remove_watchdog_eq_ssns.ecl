import header,watchdog,mdr;

//remove an ssn if it's only found in equifax

export fn_remove_watchdog_eq_ssns(dataset(recordof(watchdog.Layout_Best)) wdog0) := function

r1 := record
 string9 ssn;
 string2 rc;
end;

r1 t0(wdog0 le) := transform
 self.ssn := le.ssn;
 self.rc  := le.st;
end;

wdog := distribute(project(wdog0,t0(left)),hash(ssn));

hdr  := project(header.file_headers,header.layout_header_strings)(ssn<>'');

r2 := record
 hdr.src;
 hdr.ssn;
 boolean   ssn_only_from_eq;
end;

r2 t1(hdr le) := transform
 self.src              := if(mdr.sourceTools.SourceIsEquifax(le.src) or mdr.sourceTools.SourceIsUtility(le.src),'EQ',le.src);
 self.ssn_only_from_eq := if(mdr.sourceTools.SourceIsEquifax(le.src),true,false);
 self                  := le;
end;

p1      := project(hdr,t1(left));
p1_dist := distribute(p1,hash(ssn));
p1_sort := sort(p1_dist,ssn,local);

r2 t2(p1_sort le, p1_sort ri) := transform
 self.ssn_only_from_eq := if(le.ssn_only_from_eq=false,le.ssn_only_from_eq,ri.ssn_only_from_eq);
 self                  := le;
end;

p2      := rollup(p1_sort,left.ssn=right.ssn,t2(left,right),local);
p2_filt := p2(ssn_only_from_eq=false);

r1 t3(wdog le, p2_filt ri) := transform
 self := le;
end;

j1 := join(wdog,p2_filt,left.ssn=right.ssn,t3(left,right),local);

return j1;

end;