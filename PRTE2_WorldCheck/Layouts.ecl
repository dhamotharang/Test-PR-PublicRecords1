import worldcheck;

EXPORT Layouts := module
	
	EXPORT key_in := RECORD, maxlength(30010)
		STRING10 uid;
		WorldCheck.Layout_WorldCheck_in - [external_sources, further_information, uid];
	END;
	
	EXPORT External_Sources := WorldCheck.Layout_WorldCheck_Ext_Sources;
	
	EXPORT Main := WorldCheck.Layout_WorldCheck_Cleaned.Layout_WorldCheck_Main;
	
	shared layout_id := RECORD
  unsigned6 id;
 END;

 EXPORT base := { string20 tkn, string1 etype, DATASET(layout_id) ids{maxcount(1000000)} };
END;