Layout_Rec_Type := RECORD
	Experian_Evaluation.Layout_Experian_CP_In;
	STRING1 RecType;
END;

//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*	'C1' = Current Name with first surname
	'C2' = Current Name with second surname
	'A11' = Alias 1 with first surname
	'A12' = Alias 1 with second surname
	'A21' = Alias 2 with first surname
	'A22' = Alias 2 with second surname
	'A31' = Alias 3 with first surname
	'A32' = Alias 3 with second surname
	'SP1' = Spouse with first surname
	'SP2' = Spouse with second surname
	*/

Layout_Experian_CP_Out.Layout_Experian_Norm_Name t_norm_name (Layout_Rec_Type L, INTEGER C) := TRANSFORM
	 STRING current_name1 	:= StringLib.StringCleanSpaces((L.Surname+', '+ L.First_Name+' '+ L.Middle_Name));
	 STRING current_name2 	:= IF(L.Second_Surname <> '', StringLib.StringCleanSpaces((L.Second_Surname+', ' + L.First_Name+ ' '+ L.Middle_Name)), '');
	 aka11 			:= StringLib.StringCleanSpaces((L.Surname2 + ', '+L.First_Name2 + ' '+ L.Middle_Name2));
	 aka12 			:= IF(L.Second_Surname2 <> '', StringLib.StringCleanSpaces((L.Second_Surname2 + ', '+ L.First_Name2 +' '+ L.Middle_Name2)), '');
	 aka21 			:= StringLib.StringCleanSpaces((L.Surname3 + ', '+L.First_Name3 + ' '+ L.Middle_Name3));
	 aka22 			:= IF(L.Second_Surname3 <> '', StringLib.StringCleanSpaces((L.Second_Surname3 + ', '+ L.First_Name3 +' '+ L.Middle_Name3)), '');
	 aka31 			:= StringLib.StringCleanSpaces((L.Surname4 + ', '+L.First_Name4 + ' '+ L.Middle_Name4));
	 aka32 			:= IF(L.Second_Surname4 <> '', StringLib.StringCleanSpaces((L.Second_Surname4 + ', '+ L.First_Name4 +' '+ L.Middle_Name4)), '');
	 spouse1 		:= StringLib.StringCleanSpaces((L.Surname+', '+ L.Spouse_First_Name+' '+ L.Middle_Name));
	 spouse2 		:= IF(L.Second_Surname <> '', StringLib.StringCleanSpaces((L.Second_Surname+', ' + L.Spouse_First_Name+ ' '+ L.Middle_Name)), '');

	 SELF.Name      := CHOOSE(C,current_name1,current_name2,aka11, aka12, aka21, aka22, aka31, aka32, spouse1, spouse2);
	 SELF.NameType  := CHOOSE(C,'C1','C2','A11','A12', 'A21','A22', 'A31', 'A32','SP1','SP2');
	 SELF 			:= L;
	 SELF			:= [];
END;

norm_names := NORMALIZE(Experian_Evaluation.File_Experian_CP_In, 10, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',');

EXPORT Normalize_Names := norm_names_filtered:persist('~thor_data400::persist::experian_cp_normalized_names');
