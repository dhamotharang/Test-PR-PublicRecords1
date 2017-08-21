import civil_court;
p:=civil_court.File_Moxie_Party_Prod;
p_stat_rec :=  record
p.state_origin,
p.source_file;
p.entity_type_description_1_orig;
total := count(group);
end;
ds_pstats := table(p,p_stat_rec,state_origin,source_file,entity_type_description_1_orig,few);
ds_sorted := sort(ds_pstats,state_origin,source_file,entity_type_description_1_orig);
export civil_party_stats_for_marriage_divorce := ds_sorted : persist('TEMP::civil_party_stats_for_marriage_divorce');
