//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_test6.BWR_Ingest - Ingest - SALT V2.7 Beta 1');
IMPORT BIPV2_Best_test6,SALT27;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_Best_test6.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_Best_test6.Ingest.DoStats;
O;
