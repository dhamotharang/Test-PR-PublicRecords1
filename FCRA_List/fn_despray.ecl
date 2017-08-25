import watchdog,PromoteSupers;
EXPORT fn_despray(string pversion) := module

//despray FCRA best to the LZ for the batch team

monthly_filename := '~thor_data400::Base::Watchdog_Best_FCRA_list_LEXID';
monthly_LEXID_list := project(FCRA_list.file_best,fcra_list.layout_optout.lexid);

PromoteSupers.MAC_SF_BuildProcess(monthly_LEXID_list ,monthly_filename,BLexid_monthly_list,2,true,true);
					
export dmonthly := sequential(BLexid_monthly_list, fileservices.despray(monthly_filename, 
FCRA_list.constants.DestinationIP, FCRA_list.constants.DestinationDirectoryMonthly + pversion+'.csv',,,,TRUE)); 

weekly_filename := '~thor_data400::base::watchdog_best_fcra_lexid_optout';

export dweekly := fileservices.despray(weekly_filename, 
FCRA_list.constants.DestinationIP, FCRA_list.constants.DestinationDirectoryweekly + pversion+'.csv',,,,TRUE); 


end;
