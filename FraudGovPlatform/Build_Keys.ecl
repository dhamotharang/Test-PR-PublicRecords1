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
													  
	export full_build :=
		 parallel(
			 BuildWeightingChartKey
			,BuildClusterDetailsKey	
			,BuildElementPivotKey
			,BuildScoreBreakdownKey	
		 )
		;
		
	export All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping Build_Keys atribute')
				);

end;
