import MDR;
EXPORT fn_Best_UPIN_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_Enclarity		 => Dups * 2.0,
			Dups
	);
