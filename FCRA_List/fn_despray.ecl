import watchdog;
EXPORT fn_despray(string pversion) := module

//despray FCRA best to the LZ for the batch team

monthly_filename := '~thor_data400::Base::Watchdog_Best_FCRA_list';

export dmonthly := fileservices.despray(monthly_filename, 
FCRA_list.constants.DestinationIP, FCRA_list.constants.DestinationDirectoryMonthly + pversion+'.csv',,,,TRUE); 

weekly_filename := '~thor_data400::base::watchdog_best_fcra_lexid_optout';

export dweekly := fileservices.despray(weekly_filename, 
FCRA_list.constants.DestinationIP, FCRA_list.constants.DestinationDirectoryweekly + pversion+'.csv',,,,TRUE); 


end;
