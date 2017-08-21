import avm_v2;

avm_file := avm_v2.file_avm_base((prim_range<>'' or prim_name<>'') and zip<>'' and automated_valuation>0);

r1 := record
 unsigned8 aid;
 avm_file;
end;

r1 t1(avm_file le) := transform
 self.aid := ixi.fn_address_hash(le.prim_range,le.prim_name,le.sec_range,le.zip);
 self     := le;
end;

p1 := distribute(project(avm_file,t1(left)),hash(aid));

r2 := record
 p1.aid;
 p1.automated_valuation;
 integer aid_av_ct := count(group);
end;

ta1 := table(p1,r2,aid,automated_valuation,local);

//W20080618-135747
//shows that avm has approx 1.6M addresses with more than 1 valuation
f1 := ta1(aid_av_ct=1);

r1 t2(p1 le, f1 ri) := transform
 self := le;
end;

j1 := join(p1,f1,left.aid=right.aid and left.automated_valuation=right.automated_valuation,t2(left,right),local,keep(1));

export get_avm := dedup(j1,aid) : persist('persist::ixi_get_avm');