IMPORT IDL_Header, LinkingTools,Header;

EXPORT fn_PersistenceStats(DATASET(IDL_Header.Layout_Header_Link) hdr, DATASET(IDL_Header.Layout_Header_Link) father, string iter, boolean isForPublicRecords=FALSE) := FUNCTION

ps := LinkingTools.PersistenceStats(hdr,father,rid,did);

prefix:=if(isForPublicRecords,'~thor_data400::publicRecords','~thor::insurance');

iter_true := iter[..6];
recDS := ps.recordDS;
clustDS := ps.clusterDS;

statrec := RECORD
	string timestamp;
	string StatName;
	real8 StatValue;
END;

ds_precs := DATASET([{iter_true,'Current Records',(real8)recDS(stat_name = 'Current Records')[1].stat_value},
										 {iter_true,'Previous Records',(real8)recDS(stat_name = 'Previous Records')[1].stat_value},
										 {iter_true,'New Records',(real8)recDS(stat_name = 'Current Records')[1].subcategories(stat_name = 'New Records')[1].stat_value},
										 {iter_true,'Deleted Records',(real8)recDS(stat_name = 'Previous Records')[1].subcategories(stat_name = 'Deleted Records')[1].stat_value},
										 {iter_true,'Persistent Records',(real8)recDS(stat_name = 'Persistent Records')[1].stat_value},
										 {iter_true,'Same Cluster',(real8)recDS(stat_name = 'Persistent Records')[1].subcategories(stat_name = 'Same Cluster')[1].stat_value},
										 {iter_true,'Diff Cluster',(real8)recDS(stat_name = 'Persistent Records')[1].subcategories(stat_name = 'Diff Cluster')[1].stat_value},
										 {iter_true,'Collapsed Records',(real8)recDS(stat_name = 'Persistent Records Diff Cluster')[1].subcategories(stat_name = 'Collapsed Records')[1].stat_value},
										 {iter_true,'Split Records',(real8)recDS(stat_name = 'Persistent Records Diff Cluster')[1].subcategories(stat_name = 'Split Records')[1].stat_value},
										 {iter_true,'Shuffled Records',(real8)recDS(stat_name = 'Persistent Records Diff Cluster')[1].subcategories(stat_name = 'Shuffled Records')[1].stat_value},
										 {iter_true,'Shifted Records',(real8)recDS(stat_name = 'Persistent Records Diff Cluster')[1].subcategories(stat_name = 'Shifted Records')[1].stat_value},
										 {iter_true,'Persistent Record Pct',(real8)recDS(stat_name = 'Previous Records')[1].subcategories(stat_name = 'Persistent Records')[1].stat_pct} // percent of previous
										 ],statrec);

filename_recs := prefix+'Header::validation::persistence_record::' + iter_true + '_'+WORKUNIT;
op_recs:= OUTPUT(ds_precs,,filename_recs,compressed,overwrite);

sfilename_recs := prefix+'Header::validation::persistence_record::current';
sf_recs := Fileservices.PromoteSuperfileList([sfilename_recs],filename_recs,TRUE);

