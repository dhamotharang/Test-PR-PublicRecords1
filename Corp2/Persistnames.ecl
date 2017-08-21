import versioncontrol;
export Persistnames :=
module
	export BWRBuildCorpBoolean			:= Thor_Cluster + 'persist::Corp2::BWR_Build_Corp_Boolean';
	export fAppend_AID_For_POE			:= Thor_Cluster + 'persist::Corp2::fAppend_AID_For_POE.fStandardizeAddresses';
	export StandardAddrName					:= Thor_Cluster + 'persist::Corp2::StandardAddrName';	
	export StandardAddrNameSlim			:= Thor_Cluster + 'persist::Corp2::StandardAddrNameSlim';	
	export UpdateAR									:= Thor_Cluster + 'persist::Corp2::Update_AR';
	export UpdateEvent							:= Thor_Cluster + 'persist::Corp2::Update_Event';
	export UpdateStock							:= Thor_Cluster + 'persist::Corp2::Update_Stock'						;

	

	export dAll_superfilenames :=
	dataset([
		{BWRBuildCorpBoolean}
		,{fAppend_AID_For_POE}
		,{StandardAddrName}
		,{StandardAddrNameSlim}
		,{UpdateAR}
		,{UpdateStock}
		,{UpdateEvent}
		
	], versioncontrol.Layout_Names);
		
end;