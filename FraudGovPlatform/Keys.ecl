import tools,KELOtto;

export Keys(
	 string pversion = ''

) := module
	
	shared Base_ClusterDetails 						:= PROJECT(KELOtto.KelFiles.FullCluster	, TRANSFORM(Layouts_key.ClusterDetails	,SELF.exp1_:=topn(LEFT.exp1_ , 255,LEFT.exp1_.entity_context_uid_),SELF:=LEFT ));
	shared Base_ElementPivot 							:= PROJECT(KelOtto.KelFiles.EntityStats, Layouts_Key.ElementPivot);
	shared Base_ScoreBreakdown 						:= PROJECT(KelOtto.KelFiles.ScoreBreakdown, Layouts_Key.ScoreBreakdown);


 export Main := module
	tools.mac_FilesIndex('Base_ClusterDetails,{customer_id_,industry_type_,entity_context_uid_,tree_uid_},{Base_ClusterDetails}',KeyNames(pversion).Main.ClusterDetails,ClusterDetails);
	tools.mac_FilesIndex('Base_ElementPivot,{customer_id_,industry_type_,entity_context_uid_},{Base_ElementPivot}',KeyNames(pversion).Main.ElementPivot,ElementPivot);
	tools.mac_FilesIndex('Base_ScoreBreakdown,{customer_id_,industry_type_,entity_context_uid_},{Base_ScoreBreakdown}',KeyNames(pversion).Main.ScoreBreakdown,ScoreBreakdown);
	end; 	
end;