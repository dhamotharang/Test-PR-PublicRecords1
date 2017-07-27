#workunit ('name', 'Business Header Bdid Distribution Stats ' + Business_Header.version);

bh := Business_Header.File_Business_Header;

// Total base records
output(count(bh), named('Total_Base_Records'));

// Count Unique BDIDs in the Business Header file
layout_bh_slim := record
bh.bdid;
end;

bh_slim := table(bh, layout_bh_slim);

layout_bh_stat := record
bh_slim.bdid;
cnt := count(group);
end;

bh_stats := table(bh_slim, layout_bh_stat, bdid);

// Number of unique bdids
output(count(bh_stats), named('Number_Unique_BDIDs'));

// Top 1000 bdids in base record count
output(topn(bh_stats, 1000, -cnt),all,named('Top_1000_Base_Record_Count'));

layout_base_record_distribution := record
base_record_cnt := bh_stats.cnt;
number_of_bdids := count(group);
end;

base_record_distribution_stat := table(bh_stats, layout_base_record_distribution, cnt, few);

// Base record BDID distribution
output(sort(base_record_distribution_stat, -number_of_bdids), all, named('Base_Record_BDID_Distribution'));

// Average base records per bdid
bdid_base_avg := ave(bh_stats, cnt);
output(bdid_base_avg, named('Avg_Base_Records_Per_BDID'));

// Best records with non-zero addresses
bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '');

layout_bhb_slim := record
bhb.bdid;
end;

bhb_slim := table(bhb, layout_bhb_slim);

// Select stats for BDIDs with non-blank addresses
bh_stats_nb := join(bh_stats,
                    bhb_slim,
				left.bdid = right.bdid,
				transform(layout_bh_stat, self := left),
				hash);

// Number of unique bdids with non-blank best address				
output(count(bh_stats_nb), named('Number_Unique_BDIDs_NonBlank_Addr'));

// Average base records per bdid with non-blank best address
bdid_base_avg_nb := ave(bh_stats_nb, cnt);
output(bdid_base_avg_nb, named('Avg_Base_Records_Per_BDID_NonBlank_Addr'));

layout_base_record_distribution_nb := record
base_record_cnt := bh_stats_nb.cnt;
number_of_bdids := count(group);
end;

base_record_distribution_stat_nb := table(bh_stats_nb, layout_base_record_distribution_nb, cnt, few);

// Base record BDID distribution for BDIDs with non-blank best address
output(sort(base_record_distribution_stat_nb,-number_of_bdids), all, named('Base_Record_BDID_Distribution_NonBlank_Addr'));