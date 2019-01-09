import DEA;

Export File_DEA_Modified := Project(Dea.File_DEAv2 , Transform(DEA.Layout_DEA_OUT_base - 
								[xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc]
								, Self.name_score := ''; Self.score := ''; Self := Left;));