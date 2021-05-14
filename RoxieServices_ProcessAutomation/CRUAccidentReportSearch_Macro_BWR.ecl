
IMPORT std;    
IMPORT RoxieServices_ProcessAutomation;

no_of_threads := 20;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 1;
filetag := std.date.today()  +'_test'; 


// CRUAccidentReportSearch_infile:=;
CRUAccidentReportSearch_outfile:= '~ProcessAutomation::RoxieServices::CRUAccidentReportSearch' + filetag;


message:=output('ProcessAutomation RoxieServices jobs failed');

RoxieServices_ProcessAutomation.CRUAccidentReportSearch_Macro(no_of_threads, Timeout, Retry_time,
															 // CRUAccidentReportSearch_infile,
															 CRUAccidentReportSearch_outfile,
															 no_of_recs_to_run):RECOVERY(message,10);		
																											 

EXPORT CRUAccidentReportSearch_Macro_BWR := 'todo';