import tools, Corp2_mapping, corp2;

EXPORT Update_Bases (
	 string																				    					pversion
	,DATASET(Corp2.Layout_Corporate_Direct_Corp_Base_expanded)	pBaseCorpFile			=	corp2.Files().Base_xtnd.corp.QA
	,DATASET(Corp2.Layout_Corporate_Direct_Cont_Base_expanded)	pBaseContFile			=	corp2.Files().Base_xtnd.cont.QA
	,DATASET(Corp2.Layout_Corporate_Direct_AR_Base_Expanded)		pBaseARFile				=	corp2.Files().Base_xtnd.ar.QA
	,DATASET(Corp2.Layout_Corporate_Direct_Event_Base_Expanded)	pBaseEventsFile		=	corp2.Files().Base_xtnd.events.QA
	,DATASET(Corp2.Layout_Corporate_Direct_Stock_Base_Expanded)	pBaseStockFile		=	corp2.Files().Base_xtnd.stock.QA

	,DATASET(Corp2_Mapping.LayoutsCommon.main)									pUpdateMainFile		=	corp2.Files().Input.main.using
	,DATASET(Corp2_Mapping.LayoutsCommon.ar)										pUpdateARFile			=	corp2.Files().Input.ar.using
	,DATASET(Corp2_Mapping.LayoutsCommon.events)								pUpdateEventFile	=	corp2.Files().Input.events.using
	,DATASET(Corp2_Mapping.LayoutsCommon.stock)									pUpdateStockFile	=	corp2.Files().Input.stock.using) 
:= MODULE

	export Build_Main		:=	corp2.Build_Base_Main(pversion,
																								pBaseCorpFile,
																								pBaseContFile,
																								pUpdateMainFile,
																								pBaseEventsFile,
																								pUpdateEventFile).All;
																			
	export Build_Rest		:=	corp2.Build_Base_Remaining(	pversion,
																											pBaseARFile,
																											pUpdateARFile,
																											pBaseEventsFile,
																											pUpdateEventFile,
																											pBaseStockFile,
																											pUpdateStockFile).All;
																							
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 SEQUENTIAL(
															Build_Main
															,Build_Rest
															),
									 OUTPUT('No Valid version parameter passed, skipping Corp2.Update_Bases atribute'));

END;