#workunit('name','Official Records');


import official_records,Business_Header;

d1 := official_records.File_Moxie_Party_Dev(doc_filed_dt <> '');
 
Official_Records.Layout_Moxie_Party proj_rec(d1 l) := transform
 self.doc_filed_dt := Business_Header.validatedate(l.doc_filed_dt);
 self := l;
end;
 

d := project(d1,proj_rec(left));

 stat_rec :=  record
'official_records_party',
d.vendor,
d.state_origin,
d.county_name,
process_dt := max(group,d.process_date);
start_date := min(group,d.doc_filed_dt);
end_date := max(group,d.doc_filed_dt );
total := count(group);
process_date_count := count(group, d.process_date <> '');
vendor_count := count(group, d.vendor <> '');
state_origin_count := count(group, d.state_origin <> '');
county_name_count := count(group, d.county_name <> '');
official_record_key_count := count(group, d.official_record_key <> '');
doc_instrument_or_clerk_filing_num_count := count(group, d.doc_instrument_or_clerk_filing_num <> '');
doc_filed_dt_count := count(group, d.doc_filed_dt <> '');
doc_type_desc_count := count(group, d.doc_type_desc <> '');
entity_sequence_count := count(group, d.entity_sequence <> '');
entity_type_cd_count := count(group, d.entity_type_cd <> '');
entity_type_desc_count := count(group, d.entity_type_desc <> '');
entity_nm_count := count(group, d.entity_nm <> '');
entity_nm_format_count := count(group, d.entity_nm_format <> '');
entity_dob_count := count(group, d.entity_dob <> '');
entity_ssn_count := count(group, d.entity_ssn <> '');

end;
//dist1 := distribute(d,HASH(county_name));
//sort_cty := sort(dist1,d.county_name,local);
//dedp_cty := dedup(sort_cty,d.county_name,local);
stats := table(d(doc_filed_dt <> ''),stat_rec,vendor,state_origin,county_name,few);

export official_records_party_stats := output(topn(stats,100,county_name));