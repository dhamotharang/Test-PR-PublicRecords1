//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev2.BWR_Ingest - Ingest - SALT V2.7 Alpha 5');
IMPORT BIPV2_ProxID_dev2,SALT27;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_ProxID_dev2.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_ProxID_dev2.Ingest.DoStats;
O;
