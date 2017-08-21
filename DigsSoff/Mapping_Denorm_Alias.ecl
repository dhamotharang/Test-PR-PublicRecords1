/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes the records in Alias file. The names  
							are concatinated to populate name_aka field. 
***********************************************************************************
*/	 
import Lib_StringLib;

//Re distribute the data based on id
DAlias     		 := DISTRIBUTE(File_soff_Alias, HASH32(File_soff_Alias.id));
DAlias_Sorted  := SORT(DAlias(last+first+middle+name<>''),id,name,first,middle,last,LOCAL);
// Populate the ID's in the denormalized layout
IdTable        := table(DAlias_Sorted,Layout_Denorm_Alias,id,LOCAl);
// removes dups 
DAlias_Sorted_Deduped := DEDUP(DAlias_Sorted,RECORD,LOCAL);

//output(count(File_soff_Alias));
//output(count(File_soff_Alias_Sorted));
//output(IdTable);

Layout_Denorm_Alias DeNormAlias(Layout_Denorm_Alias L, Layout_soff_Alias R, INTEGER C) := TRANSFORM

  //Use Last, First middle if available else name. 
	varstring v_alias_temp   := StringLib.StringFilterOut(IF(R.Last <> '' or R.first <> '' or R.middle <> '', 
		                                                       trim(trim(R.last)+', '+trim(R.first)+' '+R.middle),
														                               trim(R.name)),'"'); 
																													 
	varstring v_alias_temp_1 :=	trim(StringLib.StringFindReplace(v_alias_temp, ';',''));
	varstring V_alias_temp_2 := IF (v_alias_temp_1 not in Invalid_values, v_alias_temp_1, '');													 
	
	varstring V_alias_temp_3 := REGEXREPLACE('  ',V_alias_temp_2,' ');
	// add code to replace '  ' with ' '
	SELF.name_aka := MAP (C=1 => V_alias_temp_3, 
	                             If (L.name_aka <> '' , 
																              if (V_alias_temp_3 <> '', trim(L.name_aka)+';'+V_alias_temp_3 ,
																							                          L.name_aka),
													 										V_alias_temp_3)													 
						           );
	SELF := L;
end;
	 
export Mapping_Denorm_Alias := DENORMALIZE(IdTable,DAlias_Sorted_Deduped,
                                           LEFT.id = RIGHT.id,
										                       DeNormAlias(LEFT,RIGHT,COUNTER),LOCAL);
																	
