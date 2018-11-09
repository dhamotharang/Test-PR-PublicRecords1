ApprovedErrStatList := [
                         'S400'
                        ,'S801'
                        ,'S810'
                        ,'S860'
                        ,'S880'
                        ,'S881'
                        ,'S890'
                        ,'S8B0'
                        ,'S900'
                        ,'S910'
                        ,'S980'
                        ,'S990'
                        ,'SA00'
                        ,'SA80'
                        ,'SB90'
                        ,'SC00'
                        ,'S820'
                        ,'S830'
                        ,'S891'
                        ,'S940'
                        ,'SA10'
                        ,'SB80'
                        ,'SC10'
                     ];
										 
export boolean CustomErrStat(string4 err_stat1, string4 err_stat2) := function
	return err_stat1 in ApprovedErrStatList and err_stat2 in ApprovedErrStatList;
end;