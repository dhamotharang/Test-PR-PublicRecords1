//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_mj6.BWR_Ingest - Ingest - SALT V3.0 B1');
IMPORT BIPV2_ProxID_mj6,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_ProxID_mj6.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_ProxID_mj6.Ingest.DoStats;
O;
