/*
	IDA INTEGRATION:
	
		Overview: 

	 The Build:
			
			 1. Scheduler checking folder for spray files
       2. If spray files exist cron job spray new files
       3. After files sprayed runing base build, which cleanse records and append lexid and adl_ind.
       4. After cleaning records and appendig LexiId and adl_ind we build 2 bases daily and accumulative base.
       5. After bases was build slicing daily base to 3 fields lexid, recid and source.
       6. After slicing is done building output file for despraying.
       7. After despray files build, despraying as csv file.
			

						
	
	