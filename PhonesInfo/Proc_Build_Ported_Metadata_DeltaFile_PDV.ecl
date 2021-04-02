IMPORT std, _control, PromoteSupers, RoxieKeyBuild, ut;

EXPORT Proc_Build_Ported_Metadata_DeltaFile_PDV(string version, string filename, string newDay, const varstring eclsourceip, string thor_name, string contacts):= function

	//Spray Raw Delta Files and Place Into DailyDelta Superfile
	sprayDailyDelta 	:= PhonesInfo.Spray_iConectiv_PortData_Validate_DailyDelta(version, filename, eclsourceip, thor_name);
	
	//Build DeltaBaseFile, Using the Raw Delta Files
	buildBaseDelta		:= output(PhonesInfo.Map_Ported_Metadata_DeltaFile_PDV(version),,'~thor_data400::base::phones::ported_metadata_deltamain_'+version, csv(heading(1), terminator('\n'), separator('\t')), overwrite, __compressed__);
	
	//Despray Processed DeltaBase File
	desprayBaseDelta	:= FileServices.DeSpray('~thor_data400::base::phones::ported_metadata_deltamain_'+version,
																						eclsourceip,
																						'/data/data_999/phones/delta_mobile_id/despray/'+version[1..8]+'/Ported_Metadata_DeltaMain_'+version+'.csv',
																						,
																						,
																						,
																						TRUE
																						);
	
	//Move DeltaBase Base to Superfile
	
		clearDeleteDelta	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::ported_metadata_deltamain_delete', true));		
		
		//New Hour Process
		moveComBaseDeltaHR:= sequential(FileServices.StartSuperFileTransaction(),
																		Fileservices.AddSuperfile('~thor_data400::base::phones::ported_metadata_deltamain', '~thor_data400::base::phones::ported_metadata_deltamain_'+version),
																		FileServices.FinishSuperFileTransaction()
																		);
		
		//New Day Process
		moveComBaseDeltaND:= sequential(FileServices.StartSuperFileTransaction(),
																		FileServices.AddSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_delete', '~thor_data400::base::phones::ported_metadata_deltamain_great_grandfather',, true),
																		FileServices.ClearSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_great_grandfather'),
																		FileServices.AddSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_great_grandfather', '~thor_data400::base::phones::ported_metadata_deltamain_grandfather',, true),
																		FileServices.ClearSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_grandfather'),
																		FileServices.AddSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_grandfather', '~thor_data400::base::phones::ported_metadata_deltamain_father',, true),
																		FileServices.ClearSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_father'),
																		FileServices.AddSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_father', '~thor_data400::base::phones::ported_metadata_deltamain',, true),
																		FileServices.ClearSuperFile('~thor_data400::base::phones::ported_metadata_deltamain'),
																		FileServices.AddSuperFile('~thor_data400::base::phones::ported_metadata_deltamain', '~thor_data400::base::phones::ported_metadata_deltamain_'+version),
																		FileServices.FinishSuperFileTransaction(),
																		FileServices.ClearSuperFile('~thor_data400::base::phones::ported_metadata_deltamain_delete', true)
																		);	
		
		newHr	 := sequential(clearDeleteDelta, moveComBaseDeltaHR);	
		newND  := sequential(clearDeleteDelta, moveComBaseDeltaND);
		
		moveComBaseDelta := if(stringlib.stringtouppercase(trim(newDay, left, right)[1])='Y', newND, newHr);			
	
	//Run Build & Provide Email on Build Status
	sendEmail		:= sequential(sprayDailyDelta, buildBaseDelta, desprayBaseDelta, moveComBaseDelta):
														Success(FileServices.SendEmail(contacts, 'Prod PhonesInfo Ported & Metadata DeltaBase Key Build Succeeded', workunit + ': Build complete.')),
														Failure(FileServices.SendEmail(contacts, 'Prod PhonesInfo Ported & Metadata DeltaBaseKey Build Failed', workunit + '\n' + FAILMESSAGE)
														);

	return sendEmail;

end;