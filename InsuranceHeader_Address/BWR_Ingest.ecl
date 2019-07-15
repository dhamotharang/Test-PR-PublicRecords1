//This is the code to execute in a builder window
#workunit('name','InsuranceHeader_Address.BWR_Ingest - Ingest - SALT V2.7 Gold SR1');
IMPORT InsuranceHeader_Address,SALT27;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(InsuranceHeader_Address.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
InsuranceHeader_Address.Ingest.DoStats;
O;
