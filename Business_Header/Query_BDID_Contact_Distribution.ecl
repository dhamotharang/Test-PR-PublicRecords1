#workunit ('name', 'Business Contact Bdid Distribution Stats ' + Business_Header.version);

bc := Business_Header.File_Business_Contacts;

// Total base records
output(count(bc), named('Total_Base_Records'));

// Count Unique BDIDs in the Business Contact file
layout_bc_slim := record
bc.bdid;
bc.did;
bc.from_hdr;
end;

bc_slim := table(bc, layout_bc_slim);

// Count contact records by type
layout_bc_type_stat := record
cnt_from_business_record := count(group, bc_slim.from_hdr = 'N');
cnt_from_header_record := count(group, bc_slim.from_hdr = 'Y');
cnt_from_equifax := count(group, bc_slim.from_hdr = 'E');
end;

bc_type_stats := table(bc_slim, layout_bc_type_stat);

output(bc_type_stats, named('Business_Contact_Type_Stats'));

layout_bc_bdid_stat := record
bc_slim.bdid;
cnt := count(group);
end;

bc_bdid_stats := table(bc_slim(from_hdr='N', bdid <> 0), layout_bc_bdid_stat, bdid);

// Number of unique bdids
output(count(bc_bdid_stats), named('Number_Unique_BDIDs'));

// Top 1000 bdids in base contact record count
output(topn(bc_bdid_stats, 1000, -cnt),all,named('Top_1000_BDID_Base_Record_Count'));

layout_base_record_distribution := record
base_record_cnt := bc_bdid_stats.cnt;
number_of_bdids := count(group);
end;

base_record_distribution_stat := table(bc_bdid_stats, layout_base_record_distribution, cnt, few);

// Base record BDID distribution
output(sort(base_record_distribution_stat, -number_of_bdids), all, named('Base_Record_BDID_Distribution'));

// Average base records per bdid
bdid_base_avg := ave(bc_bdid_stats, cnt);
output(bdid_base_avg, named('Avg_Base_Records_Per_BDID'));

layout_bc_did_stat := record
bc_slim.did;
cnt := count(group);
end;

bc_did_stats := table(bc_slim(from_hdr='N', did <> 0), layout_bc_did_stat, did);

// Number of unique dids
output(count(bc_did_stats), named('Number_Unique_DIDs'));

// Top 1000 dids in base contact record count
output(topn(bc_did_stats, 1000, -cnt),all,named('Top_1000_DID_Base_Record_Count'));

layout_base_record_distribution_did := record
base_record_cnt := bc_did_stats.cnt;
number_of_dids := count(group);
end;

base_record_distribution_did_stat := table(bc_did_stats, layout_base_record_distribution_did, cnt, few);

// Base record BDID distribution
output(sort(base_record_distribution_did_stat, -number_of_dids), all, named('Base_Record_DID_Distribution'));

// Average base records per did
did_base_avg := ave(bc_did_stats, cnt);
output(did_base_avg, named('Avg_Base_Records_Per_DID'));

