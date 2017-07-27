import doxie,ingenix_natlprof;

exp_rec := record
	unsigned6 did;
	unsigned2 prov_count := 0;   
	unsigned2 sanc_count := 0;   
end;

prov := ingenix_natlprof.Basefile_Provider_Did;

exp_rec from_prov(prov le) := transform
  self.did := (unsigned6)le.did;
  self.prov_count := 1;
  end;

provs := project(prov,from_prov(left));

sanc := ingenix_natlprof.file_sanctions_cleaned_dided_dates;

exp_rec from_sanc(sanc le) := transform
  self.did := (unsigned6)le.did;
  self.sanc_count := 1;
  end;

sancs := project(sanc,from_sanc(left));

exp_combs := (provs+sancs)(did<>0);

exp_res_layout := record
  unsigned6 did := exp_combs.did;
  unsigned2 prov_count := sum(group,exp_combs.prov_count);
  unsigned2 sanc_count := sum(group,exp_combs.sanc_count);
end;      
           
exp_res := table(exp_combs,exp_res_layout,did);

full_rec := record
	doxie.Lookups;
	unsigned2 prov_count := 0;   
	unsigned2 sanc_count := 0;   
end;

full_rec get_exp(doxie.Lookups l, exp_res r) := transform
	self.did := if(l.did<>0, l.did, r.did);
	self := l;
	self := r;
end;

exp_final := join(doxie.Lookups, exp_res, 
                  left.did=right.did, get_exp(left, right), hash, full outer);

export exp_lookups := exp_final : persist('persist::exp_lookups');