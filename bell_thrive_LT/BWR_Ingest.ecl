//If you are not ingesting as part of a header build you can use the below
#workunit('name','bell_thrive_LT.files().input.used - Ingest - SALT V2.0 Gold')
output(bell_thrive_LT.Ingest.UpdateStats,all);
output(bell_thrive_LT.Ingest.FieldChangeStats,all);
output(bell_thrive_LT.Ingest.InputSourceCounts,all);
output(bell_thrive_LT.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte

