import MDR;
EXPORT fn_sources (STRING2 SRC) := FUNCTION
	source_bitmap := map (
		src = MDR.SourceTools.src_DEA 									=> 1,
		src = MDR.SourceTools.src_Ingenix_Sanctions 		=> 2,
		src = MDR.SourceTools.src_NPPES							 		=> 3,
		src = MDR.SourceTools.src_Professional_License 	=> 4,		
		src = MDR.SourceTools.src_AMS									 	=> 5,
		6
	);
	
	return source_bitmap;
END;