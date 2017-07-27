//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EmpID_Down.BWR_Ingest - Ingest - SALT V3.2.0');
IMPORT BIPV2_EmpID_Down,SALT32;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_EmpID_Down.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_EmpID_Down.Ingest.DoStats;
O;
