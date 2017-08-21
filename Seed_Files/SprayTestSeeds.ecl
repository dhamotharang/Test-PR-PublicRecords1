import _Control, STD;
export SprayTestSeeds(
					string sourceip
				 ,string unixfilename
				 ,string infiledate
				 ,string basename
				 ,string groupname
				 ,string delimiter = ','
				 ,boolean isIntl = false
				 ,boolean islegacy = false
				 ) :=  function
		
		
	
		promotefile := '~thor_data400::base::testseed_'+basename;
		logicalname := if (islegacy, '~testseeds::in::'+basename, '~thor_data400::in::testseed::'+ infiledate + '::' + basename);
		
		serv := if(_Control.ThisEnvironment.Name = 'Prod_Thor','server=http://10.241.20.202:8010 ',
													'server=http://10.241.3.242:8010 '
													);
		

		over := 'overwrite=1 ';
		repl := 'replicate=1 ';
		action := 'action=spray ';
		srcip := 'srcip='+sourceip + ' ';
		srcfile := 'srcfile='+unixfilename+' ';
		dstname := 'dstname='+logicalname+' ';
		dstcluster := 'dstcluster=' + groupname + ' ';
		format := 'format=csv ';
		encoding := 'encoding=utf8 ';
		fileseparator := 'separator='+delimiter+ ' ';
		
		cmd := serv + action + over + repl + srcip + srcfile + dstname + dstcluster + format + encoding + fileseparator;
		
		sprayfile := if (isIntl,
										STD.File.DfuPlusExec(cmd),
										FileServices.SprayVariable(sourceip,unixfilename,,,,,groupname,logicalname,-1,,,true,true)
										);
		
		
		return sequential(
											if (~islegacy,
												sequential
												(
													if (~fileservices.superfileexists(promotefile),
															fileservices.createsuperfile(promotefile)),
													if (~fileservices.superfileexists(promotefile+'_father'),
															fileservices.createsuperfile(promotefile+'_father')),
													if (~fileservices.superfileexists(promotefile+'_delete'),
															fileservices.createsuperfile(promotefile+'_delete'))
															)
															),
											sprayfile,
											if (~islegacy,
													sequential
													(
														fileservices.startsuperfiletransaction(),
														fileservices.clearsuperfile(promotefile+'_delete'),
														fileservices.addsuperfile(promotefile+'_delete',promotefile+'_father',,true),
														fileservices.clearsuperfile(promotefile+'_father'),
														fileservices.addsuperfile(promotefile+'_father',promotefile,,true),
														fileservices.clearsuperfile(promotefile),
														fileservices.addsuperfile(promotefile,logicalname),
														fileservices.finishsuperfiletransaction(),
														fileservices.clearsuperfile(promotefile+'_delete',true)
														)
													, output('No Super'))
											);
		
end;