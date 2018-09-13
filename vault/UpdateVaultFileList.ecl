EXPORT UpdateVaultFileList := output(dataset([{'thor_data400::key::codes_v3_qa'
																		//,'I_criminal_offenders_fcra_did.BWR_Process_Automation'
																		,'Codes.Key_Codes_V3'
																			,'nonfcra'}
																		,{'thor_data400::key::fcra::alloymedia_student_list::qa::did'
																		//,'I_criminal_offenders_fcra_did.BWR_Process_Automation'
																		,'Codes.Key_Codes_V3'
																			,'fcra'}
																		]
																	,vault.IngestModule().rVaultFileList),,vault.IngestModule().vVaultFileList,overwrite);