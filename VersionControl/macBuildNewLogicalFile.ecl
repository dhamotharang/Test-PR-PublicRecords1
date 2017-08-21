/*2016-01-15T22:51:14Z (Oscar Barrientos)
When pHeading is false it was giving this Error:    Unknown identifier "__compressed__" .  Close Parenthesis was in the wrong position
*/
import lib_fileservices, versioncontrol;

export macBuildNewLogicalFile(	 
	 pfilenameversions
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
		if(pOverwrite or nothor(not(fileservices.FileExists(pfilenameversions) or fileservices.SuperFileExists(pfilenameversions))),
			sequential(
			if(fileservices.FileExists(pfilenameversions),
				nothor(versioncontrol.fClearLogicalFileSupers(dataset([{pfilenameversions}], versioncontrol.Layout_Names), false)))
			,if(pCsvout != true,
				map(pCompress = true and pOverwrite = true =>
							output(pDataset,,pfilenameversions,__compressed__,overwrite),
						pCompress = true =>
							output(pDataset,,pfilenameversions,__compressed__),
						pOverwrite = true =>
							output(pDataset,,pfilenameversions,overwrite),
							//else condition
							output(pDataset,,pfilenameversions)
				),
				map(pCompress = true and pOverwrite = true =>
							output(pDataset,,pfilenameversions,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading), heading(single) #end	),__compressed__,overwrite),
						pCompress = true =>
							output(pDataset,,pfilenameversions,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading), heading(single) #end	),__compressed__),
						pOverwrite = true =>
							output(pDataset,,pfilenameversions,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading), heading(single) #end	),overwrite),
							//else condition
							output(pDataset,,pfilenameversions,csv(separator(pSeparator),terminator(pTerminator),quote(pQuote) #if(pHeading), heading(single) #end	))
				)

			))
		,output('Not building ' + pfilenameversions + ' because it already exists')
		);
		
endmacro;
