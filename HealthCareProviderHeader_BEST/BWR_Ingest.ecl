//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Ingest - Ingest - SALT V2.9 Beta 3');
IMPORT HealthCareProviderHeader_BEST,SALT29;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(HealthCareProviderHeader_BEST.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
HealthCareProviderHeader_BEST.Ingest.DoStats;
O;
