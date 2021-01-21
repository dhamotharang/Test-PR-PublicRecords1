IMPORT _Control, DI_Metrics;

// The following script can be run in a builder window to generate monthly Cortera Tradeline
// metrics. At some point, this will be made obsolete except for testing purposes once an
// automation system runs Cortera_Tradeline_Metrics( ).

#WORKUNIT('name','Monthly Cortera Tradeline Metrics');

destinationIP   := _Control.IPAddress.bctlpedata12;
destinationpath := '/data/Builds/builds/DI_Metrics/';
emailContact    := 'DataInsightAutomation@lexisnexisrisk.com';

DI_Metrics.Monthly_Cortera_Tradeline_Metrics.Cortera_Tradeline_Metrics( destinationIP, destinationpath, emailContact );

// ...and then FTP the csv files from edata12 to \\Risk\inf\Data_Factory\DI_Landingzone\Cortera
