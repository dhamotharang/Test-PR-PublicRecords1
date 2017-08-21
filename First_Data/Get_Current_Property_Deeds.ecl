import ln_property, ut, ln_propertyv2;

d_deed       := ln_propertyv2.File_Deed(recording_date<>'',recording_date between '19500101' and ut.GetDate);
d_assr_sales := ln_propertyv2.File_Assessment(recording_date<>'',recording_date between '19500101' and ut.GetDate);
d_srch       := ln_propertyv2.File_Search_DID(lname<>'',prim_range<>'',prim_name<>'',zip<>'',source_code in ['BP','OP']);//Removed DID<>0

r_slim_deed := record
 string12 ln_fares_id;
 string8  recording_date;
end;

r_slim_assr_sales := record
 string12 ln_fares_id;
 string8  recording_date;
end;

r_slim_srch := record
 string12 ln_fares_id;
 string12 did;
 string20 lname;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string2  postdir;
 string8  sec_range;
 string2  st;
 string5  zip;
end;
  
  
r_slim_deed t_slim_deed(d_deed l) := transform
 self := l;
end;

r_slim_assr_sales t_slim_assr_sales(d_assr_sales l) := transform
 self := l;
end;

r_slim_srch t_slim_srch(d_srch l) := transform
 self.did := intformat(l.did,12,1);
 self     := l;
end;

deed_sales := project(d_deed,t_slim_deed(left));
assr_sales := project(d_assr_sales,t_slim_assr_sales(left));

d_slim_deed_dist := distribute(deed_sales+assr_sales,hash(ln_fares_id));
d_slim_deed_sort := sort      (d_slim_deed_dist,ln_fares_id,recording_date,local);
d_slim_deed      := dedup     (d_slim_deed_sort,ln_fares_id,recording_date,local);

//d_slim_deed := distribute(dedup(deed_sales+assr_sales,ln_fares_id,recording_date,all),hash(ln_fares_id));
d_slim_srch := distribute(dedup(project(d_srch,t_slim_srch(left)),ln_fares_id,lname,did,prim_range,prim_name,sec_range,zip,all),hash(ln_fares_id));

r_add_rec_dt := record
 r_slim_srch;
 string8 recording_date;
end;

r_add_rec_dt t_add_rec_dt(d_slim_deed l, r_slim_srch r) := transform
 self := l;
 self := r;
end;

d_srch_with_rec_dt := join(d_slim_deed,d_slim_srch,
                             left.ln_fares_id=right.ln_fares_id,
							 t_add_rec_dt(left,right),local
							);
							
d_srch_with_rec_dt_dupd := dedup(d_srch_with_rec_dt,all);

r1 := record
 string12 did;
 string20 lname;
 string8  recording_date;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string2  postdir;
 string8  sec_range;
 string2  st;
 string5  zip;
end;

r1 t_setup(d_srch_with_rec_dt_dupd l) := transform
 self := l;
end;

p2 := project(d_srch_with_rec_dt_dupd,t_setup(left));

p2_dist := distribute(p2,hash(prim_range,predir,prim_name,postdir,sec_range,st,zip));
p2_sort := sort      (p2_dist,prim_range,predir,prim_name,postdir,sec_range,st,zip,-recording_date,local);

r1 t_dunno(p2_sort l, p2_sort r) := transform
 
 v_true := if(l.recording_date>r.recording_date,true,false);
 
 self.lname          := if(v_true,l.lname,r.lname);
 self.did            := if(v_true,l.did,r.did);
 self.recording_date := if(v_true,l.recording_date,r.recording_date);
 self                := l;
end;

r1_rollup := rollup(p2_sort,
                         (left.prim_range =right.prim_range and
						  left.predir     =right.predir     and
						  left.prim_name  =right.prim_name  and
						  left.postdir    =right.postdir    and
						  left.sec_range  =right.sec_range  and
						  left.st         =right.st         and
						  left.zip        =right.zip
						 ),
						 t_dunno(left,right),
						 local
						);
						
r1_rollup_dist := distribute(r1_rollup,hash(prim_range,predir,prim_name,postdir,sec_range,st,zip));
r1_rollup_sort := sort      (r1_rollup_dist,prim_range,predir,prim_name,postdir,sec_range,st,zip,local);

r1 t_get_all(p2_sort l, r1_rollup_sort r) := transform
 self := l;
end;

r1_join := join(p2_sort,r1_rollup_sort,
                     (left.prim_range     = right.prim_range     and
					  left.predir         = right.predir         and
					  left.prim_name      = right.prim_name      and
					  left.postdir        = right.postdir        and
				      left.sec_range      = right.sec_range      and
					  left.st             = right.st             and
					  left.zip            = right.zip            and
					  left.recording_date = right.recording_date
					 ),
					 t_get_all(left,right),local,keep(1)
					);

export Get_Current_Property_Deeds := dedup(r1_join,all) : persist('~thor_dell400_2::persist::fds_curr_deeds');