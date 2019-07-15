/*
base_in := Base (or current) version of dataset
father_in := Father (or previous) version of dataset
rec_id := record id field in both datasets
cluster_id := cluster id field in both datasets
output_name := name appended to outputs (allows for multiple runs in a single WU)
*/
EXPORT PersistenceStats(base,father,rec_id,cluster_id,output_name = '',pDoOutputs = 'true') := functionmacro
	
	#IF(#TEXT(output_name) <> '')local op_name := '_'+(STRING)output_name; #ELSE local op_name := ''; #END
	
	local base_ded := DEDUP(SORT(DISTRIBUTE(base,rec_id),rec_id,LOCAL),rec_id,LOCAL);
	local father_ded := DEDUP(SORT(DISTRIBUTE(father,rec_id),rec_id,LOCAL),rec_id,LOCAL);

	local cnt_new_recs_tot := COUNT(base_ded);
	local cnt_old_recs_tot := COUNT(father_ded);
	
	local base_dist_cluster := DISTRIBUTE(base,cluster_id);
	local father_dist_cluster := DISTRIBUTE(father,cluster_id);

	local base_cluster_tot := TABLE(base_dist_cluster,{cluster_id},cluster_id,LOCAL);
	local father_cluster_tot := TABLE(father_dist_cluster,{cluster_id},cluster_id,LOCAL);

	local cnt_base_cluster_tot := COUNT(base_cluster_tot);
	local cnt_father_cluster_tot := COUNT(father_cluster_tot);
	

	local recordDataRec := RECORD
		unsigned recId_father;
		unsigned recId_base;
		unsigned clustId_father;
		unsigned clustId_base;
	END;

	//First, outer join by record to get all records from both files
	local total_recs := JOIN(base_ded,father_ded,LEFT.rec_id=RIGHT.rec_id,
											TRANSFORM(recordDataRec,SELF.recId_father := RIGHT.rec_id; SELF.recId_base:=LEFT.rec_id;
											SELF.clustId_father:=RIGHT.cluster_id;	SELF.clustId_base:=LEFT.cluster_id),LOCAL,FULL OUTER);
	
	//Standard record level stats
	local new_recs := total_recs(recId_father = 0);
	local cnt_new_recs := COUNT(new_recs);
	local old_recs := total_recs(recId_base = 0);
	local cnt_old_recs := COUNT(old_recs);
	local persistent_recs := total_recs(recId_base > 0 AND recId_father > 0);
	local cnt_persistent_recs := COUNT(persistent_recs);
	local persistent_recs_same_cluster := persistent_recs(clustId_father = clustId_base);
	local cnt_persistent_recs_same_cluster := COUNT(persistent_recs_same_cluster);
	local persistent_recs_diff_cluster := persistent_recs(clustId_father <> clustId_base);
	local cnt_persistent_recs_diff_cluster := COUNT(persistent_recs_diff_cluster);

	local clusterDataRec := RECORD
		unsigned8 clustId_father;
		unsigned8 clustId_base;
	END;

	//Standard cluster level stats requires outer join by cluster
	local total_clusters := JOIN(base_cluster_tot,father_cluster_tot,LEFT.cluster_id=RIGHT.cluster_id,TRANSFORM(clusterDataRec,SELF.clustId_father:=RIGHT.cluster_id;SELF.clustId_base:=LEFT.cluster_id),LOCAL,FULL OUTER);
	
	local new_ids := total_clusters(clustId_father = 0 and clustId_base <> 0);
	local cnt_new_ids := COUNT(new_ids);
	local old_ids := total_clusters(clustId_base = 0 and clustId_father <> 0);
	local cnt_old_ids := COUNT(old_ids);
	local same_ids := total_clusters(clustId_base = clustId_father);
	local cnt_same_ids := COUNT(same_ids);
	
		
	//Completely new entities will have a recId_father sum of 0. Fully deleted entities will have a recId_base sum of 0.
	local tab_new_id_recs := TABLE(DISTRIBUTE(total_recs(clustId_base <> 0),clustId_base),{total_recs.clustId_base, tot := SUM(GROUP,total_recs.recId_father)},clustId_base,LOCAL);
	local all_new_ids := tab_new_id_recs(tot = 0 and clustId_base <> 0);
	local cnt_all_new_ids := COUNT(all_new_ids);
	local lowest_new_id_recs_pre := DEDUP(SORT(DISTRIBUTE(total_recs(clustId_base <> 0),clustId_base),clustId_base,recId_base,LOCAL),clustId_base,LOCAL);
	local lowest_new_id_recs := JOIN(lowest_new_id_recs_pre(recId_father = 0),tab_new_id_recs(tot > 0),LEFT.clustId_base=RIGHT.clustId_base,TRANSFORM(RIGHT),LOCAL);
	local tab_lowest_new_id_recs := JOIN(new_ids,lowest_new_id_recs,LEFT.clustId_base=RIGHT.clustId_base,TRANSFORM(RIGHT),LOCAL);
	local cnt_lowest_new_id := COUNT(tab_lowest_new_id_recs);
	local tab_old_id_recs := TABLE(DISTRIBUTE(total_recs(clustId_father <> 0),clustId_father),{total_recs.clustId_father, tot := SUM(GROUP,total_recs.recId_base)},clustId_father,LOCAL);
	local all_old_ids := tab_old_id_recs(tot = 0);
	local cnt_all_old_ids := COUNT(all_old_ids);
	
	//Counts of base clusters making up each father cluster and vice versa.
	local tab_all_ids_pre := TABLE(DISTRIBUTE(total_recs,HASH(clustId_father,clustId_base)),{total_recs.clustId_father, total_recs.clustId_base},clustId_father,clustId_base, LOCAL);
	local tab_all_ids_father := TABLE(DISTRIBUTE(tab_all_ids_pre(clustId_father <> 0),clustId_father),{tab_all_ids_pre.clustId_father, cnt := COUNT(GROUP)},clustId_father,LOCAL);
	local tab_all_ids_base := TABLE(DISTRIBUTE(tab_all_ids_pre(clustId_base <> 0),clustId_base),{tab_all_ids_pre.clustId_base, cnt := COUNT(GROUP)},clustId_base,LOCAL);
	
	local totalDataRec := RECORD
		clusterDataRec;
		unsigned cnt_clustId_father;
		unsigned cnt_clustId_base;
	END;
	
	//Breakdown of same clusters
	local possibly_persistent_ids0 := JOIN(DISTRIBUTE(same_ids,clustId_father),tab_all_ids_father,LEFT.clustID_father = RIGHT.clustId_father,TRANSFORM(totalDataRec,SELF.cnt_clustId_father := 0;SELF.cnt_clustId_base := RIGHT.cnt;SELF:=LEFT),LOCAL);
	local possibly_persistent_ids := JOIN(DISTRIBUTE(possibly_persistent_ids0,clustId_base),tab_all_ids_base,LEFT.clustId_base = RIGHT.clustId_base,TRANSFORM(totalDataRec,SELF.cnt_clustId_father := RIGHT.cnt;SELF:=LEFT),LOCAL);
	local tab_ids_recs_removed := possibly_persistent_ids(cnt_clustId_father = 1 AND cnt_clustId_base > 1);
	local cnt_ids_recs_removed := COUNT(tab_ids_recs_removed);
	local tab_ids_recs_added := possibly_persistent_ids(cnt_clustId_father > 1 AND cnt_clustId_base = 1);
	local cnt_ids_recs_added := COUNT(tab_ids_recs_added);
	local tab_ids_recs_mixed := possibly_persistent_ids(cnt_clustId_father > 1 AND cnt_clustId_base > 1);
	local cnt_ids_recs_mixed := COUNT(tab_ids_recs_mixed);
	local tab_persistent_ids_fin := possibly_persistent_ids(cnt_clustId_father = 1 AND cnt_clustId_base = 1);
	local cnt_persistent_ids := COUNT(tab_persistent_ids_fin);


	//Table to get all clusterId before/after combos, then another to find how many base clusterIds came from each father clusterId
	local tab_persistent_ids_pre := TABLE(DISTRIBUTE(persistent_recs,HASH(clustId_father,clustId_base)),{persistent_recs.clustId_father, persistent_recs.clustId_base},clustId_father,clustId_base, LOCAL);
	local tab_persistent_ids_father := TABLE(DISTRIBUTE(tab_persistent_ids_pre,clustId_father),{tab_persistent_ids_pre.clustId_father, cnt := COUNT(GROUP)},clustId_father,LOCAL);
	local tab_persistent_ids_base := TABLE(DISTRIBUTE(tab_persistent_ids_pre,clustId_base),{tab_persistent_ids_pre.clustId_base, cnt := COUNT(GROUP)},clustId_base,LOCAL);
	

	local persistentDataRec := RECORD
		unsigned recId_father;
		unsigned recId_base;
		unsigned clustId_father;
		unsigned clustId_base;
		unsigned cnt_clustId_father; 								//father clustId count - per base clustId
		unsigned cnt_clustId_base;	 								//base clustId count - per father clustId
		boolean lowest_rec_removed;	 								//is the lowest record in the father clustId deleted (recId_base = 0)
		boolean base_clustId_from_father_clustId;		//is the base clustId part of the father clustId
		boolean father_clustId_lowest_rem_rec;			//is the current record the lowest remaining record (recId_base <> 0) from the father clustId
	END;
	
	debugDataRec := RECORD
		persistentDataRec;
		string category;
	END;
	
	//Cluster tracking for persistent records - below join adds base cluster count, father cluster count, and boolean checks
	local persistent_ids_recs_pre0 := JOIN(DISTRIBUTE(persistent_recs_diff_cluster,clustId_father),tab_persistent_ids_father,LEFT.clustId_father=RIGHT.clustId_father,TRANSFORM(persistentDataRec,SELF.cnt_clustId_father := 0;SELF.cnt_clustId_base := RIGHT.cnt;SELF:=LEFT;SELF:=[]),LOCAL);
	local persistent_ids_recs_pre := JOIN(DISTRIBUTE(persistent_ids_recs_pre0,clustId_base),tab_persistent_ids_base,LEFT.clustId_base=RIGHT.clustId_base,TRANSFORM(persistentDataRec,SELF.cnt_clustId_father := RIGHT.cnt;SELF:=LEFT),LOCAL);
	local total_old_persistent_recs := DISTRIBUTE(total_recs(recId_father <> 0),recId_father);
	local persistent_ids_recs01 := JOIN(total_old_persistent_recs,DISTRIBUTE(persistent_ids_recs_pre,clustId_father),LEFT.recId_father = RIGHT.clustId_father,TRANSFORM(persistentDataRec,SELF.lowest_rec_removed := IF(LEFT.recId_base = 0,TRUE,FALSE);SELF :=RIGHT),RIGHT OUTER,LOCAL);
	local persistent_ids_recs02 := JOIN(total_old_persistent_recs,DISTRIBUTE(persistent_ids_recs01,clustId_base),LEFT.recId_father = RIGHT.clustId_base, TRANSFORM(persistentDataRec,SELF.base_clustId_from_father_clustId := IF(LEFT.clustId_father = RIGHT.clustId_father, TRUE,FALSE); SELF:=RIGHT),RIGHT OUTER,LOCAL);
	local lowest_rem_rec := DEDUP(SORT(DISTRIBUTE(persistent_recs,clustId_father),clustId_father,recId_father,LOCAL),clustId_father,LOCAL);
	local persistent_ids_recs := JOIN(DISTRIBUTE(persistent_ids_recs02,clustId_father),lowest_rem_rec,LEFT.clustId_father = RIGHT.clustId_father,TRANSFORM(persistentDataRec,SELF.father_clustId_lowest_rem_rec := IF(LEFT.recId_father = RIGHT.recId_father,TRUE,FALSE); SELF :=LEFT),LEFT OUTER,LOCAL);
	
	//Persistent records diff cluster breakdown
	local shift0 := persistent_ids_recs(cnt_clustId_father = 1 AND cnt_clustId_base = 1 AND (lowest_rec_removed OR (NOT lowest_rec_removed AND base_clustId_from_father_clustId)));
	local split0 := persistent_ids_recs(cnt_clustId_base > 1 AND  base_clustId_from_father_clustId AND NOT father_clustId_lowest_rem_rec);
	local collapse0 := persistent_ids_recs(cnt_clustId_base = 1 AND NOT lowest_rec_removed AND ((NOT base_clustId_from_father_clustId) OR (cnt_clustId_father > 1 AND base_clustId_from_father_clustId AND NOT father_clustId_lowest_rem_rec)));
	local shuffle0 := persistent_ids_recs((cnt_clustId_base > 1 AND ((NOT base_clustId_from_father_clustId) OR base_clustId_from_father_clustId AND father_clustId_lowest_rem_rec)) OR cnt_clustId_base = 1 AND cnt_clustId_father > 1 AND (lowest_rec_removed OR ((NOT lowest_rec_removed) AND base_clustId_from_father_clustId AND father_clustId_lowest_rem_rec)));
	

	local persistent_recs_collapsed := PROJECT(collapse0,TRANSFORM(debugDataRec,SELF.category := 'collapse';SELF:=LEFT));
	local cnt_persistent_recs_collapsed := COUNT(persistent_recs_collapsed);
	
	local persistent_recs_shifted := PROJECT(shift0,TRANSFORM(debugDataRec,SELF.category := 'shift';SELF:=LEFT));
	local cnt_persistent_recs_shifted := COUNT(persistent_recs_shifted);
	
	local persistent_recs_split := PROJECT(split0,TRANSFORM(debugDataRec,SELF.category := 'split';SELF:=LEFT));
	local cnt_persistent_recs_split := COUNT(persistent_recs_split);
	
	local persistent_recs_shuffled := PROJECT(shuffle0,TRANSFORM(debugDataRec,SELF.category := 'shuffle';SELF:=LEFT));
	local cnt_persistent_recs_shuffled := COUNT(persistent_recs_shuffled);

	//Tables for missing/new clusters, based on above categories
	local tot_pers2 := persistent_recs_collapsed + persistent_recs_shifted + persistent_recs_split + persistent_recs_shuffled;
	local tot_pers3 := tot_pers2 + PROJECT(persistent_recs_same_cluster,TRANSFORM(debugDataRec,SELF:=LEFT;SELF:=[]));
	local pers_father := JOIN(DISTRIBUTE(old_ids,clustId_father),DEDUP(SORT(DISTRIBUTE(tot_pers3,clustId_father),clustId_father,recId_father,LOCAL),clustId_father,LOCAL),LEFT.clustId_father = RIGHT.clustId_father,TRANSFORM(RIGHT),LOCAL);
	local pers_base_pre := JOIN(DISTRIBUTE(new_ids,clustId_base),DEDUP(SORT(DISTRIBUTE(tot_pers3,clustId_base),clustId_base,recId_base,LOCAL),clustId_base,LOCAL),LEFT.clustId_base = RIGHT.clustId_base,TRANSFORM(RIGHT),LOCAL);
	local pers_base := JOIN(pers_base_pre(clustId_base <> 0),tab_lowest_new_id_recs,LEFT.clustId_base = RIGHT.clustId_base,TRANSFORM(LEFT),LEFT ONLY, LOCAL);
	local tab_ids_split := TABLE(DISTRIBUTE(pers_base(category[..5] = 'split'),clustId_base),{pers_base.clustId_base},clustId_base,LOCAL);
	local cnt_ids_split := COUNT(tab_ids_split);
	local tab_ids_shifted_new := TABLE(DISTRIBUTE(pers_base(category[..5] = 'shift'),clustId_base),{pers_base.clustId_base},clustId_base,LOCAL);
	local cnt_ids_shifted_new := COUNT(tab_ids_shifted_new);
	local tab_ids_shifted_old := TABLE(DISTRIBUTE(pers_father(category[..5] = 'shift'),clustId_father),{pers_father.clustId_father},clustId_father,LOCAL);
	local cnt_ids_shifted_old := COUNT(tab_ids_shifted_old);
	local tab_ids_collapsed := TABLE(DISTRIBUTE(pers_father(category[..8] = 'collapse'),clustId_father),{pers_father.clustId_father},clustId_father,LOCAL);
	local cnt_ids_collapsed := COUNT(tab_ids_collapsed);
	local tab_ids_shuffled_new := TABLE(DISTRIBUTE(pers_base(category[..7] = 'shuffle'),clustId_base),{pers_base.clustId_base},clustId_base,LOCAL);
	local cnt_ids_shuffled_new := COUNT(tab_ids_shuffled_new);
	local tab_ids_shuffled_old := TABLE(DISTRIBUTE(pers_father(category[..7] = 'shuffle'),clustId_father),{pers_father.clustId_father},clustId_father,LOCAL);
	local cnt_ids_shuffled_old := COUNT(tab_ids_shuffled_old);


  local PersistenceStatsResults := MODULE

