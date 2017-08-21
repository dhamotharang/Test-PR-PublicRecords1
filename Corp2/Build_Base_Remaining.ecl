IMPORT Corp2_Mapping, tools;

EXPORT Build_Base_Remaining(STRING 																		 									pversion,
														DATASET(Corp2.Layout_Corporate_Direct_AR_Base_expanded)			inARBase,
														DATASET(Corp2_Mapping.LayoutsCommon.ar)											inARUpdate,
														DATASET(Corp2.Layout_Corporate_Direct_Event_Base_expanded)	inEventBase,
														DATASET(Corp2_Mapping.LayoutsCommon.Events)									inEventUpdate,
														DATASET(Corp2.Layout_Corporate_Direct_Stock_Base_expanded)	inStockBase,
														DATASET(Corp2_Mapping.LayoutsCommon.Stock)									inStockUpdate) := MODULE
															
	pUpdateAR						:=	corp2.Build_Base_AR(inARBase, inARUpdate, pversion);
	pUpdateEvent				:=	Corp2.Build_Base_Event(inEventBase, inEventUpdate, pversion);
	pUpdateStock				:=	Corp2.Build_Base_Stock(inStockBase, inStockUpdate, pversion);

	Update_AR_Base			:= tools.macf_WriteFile(Filenames(pversion).Base_xtnd.ar.new			,corp2.KeyFilters.AR(pUpdateAR));	
	Update_Event_Base		:= tools.macf_WriteFile(Filenames(pversion).Base_xtnd.events.new	,corp2.KeyFilters.Events(pUpdateEvent));						
	Update_Stock_Base		:= tools.macf_WriteFile(Filenames(pversion).Base_xtnd.stock.new		,corp2.KeyFilters.Stock(pUpdateStock));														
	
	export 	All :=	parallel(
															Update_AR_Base
															,Update_Event_Base
															,Update_Stock_Base
 								  					 );
	
end;											 