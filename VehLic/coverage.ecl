import vehlic, ut;

ds := vehlic.File_Vehicles;

rec := record
 string2  st;
 string2  src;
 string12 rec_type;
 string8  coverage_dt;
end;

rec t_reg_recs(ds l) := transform
 
 string8 v_dt := if(length(trim(l.registration_effective_date))=8,l.registration_effective_date,
                 if(length(trim(l.registration_effective_date))=6,l.registration_effective_date+'00',
				 ''));
 
 self.st          := l.orig_state;
 self.src         := l.source_code;
 self.rec_type    := 'REGISTRATION';
 self.coverage_dt := v_dt;
end;

rec t_titl_recs(ds l) := transform

 string8 v_dt := if(length(trim(l.title_issue_date))=8,l.title_issue_date,
                 if(length(trim(l.title_issue_date))=6,l.title_issue_date+'00',
				 ''));

 self.st          := l.orig_state;
 self.src         := l.source_code;
 self.rec_type    := 'TITLE';
 self.coverage_dt := v_dt;
end;

p_reg_recs   := sort(distribute(project(ds(REGISTRATION_EFFECTIVE_DATE<>'' and REGISTRATION_EFFECTIVE_DATE[1..6] between '197000' and ut.GetDate[1..6]),t_reg_recs(left)),hash(st,src)),st,src,local);
p_titl_recs  := sort(distribute(project(ds(TITLE_ISSUE_DATE<>''            and TITLE_ISSUE_DATE[1..6]            between '197000' and ut.GetDate[1..6]),t_titl_recs(left)),hash(st,src)),st,src,local);

stat_reg := record
 p_reg_recs.st;
 p_reg_recs.src;
 p_reg_recs.rec_type;
 unsigned4 reg_recs   := count(group);
 unsigned4 min_reg_dt := min(group,(unsigned4)p_reg_recs.coverage_dt);
 unsigned4 max_reg_dt := max(group,(unsigned4)p_reg_recs.coverage_dt);
end;

stat_titl := record
 p_titl_recs.st;
 p_titl_recs.src;
 p_titl_recs.rec_type;
 unsigned4 titl_recs   := count(group);
 unsigned4 min_titl_dt := min(group,(unsigned4)p_titl_recs.coverage_dt);
 unsigned4 max_titl_dt := max(group,(unsigned4)p_titl_recs.coverage_dt);
end;

t_reg  := table(p_reg_recs,stat_reg,st,src,rec_type,few);
t_titl := table(p_titl_recs,stat_titl,st,src,rec_type,few);

output(t_reg);
output(t_titl);

rec2 := record
 string2   st;
 string2   src;
 string12  rec_type_reg;
 unsigned4 reg_recs;
 unsigned4 min_reg_dt;
 unsigned4 max_reg_dt;
 string12  rec_type_titl;
 unsigned4 titl_recs;
 unsigned4 min_titl_dt;
 unsigned4 max_titl_dt;
end;

rec2 t_join(t_reg l, t_titl r) := transform
 
 boolean has_left_rec  := if(l.st<>'',true,false);
 boolean has_right_rec := if(r.st<>'',true,false);
 
 self.st            := if(has_left_rec,l.st,r.st);
 self.src           := if(has_left_rec,l.src,r.src);
 self.rec_type_reg  := l.rec_type;
 self.reg_recs      := l.reg_recs;
 self.min_reg_dt    := l.min_reg_dt;
 self.max_reg_dt    := l.max_reg_dt;
 self.rec_type_titl := r.rec_type;
 self.titl_recs     := r.titl_recs;
 self.min_titl_dt   := r.min_titl_dt;
 self.max_titl_dt   := r.max_titl_dt;
end;

out := join(t_reg,t_titl,
            (left.st=right.st and left.src=right.src),
			t_join(left,right),
			full outer);

export coverage := output(sort(out,st,src),named('Vehicle_Coverages'));