export  output_samples := parallel(
   OUTPUT(CHOOSEN(new_recs,100),NAMED('new_recs'+op_name))
  ,OUTPUT(CHOOSEN(old_recs,100),NAMED('deleted_recs'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs,100),NAMED('persistent_recs'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_same_cluster,100),NAMED('persistent_recs_same_cluster'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_diff_cluster,100),NAMED('persistent_recs_diff_cluster'+op_name))
  ,OUTPUT(CHOOSEN(new_ids,100),NAMED('new_clusters'+op_name))
  ,OUTPUT(CHOOSEN(old_ids,100),NAMED('missing_clusters'+op_name))
  ,OUTPUT(CHOOSEN(same_ids,100),NAMED('same_clusters'+op_name))
  ,OUTPUT(CHOOSEN(all_new_ids,100),NAMED('all_new_clusters'+op_name))
  ,OUTPUT(CHOOSEN(tab_lowest_new_id_recs,100),NAMED('new_base_record_clusters'+op_name))
  ,OUTPUT(CHOOSEN(all_old_ids,100),NAMED('old_clusters_deleted'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_recs_removed,100),NAMED('same_clusters_recs_removed'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_recs_added,100),NAMED('same_clusters_recs_added'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_recs_mixed,100),NAMED('same_clusters_recs_mixed'+op_name))
  ,OUTPUT(CHOOSEN(tab_persistent_ids_fin,100),NAMED('persistent_clusters'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_collapsed,100),NAMED('persistent_recs_collapsed'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_shifted,100),NAMED('persistent_recs_shifted'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_split,100),NAMED('persistent_recs_split'+op_name))
  ,OUTPUT(CHOOSEN(persistent_recs_shuffled,100),NAMED('persistent_recs_shuffled'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_split,100),NAMED('new_clusters_from_split'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_shifted_new,100),NAMED('new_clusters_deleted_base_record'+op_name)) 
  ,OUTPUT(CHOOSEN(tab_ids_shifted_old,100),NAMED('old_clusters_deleted_base_record'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_collapsed,100),NAMED('old_clusters_collapsed'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_shuffled_new,100),NAMED('new_clusters_from_shuffle'+op_name))
  ,OUTPUT(CHOOSEN(tab_ids_shuffled_old,100),NAMED('old_clusters_shuffled'+op_name))
);

	EXPORT StatRec := RECORD
		string stat_name;
		unsigned stat_value;
		real stat_pct;
	END;
	
	EXPORT SummaryRec := RECORD
		string stat_name;
		unsigned stat_value;
		DATASET(StatRec) subcategories;
	END;
	
			
		 SHARED real makePct(unsigned n, unsigned d) := FUNCTION
			pct := ((REAL)n)/((REAL)d);
			return ROUND(pct,4)*100;
		 END;
			
		 		 EXPORT recordDS := 	DATASET([{'Current Records',cnt_new_recs_tot,DATASET([
																		{'New Records',cnt_new_recs,makePct(cnt_new_recs,cnt_new_recs_tot)},
																		{'Persistent Records',cnt_persistent_recs,makePct(cnt_persistent_recs,cnt_new_recs_tot)}],StatRec)},
																 {'Previous Records',cnt_old_recs_tot,DATASET([
																		{'Deleted Records',cnt_old_recs,makePct(cnt_old_recs,cnt_old_recs_tot)},
																		{'Persistent Records',cnt_persistent_recs,makePct(cnt_persistent_recs,cnt_old_recs_tot)}],StatRec)},
																 {'Persistent Records',cnt_persistent_recs,DATASET([
																		{'Same Cluster',cnt_persistent_recs_same_cluster,makePct(cnt_persistent_recs_same_cluster,cnt_persistent_recs)},
																		{'Diff Cluster',cnt_persistent_recs_diff_cluster,makePct(cnt_persistent_recs_diff_cluster,cnt_persistent_recs)}],StatRec)},
																 {'Persistent Records Diff Cluster',cnt_persistent_recs_diff_cluster,DATASET([
																		{'Collapsed Records',cnt_persistent_recs_collapsed,makePct(cnt_persistent_recs_collapsed,cnt_persistent_recs_diff_cluster)},
																		{'Split Records',cnt_persistent_recs_split,makePct(cnt_persistent_recs_split,cnt_persistent_recs_diff_cluster)},
																		{'Shuffled Records',cnt_persistent_recs_shuffled,makePct(cnt_persistent_recs_shuffled,cnt_persistent_recs_diff_cluster)},
																		{'Shifted Records',cnt_persistent_recs_shifted,makePct(cnt_persistent_recs_shifted,cnt_persistent_recs_diff_cluster)}],StatRec)}],SummaryRec);
															
		 EXPORT clusterDS := DATASET([{'Current Clusters',cnt_base_cluster_tot,DATASET([
																		{'New Clusters',cnt_new_ids,makePct(cnt_new_ids,cnt_base_cluster_tot)},
																		{'Same Clusters',cnt_same_ids,makePct(cnt_same_ids,cnt_base_cluster_tot)}],StatRec)},
																 {'Previous Clusters',cnt_father_cluster_tot,DATASET([
																		{'Missing Clusters',cnt_old_ids,makePct(cnt_old_ids,cnt_father_cluster_tot)},
																		{'Same Clusters',cnt_same_ids,makePct(cnt_same_ids,cnt_father_cluster_tot)}],StatRec)},
																 {'New Clusters',cnt_new_ids,DATASET([
																		{'All New Records',cnt_all_new_ids,makePct(cnt_all_new_ids,cnt_new_ids)},
																		{'New Base Record',cnt_lowest_new_id,makePct(cnt_lowest_new_id,cnt_new_ids)},
																		{'From Split',cnt_ids_split,makePct(cnt_ids_split,cnt_new_ids)},
																		{'From Shuffle',cnt_ids_shuffled_new,makePct(cnt_ids_shuffled_new,cnt_new_ids)},
																		{'Deleted Base Record',cnt_ids_shifted_new,makePct(cnt_ids_shifted_new,cnt_new_ids)}],StatRec)},
																 {'Missing Clusters',cnt_old_ids,DATASET([
																		{'All Records Deleted',cnt_all_old_ids,makePct(cnt_all_old_ids,cnt_old_ids)},
																		{'Collapsed',cnt_ids_collapsed,makePct(cnt_ids_collapsed,cnt_old_ids)},
																		{'Deleted Base Record',cnt_ids_shifted_old,makePct(cnt_ids_shifted_old,cnt_old_ids)},
																		{'Shuffled',cnt_ids_shuffled_old,makePct(cnt_ids_shuffled_old,cnt_old_ids)}],StatRec)},
																 {'Same Clusters',cnt_same_ids,DATASET([
																		{'Recs Removed',cnt_ids_recs_removed,makePct(cnt_ids_recs_removed,cnt_same_ids)},
																		{'Recs Added',cnt_ids_recs_added,makePct(cnt_ids_recs_added,cnt_same_ids)},
																		{'Recs Mixed',cnt_ids_recs_mixed,makePct(cnt_ids_recs_mixed,cnt_same_ids)},
																		{'Persistent Clusters',cnt_persistent_ids,makePct(cnt_persistent_ids,cnt_same_ids)}],StatRec)}],SummaryRec);

	END;

	return PersistenceStatsResults;

endmacro;