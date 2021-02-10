import lib_fileservices, SALTTOOLS4;
export mac_WriteFile(	 
	 pfilename
	,pDataset
	,pOutput
	,pCompress				= 'true'
	,pCsvout 					= 'false'
	,pOverwrite				= 'false'
	,pSeparator				= '\',\''
	,pTerminator			= '\'\\n\''
	,pQuote						= '\'"\''
	,pHeading					= true
	,pShouldExport		= true
) := 
macro
	
	#if(pShouldExport)
		export
	#end
	pOutput :=
		if(pOverwrite or nothor(not(fileservices.FileExists(pfilename) or fileservices.SuperFileExists(pfilename))),
			sequential(
			if(fileservices.FileExists(pfilename),
				nothor(SALTTOOLS4.fun_ClearfilesFromSupers(dataset([{pfilename}], SALTTOOLS4.Layout_Names), false)))
			,if(pCsvout != true,
				map(pCompress = true and pOverwrite = true =>
							output(pDataset,,pfilename,__compressed__,overwrite),
						pCompress = true =>
							output(pDataset,,pfilename,__compressed__),
						pOverwrite = true =>
							output(pDataset,,pfilename,overwrite),
							//else condition
							output(pDataset,,pfilename)
				),
				map(pCompress = true and pOverwrite = true =>
							output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),__compressed__,overwrite),
						pCompress = true =>                                                                                                              
							output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),__compressed__),
						pOverwrite = true =>                                                                                                             
							output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),overwrite),
							//else condition                                                                                                               
							output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	))
				)
			))
		,output('Not building ' + pfilename + ' because it already exists')
		);
		
endmacro;
