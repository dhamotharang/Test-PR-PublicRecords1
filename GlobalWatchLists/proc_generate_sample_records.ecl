// Simply run to generate a sample file that contains every 70th record.
// Currently generates approximately 600 records.
d := GlobalWatchLists.File_GlobalWatchLists;  
dsample := sample(d,50,1);  


export proc_generate_sample_records := output(dsample,,'~thor_200::out::gwlSampleData',overwrite); ;