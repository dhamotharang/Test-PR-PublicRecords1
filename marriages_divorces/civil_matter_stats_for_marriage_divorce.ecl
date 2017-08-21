import civil_court;
m:=civil_court.File_Moxie_Matter_Prod;
m_stat_rec :=  record
m.state_origin,
m.source_file;
m.case_type;
m.case_cause;
total := count(group);
end;
ds_mstats := table(m,m_stat_rec,state_origin,source_file,case_type,case_cause,few);
ds_sorted2 := sort(ds_mstats,state_origin,source_file,case_type,case_cause);
export civil_matter_stats_for_marriage_divorce := ds_sorted2 : persist('TEMP::civil_matter_stats_for_marriage_divorce');

