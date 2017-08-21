glba_sources := ['EQ'];

header_oct := dataset('~thor_dell400_2::base::header_dis_20060924_patched',header.Layout_Header,flat);

r_oct := record
 header_oct.did;
 unsigned8 did_ct:= 1;
end;

r_oct t_oct(header.Layout_Header l) := transform
 self := l;
end;

p_oct      := project   (header_oct,t_oct(left));
p_oct_dist := distribute(p_oct,hash(did));
p_oct_sort := sort      (p_oct_dist,did,local);

r_oct t_oct_2(p_oct_sort l, p_oct_sort r) := transform
 self.did_ct := l.did_ct+1;
 self        := l;
end;

header_nonfragments      := rollup(p_oct_sort,left.did=right.did,t_oct_2(left,right))(did_ct>1) : persist('~thor_dell400_2::persist::oct_nonfragmented_adls');
header_nonfragments_dist := distribute(header_nonfragments,hash(did));


rec := record
 unsigned6 did;
end;

rec t_eq_recs(header_oct l) := transform
 self := l;
end;

//EQ records
p_eq_recs := project(header_oct(src in glba_sources),t_eq_recs(left));
p_eq_recs_dist := distribute(p_eq_recs,hash(did));
p_eq_recs_sort := sort      (p_eq_recs_dist,did,local);
p_eq_recs_dupd := dedup     (p_eq_recs_sort,did,local);
eq_dids := p_eq_recs_dupd;
//Non-EQ records
p_ne_eq_recs := project(header_oct(src not in glba_sources),t_eq_recs(left));
p_ne_eq_recs_dist := distribute(p_ne_eq_recs,hash(did));
p_ne_eq_recs_sort := sort      (p_ne_eq_recs_dist,did,local);
p_ne_eq_recs_dupd := dedup     (p_ne_eq_recs_sort,did,local);
ne_eq_dids := p_ne_eq_recs_dupd;

rec t_eq_nonfragments(rec l, r_oct r) := transform
 self := l;
end;

eq_nonfragments := join(eq_dids, header_nonfragments_dist,
                        left.did=right.did,
					    t_eq_nonfragments(left,right),
					    local);
//count(eq_nonfragments);

ne_eq_nonfragments := join(ne_eq_dids, header_nonfragments_dist,
                           left.did=right.did,
					       t_eq_nonfragments(left,right),
					       local);						
//count(ne_eq_nonfragments);

eq_nonfragments_dist    := distribute(eq_nonfragments,hash(did));
ne_eq_nonfragments_dist := distribute(ne_eq_nonfragments,hash(did));

rec t_eq_vs_ne_eq_nonfragments(rec l, rec r) := transform
 self := l;
end;

eq_unique_nonfragments := join(eq_nonfragments,ne_eq_nonfragments,
                               left.did=right.did,
							   t_eq_vs_ne_eq_nonfragments(left,right),
							   left only,local);
output(count(eq_unique_nonfragments),named('EQ_Unique'));						   

ne_eq_unique_nonfragments := join(eq_nonfragments,ne_eq_nonfragments,
                               left.did=right.did,
							   t_eq_vs_ne_eq_nonfragments(left,right),
							   right only,local);
output(count(ne_eq_unique_nonfragments),named('Non_EQ_Unique'));						   							   
					  