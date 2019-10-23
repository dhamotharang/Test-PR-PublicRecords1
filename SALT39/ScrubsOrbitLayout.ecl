EXPORT ScrubsOrbitLayout := RECORD
  UNSIGNED8 recordstotal;
	UNSIGNED4 processdate;
	STRING10  sourcecode;
	STRING    ruledesc;
	STRING    ErrorMessage;
	UNSIGNED8 rulecnt;
	UNSIGNED1 rulepcnt;
	STRING1   rejectwarning := '';
	SALT39.StrType rawcodemissing := '';
	UNSIGNED1 rawcodemissingcnt := 0;
  END;
