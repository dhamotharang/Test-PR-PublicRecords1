EXPORT proc_build_all (string filedate, boolean skipTest=false) := FUNCTION
	run_all := SEQUENTIAL(fSpray, 
																							proc_build_base,
																							fn_DeltaBaseFile(filedate),  //* Added File Compare to flag major changes
																							if(skipTest = true,	   					//* If Major changes exist, fail build
																										if(fn_BaseFileCheck(filedate)=true,OUTPUT('Reverify base files'), OUTPUT('No Major Change during File Compare')
																											)),		
																							proc_build_keys(filedate)
																							);
	
RETURN run_all;
END;