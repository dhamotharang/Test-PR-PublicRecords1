//If you are not ingesting as part of a header build you can use the below
#workunit('name','NPPES.FileIN - Ingest - SALT V1.9 Gold')
output(NPPES.Ingest.UpdateStats,all);
output(NPPES.Ingest.FieldChangeStats,all);
output(NPPES.Ingest.InputSourceCounts,all);
output(NPPES.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte

