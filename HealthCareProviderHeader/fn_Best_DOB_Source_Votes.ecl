import MDR;
EXPORT fn_Best_DOB_Source_Votes (STRING2 SRC, Integer Dups) := 
	
	MAP (SRC = MDR.SourceTools.src_NPPES								 => Dups * 5.0,
	     SRC = MDR.SourceTools.src_DEA									 => Dups * 4.0,
			 SRC = MDR.SourceTools.src_Enclarity						 => Dups * 3.0,
			 SRC = MDR.SourceTools.src_Professional_License	 => Dups * 2.0,
			 SRC = MDR.SourceTools.src_AMS									 => Dups * 0.1,
			Dups
	);
