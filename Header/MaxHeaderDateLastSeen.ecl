IMPORT dx_header, data_services;

// choose FCRA or non-FCRA index, take the first row (must be only one) and return a date as a string
EXPORT MaxHeaderDateLastSeen(boolean isFCRA = FALSE) := FUNCTION
  unsigned1 iType := IF (isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

  RETURN (string6) CHOOSEN (dx_header.key_max_dt_last_seen(iType), 1)[1].max_date_last_seen;
END;
