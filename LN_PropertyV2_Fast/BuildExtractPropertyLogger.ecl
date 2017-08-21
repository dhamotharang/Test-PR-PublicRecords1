IMPORT ut, Data_Services,STD;
EXPORT BuildExtractPropertyLogger := MODULE

	EXPORT layout := RECORD
			string9 version;
			string5 update_type;
			string8 deed_process_date := '';
			string8 assd_process_date := '';
			string120 workunits;
			string8 last_updated;
	END;
	SHARED fileName := Data_Services.Data_location.Prefix('default_location')+'thor_data400::lookup::ln_propertyv2::extract_log'; 
										
	EXPORT file := dataset(fileName, layout, thor);

	EXPORT getlastversion(string currentversion) := sort(file(version<currentversion),-version)[1];

	EXPORT update(string versionToUpdate, string fieldName, string newValue) := FUNCTION
				entryInFile := file(trim(version)=trim(versionToUpdate));
				updater:= MAP( (fieldName = 'version') 							=> dataset([{versionToUpdate,'','','','',''}],layout),
											 (fieldName = 'update_type')					=> dataset([{versionToUpdate,newValue,'','','',''}],layout),
											 (fieldName = 'deed_process_date') 		=> dataset([{versionToUpdate,'',newValue,'','',''}],layout),
											 (fieldName = 'assd_process_date') 		=> dataset([{versionToUpdate,'','',newValue,'',''}],layout),
																															 dataset([{versionToUpdate,'','','','',''}],layout)
													);
				currentEntry := if(count(entryInFile)=0,updater,entryInFile);

				layout updateLog(currentEntry L, updater R) := TRANSFORM

							SELF.update_type					  := if(R.update_type				= '',L.update_type,				R.update_type				);
							SELF.deed_process_date			:= if(R.deed_process_date	= '',L.deed_process_date,	R.deed_process_date	);
							SELF.assd_process_date	 		:= if(R.assd_process_date = '',L.assd_process_date,	R.assd_process_date	);
							
							wuid := STD.System.Job.WUID()[6..]; // drop the W and the YYYY (look at the version / update year)
							SELF.workunits := trim(L.workunits)+ if(regexfind(wuid,L.workunits),'',wuid+',');
							SELF.last_updated := ut.GetDate;
							
							SELF.version := versionToUpdate;
				END;
				updatedEntry := join(currentEntry,updater,LEFT.version=RIGHT.version,updateLog(LEFT,RIGHT),ALL);
				updatedLog := file(version<>versionToUpdate) + updatedEntry;
				return sequential(output(updatedLog,,fileName+'_temp',overwrite),
													fileservices.DeleteLogicalFile(fileName),
													fileservices.RenameLogicalFile(fileName+'_temp',fileName)
													);
	END;
END;
