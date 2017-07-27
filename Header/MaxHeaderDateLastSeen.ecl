IMPORT doxie;

// choose FCRA or non-FCRA index, take the first row (must be only one) and return a date as a string
EXPORT MaxHeaderDateLastSeen(boolean isFCRA = FALSE) := 
	(string6) CHOOSEN (IF (isFCRA, doxie.Key_FCRA_max_dt_last_seen, doxie.key_max_dt_last_seen), 1)[1].max_date_last_seen;
