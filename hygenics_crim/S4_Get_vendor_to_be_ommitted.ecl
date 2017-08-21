import lib_date;

x := hygenics_crim.file_in_defendant_doc + 
     hygenics_crim.file_in_defendant_counties + 
		 hygenics_crim.file_in_defendant + 
     hygenics_crim.file_in_defendant_arrests ;
		 
tab := table(x(sourcename NOT IN ['FLORIDA_DEPARTMENT_OF_CORRECTIONS_HISTORY_FILE','OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE']), {sourcename,recorduploaddate}, 	sourcename,recorduploaddate	,few);

output(choosen(tab(hygenics_crim._functions.fn_sourcename_to_vendor(trim(sourcename),'')<> ''),all),{sourcename,hygenics_crim._functions.fn_sourcename_to_vendor(trim(sourcename),''),
            recorduploaddate,LIB_Date.DaysApart(recorduploaddate,'20161031' )<=180});