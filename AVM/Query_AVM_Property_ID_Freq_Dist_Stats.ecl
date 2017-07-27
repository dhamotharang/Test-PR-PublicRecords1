// AVM File Distribution stats

sf := AVM.avm_search;

layout_search_slim := record
sf.avm_property_id;
string1 record_source := sf.ln_fares_id[1];
string1 record_type := sf.ln_fares_id[2];
sf.GEOLINK;
sf.county_name;
sf.st;
sf.zip;
end;

sf_slim := table(sf, layout_search_slim);

// Distribution stats by property_id
layout_property_id_stat := record
sf_slim.avm_property_id;
total_cnt := count(group);
cnt_deeds_mortgages := count(group, sf_slim.record_type in ['D','M']);
cnt_assessors := count(group, sf_slim.record_type = 'A');
total_cnt_dayton := count(group, sf_slim.record_source = 'D');
cnt_deeds_mortgages_dayton := count(group, sf_slim.record_type in ['D','M'] and sf_slim.record_source = 'D');
cnt_assessors_dayton := count(group, sf_slim.record_type = 'A' and sf_slim.record_source = 'D');
total_cnt_okcity := count(group, sf_slim.record_source = 'O');
cnt_deeds_mortgages_okcity := count(group, sf_slim.record_type in ['D','M'] and sf_slim.record_source = 'O');
cnt_assessors_okcity := count(group, sf_slim.record_type = 'A' and sf_slim.record_source = 'O');
end;

property_id_stat := table(sf_slim, layout_property_id_stat, avm_property_id);

output(topn(property_id_stat, 1000, -total_cnt), {avm_property_id, total_cnt}, named('Property_Id_Stat_Total'), all);

// Frequency Distribution

layout_property_id_freq := record
property_id_stat.total_cnt;
number_of_property_ids := count(group);
end;

property_id_freq_stat := table(property_id_stat, layout_property_id_freq, total_cnt, few);

output(topn(property_id_freq_stat, 1000, -number_of_property_ids), named('Property_Id_Freq_Dist'), all);
