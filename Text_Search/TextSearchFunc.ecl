// This function is deprecated.  Use the Text_Search_Module.
//
EXPORT TextSearchFunc(FileName_Info info, STRING srch, 
											boolean scoreResults = TRUE,
											BOOLEAN keepHits=FALSE, 
											INTEGER docs=1000,
											BOOLEAN useGraph=FALSE) := FUNCTION
	// this is now just a wrapper for Text_Search_Module
	
	tm := Text_Search_Module(info,srch,scoreResults,keephits,,docs,TRUE,useGraph);
	
	RETURN tm.answers;
END;