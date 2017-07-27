export string8 FormatDateOut(unsigned4 date) := 
  map(date <> 0 and date > 10000000 => intformat(date, 8, 1),
      date <> 0 and date > 100000 => intformat(date, 6, 1),
	  date <> 0 and date > 1000 => intformat(date, 4, 1),
	  '');