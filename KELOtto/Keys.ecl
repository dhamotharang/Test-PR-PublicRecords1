IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';

	FileClusterDetails := DATASET('', {KELOtto.KelFiles.FullCluster}, THOR);

	EXPORT KeyClusterDetails := INDEX(FileClusterDetails,
															{customer_id_,industry_type_,STRING100 tree_uid_:=tree_uid_,STRING100 entity_context_uid_:=entity_context_uid_},
															{FileClusterDetails},
															prefix + 'thor_data400::key::fraudgov::qa::kel::clusterdetails');
														
	FileElementPivot := DATASET('', {KELOtto.KelFiles.EntityStats}, THOR);

	EXPORT KeyElementPivot := INDEX(FileElementPivot,
															{customer_id_,industry_type_,STRING100 entity_context_uid_:=entity_context_uid_},
															{FileElementPivot},
															prefix + 'thor_data400::key::fraudgov::qa::kel::elementpivot');
															
	FileScoreBreakdown := DATASET('', {KELOtto.KelFiles.ScoreBreakdown}, THOR);

	EXPORT KeyScoreBreakdown := INDEX(FileScoreBreakdown,
															{customer_id_,industry_type_,STRING100 entity_context_uid_:=entity_context_uid_},
															{FileScoreBreakdown},
															prefix + 'thor_data400::key::fraudgov::qa::kel::scorebreakdown');
END;