pState := 'ca';

#workunit('name', 'CorpV2 ' + stringlib.stringtouppercase(pState) + ' Spray & Mapping');

sequential( 
	 corp2_mapping.fSprayFiles(pState)
	,Corp2_Mapping.fMapState	(pState ,'20080311', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080318', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080325', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080402', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080408', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080416', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080422', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080429', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080506', poverwrite := true)
	,Corp2_Mapping.fMapState	(pState ,'20080701', poverwrite := true)
);                             