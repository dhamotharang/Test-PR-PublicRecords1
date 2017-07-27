
EXPORT Layout_AllowedSources := RECORD
		STRING2 Source 			:= ''; // MDR.SourceTool 2-character source codes		
		STRING1 SourceClass := ''; // A, B, C, or D sources. A + B = Header Sources, C + D = Non-Header Sources
END;