cluster := SNA.File_Person_Cluster;
ctr := RECORD
	cluster.cluster_id;
	unsigned2 TotalCnt := COUNT(GROUP);
	unsigned2 FirstDegrees := COUNT(GROUP,cluster.Degree > 0 AND cluster.Degree <= 1.0);
	unsigned2 SecondDegrees := COUNT(GROUP,cluster.Degree > 1.0);
	real4 Cohesivity := AVE(GROUP,cluster.Degree);
	//CCPA-767
	UNSIGNED4 global_sid		:= 0;
	UNSIGNED8 record_sid		:= 0;
	UNSIGNED4 did 						:= 0;
END;

cohesivity_table := TABLE(cluster,ctr,cluster_id,MERGE);

export file_person_cluster_stats := cohesivity_table;