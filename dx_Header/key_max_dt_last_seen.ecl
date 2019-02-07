IMPORT $;

EXPORT key_max_dt_last_seen (integer data_category = 0) := 
         INDEX ($.layouts.i_max_date, $.layouts.i_max_date, $.names().i_max_date);
