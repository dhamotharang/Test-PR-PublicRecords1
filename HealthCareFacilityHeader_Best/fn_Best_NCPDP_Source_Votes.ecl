import MDR;
EXPORT fn_Best_NCPDP_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_NCPDP								 => Dups * 2.0,
			 SRC = MDR.SourceTools.src_Enclarity						 => Dups * 1.0,
			Dups
	);
