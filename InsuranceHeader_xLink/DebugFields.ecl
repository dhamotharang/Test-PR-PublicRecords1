EXPORT DebugFields := RECORD		
	INTEGER2 xlink_weight := 0; 
  UNSIGNED2 xlink_score := 0;	// salt score
  INTEGER1 xlink_distance := 0;  
	UNSIGNED4 xlink_keys := 0;  
	STRING xlink_keys_desc := '';
  STRING60 xlink_matches := '';  
  STRING xlink_matches_desc := '';
END;