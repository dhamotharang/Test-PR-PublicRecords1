pdd := misc._pilot_derogatories_dedup;


layout_report := record
string2 state := pdd.st;
integer total_cnt 	:= count(group);
integer sor_cnt		:= count(group,pdd.has_sor);
integer crim_cnt	:= count(group,pdd.has_crim);
end;

pdd_table := table(pdd,layout_report,pdd.prov_clean_st);

output(pdd_table);

