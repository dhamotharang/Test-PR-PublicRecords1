import tools,FraudgovKEL;

export Keys(
	 string pversion = ''

) := module
	shared Base_WeightingChart						:= PROJECT(Files().Input.ConfigRiskLevel.Sprayed, Transform(Layouts_Key.WeightingChart
																											,self.entitytype := (integer8)left.entitytype , self.low	:=(decimal64_32)left.low
																											,self.high	:= (decimal64_32)left.high , self.risklevel	:= (integer8)left.risklevel
																											,self.weight	:= (integer8)left.weight,self:=left));
	shared Base_EntityProfile							:= PROJECT(FraudgovKEL.KEL_PivotIndexPrep.ds_KEL_PivotIndexPrep(aotcurrprofflag=1)
																											,Transform(Layouts_Key.EntityProfile
																											,self.entitycontextuid :=left.entitycontextuid,self:=left));	
	shared Base_ConfigAttributes					:= PROJECT(Files().Input.ConfigAttributes.Sprayed
																							,Transform(Layouts_Key.ConfigAttributes
																								,self.entitytype	:= (integer8)left.entitytype
																								,self.field	:= (string200)left.field
																								,self.low:=(decimal)left.low
																								,self.high:=(decimal)left.high
																								,self.risklevel	:=(integer)left.risklevel
																								,self.weight	:=(integer)left.weight
																								,self.customerid	:=(unsigned)left.customerid
																								,self.industrytype	:=(unsigned)left.industrytype
																								,Self:=left));
	shared Base_ConfigRules								:= PROJECT(Files().Input.ConfigRules.Sprayed,Transform(Layouts_Key.ConfigRules,Self:=left));
																																																		
	shared Base_ClusterDetails 						:= Key_ClusterDetails_Delta + Key_ClusterDetails_Demo;
	shared Base_ElementPivot 							:= Key_ElementPivot_Delta +	Key_ElementPivot_Demo;
	shared Base_ScoreBreakdown 						:= Key_ScoreBreakdown_Delta + Key_ScoreBreakdown_Demo;
																											
 export Main := module
	tools.mac_FilesIndex('Base_ClusterDetails,{customer_id_,industry_type_,entity_context_uid_,tree_uid_},{Base_ClusterDetails}',KeyNames(pversion).Main.ClusterDetails,ClusterDetails);
	tools.mac_FilesIndex('Base_ElementPivot,{customer_id_,industry_type_,entity_context_uid_},{Base_ElementPivot}',KeyNames(pversion).Main.ElementPivot,ElementPivot);
	tools.mac_FilesIndex('Base_ScoreBreakdown,{customer_id_,industry_type_,entity_context_uid_},{Base_ScoreBreakdown}',KeyNames(pversion).Main.ScoreBreakdown,ScoreBreakdown);
	tools.mac_FilesIndex('Base_WeightingChart,{field,entitytype},{Base_WeightingChart}',KeyNames(pversion).Main.WeightingChart,WeightingChart);
	tools.mac_FilesIndex('Base_EntityProfile,{customerid,industrytype,entitycontextuid},{Base_EntityProfile}',KeyNames(pversion).Main.EntityProfile,EntityProfile);
	tools.mac_FilesIndex('Base_ConfigAttributes,{Field, EntityType, CustomerId, IndustryType,value},{Base_ConfigAttributes}',KeyNames(pversion).Main.ConfigAttributes,ConfigAttributes);
	tools.mac_FilesIndex('Base_ConfigRules,{CustomerId, IndustryType, Field, EntityType,rulename},{Base_ConfigRules}',KeyNames(pversion).Main.ConfigRules,ConfigRules);
	end; 	
end;