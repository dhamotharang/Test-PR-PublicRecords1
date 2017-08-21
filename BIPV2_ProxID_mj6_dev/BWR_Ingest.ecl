//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_mj6_dev.BWR_Ingest - Ingest - SALT V3.0 B1');
IMPORT BIPV2_ProxID_mj6_dev,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_ProxID_mj6_dev.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_ProxID_mj6_dev.Ingest.DoStats;
O;
