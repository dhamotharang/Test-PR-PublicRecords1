import MDR;
EXPORT fn_Best_Medicare_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_NPPES								 => Dups * 2.0,
			 SRC = MDR.SourceTools.src_Enclarity						 => Dups * 1.0,
			Dups
	);
