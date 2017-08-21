
import risk_indicators,ut,header;

export fn_apply_title(dataset(recordof(header.layout_header)) in_hdr) := function

recordof(in_hdr) t1(in_hdr le) := transform
 self.title := '';
 self       := le;
end;

p1      := distribute(project(in_hdr,t1(left)),hash(did));
//generate gender base table
g_file  := risk_indicators.File_gender_base;

//drop where a DID has both genders
by_did  := distribute(g_file(did>0 and gender <> 'D'),hash(did));
//drop where a confidend greater than .95
by_fname := g_file(did=0 and confidence_score>.95 and length(trim(fname))>1);
by_mname := g_file(did=0 and confidence_score>.95 and mname <> '');

//apply gender by did
recordof(in_hdr) t2(p1 le, by_did ri) := transform
 self.title := if(ri.gender='M','MR',if(ri.gender='F','MS',''));
 self       := le;
end;

p2     := join(p1,by_did,left.did=right.did,t2(left,right),left outer, local);

p2_has_title    := p2(title <> '');
p2_has_no_title := p2(title = '');

//choose best fname

best_fname := header.fn_bestfname(in_hdr);
h_gender_rec := record
  string20 best_fname;
  string20 best_mname;
  string1 fname_gender;
  integer mname_count := 0;
  in_hdr;
  end;

h_gender_rec tbestfname(p2_has_no_title le, best_fname ri) := transform

self.best_fname := ri.fname;
self := le;
self := [];
end;

p2_has_bestfname := join(distribute(p2_has_no_title, hash(did)), distribute(best_fname,hash(did)),
 left.did = right.did, tbestfname(left, right), left outer, local);

//apply gender by fname

h_gender_rec t3(p2_has_bestfname le, by_fname ri) := transform
 self.title          := if(le.best_fname = ri.fname and ri.gender='M','MR',if(le.best_fname = ri.fname and ri.gender='F','MS',''));
 self.fname_gender   := if(le.best_fname = ri.fname, ri.gender, '');
 self       := le;
 self       := [];
end;

p3      := join(p2_has_bestfname,by_fname,left.best_fname=right.fname,t3(left,right),left outer,lookup);
p3_dist := distribute(p3,hash(did));

p3_grp := group(sort(p3_dist(title <> ''),did,local),did,local);
	
//rollup to see if there are any DID that are both male and female, if so make them 'D' as dual 
gender_did_rolled := group(rollup(p3_grp, true, transform(h_gender_rec, 
									 self.title := if(left.title = right.title, right.title, 'D');
									 self := right)));

//mark DID has two genders
p3_dist tdualgender(p3_dist le, gender_did_rolled ri) := transform

self.title := if(le.did = ri.did, ri.title, le.title);
self := le;

end;

p4 := join(p3_dist, gender_did_rolled, left.did = right.did, tdualgender(left, right), left outer, local);

//split did with two genders

p4_has_dual_gender :=  project(p4(title = 'D'), recordof(in_hdr));

p4_no_dual_gender  :=   p4(title <> 'D');

//apply gender by mname as additional gender enhancement

//Sort by DID and mname
srt_h := sort(distribute(p4_no_dual_gender(length(trim(mname,left,right)) > 1),hash(did)), did, mname, local);

//Group by DID and mname
grp := group(srt_h,did,local);

//Count the occurrances of each DID and mname combination
h_gender_rec cnt_mname(grp le, grp rt) := transform
self.mname_count := if(le.mname = rt.mname, le.mname_count + 1, le.mname_count);
self := rt;
  end;

mname_did_cnt := iterate(grp,cnt_mname(left,right));

//Sort and dedup by mname to give one record per DID/mname with the highest count
cnt_dedup := dedup(sort(mname_did_cnt,-mname_count),mname);

p4_no_dual_gender_dist := distribute(p4_no_dual_gender, hash(did));
p4_no_dual_gender_dedup := dedup(sort(p4_no_dual_gender_dist, did, fname_gender, local), did, fname_gender, local);

h_gender_rec tbestMname(p4_no_dual_gender_dedup le, cnt_dedup ri) := transform
self.best_mname := ri.mname;
self            := le;
self            := [];
end;

p4a      := join(p4_no_dual_gender_dedup, distribute(cnt_dedup, hash(did)), left.did =right.did,tbestMname(left,right),local);

recordof(in_hdr) tNobestMname(p4_no_dual_gender_dedup le, cnt_dedup ri) := transform
self            := le;
end;

p4_no_best_mname := join(p4_no_dual_gender_dedup, distribute(cnt_dedup, hash(did)), left.did =right.did,tNobestMname(left,right), left only, local);

recordof(in_hdr) t4b(p4a le, by_mname ri) := transform

string1 comb_gender := if(le.best_mname=ri.mname and le.fname_gender <> ri.gender, 'U',le.fname_gender);						  
self.title          := if(comb_gender='M','MR',if(comb_gender='F','MS',''));
self                := le;
end;

p4b      := join(p4a,by_mname,left.best_mname=right.mname,t4b(left,right),left outer,lookup);

p4b_dist := distribute(p4b + p4_no_best_mname,hash(did));

p4b_grp := group(sort(p4b_dist,did,local),did,local);
	
//just in case rollup to see if there are any DID that are both male and female, if so make them 'D' as dual 
p4_gender_did_rolled := group(rollup(p4b_grp, true, transform(recordof(in_hdr), 
									 self.title := if(left.title <> right.title and right.title <> '' and left.title <> '',
									 'D', if(left.title <> '', left.title, right.title));
									 self := right)));

//mark DID has two genders
recordof(in_hdr) tfinal(p4_no_dual_gender_dist le, p4_gender_did_rolled ri) := transform

self.title := if(le.did = ri.did, ri.title, le.title);
self := le;

end;

p5 := join(p4_no_dual_gender_dist, p4_gender_did_rolled, left.did = right.did, tfinal(left, right), left outer, local);

//combine dual gender
p6 := p2_has_title + p5 + project(p4_has_dual_gender, transform(recordof(p4_has_dual_gender), self.title := '', self := left));

p6_dist := distribute(p6, hash(did));

return p6_dist  ;

end;