import tools;

export Logs_FindFile(

	  boolean 	pIsTesting				= true
	 ,string 		pFilenamePattern	= filenames().input.victor.regex
	
) :=
function

	dlist := fileservices.logicalfilelist();

	dlist_filt := dlist(regexfind(pFilenamePattern,name,nocase));

	drenameinfo := project(
		dlist_filt
		,transform(
			 Tools.Layout_SuperFilenames.InputLayout
			,file_version								:= regexfind('[0-9]{8}[a-b]?'	,left.name	,0,nocase);
			 self.superkeyname					:= '~' + left.name;
			 self.logicalkeynameversion	:= filenames(file_version).input.logs_thor.logical;
		)
	);

	add_to_super := nothor(apply(drenameinfo	,sequential(
				 fileservices.renamelogicalfile	(superkeyname													, logicalkeynameversion)
				,fileservices.addsuperfile			(filenames().input.logs_thor.sprayed	, logicalkeynameversion)
			)));
	
	returnstuff := if(pIsTesting = true
											,output(drenameinfo)
											,sequential(
												 fileservices.startsuperfiletransaction()
												,fileservices.clearsuperfile(filenames().input.logs_thor.sprayed)
												,add_to_super
												,fileservices.finishsuperfiletransaction()
											)
								);
	
	return returnstuff;

end;