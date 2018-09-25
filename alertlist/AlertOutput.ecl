import AlertList;

EXPORT AlertOutput(string jobid) := FUNCTION

	alert_out := dataset('~thordev_socialthor_50::out::social_alert_results::' + jobid, alertlist.files.Layout_Accurint_Social_Stats, thor);

 return alert_out;
END;