ds_pclust := DATASET([{iter_true,'Current Clusters',(real8)clustDS(stat_name = 'Current Clusters')[1].stat_value},
										 {iter_true,'Previous Clusters',(real8)clustDS(stat_name = 'Previous Clusters')[1].stat_value},
										 {iter_true,'New Clusters',(real8)clustDS(stat_name = 'New Clusters')[1].stat_value},
										 {iter_true,'Missing Clusters',(real8)clustDS(stat_name = 'Missing Clusters')[1].stat_value},
										 {iter_true,'Same Clusters',(real8)clustDS(stat_name = 'Same Clusters')[1].stat_value},
										 {iter_true,'All New Records',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'All New Records')[1].stat_value},
										 {iter_true,'New Base Record',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'New Base Record')[1].stat_value},
										 {iter_true,'From Split',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'From Split')[1].stat_value},
										 {iter_true,'From Shuffle',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'From Shuffle')[1].stat_value},
										 {iter_true,'Deleted Base Record',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'Deleted Base Record')[1].stat_value},
										 {iter_true,'All Records Deleted',(real8)clustDS(stat_name = 'Missing Clusters')[1].subcategories(stat_name = 'All Records Deleted')[1].stat_value},
										 {iter_true,'Collapsed',(real8)clustDS(stat_name = 'Missing Clusters')[1].subcategories(stat_name = 'Collapsed')[1].stat_value},
										 {iter_true,'Shuffled',(real8)clustDS(stat_name = 'Missing Clusters')[1].subcategories(stat_name = 'Shuffled')[1].stat_value},
										 {iter_true,'Recs Removed',(real8)clustDS(stat_name = 'Same Clusters')[1].subcategories(stat_name = 'Recs Removed')[1].stat_value},
										 {iter_true,'Recs Added',(real8)clustDS(stat_name = 'Same Clusters')[1].subcategories(stat_name = 'Recs Added')[1].stat_value},
										 {iter_true,'Recs Mixed',(real8)clustDS(stat_name = 'Same Clusters')[1].subcategories(stat_name = 'Recs Mixed')[1].stat_value},
										 {iter_true,'Persistent Cluster Pct',(real8)clustDS(stat_name = 'Same Clusters')[1].subcategories(stat_name = 'Persistent Clusters')[1].stat_pct} // percent of previous
										 ],statrec);
										 
filename_clust := prefix+'Header::validation::persistence_cluster::' + iter_true + '_'+WORKUNIT;
op_clust:= OUTPUT(ds_pclust,,filename_clust,compressed,overwrite);

sfilename_clust := prefix+'Header::validation::persistence_cluster::current';
sf_clust := Fileservices.PromoteSuperfileList([sfilename_clust],filename_clust,TRUE);

seg_i := InsuranceHeader_Postprocess.corecheck;
seg_p := project(Header.fn_ADLSegmentation_v2(header.File_Headers).core_check_pst,TRANSFORM({seg_i},
				SELF.cnt:=LEFT.rec_cnt,SELF:=LEFT,SELF:=[]));

seg := if(isForPublicRecords,seg_p,seg_i);

cnt_1 := COUNT(seg(cnt = 1));
cnt_10 := COUNT(seg(cnt BETWEEN 2 AND 10));
cnt_100 := COUNT(seg(cnt BETWEEN 11 AND 100));
cnt_1000 := COUNT(seg(cnt BETWEEN 101 AND 1000));
cnt_large := COUNT(seg(cnt > 1000));

cnt_core := COUNT(seg(ind = 'CORE'));
cnt_dead := COUNT(seg(ind = 'DEAD'));
cnt_cmerge := COUNT(seg(ind = 'C_MERGE'));
cnt_hmerge := COUNT(seg(ind = 'H_MERGE'));
cnt_inactive := COUNT(seg(ind = 'INACTIVE'));
cnt_noise := COUNT(seg(ind = 'NOISE'));
cnt_nossn := COUNT(seg(ind = 'NO_SSN'));
cnt_ambig := COUNT(seg(ind = 'AMBIG'));
cnt_corenovssn := COUNT(seg(ind = 'CORENOVSSN'));
cnt_suspect := COUNT(seg(ind = 'SUSPECT'));

