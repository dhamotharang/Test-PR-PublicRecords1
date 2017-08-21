import lib_workunitservices;

// Parameters - 
// inwuid - Exact job name as shown on eclwatch
// tshold - schedule time in mins
// emaillist - email group that needs to be notified

export proc_monitor_blocked_jobs(string inwuid,string tshold,string emaillist) := function

	fileprefix := '~thor::monitor::thorjobs::';
	removespacejname := stringlib.stringtolowercase(regexreplace(' ',inwuid,'_'));
	
	superfilename := fileprefix+ removespacejname;
	
	wsds := lib_workunitservices.WorkunitServices.workunitlist(lowwuid := '')(wuid = inwuid);// : independent; // get the wu info for the job name

	removesplchars := stringlib.stringtolowercase(regexreplace('[-:]',wsds[1].modified,''));
	
	return 	if(trim(thorlib.cluster(),left,right) = 'hthor',
					sequential(
					// create superfile if it doesn't exist
					if (~fileservices.superfileexists(superfilename),
						fileservices.createsuperfile(superfilename)),
					if (wsds[1].state = 'blocked', // when the job is blocked
						// if the superfile count is > 0 then the job is blocked
						if (fileservices.getsuperfilesubcount(superfilename) > 0,
							// the logical file name in super file holds the modified value from WU info
							if (~regexfind(removesplchars,fileservices.getsuperfilesubname(superfilename,1)),
								sequential(
									fileservices.clearsuperfile(superfilename,true),
									output(dataset([],{string lmodified}),,superfilename+removesplchars),
									fileservices.addsuperfile(superfilename,superfilename+removesplchars)
									),
								  fileservices.sendemail(
												emaillist,
												inwuid + ' blocked longer than usual',
												inwuid + ' is blocked for more than ' + tshold + ' mins. Please make sure that there are no THOR issues and then call the on-call person in dataops'
										)
								),
							sequential(
								output(dataset([],{string lmodified}),,superfilename+removesplchars),
								fileservices.addsuperfile(superfilename,superfilename+removesplchars)
								)
							),
					if (wsds[1].state in // when the job is either aborted or completed
							['unknown','completed','aborting','aborted','failed'],
							sequential(if (fileservices.superfileexists(superfilename),
											sequential(fileservices.clearsuperfile(superfilename,true),
												fileservices.deletelogicalfile(superfilename))
											),
										fail(inwuid + ' is not blocked or running. Monitoring for this job is now terminated.')
									),
								// when the job is 'running','wait',
								// 'compiling','compiled','submitted','scheduled','paused'
							if (count(wsds) > 0, // if there are any records associated with the WU
									sequential(
									fileservices.clearsuperfile(superfilename,true),
									output(dataset([],{string lmodified}),,superfilename+removesplchars),
									fileservices.addsuperfile(superfilename,superfilename+removesplchars)
									),
									sequential(
									fileservices.sendemail(
												emaillist,
												inwuid + ' - invalid WU',
												inwuid + ' - invalid'
										),
									fail(inwuid + ' is not a valid WU'))
							)
						)
					)
				),
				sequential(
				fileservices.sendemail(
												emaillist,
												inwuid + ' - not scheduled on hthor',
												inwuid + ' - monitor job should always be scheduled on hthor'
										),
				fail('Schedule the job ONLY on hthor'))
				);

end;