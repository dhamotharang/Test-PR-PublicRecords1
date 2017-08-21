import scrubs_sexoffender_def_raw,hygenics_soff, lib_date, ut, lib_fileservices;

EXPORT Check_180_Days (string pVersion):= function

pCoverage := hygenics_soff.File_In_SO_Defendant;

//Flag records where coverage date > 180 days
	src_filter 								:= StringLib.StringFilter(pCoverage.RecordUploadDate, '0123456789');
	file_date_filter 					:= StringLib.StringFilter(pVersion, '0123456789');
	
rPopulationStats_file_Coverage
 :=
  record	
		state									:= pCoverage.statecode;
		source_file						:= pCoverage.sourcename;
		coverage_end_date			:= pCoverage.RecordUploadDate;
		fcra_remove_flag			:=	if(trim(src_filter, left, right)<>'' and length(src_filter) = length(file_date_filter) and LIB_Date.DaysApart(src_filter, file_date_filter)<=180,
																'',
															if(trim(src_filter, left, right)='' and pCoverage.statecode not in ['OR','CA'],
																'',
																'Y'));
  end; 

// Offender table and stats
dPopulationStats_pOffender := table(pCoverage
																			,rPopulationStats_file_Coverage
																			,statecode, sourcename
																			,few);

// run FCRA warning
Hygenics_SOff.run_FCRA_warning;

// run scrubs defendent raw file. 
 a := scrubs_sexoffender_def_raw.fnRunScrubs(pVersion,'tarun.patel@lexisnexis.com');
 //b := Hygenics_SOff.email_scrubs_def_raw_report;
 
//sequential(a,b);
a;

return output(sort(dPopulationStats_pOffender, state, source_file));

end;
