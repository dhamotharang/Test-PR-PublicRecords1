//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader.BWR_Ingest - Ingest - SALT V2.9 Gold');
IMPORT HealthCareProviderHeader,SALT29;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(HealthCareProviderHeader.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
HealthCareProviderHeader.Ingest.DoStats;
O;
