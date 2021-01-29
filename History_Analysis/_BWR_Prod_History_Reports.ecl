import wk_ut, History_Analysis;

tenmorning := cron('0 15 * * *'); // expressed in cordinated universal time (UTC)

ecl_as_string:= 'import History_Analysis;\nHistory_Analysis._BWR_Create_Reports;';
wk_ut.CreateWuid(ecl_as_string,
                 'thor400_sta_eclcc',
				 'dataland_esp.br.seisint.com'
                ):when(tenmorning);
