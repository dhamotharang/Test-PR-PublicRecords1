import tools,KELOtto;

export Keys(
	 string pversion = ''

) := module
	
	shared Base_ClusterDetails 						:= PROJECT(KELOtto.KelFiles.FullCluster	, TRANSFORM(Layouts_key.ClusterDetails	,SELF.exp1_:=topn(LEFT.exp1_ , 255,LEFT.exp1_.entity_context_uid_),self.zip_ := (integer8) LEFT.zip_ ,SELF:=LEFT ));
	shared Base_ElementPivot 							:= PROJECT(KelOtto.KelFiles.EntityStats, Transform(Layouts_Key.ElementPivot,self.entityhash:=(unsigned8)left.entityhash,self:=left));
	shared Base_ScoreBreakdown 						:= PROJECT(KelOtto.KelFiles.ScoreBreakdown, Layouts_Key.ScoreBreakdown);
	shared Base_WeightingChart 						:= PROJECT(Files().Input.ConfigRiskLevel.Sprayed, Transform(Layouts_Key.WeightingChart
																											,self.entitytype := (integer8)left.entitytype , self.low	:=(decimal64_32)left.low
																											,self.high	:= (decimal64_32)left.high , self.risklevel	:= (integer8)left.risklevel
																											,self.weight	:= (integer8)left.weight,self:=left));
																									

 export Main := module
	tools.mac_FilesIndex('Base_ClusterDetails,{customer_id_,industry_type_,entity_context_uid_,tree_uid_},{Base_ClusterDetails}',KeyNames(pversion).Main.ClusterDetails,ClusterDetails);
	tools.mac_FilesIndex('Base_ElementPivot,{customer_id_,industry_type_,entity_context_uid_},{Base_ElementPivot}',KeyNames(pversion).Main.ElementPivot,ElementPivot);
	tools.mac_FilesIndex('Base_ScoreBreakdown,{customer_id_,industry_type_,entity_context_uid_},{Base_ScoreBreakdown}',KeyNames(pversion).Main.ScoreBreakdown,ScoreBreakdown);
	tools.mac_FilesIndex('Base_WeightingChart,{field,entitytype},{Base_WeightingChart}',KeyNames(pversion).Main.WeightingChart,WeightingChart);
	end; 	
end;