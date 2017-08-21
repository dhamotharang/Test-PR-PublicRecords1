//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev3.BWR_Ingest - Ingest - SALT V2.6 Beta 2');
IMPORT BIPV2_ProxID_dev3,SALT26;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_ProxID_dev3.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_ProxID_dev3.Ingest.DoStats;
O;
