import MDR;
EXPORT fn_Best_NPI_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_NPPES								 => Dups * 2.0,
			Dups
	);
