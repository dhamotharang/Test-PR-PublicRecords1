IMPORT lib_date;
IMPORT lib_timelib;

STRING BL := '';

EXPORT STRING makeDateRstrctStr(STRING orgSrchStr,
																STRING dateSegName,
																UNSIGNED2 lastXDays,
																STRING envVerName = BL) := FUNCTION
	STRING verDtStr := IF(envVerName <> BL, thorlib.getenv(envVerName, BL), BL);
  STRING todayStr := (STRING) timelib.CurrentDate(TRUE); // Local time, not Zulu
	UNSIGNED2 diffDays := IF(verDtStr <> BL, (UNSIGNED2) lib_date.DaysApart(verDtStr, todayStr) + 7, 0);
	STRING segPart := getDate(-MAX(diffDays, lastXDays));

	RETURN IF(dateSegName <> BL, '(' + orgSrchStr + ') AND ' + dateSegName + '(GE ' + segPart + ')',
															 orgSrchStr);
END;