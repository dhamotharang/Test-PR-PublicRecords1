EXPORT fSetCurrentFlag(DATASET(layouts.final) f) := FUNCTION
	roll := DISTRIBUTE(f,hash(std_source_upd));

	dates := DISTRIBUTE(LastReportedDates(roll),hash(std_source_upd));

	upd := JOIN(roll, dates, left.std_source_upd = right.std_source_upd,
								TRANSFORM(recordof(roll),
											self.RESULT_CD_1 := IF(
												left.DATE_VENDOR_LAST_REPORTED = right.DATE_VENDOR_LAST_REPORTED,
												'C',
												'');
											self := left;), LEFT OUTER, LOCAL);

	return upd;
END;