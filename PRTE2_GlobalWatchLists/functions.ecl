Import GlobalWatchLists,ut,prte2_header,aid,header,lib_datalib,Data_Services,doxie;

EXPORT functions := module

//Baddies
Export Baddies := function
rel_counts := function
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
return ta; 
end;

//Bad_Names
Bad_Names := function
GWL_Base := DATASET(constants.Base_GWL, layouts.Layout_GWL, FLAT );
p:=Project(GWL_Base (did !=0),
Transform(Layouts.Layout_Patriot_addressid,
Self:=Left;
Self:=[];
));
//p:=files.File_Patriot;

r := record
  unsigned1 one := 1;
  p.fname;
  p.mname;
  p.lname;
  end;
return dedup(table(p(fname<>'',lname<>''),r),fname,lname,mname,all);
End;

//UniqueNames
UniqueNames :=Function
h := header.file_headers;
hr := record
  string20 fname := h.fname;
  string20 lname := h.lname;
  string20 mname := h.mname;
  end;
ht := dedup(table(h,hr),fname,lname,mname,all);
return ht; 
end;

//ScoreNames
ScoreNames := function
u := UniqueNames;
Urec := record
	U;
	unsigned4	seq;
end;
Urec into_seq(U L, integer C) := transform
	self.seq := C;
	self := L;
end;
u2 := project(u,into_seq(LEFT,COUNTER));
res := record
  U;
  unsigned2 score := 0;
  end;
bads := Bad_Names;
integer namecheck(string20 f1,string20 m1, string20 l1,
   string20 f2,string20 m2, string20 l2) := MIN(datalib.namematch(f1,m1,l1,f2,m2,l2),3);
res compare(U2 L, Bads R) := transform
	  self.score := namecheck(L.fname,L.mname,L.lname,R.fname,R.mname,R.lname);
	  self := L;
end;
o1a := join(U2(seq % 4 = 0),bads,
			 namecheck(Left.fname,Left.mname,Left.lname,
			 Right.fname,Right.mname,Right.lname) < 3 ,
			 compare(LEFT,RIGHT),left outer,all); 
o1b := join(U2(seq % 4 = 1),bads,
			 namecheck(Left.fname,Left.mname,Left.lname,
			 Right.fname,Right.mname,Right.lname) < 3 ,
			 compare(LEFT,RIGHT),left outer,all);
o1c := join(U2(seq % 4 = 2),bads,
			 namecheck(Left.fname,Left.mname,Left.lname,
			 Right.fname,Right.mname,Right.lname) < 3 ,
			 compare(LEFT,RIGHT),left outer,all);
o1d := join(U2(seq % 4 = 3),bads,
			 namecheck(Left.fname,Left.mname,Left.lname,
			 Right.fname,Right.mname,Right.lname) < 3 ,
			 compare(LEFT,RIGHT),left outer,all);
o1 := o1a + o1b + o1c + o1d;
res roll(o1 L, o1 R) := transform
	self.score := if (L.score < R.score, L.score, R.score);
	self := L;
end;
o2 := rollup(sort(distribute(o1,hash(lname)),lname,fname,mname,local),left.fname = right.fname and left.mname = right.mname and left.lname = right.lname,
			roll(LEFT,RIGHT),local);
return o2;
End;

//File_ScoredNames
File_ScoredNames := Function
mr := record
  ScoreNames;
  end;
return dataset(constants.FileName_Scorenames,mr,flat);
End;

//Bad_Dids
Bad_Dids := function
h := header.file_headers;
hr := record
  unsigned1 one := 1;
  h.did;
  h.fname;
  h.lname;
  h.mname;
  end;
ht := dedup(table(h,hr),did,fname,lname,mname,all);
di := record
  unsigned6 did;
  unsigned8 zero := 0;
  end;
di take_did(hr le) := transform
  self := le;
  end;
br := join(ht,File_ScoredNames(score<3),left.fname=right.fname and left.mname=right.mname and
           left.lname=right.lname,take_did(left),hash);
return dedup(br,did,all); 
End;

//First_Seens
First_Seens := Function
h := header.file_headers;
hr := record
  h.did;
  unsigned8 dfs := if ( h.dt_vendor_first_reported=0 or h.dt_first_seen > 0 and h.dt_first_seen<h.dt_vendor_first_reported,
                    h.dt_first_seen,h.dt_vendor_first_reported);
  end;
