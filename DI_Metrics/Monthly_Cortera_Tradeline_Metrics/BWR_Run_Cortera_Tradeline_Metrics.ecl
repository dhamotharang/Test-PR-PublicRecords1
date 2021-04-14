IMPORT STD, _Control, DI_Metrics;

// The following script can be run in a builder window to generate monthly Cortera Tradeline
// metrics. At some point, this will be made obsolete except for testing purposes once an
// automation system runs Cortera_Tradeline_Metrics( ).

#WORKUNIT('name','Monthly Cortera Tradeline Metrics');

destinationIP   := _Control.IPAddress.bctlpedata12;
destinationpath := '/data/datainsight/data_evaluations/DataMetrics/Stats_NonFCRA/'; // success!
emailContact    := 'DataInsightAutomation@lexisnexisrisk.com';
today := (STRING8)WORKUNIT[2..9];

DI_Metrics.Monthly_Cortera_Tradeline_Metrics.Cortera_Tradeline_Metrics( destinationIP, destinationpath, emailContact, today );

// ...and then FTP the csv files from edata12 to \\Risk\inf\Data_Factory\DI_Landingzone\Cortera
