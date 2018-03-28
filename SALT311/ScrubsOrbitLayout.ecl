EXPORT ScrubsOrbitLayout := RECORD
  UNSIGNED8 recordstotal;
	UNSIGNED4 processdate;
	STRING10  sourcecode;
	STRING    ruledesc;
	STRING    ErrorMessage;
	UNSIGNED8 rulecnt;
	DECIMAL5_2 rulepcnt;
	STRING1   rejectwarning := '';
	SALT311.StrType rawcodemissing := '';
	UNSIGNED1 rawcodemissingcnt := 0;
  END;
