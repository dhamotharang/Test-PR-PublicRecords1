import lib_fileservices, versioncontrol;

export macBuildNewLogicalFile(	 
								 pfilenameversions
								,pDataset
								,pOutput
								,pCompress				= 'true'
								,pCsvout 					= 'false'
								,pOverwrite				= 'false'
								) := 
macro
	

	export pOutput :=
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
							output(pDataset,,pfilenameversions,csv(quote('"')),__compressed__,overwrite),
						pCompress = true =>
							output(pDataset,,pfilenameversions,csv(quote('"')),__compressed__),
						pOverwrite = true =>
							output(pDataset,,pfilenameversions,csv(quote('"')),overwrite),
							//else condition
							output(pDataset,,pfilenameversions,csv(quote('"')))
				)

			))
		,output('Not building ' + pfilenameversions + ' because it already exists')
		);
		
endmacro;