ds_postlink_i := DATASET([{iter_true,'%Current Clusters, New',(real8)clustDS(stat_name = 'Current Clusters')[1].subcategories(stat_name = 'New Clusters')[1].stat_pct},
										 {iter_true,'%Current Clusters, New, All New Records',(real8)clustDS(stat_name = 'New Clusters')[1].subcategories(stat_name = 'All New Records')[1].stat_pct},
										 {iter_true,'%Current Clusters, Still Exist',(real8)clustDS(stat_name = 'Current Clusters')[1].subcategories(stat_name = 'Same Clusters')[1].stat_pct},
										 {iter_true,'%Current Clusters, Still Exist, Same Records',(real8)clustDS(stat_name = 'Same Clusters')[1].subcategories(stat_name = 'Persistent Clusters')[1].stat_pct},
										 {iter_true,'%Previous Clusters, Disappeared',(real8)clustDS(stat_name = 'Previous Clusters')[1].subcategories(stat_name = 'Missing Clusters')[1].stat_pct},
										 {iter_true,'%Previous Clusters, Disappeared, Collapsed',(real8)clustDS(stat_name = 'Missing Clusters')[1].subcategories(stat_name = 'Collapsed Clusters')[1].stat_pct},
										 {iter_true,'%Current Records, New',(real8)recDS(stat_name = 'Current Records')[1].subcategories(stat_name = 'New Records')[1].stat_pct},
										 {iter_true,'%Previous Records, Disappeared',(real8)recDS(stat_name = 'Previous Records')[1].subcategories(stat_name = 'Deleted Records')[1].stat_pct},
										 {iter_true,'%Previous Records, Same DID',(real8)(recDS(stat_name = 'Persistent Records')[1].subcategories(stat_name = 'Same Cluster')[1].stat_value / recDS(stat_name = 'Previous Records')[1].stat_value)},
										 {iter_true,'%Previous Records, Different DID',(real8)(recDS(stat_name = 'Persistent Records')[1].subcategories(stat_name = 'Diff Cluster')[1].stat_value / recDS(stat_name = 'Previous Records')[1].stat_value)},
										 {iter_true,'%Previous Records, Different DID, Collapsed',(real8)recDS(stat_name = 'Persistent Records Diff Cluster')[1].subcategories(stat_name = 'Collapsed Records')[1].stat_pct},
										 {iter_true,'Cluster Count, Singleton',cnt_1},
										 {iter_true,'Cluster Count, 2 to 10 Records',cnt_10},
										 {iter_true,'Cluster Count, 11 to 100 Records',cnt_100},
										 {iter_true,'Cluster Count, 101 to 1000 Records',cnt_1000},
										 {iter_true,'Cluster Count, 1001 or More Records',cnt_large},
										 {iter_true,'Segmentation Count, Core',cnt_Core},
										 {iter_true,'Segmentation Count, Dead',cnt_Dead},
										 {iter_true,'Segmentation Count, No SSN',cnt_nossn},
										 {iter_true,'Segmentation Count, Inactive',cnt_inactive},
										 {iter_true,'Segmentation Count, C_Merge',cnt_cmerge},
										 {iter_true,'Segmentation Count, H_Merge',cnt_hmerge},
										 {iter_true,'Segmentation Count, Noise',cnt_noise}],statRec);
ds_postlink_p:=dataset([
										 {iter_true,'Segmentation Count, AMBIG',cnt_ambig},
										 {iter_true,'Segmentation Count, CORENOVSSN',cnt_corenovssn},
										 {iter_true,'Segmentation Count, SUSPECT',cnt_suspect}
						],statRec);

ds_postlink:=if(isForPublicRecords,ds_postlink_i+ds_postlink_p,ds_postlink_i);

filename_postlink := prefix+'Header::validation::postlink::' + iter_true + '_' + WORKUNIT;									 
op_postlink := OUTPUT(ds_postlink,,filename_postlink,compressed,overwrite);

sfilename_postlink := prefix+'Header::validation::postlink::current';
sf_postlink := Fileservices.PromoteSuperfileList([sfilename_postlink],filename_postlink,TRUE);


RETURN SEQUENTIAL(PARALLEL(OUTPUT(recDS,named('record_persistence')),
													 OUTPUT(clustDS,named('cluster_persistence')),
													 op_recs,op_clust,op_postlink),
									 Fileservices.StartSuperFileTransaction(),
									 sf_recs,
									 sf_clust,
									 sf_postlink,
									 Fileservices.FinishSuperFileTransaction());


END;