//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_DOWN_Platform.BWR_Ingest - Ingest - SALT V2.7 Gold');
IMPORT BIPV2_POWID_DOWN_Platform,SALT27;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_POWID_DOWN_Platform.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_POWID_DOWN_Platform.Ingest.DoStats;
O;
