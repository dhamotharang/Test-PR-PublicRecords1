import official_records;

d := official_records.File_Moxie_Party_Dev;

//d := distribute(outf,hash(vendor));

stat_rec :=  record
'official_records_party',
d.vendor,
d.state_origin,
d.county_name,
official_records.Version_Development;
d.process_date;

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

stats := table(d,stat_rec,vendor,state_origin,county_name,d.process_date,few);

output(choosen(stats,1000));