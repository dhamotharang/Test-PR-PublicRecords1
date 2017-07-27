/**
  *Function to transforms YYYYMMDD to MM/DD/YYYY
  *IF no Partial dates in the input STD.date.ConvertDateFormat( inDate, '%Y%m%d','%m/%d/%Y') is better replacement
 */
EXPORT date_YYYYMMDDtoDateSlashed(STRING inDate) := IF (LENGTH(TRIM(inDate,LEFT,RIGHT)) = 8,
	                                                      inDate[5..6] + '/' + inDate[7..8] + '/' + inDate[1..4],
																												inDate);