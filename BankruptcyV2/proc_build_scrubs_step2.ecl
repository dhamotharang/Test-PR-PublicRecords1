IMPORT BankruptcyV3,	Scrubs_bk_main, scrubs_bk_search, Scrubs,std,ut,tools, data_services;

EXPORT proc_build_scrubs_step2(string filedate, string emailList='')  := FUNCTION

	#OPTION('multiplePersistInstances',FALSE);

	DeleteTempFile(string	filename)	:=	if(fileservices.FileExists(filename),fileservices.DeleteLogicalFile(filename),output(' No file to delete. (' +filename + ')' ));

	//Define files to scrub. There were produlated by proc_build_base
	file_to_scrub_main 	:= DATASET('~thor_data400::temp::bankruptcyv2::file_to_scrub_main::'+filedate,Scrubs_bk_main.Layout_bk_main,THOR);
	file_to_scrub_t 		:= DATASET('~thor_data400::temp::bankruptcyv2::file_to_scrub_t::'+filedate,scrubs_bk_search.Layout_bk_search,THOR);
	
	del_file_to_scrub_main := DeleteTempFile('~thor_data400::temp::bankruptcyv2::file_to_scrub_main::'+filedate);
	del_file_to_scrub_t	:= DeleteTempFile('~thor_data400::temp::bankruptcyv2::file_to_scrub_t::'+filedate);
	
  submit_stat_main := Scrubs.ScrubsPlus_PassFile(file_to_scrub_main,'BankruptcyV2','Scrubs_bk_main','Scrubs_bk_main','',filedate,emailList);
	submit_stat_search := Scrubs.ScrubsPlus_PassFile(file_to_scrub_t,'BankruptcyV2','Scrubs_bk_search','Scrubs_bk_search','',filedate,emailList);
  	
	run_withdrawnstatus_scrubs	:=	BankruptcyV3.proc_build_withdrawnstatus(filedate).Scrubs;
	
	RETURN	sequential(
						parallel(
							submit_stat_main,
							submit_stat_search,
							run_withdrawnstatus_scrubs
						),
						del_file_to_scrub_main,
						del_file_to_scrub_t
					);
									
END;