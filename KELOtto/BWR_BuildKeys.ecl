#option('multiplePersistInstances', false); 

//Elements Stats
dElementPivot := KelOtto.KelFiles.EntityStats;
keyElementPivot := INDEX(dElementPivot, {customer_id_,industry_type_,string100 entity_context_uid_:=entity_context_uid_}, {dElementPivot}, '~thor_data400::key::fraudgov::qa::kel::elementpivot');

//Score Breakdown
dScore := KELOtto.KelFiles.ScoreBreakdown;
keyScoreBreakdown := INDEX(dScore, {customer_id_,industry_type_,string100 entity_context_uid_:=entity_context_uid_}, {dScore}, '~thor_data400::key::fraudgov::qa::kel::scorebreakdown');

//Cluster Details
dGraph := PROJECT(KELOtto.KelFiles.FullCluster
				,TRANSFORM(RECORDOF(LEFT)
					,SELF.exp1_:=topn(LEFT.exp1_ , 255,LEFT.exp1_.entity_context_uid_)
					,SELF:=LEFT
				));
keyGraph := INDEX(dGraph, {customer_id_,industry_type_,string100 tree_uid_:=tree_uid_,string100 entity_context_uid_:=entity_context_uid_}, {dGraph}, '~thor_data400::key::fraudgov::qa::kel::clusterdetails');

//Build Indexes
PARALLEL(BUILDINDEX(keyGraph, OVERWRITE),
	 BUILDINDEX(keyScoreBreakdown, OVERWRITE),
	 BUILDINDEX(keyElementPivot, OVERWRITE)
	 );
