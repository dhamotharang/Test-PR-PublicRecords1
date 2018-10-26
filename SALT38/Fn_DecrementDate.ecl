IMPORT STD;
EXPORT Fn_DecrementDate(UNSIGNED6 date, STRING dt_resolution='YYYYMMDD') := FUNCTION
  STRING yyyymmddhhmmss := (STRING)date;
	dateSecs := STD.Date.SecondsFromParts((UNSIGNED2)yyyymmddhhmmss[1..4], //yyyy
	                                      (UNSIGNED1)yyyymmddhhmmss[5..6], //mm
																				(UNSIGNED1)yyyymmddhhmmss[7..8], //dd
																				(UNSIGNED1)yyyymmddhhmmss[9..10], //hh
																				(UNSIGNED1)yyyymmddhhmmss[11..12], //mm
																				(UNSIGNED1)yyyymmddhhmmss[13..14]); //ss
  dateYYYYMMDDHHMMSSMinusSec 	:= DATASET([STD.Date.CreateDateTimeFromSeconds(dateSecs - 1)])[1];																				
	
  STRING new_date := MAP(dt_resolution='YYYYMMDD'=>utDateMath(((STRING)date)[1..8],-1),
	                       dt_resolution='YYYYMM'=>utDateMath(((STRING)date)[1..6],-1)[1..6],
												 dt_resolution='YYYYMMDDHHMMSS'=>(STRING)(dateYYYYMMDDHHMMSSMinusSec.year*10000000000 + dateYYYYMMDDHHMMSSMinusSec.month*100000000 + dateYYYYMMDDHHMMSSMinusSec.day*1000000 + dateYYYYMMDDHHMMSSMinusSec.hour*10000 + dateYYYYMMDDHHMMSSMinusSec.minute*100 + dateYYYYMMDDHHMMSSMinusSec.second), //tbd
												 utDateMath(((STRING)date)[1..8],-1));
	RETURN new_date;
END;