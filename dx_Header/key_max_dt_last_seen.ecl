IMPORT data_services;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_max_date_fcra,
                                     $.names().i_max_date); 

EXPORT key_max_dt_last_seen (integer data_category = 0) := 
         INDEX ($.layouts.i_max_date, $.layouts.i_max_date, fname(data_category));
