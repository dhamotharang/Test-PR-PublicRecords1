IMPORT ut,tools,FraudgovKEL; 
EXPORT Build_Base_Kel (
   string pversion
) := 
module 

	shared Base_ConfigAttributes									:= PROJECT(Files().Input.ConfigAttributes.Sprayed
																											,Transform(Layouts.ConfigAttributes
																												,self.entitytype	:= (integer8)left.entitytype
																												,self.field	:= (string200)left.field
																												,self.low:=(decimal)left.low
																												,self.high:=(decimal)left.high
																												,self.risklevel	:=(integer)left.risklevel
																												,self.weight	:=(integer)left.weight
																												,self.customerid	:=(unsigned)left.customerid
																												,self.industrytype	:=(unsigned)left.industrytype
																												,Self:=left));

	shared Base_EntityRules					:= Project(FraudgovKEL.KEL_EventPivot.EntityProfileRules,Transform(Layouts.EntityRules,self:=left));																				
	
	shared Base_EntityAttributes		:= Project(FraudgovKEL.KEL_EntityStats,Transform(Layouts.EntityAttributes,self:=left));																				

	shared Base_GraphEdges					:= Project(FraudgovKEL.KEL_GraphPrep.Edges,Transform(Layouts.GraphEdges,self:=left));																				

	shared Base_GraphVertices				:= Project(FraudgovKEL.KEL_GraphPrep.Vertices,Transform(Layouts.GraphVertices,self:=left));																				
	
	shared Base_EntityProfile				:= Project(FraudgovKEL.KEL_EventPivot.EventPivotShell,Transform(Layouts.EntityProfile,self:=left));																				
	
	tools.mac_WriteFile(Filenames(pversion).Base.kel_EntityProfile.New, Base_EntityProfile, Build_kel_EntityProfile , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_ConfigAttributes.New, Base_ConfigAttributes, Build_kel_ConfigAttributes , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_EntityRules.New, Base_EntityRules, Build_kel_EntityRules , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_EntityAttributes.New, Base_EntityAttributes, Build_kel_EntityAttributes , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_GraphEdges.New, Base_GraphEdges, Build_kel_GraphEdges , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_GraphVertices.New, Base_GraphVertices, Build_kel_GraphVertices , pOverwrite := true);

// Return
	export full_build :=
		 Parallel(
			 Build_kel_EntityProfile,
			 Build_kel_ConfigAttributes,
			 Build_kel_EntityRules,
			 Build_kel_EntityAttributes,
			 Build_kel_GraphEdges,
			 Build_kel_GraphVertices		 
		);
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Kel atribute')
	);
	
end;
