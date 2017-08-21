//If you are not ingesting as part of a header build you can use the below
#workunit('name','DNB_DMI.file_base - Ingest - SALT V1.9 Gold')
output(DNB_DMI.Ingest.UpdateStats,all);
output(DNB_DMI.Ingest.FieldChangeStats,all);
output(DNB_DMI.Ingest.InputSourceCounts,all);
output(DNB_DMI.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte

