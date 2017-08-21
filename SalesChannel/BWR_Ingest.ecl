//If you are not ingesting as part of a header build you can use the below
#workunit('name','SalesChannel.File_Base - Ingest - SALT V2.0 Gold')
output(SalesChannel.Ingest.UpdateStats,all);
output(SalesChannel.Ingest.FieldChangeStats,all);
output(SalesChannel.Ingest.InputSourceCounts,all);
output(SalesChannel.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte

