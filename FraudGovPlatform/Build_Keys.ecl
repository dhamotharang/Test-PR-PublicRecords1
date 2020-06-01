import doxie, tools, versioncontrol,FraudShared;

export Build_Keys(
	 string pversion = ''
  ) := module
  
	shared TheKeys := Keys(
		 pversion
	);

	tools.mac_WriteIndex('TheKeys.Main.ClusterDetails.New'								  	,BuildClusterDetailsKey			);
	tools.mac_WriteIndex('TheKeys.Main.ElementPivot.New'											,BuildElementPivotKey				);
	tools.mac_WriteIndex('TheKeys.Main.ScoreBreakdown.New'										,BuildScoreBreakdownKey			);
	tools.mac_WriteIndex('TheKeys.Main.WeightingChart.New'										,BuildWeightingChartKey			);
	tools.mac_WriteIndex('TheKeys.Main.EntityProfile.New'											,BuildEntityProfileKey			);
	tools.mac_WriteIndex('TheKeys.Main.ConfigAttributes.New'									,BuildConfigAttributesKey		);
	tools.mac_WriteIndex('TheKeys.Main.ConfigRules.New'												,BuildConfigRulesKey				);
	//Kel Demo
	tools.mac_WriteIndex('TheKeys.Main.ClusterDetails_Demo.New'								,BuildClusterDetailsKey_Demo	);
	tools.mac_WriteIndex('TheKeys.Main.ElementPivot_Demo.New'									,BuildElementPivotKey_Demo		);
	tools.mac_WriteIndex('TheKeys.Main.ScoreBreakdown_Demo.New'								,BuildScoreBreakdownKey_Demo	);
	//Kel Delta
	tools.mac_WriteIndex('TheKeys.Main.ClusterDetails_Delta.New'							,BuildClusterDetailsKey_Delta	);
	tools.mac_WriteIndex('TheKeys.Main.ElementPivot_Delta.New'								,BuildElementPivotKey_Delta		);
	tools.mac_WriteIndex('TheKeys.Main.ScoreBreakdown_Delta.New'							,BuildScoreBreakdownKey_Delta	);
													  
	export full_build :=
		 parallel(
			 BuildWeightingChartKey
			,BuildClusterDetailsKey	
			,BuildElementPivotKey
			,BuildScoreBreakdownKey	
			,BuildEntityProfileKey
			,BuildConfigAttributesKey
			,BuildConfigRulesKey
		 )
		;
	
	export full_build_demo :=
		 parallel(
			 BuildClusterDetailsKey_Demo	
			,BuildElementPivotKey_Demo
			,BuildScoreBreakdownKey_Demo	
		 )
		;
	export full_build_delta :=
		 parallel(
			 BuildClusterDetailsKey_Delta	
			,BuildElementPivotKey_Delta
			,BuildScoreBreakdownKey_Delta	
		 )
		;	
	export All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping Build_Keys atribute')
				);
				
	export Demo_All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build_demo
				,output('No Valid version parameter passed, skipping Build_Keys atribute')
				);
				
	export Delta_All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build_Delta	
				,output('No Valid version parameter passed, skipping Build_Keys atribute')
				);				
end;
