EXPORT Layout_Vehicle_Key := RECORD
  STRING30 Vehicle_Key;
  STRING15 Iteration_Key;
  STRING15 Sequence_Key := '';
  STRING2 state_origin := ''; //needed for dppa stuff
  BOOLEAN is_deep_dive := FALSE;
END;
