import STD, Vault;
EXPORT UpdateVaultFileList := sequential
																(
																	output(dedup(sort(dataset([{'thor_data400::key::codes_v3_qa'
																		//,'I_criminal_offenders_fcra_did.BWR_Process_Automation'
																		,'Codes.Key_Codes_V3'
																			,'nonfcra'}
																		,{'thor_data400::key::fcra::alloymedia_student_list::qa::did'
																		//,'I_criminal_offenders_fcra_did.BWR_Process_Automation'
																		,'Codes.Key_Codes_V3'
																			,'fcra'}
																		]
																	,vault.IngestModule().rVaultFileList) + dataset(vault.IngestModule().vVaultFileList,vault.IngestModule().rVaultFileList,thor,opt),superfile,attributename,l_cluster),record),,vault.IngestModule().vVaultFileList + '_temp',overwrite)
																	,output(dataset(vault.IngestModule().vVaultFileList+'_temp',vault.IngestModule().rVaultFileList,thor,opt),,vault.IngestModule().vVaultFileList,overwrite)
																	,STD.File.DeleteLogicalFile(vault.IngestModule().vVaultFileList + '_temp')
																	
																);