import tools,KELOtto;

export Keys(
	 string pversion = ''

) := module
	
	shared Base_ClusterDetails 						:= PROJECT(KELOtto.KelFiles.FullCluster	,TRANSFORM(RECORDOF(LEFT)	,SELF.exp1_:=topn(LEFT.exp1_ , 255,LEFT.exp1_.entity_context_uid_),SELF:=LEFT ));
	shared Base_ElementPivot 							:= KelOtto.KelFiles.EntityStats;
	shared Base_ScoreBreakdown 						:= KelOtto.KelFiles.ScoreBreakdown;


 export Main := module
	tools.mac_FilesIndex('Base_ClusterDetails,{customer_id_,industry_type_,string100 tree_uid_:=tree_uid_,string100 entity_context_uid_:=entity_context_uid_},{Base_ClusterDetails}',KeyNames(pversion).Main.ClusterDetails,ClusterDetails);
	tools.mac_FilesIndex('Base_ElementPivot,{customer_id_,industry_type_,string100 entity_context_uid_:=entity_context_uid_},{Base_ElementPivot}',KeyNames(pversion).Main.ElementPivot,ElementPivot);
	tools.mac_FilesIndex('Base_ScoreBreakdown,{customer_id_,industry_type_,string100 entity_context_uid_:=entity_context_uid_},{Base_ScoreBreakdown}',KeyNames(pversion).Main.ScoreBreakdown,ScoreBreakdown);
	end; 	
end;