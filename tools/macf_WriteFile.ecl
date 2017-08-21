import lib_fileservices, Tools;
export macf_WriteFile(	 
	 pfilename
	,pDataset
	,pCompress				= 'true'
	,pCsvout 					= 'false'
	,pOverwrite				= 'false'
	,pSeparator				= '\',\''
	,pTerminator			= '\'\\n\''
	,pQuote						= '\'"\''
	,pHeading					= true
  ,pDescription     = '\'\''
) := 
functionmacro
	
	return
		if(pOverwrite or nothor(not(fileservices.FileExists(pfilename) or fileservices.SuperFileExists(pfilename))),
			sequential(
			if(fileservices.FileExists(pfilename),
				nothor(Tools.fun_ClearfilesFromSupers(dataset([{pfilename}], Tools.Layout_Names), false)))
			,if(pCsvout != true
				,map( pCompress  = true and pOverwrite = true  => output(pDataset,,pfilename,__compressed__,overwrite)
						 ,pCompress  = true                        => output(pDataset,,pfilename,__compressed__          )
						 ,pOverwrite = true                        => output(pDataset,,pfilename,overwrite               )
             ,                                            output(pDataset,,pfilename                         )
				)
				,map( pCompress  = true and pOverwrite = true => output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),__compressed__,overwrite)
						 ,pCompress  = true                       => output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),__compressed__          )
						 ,pOverwrite = true                       => output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	),overwrite               )
             ,                                           output(pDataset,,pfilename,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading) ,heading(single) #end	)                         )
				)
			)
      ,if(pDescription != ''  ,FileServices.SetFileDescription(pfilename, pDescription))
      )
		,output('Not building ' + pfilename + ' because it already exists')
		);
		
endmacro;
