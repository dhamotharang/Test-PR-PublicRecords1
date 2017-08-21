import VersionControl;
export BuildNewLogicalFile(
	 pFilename				//	thor_data400::in::prepped::event::dbo::mo::20151224_091102003
	,pDataset					//	DATA
	,pCsvout = false	//	FALSE
) :=
FUNCTIONMACRO
			import VersionControl;
			#if(pCsvout = true)
				VersionControl.macBuildNewLogicalFile( 
																					pFilename // pfilenameversions
																				 ,distribute(pDataset,random()) 	//,pDataset
																				 ,vOutput 	//,pOutput
																				 ,true			//,pCompress					= 'true'
																				 ,pCsvout		//,pCsvout						=	'false'
																				 ,true  		//,pOverwrite					= 'false'
																				 ,'~|~' 		//,pSeparator					= '\',\''
																				 ,'~<EOL>~' //,pTerminator				= '\'\\n\''
																				 ,'\'"\''		//,pQuote							= '\'"\''
																				 ,false  		//,pHeading						= true
																				 ,false	 		//,pShouldExport			= true
																				);
			#else
				VersionControl.macBuildNewLogicalFile( 
																					pFilename // pfilenameversions
																				 ,distribute(pDataset,random()) 	//,pDataset
																				 ,vOutput 	//,pOutput
																				 ,true			//,pCompress					= 'true'
																				 ,false			//,pCsvout						=	'false'
																				 ,true  		//,pOverwrite					= 'false'
																				 ,'\',\''		//,pSeparator					= '\',\''
																				 ,'\'\\n\'' //,pTerminator				= '\'\\n\''
																				 ,'\'"\''		//,pQuote							= '\'"\''
																				 ,false  		//,pHeading						= true
																				 ,false	 		//,pShouldExport			= true																				 
																				);			
																				
			#end;
			return vOutput;	
ENDMACRO;



	