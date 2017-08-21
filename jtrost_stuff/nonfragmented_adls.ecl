import header;

export nonfragmented_adls(dataset(recordof(header.Layout_Header)) ds0) :=
function

ds := distribute(ds0,hash(did));

r1 := record
 ds.did;
 string1   has_eq_rec    :='';
 string1   has_other_rec :='';
 string1   has_mi_rec    :='';
 string1   has_nm_suffix :='';
 string1   has_dob       :='';
 unsigned8 did_ct        := 1;
 string6   dt_first_seen1;
 string6   dt_last_seen1;
end;

eq_sources := ['EQ','MU','U','UT','UW'];

r1 t1(ds le) := transform
 self.has_eq_rec    := if(le.src in     eq_sources,'Y','N');
 self.has_other_rec := if(le.src not in eq_sources,'Y','N');
 self.has_mi_rec    := if(le.src in ['MA','MI'],'Y','N');
 self.has_nm_suffix := if(le.name_suffix<>'','Y','N');
 self.has_dob       := if(le.dob<>0,'Y','N');
 self.dt_first_seen1 := '';
 self.dt_last_seen1  := '';
 self               := le;
end;

p1      := project   (ds,t1(left));
p1_sort := sort      (p1,did,local);

r1 t2(p1_sort le, p1_sort ri) := transform
 self.has_eq_rec    := if(le.has_eq_rec   ='Y',le.has_eq_rec,   ri.has_eq_rec);
 self.has_other_rec := if(le.has_other_rec='Y',le.has_other_rec,ri.has_other_rec);
 self.has_mi_rec    := if(le.has_mi_rec   ='Y',le.has_mi_rec,   ri.has_mi_rec);
 self.has_nm_suffix := if(le.has_nm_suffix='Y',le.has_nm_suffix,ri.has_nm_suffix);
 self.has_dob       := if(le.has_dob='Y',      le.has_dob,      ri.has_dob);
 self.did_ct        := le.did_ct+1;
 self               := le;
end;

p2       := rollup    (p1_sort,left.did=right.did,t2(left,right),local);// : persist('header_did_counts');

    fragments := p2(did_ct=1);
non_fragments := p2(did_ct>1);

r1 get_dates_for_fragments(fragments le, ds ri) := transform
 self.dt_first_seen1 := if(ri.dt_first_seen<>0,(string)ri.dt_first_seen,'');
 self.dt_last_seen1  := if(ri.dt_last_seen <>0,(string)ri.dt_last_seen, '');
 self               := le;
end;

j1 := join(fragments,ds,
           left.did=right.did,
		   get_dates_for_fragments(left,right),
		   local
		  );

concat := (j1 + non_fragments) : persist('header_rec_counts_per_did');		  

return concat;

end;