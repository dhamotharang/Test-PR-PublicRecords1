import header,ut;

export eq_fragments(dataset(recordof(header.layout_header)) in_hdr, 
                    integer discard_mos_old, 
					boolean must_have_ssn
				   ) := function

hdr := distribute(in_hdr+header.transunion_did,hash(did));

r1 := record
 hdr.did;
 integer max_dt_last_seen;
 integer did_ct;
 boolean is_eq;
 boolean has_ssn;
end;

r1 t1(header.layout_header le) := transform
 self.max_dt_last_seen := le.dt_last_seen;
 self.did_ct           := 1;
 self.is_eq            := le.src='EQ';
 self.has_ssn          := le.ssn<>'';
 self                  := le;
end;

//exclude utility records to avoid double-counting -> EQ is the same vendor for utility
ut_recs  := hdr(src     in ['UT','UW']);
the_rest := sort(project(hdr(src not in ['UT','UW']),t1(left)),did,has_ssn,local);

r1 t2(r1 le, r1 ri) := transform
 self.max_dt_last_seen := ut.max2(le.max_dt_last_seen,ri.max_dt_last_seen);
 self.did_ct           := le.did_ct+1;
 self.is_eq            := if(le.is_eq=false,le.is_eq,ri.is_eq);
 self.has_ssn          := if(le.has_ssn=true,le.has_ssn,ri.has_ssn);
 self                  := le;
end;

p1 := rollup(the_rest,left.did=right.did,t2(left,right),local);

f1 := p1(did_ct=1 and is_eq=true);

r2 := record
 f1.max_dt_last_seen;
 count_ := count(group);
end;

ta1 := sort(table(f1,r2,max_dt_last_seen,few),-max_dt_last_seen);

r3 := record
 f1;
 integer  mos_diff;
 string13 bucket;
 integer  sort_order;
end;

integer today_in_mos := header.ConvertYYYYMMToNumberOfMonths((integer)ut.getdate);

r3 t3(f1 le) := transform

 integer v_mos_diff := today_in_mos - header.ConvertYYYYMMToNumberOfMonths(le.max_dt_last_seen);
					  
 self.mos_diff := v_mos_diff;
 self.bucket   := map(le.max_dt_last_seen=0            => 'no date avail',
                      self.mos_diff<=12                => (string)self.mos_diff+' month',
					  self.mos_diff between 13 and 18  => '13 and 18 mos',
					  self.mos_diff between 19 and 24  => '19 and 24 mos',
                      self.mos_diff between 25 and 36  => '2 and 3 yrs',
					  self.mos_diff between 37 and 48  => '3 and 4 yrs',
					  self.mos_diff between 49 and 60  => '4 and 5 yrs',
					  self.mos_diff between 61 and 120 => '5 and 10 yrs',
					  self.mos_diff>120                => 'over 10 yrs',
					  '-');
 self.sort_order := case(self.bucket,
                     '0 month'       => 1,
					 '1 month'       => 2,
					 '2 month'       => 3,
					 '3 month'       => 4,
					 '4 month'       => 5,
					 '5 month'       => 6,
					 '6 month'       => 7,
					 '7 month'       => 8,
					 '8 month'       => 9,
					 '9 month'       => 10,
					 '10 month'      => 11,
					 '11 month'      => 12,
					 '12 month'      => 13,
					 '13 and 18 mos' => 14,
					 '19 and 24 mos' => 15,
					 '2 and 3 yrs'   => 16,
					 '3 and 4 yrs'   => 17,
					 '4 and 5 yrs'   => 18,
					 '5 and 10 yrs'  => 19,
					 'over 10 yrs'   => 20,
					 'no date avail' => 21,
					 22);
 self          := le;
end;

p2 := project(f1,t3(left));

r4 := record
 p2.bucket;
 p2.sort_order;
 integer has_ssn := count(group,p2.has_ssn=true);
 count_          := count(group);
end;

ta2 := sort(table(p2,r4,bucket,sort_order,few),sort_order);

//represents the set of DID's to remove
f2 := if(must_have_ssn=true,
       p2(has_ssn=true and mos_diff>discard_mos_old and max_dt_last_seen>0),
	  p2(mos_diff>discard_mos_old and max_dt_last_seen>0));

f2_dist := distribute(f2,hash(did));

recordof(in_hdr) t4(hdr le, f2_dist ri) := transform
 self := le;
end;

j1 := join(hdr(src not in ['UT','UW']),f2_dist,left.did=right.did,t4(left,right),local) : persist('persist::old_eq_fragments');

output(count(f1),named('eq_fragments_ct'));
output(choosen(p2,500),named('samples'));
output(ta2,named('grouped_by_bucket'));

return j1;

end;