import MDR;
EXPORT fn_Best_DEA_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_DEA								 => Dups * 2.0,
			Dups
	);
