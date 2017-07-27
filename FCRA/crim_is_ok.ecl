import ut;

export crim_is_ok(STRING8 today, STRING8 fcra_date, STRING1 fcra_conviction_flag, STRING1 fcra_traffic_flag) := 
ut.DaysApart(today,fcra_date) < ut.DaysInNYears(7) AND fcra_conviction_flag in ['Y','D'] AND fcra_traffic_flag='N';