import MDR;
EXPORT fn_Best_CLIA_Source_Votes (STRING2 SRC, Integer Dups) := 
		
	MAP (SRC = MDR.SourceTools.src_CLIA									 => Dups * 5.0,
			 SRC = MDR.SourceTools.src_Enclarity						 => Dups * 4.0,
			Dups
	);
