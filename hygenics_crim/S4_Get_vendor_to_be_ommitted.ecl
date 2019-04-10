


//hygenics_crim.S4_Get_vendor_to_be_ommitted;

import lib_date;

x := hygenics_crim.file_in_defendant_doc + 
     hygenics_crim.file_in_defendant_counties + 
		 hygenics_crim.file_in_defendant + 
     hygenics_crim.file_in_defendant_arrests ;
		 
//get IE sources.  One sourcename can have many recorduploaddate. 
//So for that sourcename, use most recent recorduploaddate
IE_sources := x(sourcename[length(trim(sourcename,left,right))-2..length(trim(sourcename,left,right))]= '_IE');		 
sort_IE_sources := sort(distribute(IE_sources,hash32(sourcename)),sourcename,-recorduploaddate,local);
dedup_IE_sources := dedup(distribute(sort_IE_sources,hash32(sourcename)),sourcename,local);		 

//get non IE sources
other_sources := x(sourcename[length(trim(sourcename,left,right))-2..length(trim(sourcename,left,right))]<> '_IE');		 

y := other_sources + dedup_IE_sources;
		 
tab := table(y(sourcename NOT IN ['FLORIDA_DEPARTMENT_OF_CORRECTIONS_HISTORY_FILE','OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE']), {sourcename,recorduploaddate}, 	sourcename,recorduploaddate	,few);

output(choosen(tab(hygenics_crim._functions.fn_sourcename_to_vendor(trim(sourcename),'')<> ''),all),{sourcename,hygenics_crim._functions.fn_sourcename_to_vendor(trim(sourcename),''),
            recorduploaddate,LIB_Date.DaysApart(recorduploaddate,'20190212' )<=180});
						
				
					