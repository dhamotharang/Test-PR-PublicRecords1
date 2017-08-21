import ingenix_natlprof;

providers := ingenix_natlprof.basefile_provider_did;

layout_provider_with_flags := record 
recordof(providers);
boolean has_death;
boolean has_sanction := false;
boolean has_sor := false;
boolean has_crim := false;
end;

pdd := dataset('~thor::temp::_provider_derogatories',layout_provider_with_flags,flat);


layout_report := record
string2 state := pdd.prov_clean_st;
integer total_cnt 	:= count(group);
integer death_cnt 	:= count(group,pdd.has_death);
integer sanction_cnt := count(group,pdd.has_sanction);
integer sor_cnt		:= count(group,pdd.has_sor);
integer crim_cnt	:= count(group,pdd.has_crim);
end;

pdd_table := table(pdd,layout_report,pdd.prov_clean_st);

output(pdd_table);

