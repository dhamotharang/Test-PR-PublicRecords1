import tools,wk_ut; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export Proxid_Iteration_Stats             := tools.macf_FilesBase	(fnames.Proxid_Iteration_Stats            ,BIPV2_QA_Tool.Layouts.iteration_stats    );
	export Lgid3_Iteration_Stats              := tools.macf_FilesBase	(fnames.Lgid3_Iteration_Stats             ,BIPV2_QA_Tool.Layouts.iteration_stats    );
	export Proxid_mj6_Iteration_Stats         := tools.macf_FilesBase	(fnames.Proxid_mj6_Iteration_Stats        ,BIPV2_QA_Tool.Layouts.iteration_stats    );

	export Proxid_Persistence_Record_Stats    := tools.macf_FilesBase	(fnames.Proxid_Persistence_Record_Stats   ,BIPV2_QA_Tool.Layouts.persistence_stats  );
	export Proxid_Persistence_Cluster_Stats   := tools.macf_FilesBase	(fnames.Proxid_Persistence_Cluster_Stats  ,BIPV2_QA_Tool.Layouts.persistence_stats  );
	export Seleid_Persistence_Record_Stats    := tools.macf_FilesBase	(fnames.Seleid_Persistence_Record_Stats   ,BIPV2_QA_Tool.Layouts.persistence_stats  );
	export Seleid_Persistence_Cluster_Stats   := tools.macf_FilesBase	(fnames.Seleid_Persistence_Cluster_Stats  ,BIPV2_QA_Tool.Layouts.persistence_stats  );
	
	export Seleid_Entity_Stats                := tools.macf_FilesBase	(fnames.Seleid_Entity_Stats               ,BIPV2_QA_Tool.Layouts.entity_stats       );
	export Proxid_Entity_Stats                := tools.macf_FilesBase	(fnames.Proxid_Entity_Stats               ,BIPV2_QA_Tool.Layouts.entity_stats       );

	export Seleid_PostLink_Stats              := tools.macf_FilesBase	(fnames.Seleid_PostLink_Stats             ,BIPV2_QA_Tool.Layouts.postlink_stats     );
	export Proxid_PostLink_Stats              := tools.macf_FilesBase	(fnames.Proxid_PostLink_Stats             ,BIPV2_QA_Tool.Layouts.postlink_stats     );

end;