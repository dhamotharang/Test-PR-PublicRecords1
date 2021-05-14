IMPORT std, ut;    

no_of_threads := 20;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 1;
filetag := std.date.today()  +'_test'; 


// PhoneHeaderScore_infile:=;
PhoneHeaderScore_outfile:= '~ProcessAutomation::RoxieServices::PhoneHeaderScore' + filetag;


message:=output('ProcessAutomation RoxieServices jobs failed');

RoxieServices_ProcessAutomation.PhoneHeaderScore_Macro(no_of_threads, Timeout, Retry_time,
															 // PhoneHeaderScore_infile,
															 PhoneHeaderScore_outfile,
															 no_of_recs_to_run):RECOVERY(message,10);		
																											 
	  
EXPORT PhoneHeaderScore_Macro_BWR := 'todo';