//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader_Best.BWR_Ingest - Ingest - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader_Best,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(HealthCareFacilityHeader_Best.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
HealthCareFacilityHeader_Best.Ingest.DoStats;
O;
