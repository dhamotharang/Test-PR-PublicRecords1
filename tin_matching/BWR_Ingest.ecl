//If you are not ingesting as part of a header build you can use the below
#workunit('name','tin_matching.pBaseFile - Ingest - SALT V2.0 Gold')
output(tin_matching.Ingest.UpdateStats,all);
output(tin_matching.Ingest.FieldChangeStats,all);
output(tin_matching.Ingest.InputSourceCounts,all);
output(tin_matching.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte

