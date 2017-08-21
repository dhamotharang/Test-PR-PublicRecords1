import lib_fileservices;

export fDesprayFiles(

	 dataset(Layout_DKCs.Input) pFiles
	,string											pDestinationIP		= ''
	,string											pDestinationpath	= ''
	,string											pOutputName				= ''
	,boolean										pOverwrite				= false
	,boolean										pIsTesting				= false

) :=
function

	Layout_DKCs.Out tGetInfo(Layout_DKCs.Input l) :=
	transform
		
		destinationIP			:= if(pDestinationIP		!= ''	,pDestinationIP		,l.destinationIP	);
		destinationpath		:= if(pDestinationpath	!= ''	,pDestinationpath	,l.destinationpath);
		
		
		destination_directory := regexreplace('^(.*?/)[^/]*$', destinationpath, '$1');
		destination_file			:= regexreplace('^.*?/([^/]*)$', destinationpath, '$1');

		IsSuperfile						:= fileservices.superfileexists(l.logicalkeyname);
		dSuperfilecontents		:= if(IsSuperfile
																	,fileservices.superfilecontents(l.logicalkeyname)
																	,dataset([],layout_names) 
																);
																
		self.logicalkeyname		 	:= l.logicalkeyname	;	
		self.destinationIP			:= IPAddresses.fGetIPAddressFromServerName(destinationIP)		;
		self.destinationpath		:= destinationpath	;
		self.allowoverwrite		 	:= l.allowoverwrite	or pOverwrite;
		self.Thor_file_exists	 	:= fileservices.fileexists			(l.logicalkeyname) ;
		self.IsSuperfile				:= IsSuperfile;
		
		self.dSuperfilecontents	:= dSuperfilecontents;

		self.Thor_File_size			:= map(self.IsSuperfile and count(dSuperfilecontents) > 0	=> fileservices.logicalfilelist(dSuperfilecontents[1].name)[1].size
																	,self.Thor_file_exists															=> fileservices.logicalfilelist(self.logicalkeyname[2..])[1].size
																	,0
																);

																
		self.dDirectoryListing	:= FileServices.remotedirectory(
																	 self.destinationIP
																	,destination_directory
																	,destination_file
																);
		
		
		self.Remote_file_exists := count(self.dDirectoryListing) > 0;

		self.filesize_difference	:= if(self.Remote_file_exists and (self.Thor_file_exists or self.IsSuperfile)
																		,self.Thor_File_size - self.dDirectoryListing[1].size
																		,0);

//so maybe the difference should be between 0 and about 9 - 10 megabytes

		self.Will_DKC						:= if(		(self.Thor_file_exists
																	or	(self.IsSuperfile and count(dSuperfilecontents) > 0))
																	and ((not self.Remote_file_exists)
																				or self.allowoverwrite
//																				or self.filesize_difference > 10000000	// looks like diff should be around 0 - 10 megs, W20071026-163417
																			)
																		,true
																		,false
																);
																	
	
	end;

	dOutput := project(pFiles, tGetInfo(left));

	dOutput_filtered := dOutput(Will_DKC);
	
	despray_keys := 
	sequential(
		if(pOutputName != ''
			,output(dOutput, named(pOutputName), all)
			,output(dOutput, all)
		)
		,if(pIsTesting = false
			,apply(dOutput_filtered
				,FileServices.Despray( 
					 logicalkeyname
					,destinationIP
					,destinationpath
					,,,
					,allowoverwrite
	))));

	return nothor(despray_keys);

end;
