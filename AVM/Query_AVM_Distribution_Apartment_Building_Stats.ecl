sf := AVM.avm_search;

layout_search_slim := record
sf.avm_property_id;
string1 record_source := sf.ln_fares_id[1];
string1 record_type := sf.ln_fares_id[2];
sf.GEOLINK;
sf.county_name;
sf.st;
sf.zip;
sf.prim_name;
sf.prim_range;
sf.predir;
sf.suffix;
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

property_id_list := topn(property_id_stat, 1000, -total_cnt);

layout_property_id_addr := record
  unsigned6 avm_property_id;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   suffix;
  string5   zip;
  integer4  apt_cnt := 0;
end;

property_id_addr_init := join(sf_slim,
                               property_id_list,
						 left.avm_property_id = right.avm_property_id,
						 transform(layout_property_id_addr, self := left),
						 lookup);
						 
property_id_addr_dedup := dedup(property_id_addr_init, all);
						 
apts := Header.ApartmentBuildings;

property_id_addr_apt := join(apts,
                             property_id_addr_dedup,
					    (string)left.zip = right.zip and
					      (string)left.prim_name = right.prim_name and
						 (string)left.prim_range = right.prim_range and
						 (string)left.suffix = right.suffix and
						 (string)left.predir = right.predir,
					    transform(layout_property_id_addr,
					              self.apt_cnt := left.apt_cnt,
							    self := right),
					    right outer,
					    hash);
					    
output(sort(property_id_addr_apt(apt_cnt > 1), -apt_cnt), all);
