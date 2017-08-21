#workunit('name','HThor R3 Inquiry Tracking Logs Supermove')

inquiry_acclogs.Proc_Prod_R3Monitoring.SuperMove 

: 
	 WHEN(cron('30 0-23/2 * * *')),
	 Failure(FileServices.SendEmail('John.Freibaum@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', 'ProdR3 File Move Failed on Monitoring Thor', thorlib.wuid() + '\nCheck Monitoring Thor http://10.173.249.4:8010/ - ' + FAILMESSAGE));
