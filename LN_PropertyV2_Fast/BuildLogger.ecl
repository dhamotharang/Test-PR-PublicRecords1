IMPORT ut, Data_Services,STD;
EXPORT BuildLogger := MODULE

	EXPORT layout := RECORD
			string9 version;
			string5 update_type;
			string8 prep_start_date := '';
			string8 prep_end_date := '';
			string8 base_build_start_date := '';
			string8 base_build_end_date := '';
			string8 key_build_start_date := '';
			string8 key_build_end_date := '';
			string8 cert_date := '';
			string8 prod_date := '';
			unsigned total_processing_days:= 0;
			unsigned total_deployment_days;
			unsigned total_qa_days := 0;
			unsigned total_days := 0;
			string120 workunits;
			string8 last_updated;
	END;
	SHARED fileName := '~thor_data400::lookup::ln_propertyv2::build_metrics'; // we can only log locally always
										
	EXPORT file := dataset(fileName, layout, thor);	
	EXPORT update(string versionToUpdate, string fieldName, string newValue) := FUNCTION
				entryInFile := file(trim(version)=trim(versionToUpdate));
				updater:= MAP( (fieldName = 'version') 							=> dataset([{versionToUpdate,'','','','','','','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'update_type')					=> dataset([{versionToUpdate,newValue,'','','','','','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'prep_start_date') 			=> dataset([{versionToUpdate,'',newValue,'','','','','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'prep_end_date') 				=> dataset([{versionToUpdate,'','',newValue,'','','','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'base_build_start_date')=> dataset([{versionToUpdate,'','','',newValue,'','','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'base_build_end_date') 	=> dataset([{versionToUpdate,'','','','',newValue,'','','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'key_build_start_date') => dataset([{versionToUpdate,'','','','','',newValue,'','','',0,0,0,0,'',''}],layout),
											 (fieldName = 'key_build_end_date') 	=> dataset([{versionToUpdate,'','','','','','',newValue,'','',0,0,0,0,'',''}],layout),
											 (fieldName = 'cert_date') 						=> dataset([{versionToUpdate,'','','','','','','',newValue,'',0,0,0,0,'',''}],layout),
											 (fieldName = 'prod_date') 						=> dataset([{versionToUpdate,'','','','','','','','',newValue,0,0,0,0,'',''}],layout),
																															 dataset([{versionToUpdate,'','','','','','','','',''/*  */,0,0,0,0,'',''}],layout)
													);
				currentEntry := if(count(entryInFile)=0,updater,entryInFile);

				layout updateLog(currentEntry L, updater R) := TRANSFORM

							// NOTE: Start date will only be updated the first time. That is by design.
							SELF.update_type					  := if(R.update_type				 		= '',L.update_type,						R.update_type						);
/*ONE UPDATE*/SELF.prep_start_date				:= if(L.prep_start_date			 	= '',R.prep_start_date,				L.prep_start_date				);
							SELF.prep_end_date					:= if(R.prep_end_date				  = '',L.prep_end_date,					R.prep_end_date					);
/*ONE UPDATE*/SELF.base_build_start_date	:= if(L.base_build_start_date = '',R.base_build_start_date,	L.base_build_start_date	);
							SELF.base_build_end_date		:= if(R.base_build_end_date		= '',L.base_build_end_date,		R.base_build_end_date		);
/*ONE UPDATE*/SELF.key_build_start_date		:= if(L.key_build_start_date 	= '',R.key_build_start_date,	L.key_build_start_date	);
							SELF.key_build_end_date 		:= if(R.key_build_end_date 		= '',L.key_build_end_date,		R.key_build_end_date		);
							SELF.cert_date 					 		:= if(R.cert_date 						= '',L.cert_date,							R.cert_date							);
							SELF.prod_date 					 		:= if(R.prod_date 						= '',L.prod_date,							R.prod_date							);
							
							SELF.total_processing_days := ut.DaysApart(L.prep_start_date, SELF.key_build_end_date), 
							SELF.total_qa_days := ut.DaysApart(L.cert_date, L.prod_date), 
							SELF.total_days:= ut.DaysApart(L.prep_start_date, L.prod_date), 
							SELF.total_deployment_days := self.total_days - (self.total_processing_days + self.total_qa_days);
							wuid := STD.System.Job.WUID()[6..]; // drop the W and the YYYY (look at the version / update year)
							SELF.workunits := trim(L.workunits)+ if(regexfind(wuid,L.workunits),'',wuid+',');
							SELF.last_updated := ut.GetDate;
							
							SELF.version := versionToUpdate;
				END;
				updatedEntry := join(currentEntry,updater,LEFT.version=RIGHT.version,updateLog(LEFT,RIGHT));
				updatedLog := file(version<>versionToUpdate) + updatedEntry;
				return sequential(output(updatedLog,,fileName+'_temp',overwrite),
													fileservices.DeleteLogicalFile(fileName),
													fileservices.RenameLogicalFile(fileName+'_temp',fileName)
													);
	END;
END;
 // ******************** EXAMPLE ON HOW TO USE ***************************************** //
/*
sequential(
						output(choosen(BuildLogger.file,1000),named('before')),
						BuildLogger.update('test1','base_build_end_date','20150103'),
						BuildLogger.update('test1','update_type','N_ONE'),
						output(choosen(BuildLogger.file,1000),named('after'))
						);
*/