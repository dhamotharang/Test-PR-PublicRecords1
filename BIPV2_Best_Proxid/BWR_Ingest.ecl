//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_Proxid.BWR_Ingest - Ingest - SALT V2.8 Gold SR1');
IMPORT BIPV2_Best_Proxid,SALT28;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_Best_Proxid.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_Best_Proxid.Ingest.DoStats;
O;
