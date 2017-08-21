//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader.BWR_Ingest - Ingest - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(HealthCareFacilityHeader.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
HealthCareFacilityHeader.Ingest.DoStats;
O;
