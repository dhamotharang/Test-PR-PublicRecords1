src_set := ['DE','LT','MI','TU','DS','PD','L2','FD','LI','BA','FV','MA','6X','BX','VD','FW','MW'];

ds := jtrost_stuff.ssn_gather;

r1 := record
 string9 ssn;
end;

r1 t0(ds le) := transform
 self := le;
end;

r2 := record
 string9 ssn;
 boolean in_de;
 boolean in_lt;
 boolean in_mi;
 boolean in_tu;
 //boolean in_ds;
 boolean in_pd;
 boolean in_l2;
 boolean in_fd;
 //boolean in_li;
 boolean in_ba;
 boolean in_fv;
 boolean in_ma;
 boolean in_6x;
 boolean in_bx;
 boolean in_vd;
 boolean in_fw;
 boolean in_mw;
 boolean in_other_src;
end;

r2 t1(ds le) := transform
 self.in_de := if(le.src='DE',true,false);
 self.in_lt := if(le.src='LT',true,false);
 self.in_mi := if(le.src='MI',true,false);
 self.in_tu := if(le.src='TU',true,false);
 //self.in_ds := if(le.src='DS',true,false);
 self.in_pd := if(le.src='PD',true,false);
 self.in_l2 := if(le.src='L2',true,false);
 self.in_fd := if(le.src='FD',true,false);
 //self.in_li := if(le.src='LI',true,false);
 self.in_ba := if(le.src='BA',true,false);
 self.in_fv := if(le.src='FV',true,false);
 self.in_ma := if(le.src='MA',true,false);
 self.in_6x := if(le.src='6X',true,false);
 self.in_bx := if(le.src='BX',true,false);
 self.in_vd := if(le.src='VD',true,false);
 self.in_fw := if(le.src='FW',true,false);
 self.in_mw := if(le.src='MW',true,false);
 self.in_other_src := if(le.src not in src_set,true,false);
 self       := le;
end;

r2 set2_rold(r2 le, r2 ri) := transform
 self.in_de := if(le.in_de=true,le.in_de,ri.in_de);
 self.in_lt := if(le.in_lt=true,le.in_lt,ri.in_lt);
 self.in_mi := if(le.in_mi=true,le.in_mi,ri.in_mi);
 self.in_tu := if(le.in_tu=true,le.in_tu,ri.in_tu);
 //self.in_ds := if(le.in_ds=true,le.in_ds,ri.in_ds);
 self.in_pd := if(le.in_pd=true,le.in_pd,ri.in_pd);
 self.in_l2 := if(le.in_l2=true,le.in_l2,ri.in_l2);
 self.in_fd := if(le.in_fd=true,le.in_fd,ri.in_fd);
 //self.in_li := if(le.in_li=true,le.in_li,ri.in_li);
 self.in_ba := if(le.in_ba=true,le.in_ba,ri.in_ba);
 self.in_fv := if(le.in_fv=true,le.in_fv,ri.in_fv);
 self.in_ma := if(le.in_ma=true,le.in_ma,ri.in_ma);
 self.in_6x := if(le.in_6x=true,le.in_6x,ri.in_6x);
 self.in_bx := if(le.in_bx=true,le.in_bx,ri.in_bx);
 self.in_vd := if(le.in_vd=true,le.in_vd,ri.in_vd);
 self.in_fw := if(le.in_fw=true,le.in_fw,ri.in_fw);
 self.in_mw := if(le.in_mw=true,le.in_mw,ri.in_mw);
 self.in_other_src := if(le.in_other_src=true,le.in_other_src,ri.in_other_src);
 self       := le;
end;
 
set1 := project(ds(src ='--'),t0(left));
set2 := project(ds(src!='--'),t1(left));

set1_dist := distribute(set1,hash(ssn));
set2_dist := distribute(set2,hash(ssn));

set1_sort := sort(set1_dist,ssn,local);
set2_sort := sort(set2_dist,ssn,local);

set1_dupd := dedup(set1_sort,ssn,local);
set2_dupd := rollup(set2_sort,left.ssn=right.ssn,set2_rold(left,right),local);

r3 := record
 string9 ssn;
 boolean in_eq_ut;
 boolean in_other;
 set2_dupd.in_de;
 set2_dupd.in_lt;
 set2_dupd.in_mi;
 set2_dupd.in_tu;
 //set2_dupd.in_ds;
 set2_dupd.in_pd;
 set2_dupd.in_l2;
 set2_dupd.in_fd;
 //set2_dupd.in_li;
 set2_dupd.in_ba;
 set2_dupd.in_fv;
 set2_dupd.in_ma;
 set2_dupd.in_6x;
 set2_dupd.in_bx;
 set2_dupd.in_vd;
 set2_dupd.in_fw;
 set2_dupd.in_mw;
 set2_dupd.in_other_src;
end;

r3 t2(set1_dupd le, set2_dupd ri) := transform
 self.ssn      := if(le.ssn<>'',le.ssn,ri.ssn);
 self.in_eq_ut := if(le.ssn<>'',true,false);
 self.in_other := if(ri.ssn<>'',true,false);
 self          := ri;
end;

j1 := join(set1_dupd,set2_dupd,left.ssn=right.ssn,t2(left,right),full outer,local);

r4 := record
 j1.in_eq_ut;
 j1.in_other;
 count_ := count(group);
end;

ta1 := table(j1,r4,in_eq_ut,in_other,few);
//output(ta1);

ds_dist := dedup(sort(distribute(ds,hash(ssn)),ssn,src,local),ssn,src,local);
j1_filt := distribute(j1(in_eq_ut=false and in_other=true),hash(ssn));;

r5 := record
 count_ := count(group);
 j1_filt.in_de;
 j1_filt.in_lt;
 j1_filt.in_mi;
 j1_filt.in_tu;
 //j1_filt.in_ds;
 j1_filt.in_pd;
 j1_filt.in_l2;
 j1_filt.in_fd;
 //j1_filt.in_li;
 j1_filt.in_ba;
 j1_filt.in_fv;
 j1_filt.in_ma;
 j1_filt.in_6x;
 j1_filt.in_bx;
 j1_filt.in_vd;
 j1_filt.in_fw;
 j1_filt.in_mw;
 j1_filt.in_other_src;
end;

ta3      := table(j1_filt,r5,in_de,in_lt,in_mi,in_tu,/*in_ds,*/in_pd,in_l2,in_fd,/*in_li,*/in_ba,in_fv,in_ma,in_6x,in_bx,in_vd,in_fw,in_mw,in_other_src,few);
ta3_sort := sort(ta3,-count_);
//output(ta3_sort,all);

export ssn_doubles := sequential(output(ta1),output(ta3_sort,all));