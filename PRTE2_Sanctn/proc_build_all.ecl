EXPORT proc_build_all (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

	run_all := SEQUENTIAL(
												fSpray, 
												proc_build_base, 
												/* future development
												fn_DeltaBaseFile(filedate),
						  							if(skipTest=true, 
																if(fn_CheckBaseFile(filedate)=true,
																			OUTPUT('Reverify base files'), 
																							OUTPUT('No Major Change during File Compare')
																																)),			*/
														proc_build_keys(filedate, skipDOPS, emailTo) 
														);
	
RETURN run_all;
END;