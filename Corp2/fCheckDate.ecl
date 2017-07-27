string8 CheckValidRange(string8 date) :=
  if((integer)date < 16000101 or (integer)date > (integer)stringlib.GetDateYYYYMMDD(), '', date);

export string8 fCheckDate(string date) := 
  map(date = '' => '',
      length(trim(date)) =  8 => CheckValidRange(date),  // full YYYYMMDD date
      length(trim(date)) = 4 => CheckValidRange(trim(date) + '0000'), // assumed YYYY only
      length(trim(date)) = 6 => CheckValidRange(trim(date) + '00'), // assumed YYYYMM only
	  length(trim(date)) > 8 => CheckValidRange(date[1..8]),
	  '');