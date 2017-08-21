IMPORT PRTE_CSV;
/* This code will reverse engineer the source file from the existing keys and rebuild the data again from the source file to compare 
to make sure no data is missed */
	
//Source Datasets for reverse engineering existing PRCT files for watercraft
DS_Key_CID			 		:= 	PRTE_CSV.Watercraft.dCSVWatercraft__cid;
DS_Key_SID					:=	PRTE_CSV.Watercraft.dCSVWatercraft__sid;
DS_Key_WID					:= 	PRTE_CSV.Watercraft.dCSVWatercraft__wid;

//Source Datasets Layouts. This is not used. It is just for reference.
Layout_CID					:= 	PRTE_CSV.Watercraft.rCSVWatercraft__cid;
Layout_SID					:= 	PRTE_CSV.Watercraft.rCSVWatercraft__sid;
Layout_WID					:= 	PRTE_CSV.Watercraft.rCSVWatercraft__wid;
	
CG 									:= PROJECT(DS_Key_CID, 
																TRANSFORM(PRTE2_Watercraft._Layouts.CoastGuard,
																					SELF.hull_number := stringlib.stringtouppercase(LEFT.hull_number);
																					SELF:= LEFT;
																					SELF := []));
												
Search 							:= PROJECT(DS_Key_SID, 
																TRANSFORM(PRTE2_Watercraft._Layouts.Search,
																					SELF:= LEFT;
																					SELF := []));
																					
Main 								:= PROJECT(DS_Key_WID, 
																TRANSFORM(PRTE2_Watercraft._Layouts.main,
																					SELF.hull_number := stringlib.stringtouppercase(LEFT.hull_number);
																					SELF:= LEFT;
																					SELF := []));
																					
Main_CG_Joined			:= JOIN(Main,CG,
																LEFT.state_origin			= RIGHT.state_origin AND
																LEFT.watercraft_key		= RIGHT.watercraft_key AND
																LEFT.sequence_key			= RIGHT.sequence_key,
																TRANSFORM(PRTE2_Watercraft._Layouts.BaseInput_Slim, 
																					SELF.state_origin := LEFT.state_origin;
																					SELF.watercraft_key := LEFT.watercraft_key;
																					SELF.sequence_key := LEFT.sequence_key;
																					SELF.source_code_Main := LEFT.Source_code;
																					SELF.source_code_CG := RIGHT.Source_code;
																					SELF.hull_number_Main := LEFT.Hull_number;
																					SELF.hull_number_CG := RIGHT.hull_number;
																					SELF.history_flag_Main := LEFT.history_flag;
																					SELF := LEFT;
																					SELF := RIGHT;
																					SELF := [];), LEFT OUTER);

AllDataSource			 	:= JOIN(Main_CG_Joined,Search,
															 LEFT.state_origin			= RIGHT.state_origin AND
															 LEFT.watercraft_key		= RIGHT.watercraft_key AND
															 LEFT.sequence_key			= RIGHT.sequence_key,
															 TRANSFORM(PRTE2_Watercraft._Layouts.BaseInput_Slim, 
																				 SELF.state_origin := LEFT.state_origin;
																				 SELF.watercraft_key := LEFT.watercraft_key;
																				 SELF.sequence_key := LEFT.sequence_key;
																				 SELF.source_code_Search := RIGHT.Source_code;
																				 SELF.history_flag_Search := RIGHT.history_flag;
																				 SELF := RIGHT;
																				 SELF := LEFT;
																				 SELF := [];), LEFT OUTER);
 

// Now recreate the base files from the AllDataSource

AllDataSourceExpanded := PROJECT(AllDataSource, 
																	TRANSFORM(PRTE2_Watercraft._Layouts.Base, 
																						SELF := LEFT; 
																						SELF := [];));

Recreated_Main_Temp		:= PROJECT(AllDataSourceExpanded(source_code_Main <> ''),
																	TRANSFORM(PRTE2_Watercraft._Layouts.main, 
																						SELF := LEFT;
																						SELF.Source_code  := LEFT.source_code_Main;
																						SELF.Hull_number  := LEFT.hull_number_Main;
																						SELF.history_flag := LEFT.history_flag_Main;
																						SELF := [];));
								
Recreated_Main				:= DEDUP(SORT(Recreated_Main_Temp,RECORD),RECORD);

Recreated_CG_Temp			:= PROJECT(AllDataSourceExpanded(source_code_CG <> ''),
																	TRANSFORM(PRTE2_Watercraft._Layouts.Coastguard, 
																						SELF := LEFT;
																						SELF.Source_code  := LEFT.source_code_CG;
																						SELF.Hull_number  := LEFT.hull_number_CG;
																						SELF := [];));
								
Recreated_CG					:= DEDUP(SORT(Recreated_CG_Temp,RECORD),RECORD);

Recreated_Search_Temp			:= PROJECT(AllDataSourceExpanded(source_code_Search <> ''),
																	TRANSFORM(PRTE2_Watercraft._Layouts.Search, 
																						SELF := LEFT;
																						SELF.Source_code  := LEFT.source_code_Search;
																						SELF.history_flag  := LEFT.history_flag_Search;
																						SELF := [];));
								
Recreated_Search					:= DEDUP(SORT(Recreated_Search_Temp,RECORD),RECORD);

DS := DATASET([	{'Main'											,COUNT(Main)},
								{'CG'												,COUNT(CG)},
								{'Main_CG'									,COUNT(Main_CG_Joined)},
								{'Search'										,COUNT(Search)},
								{'AllJoined'								,COUNT(AllDataSource)},
								{'AllExpanded'							,COUNT(AllDataSourceExpanded)},
								{'Recreated_Search_Temp'		,COUNT(Recreated_Search_Temp)},
								{'Recreated_Main_Temp'			,COUNT(Recreated_Main_Temp)},
								{'Recreated_CG_Temp'				,COUNT(Recreated_CG_Temp)},
								{'Recreated_Search'					,COUNT(Recreated_Search)},
								{'Recreated_Main'						,COUNT(Recreated_Main)},
								{'Recreated_CG'							,COUNT(Recreated_CG)},
								{'Search - Recreated_Search',COUNT(Search - Recreated_Search)},
								{'Main - Recreated_Main'		,COUNT(Main - Recreated_Main)},
								{'CG - Recreated_CG'				,COUNT(CG - Recreated_CG)},
								{'Recreated_Search - Search',COUNT(Recreated_Search - Search)},
								{'Search - Recreated_Search',COUNT(Search - Recreated_Search)},
								{'Search - Recreated_Search',COUNT(Search - Recreated_Search)}],
							{STRING DsName,INTEGER Cnt});
DS;