ht := table(h,hr);
hm := record
  ht.did;
  unsigned8 df := min(group,ht.dfs);
  end;
return table(ht,hm,ht.did,local);
End;

//BadNames_EveryNode
BadNames_EveryNode := Function
bn2 := record
  Bad_Names;
  unsigned2 dist_place;
  end;
bn2 dup(Bad_Names le,unsigned2 cnt) := transform
  self := le;
  self.dist_place := cnt;
  end;
b_ndist := distribute(normalize(Bad_Names,thorlib.nodes(),dup(left,counter)),dist_place);
Return b_ndist;
End;

//Dids_With_Namehook
Dids_With_Namehook:=function
f := header.file_headers;
r1 := record
  f;
  unsigned one := 1;
  end;
r1 take_l(f le) := transform
  self := le;
  end;
t_score := record
  unsigned6 did;
  string20 fname;
  string20 mname;
  string20 lname;
  end;
jo := join(f,distribute(Bad_Dids,hash(did)),left.did=right.did,take_l(left),local);
b_ndist := BadNames_EveryNode;
t_score take(jo le, b_ndist ri) := transform
  self.did := le.did;
  self.fname := ri.fname;
  self.mname := ri.mname;
  self.lname := ri.lname;
  end;
jt := join(jo,b_ndist,left.one=right.one and
      lib_datalib.datalib.DoNamesMatch(left.fname,left.mname,left.lname,
      right.fname,right.mname,right.lname,3)<3,
      take(left,right),local,right outer);
return jt; 
End;

//Annotated_Badguys
Annotated_Badguys:=function 
jt := Dids_With_Namehook;
popu := record
  jt.fname;
  jt.mname;
  jt.lname;
  unsigned4 cnt := count(group);
  end;
ta := table(dedup(jt,fname,mname,lname,did,all),popu,fname,mname,lname);
return sort(ta,-cnt); 
End;
b1 := Dids_With_Namehook;
res_type1 := record
  unsigned6 did;
  unsigned4 other_count;
  unsigned4 first_seen;
  unsigned2 rel_count;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	unsigned8 dummy := 0;
  end;
res_type1 take_ocount(b1 le,Annotated_Badguys ri) := transform
  self.did := le.did;
  self.other_count := ri.cnt;
	self.fname := ri.fname;
	self.mname := ri.mname;
	self.lname := ri.lname;
	SELF := [];
  end;
j01 := join(b1,Annotated_Badguys,left.fname=right.fname and
                               left.mname=right.mname and
                               left.lname=right.lname,
                               take_ocount(left,right),hash);
j0 := dedup(sort(distribute(j01,hash(did)),did,other_count,local),did,local);
res_type1 take_relcount(j0 le,rel_counts ri) := transform
  self.rel_count := ri.cnt;
  self.first_seen := 0;
  self := le;
  end;
j1 := join(j0,rel_counts,left.did=right.did,
             take_relcount(left,right),hash,left outer);
res_type1 take_fs(j1 le,First_Seens ri) := transform
  self.first_seen := ri.df;
  self := le;
  end;
j2 := join(j1,First_Seens,left.did=right.did,take_fs(left,right),hash,left outer);
return j2; 
End;

//Key_Baddids_with_name
Export Key_Baddids_with_name := function
p := Baddies;
p1 :=
RECORD
	p;
	INTEGER nmscore;
END;
keyrec := doxie.key_header;

tmpi :=   INDEX(keyRec,{keyRec.s_did}, {keyrec}, data_services.data_location.prefix('person_header')+'prte::key::header::qa::data');

redist := DISTRIBUTE(p, tmpi, LEFT.did = RIGHT.s_did);
p1 getBestName(redist le, tmpi ri) :=
TRANSFORM
	SELF.fname := ri.fname;
	SELF.mname := ri.mname;
	SELF.lname := ri.lname;
	SELF.nmscore := datalib.namematch(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname);
	SELF := le;
END;
j := JOIN(redist,tmpi,LEFT.did=RIGHT.s_did,getBestName(LEFT,RIGHT));
return PROJECT(DEDUP(SORT(j,did,nmscore),did),TRANSFORM(recordof(p), SELF := LEFT));
end;
End;