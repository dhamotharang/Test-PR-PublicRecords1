/*
  need way to do this for other patches/etc where we explode or change clusters
  1. custom code is needed to find the clusters to explode.  the code below is a template.
  2. reset clusters and write out patched file
  3. run proxid, hrchy and lgid3 iters
  4. run persistence and active/gold stats



  so, do this per cluster.
  get stats for each, all, active and gold clusters
  probably use pct_bow_mismatch to find the overlinked ones
  could be a combination of bow mismatch >= 30 or a cluster has more than 10 feins or 10 cnp_names per duns.
  if i have:  
    proxid, all           ,active ,gold ,cnt_cnp_names, cnt_feins
    proxid, duns_number   ,active ,gold ,cnt_cnp_names, cnt_feins
    proxid, D&B fein      ,active ,gold ,cnt_cnp_names, cnt_feins
    proxid, not D&B fein  ,active ,gold ,cnt_cnp_names, cnt_feins
  
  
  once i have this dataset, i can rollup and couple of different ways to generate a few matrices
  filter for 'all'
  project this and set any cnt_cnp_names and cnt_feins to the 8 categories.  6-10 becomes 6, 11-15 becomes 11, 15 plus becomes 15
  do a table grouped on cnt_cnp_names, cnt_feins and count them
  now we have cnp_cnp_names, cnt_feins, cnt
  project into rollup layout
  so if i rollup on cnt_feins, and populate the cnt_company_names for each record, that should do it
  
  
  manish wants this for old D&B fein clusters
  matrix
  duns_number cnp_names
  feins
  
*/

//-- manish wants to count the number of cnp_names and feins per duns_number within a cluster(presumable from D&B fein)
//ds_dnb_fein_duns_slim               := table(bipv2.CommonBase.ds_built(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old',trim(duns_number) != ''),{seleid,duns_number,cnp_name,company_fein}  ,seleid,duns_number,cnp_name,company_fein ,merge);

// -- all clusters count cnp_name and feins
//ds_duns_slim_all      := table(bipv2.CommonBase.ds_built,{seleid,cnp_name,company_fein,sele_gold,seleid_status_public}  ,seleid,cnp_name,company_fein,sele_gold,seleid_status_public ,merge) : persist('~persist::lbentley::ds_duns_slim_all');
//BIPV2_Files.files_empid_down().DS_BASE



//ds_base                         := bipv2.CommonBase.ds_built    : persist('~persist::lbentley::ds_base'              );                            
//output(ds_base);

// -- for SBFE, we should look at the number of cnp_names and feins per cluster
// -- might want to look at the sbfe records within a cluster
// -- AND USE A VERY HIGH THRESHOLD FOR PCT BOW MISMATCH FOR THOSE NAMES
// -- this will narrow it down to the names that mismatch the most
// -- can get those numbers, and/or reduce the number by taking out the ones that are verified by other sources.
// -- so the exact name, address, fein is verified by another source.

new_dotid_filename          := '~thor_data400::bipv2_dotid::salt_iter::20180302::BH333_post::explode_SBFE_overlinked_clusters';
//ds_built                    := bipv2.CommonBase.ds_built;
ds_built                    := DATASET(ut.foreign_prod + 'thor_data400::bipv2_empid_down::base',         BIPV2.CommonBase.Layout, THOR, OPT) : persist('~persist::lbentley::BH333::ds_built');//BIPV2_Files.files_empid_down().DS_BASE;

ds_built_sbfe     := ds_built(source = mdr.sourcetools.src_Business_Credit)  : persist('~persist::lbentley::BH333::ds_built_sbfe');
ds_built_not_sbfe := ds_built(source != mdr.sourcetools.src_Business_Credit)  : persist('~persist::lbentley::BH333::ds_built_not_sbfe');

ds_built_not_sbfe_slim := table(ds_built_not_sbfe ,{proxid,cnp_name} ,proxid,cnp_name ,merge);

ds_built_sbfe_not_verified := join(ds_built_sbfe  ,ds_built_not_sbfe_slim ,left.proxid = right.proxid and left.cnp_name = right.cnp_name  ,transform(left)  ,left only  ,hash);

pct_bow_mismatch_threshold  := 30;
cnp_names_threshold         := 6;
feins_threshold             := 4;

