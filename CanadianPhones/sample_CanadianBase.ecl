sampleRecs := dedup(sort(
				distribute(CanadianPhones.file_CanadianWhitePagesBase,hash(phonenumber))
				,source_file, phonenumber,-Date_last_reported,local)
				,source_file, keep 100,local);
export sample_CanadianBase := 
	   output(enth(sampleRecs,1000),named('PostProcessDataSample'),all);