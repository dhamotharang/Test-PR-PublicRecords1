#workunit('name','R3 Inquiry Tracking GCID Flag Append')

inquiry_acclogs.Proc_Prod_R3Monitoring.Separate_R3_Records 

: 
	 WHEN(CRON('30 7 * * *')),
	 Failure(FileServices.SendEmail('John.Freibaum@lexisnexisrisk.com, Cecelie.Reid@lexisnexisrisk.com, Fernando.Incarnacao@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com', 'ProdR3 File Creation Failed on Monitoring Thor', thorlib.wuid() + '\nCheck Monitoring Thor http://10.173.249.4:8010/ - ' + FAILMESSAGE));