overlinking_info_proxid := BIPV2_Tools.mac_Compile_Overlinking_Info(proxid,ds_built_sbfe_not_verified) : persist('~persist::lbentley::BH333::overlinking_info.proxid');
//output(overlinking_info_proxid);
overlinking_info_seleid := BIPV2_Tools.mac_Compile_Overlinking_Info(seleid,ds_built_sbfe_not_verified) : persist('~persist::lbentley::BH333::overlinking_info.seleid');
//output(overlinking_info_seleid);

output(sort(table(ds_built_sbfe(seleid in [37996965,47759091,52788210]),{seleid,cnp_name},seleid,cnp_name,merge),seleid,cnp_name),named('ds_built_sbfe'),all);
output(overlinking_info_seleid(seleid in [37996965,47759091,52788210]),named('overlinking_seleid_examples'));

// get clusters with SBFE in them and over 30% cnp_name mismatch
overlinking_info_proxid_gt30 := overlinking_info_proxid((real8)pct_bow_mismatches_lt3 >= pct_bow_mismatch_threshold,mdr.sourcetools.src_Business_Credit in sources);
overlinking_info_seleid_gt30 := overlinking_info_seleid((real8)pct_bow_mismatches_lt3 >= pct_bow_mismatch_threshold,mdr.sourcetools.src_Business_Credit in sources,count_cnp_name_raws >= cnp_names_threshold/* or count_feins >= feins_threshold*/);

ds_get_all_proxid_records         := join(ds_built ,overlinking_info_proxid_gt30 ,left.proxid = right.proxid ,transform({recordof(left),string prox_status,string pct_bow_mismatches}
  ,self.prox_status           := left.proxid_status_public
  ,self.pct_bow_mismatches    := right.pct_bow_mismatches_lt3
  ,self                       := left
)  ,hash)  : persist('~persist::lbentley::BH333::ds_get_all_proxid_records');
ds_get_all_seleid_records         := join(ds_built ,overlinking_info_seleid_gt30 ,left.seleid = right.seleid ,transform({recordof(left),string sele_status,string pct_bow_mismatches}
  ,self.sele_status           := left.seleid_status_public
  ,self.pct_bow_mismatches    := right.pct_bow_mismatches_lt3
  ,self                       := left
)  ,hash)  : persist('~persist::lbentley::BH333::ds_get_all_seleid_records');

ds_get_all_proxid_records_agg := BIPV2_Tools.Agg_Slim(ds_get_all_proxid_records,proxid,50,['prox_status','sele_gold','pct_bow_mismatches'])  : persist('~persist::lbentley::BH333::ds_get_all_proxid_records_agg');
ds_get_all_seleid_records_agg := BIPV2_Tools.Agg_Slim(ds_get_all_seleid_records,seleid,50,['sele_status','sele_gold','pct_bow_mismatches'])  : persist('~persist::lbentley::BH333::ds_get_all_seleid_records_agg');
//tools.mac_getlayout(ds_get_all_proxid_records_agg  ,mylayout);
//output(mylayout);

// -- filter for proxid: 4 or more feins from D&B fein or 6 or more cnp_names from D&B fein.
ds_proxid_candidates  := ds_get_all_proxid_records_agg;//(count_cnp_names >= cnp_names_threshold/* or count_feins >= feins_threshold*/);
ds_seleid_candidates  := ds_get_all_seleid_records_agg;//(count_cnp_names >= cnp_names_threshold/* or count_feins >= feins_threshold*/);

// -- in common stuff I think
// -- this is filtering the candidate proxids and seleids
ds_proxid_candidate_records := join(ds_get_all_proxid_records  ,table(ds_proxid_candidates,{proxid})  ,left.proxid = right.proxid ,transform(left),hash) : persist('~persist::lbentley::ds_dnb_fein_proxid_candidate_records');
ds_seleid_candidate_records := join(ds_get_all_seleid_records  ,table(ds_seleid_candidates,{seleid})  ,left.seleid = right.seleid ,transform(left),hash) : persist('~persist::lbentley::ds_dnb_fein_seleid_candidate_records');

// don't care about proxids with this, just seleids and lgid3s.
reset_clusters := bipv2_tools.mac_reset_clusters(dataset([],recordof(ds_proxid_candidate_records)),ds_seleid_candidate_records,dataset([],recordof(ds_get_all_proxid_records_agg)),ds_get_all_seleid_records_agg,new_dotid_filename);
reset_clusters;

