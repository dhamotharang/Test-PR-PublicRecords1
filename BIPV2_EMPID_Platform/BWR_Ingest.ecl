//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EMPID_Platform.BWR_Ingest - Ingest - SALT V3.0 Gold');
IMPORT BIPV2_EMPID_Platform,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_EMPID_Platform.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_EMPID_Platform.Ingest.DoStats;
O;
