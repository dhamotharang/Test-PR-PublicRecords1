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
output(topn(property_id_stat, 1000, -cnt_deeds_mortgages), {avm_property_id, cnt_deeds_mortgages}, named('Property_Id_Stat_Deeds_Mortgages'), all);
output(topn(property_id_stat, 1000, -cnt_assessors), {avm_property_id, cnt_assessors}, named('Property_Id_Stat_Assessors'), all);
output(topn(property_id_stat, 1000, -total_cnt_dayton), {avm_property_id, total_cnt_dayton}, named('Property_Id_Stat_Total_Dayton'), all);
output(topn(property_id_stat, 1000, -total_cnt_okcity), {avm_property_id, total_cnt_okcity}, named('Property_Id_Stat_Total_OKCity'), all);

// Distribution stats by state
layout_state_stat := record
sf_slim.st;
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

state_stat := table(sf_slim, layout_state_stat, st);

output(sort(state_stat, -total_cnt), {st, total_cnt}, named('State_Stat_Total'), all);
output(sort(state_stat, -cnt_deeds_mortgages), {st, cnt_deeds_mortgages}, named('State_Stat_Deeds_Mortgages'), all);
output(sort(state_stat, -cnt_assessors), {st, cnt_assessors}, named('State_Stat_Assessors'), all);
output(sort(state_stat, -total_cnt_dayton), {st, total_cnt_dayton}, named('State_Stat_Total_Dayton'), all);
output(sort(state_stat, -total_cnt_okcity), {st, total_cnt_okcity}, named('State_Stat_Total_OKCity'), all);

// Distribution stats by State, County
layout_state_county_stat := record
sf_slim.st;
sf_slim.county_name;
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

state_county_stat := table(sf_slim, layout_state_county_stat, st, county_name);

output(sort(state_county_stat, -total_cnt), {st, county_name, total_cnt}, named('State_County_Stat_Total'), all);
output(sort(state_county_stat, -cnt_deeds_mortgages), {st, county_name, cnt_deeds_mortgages}, named('State_County_Stat_Deeds_Mortgages'), all);
output(sort(state_county_stat, -cnt_assessors), {st, county_name, cnt_assessors}, named('State_County_Stat_Assessors'), all);
output(sort(state_county_stat, -total_cnt_dayton), {st, county_name, total_cnt_dayton}, named('State_County_Stat_Total_Dayton'), all);
output(sort(state_county_stat, -total_cnt_okcity), {st, county_name, total_cnt_okcity}, named('State_County_Stat_Total_OKCity'), all);

// Distribution stats by GEOLINK
layout_GEOLINK_stat := record
sf_slim.GEOLINK;
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

GEOLINK_id_stat := table(sf_slim, layout_GEOLINK_stat, GEOLINK);

output(topn(GEOLINK_id_stat, 1000, -total_cnt), {GEOLINK, total_cnt}, named('GEOLINK_Stat_Total'), all);
output(topn(GEOLINK_id_stat, 1000, -cnt_deeds_mortgages), {GEOLINK, cnt_deeds_mortgages}, named('GEOLINK_Stat_Deeds_Mortgages'), all);
output(topn(GEOLINK_id_stat, 1000, -cnt_assessors), {GEOLINK, cnt_assessors}, named('GEOLINK_Stat_Assessors'), all);
output(topn(GEOLINK_id_stat, 1000, -total_cnt_dayton), {GEOLINK, total_cnt_dayton}, named('GEOLINK_Stat_Total_Dayton'), all);
output(topn(GEOLINK_id_stat, 1000, -total_cnt_okcity), {GEOLINK, total_cnt_okcity}, named('GEOLINK_Stat_Total_OKCity'), all);

// Distribution stats by zip
layout_zip_stat := record
sf_slim.zip;
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

zip_id_stat := table(sf_slim, layout_zip_stat, zip);

output(topn(zip_id_stat, 1000, -total_cnt), {zip, total_cnt}, named('Zip_Stat_Total'), all);
output(topn(zip_id_stat, 1000, -cnt_deeds_mortgages), {zip, cnt_deeds_mortgages}, named('Zip_Stat_Deeds_Mortgages'), all);
output(topn(zip_id_stat, 1000, -cnt_assessors), {zip, cnt_assessors}, named('Zip_Stat_Assessors'), all);
output(topn(zip_id_stat, 1000, -total_cnt_dayton), {zip, total_cnt_dayton}, named('Zip_Stat_Total_Dayton'), all);
output(topn(zip_id_stat, 1000, -total_cnt_okcity), {zip, total_cnt_okcity}, named('Zip_Stat_Total_OKCity'), all);
