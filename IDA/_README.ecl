
	// IDA INTEGRATION:
	
	// 	Overview: 

	//  The Build:
			
	//    1. Scheduler checking folder for spray files
    //    2. If spray files exist cron job spray new files
    //    3. After files sprayed runing base build, which cleanse records and append lexid and adl_ind.
    //    4. After cleaning records and appendig LexiId and adl_ind we build daily base.
    //    5. After bases was build slicing daily base to 3 fields lexid, recid and source.
    //    6. After slicing is done building output file for despraying.
    //    7. After despray files build, despraying as txt file.
    //    8. Once a month we will build monthly base using all daily files.
    //    9. We will take all daily files will pass thru cleaning and lexid append and adl_ind.
    //   10. After Lexid reappended we will build monthly base and base changes file.
    //   11. After monthly base is built we remove all daily files. 
			

						
	
	