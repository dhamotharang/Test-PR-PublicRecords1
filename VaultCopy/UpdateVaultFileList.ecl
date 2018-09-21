import STD, VaultCopy;
// {superkey, attributename, fcra or nonfcra}
EXPORT UpdateVaultFileList(string p_superfilesuffix = 'vault'
										,string p_location = 'uspr'
										,string p_processname = 'ingest'
										) := output(dataset([
											/*{'thor_200::key::criminal_offenders::fcra::qa::did'
												,'I_criminal_offenders_fcra_did.BWR_Process_Automation'
												,'fcra'}
											,{'thor_data400::key::thrive::fcra::qa::did'
												,'I_thrive_fcra_did.BWR_ProcessAutomation'
												,'fcra'}
											,*/{'thor_data400::key::bankruptcyv3::did_qa'
														,'STD.system.Job.Target()'
														,'nonfcra'
														,1
													}
												,{'thor_data400::key::bankruptcy::autokey::addressb2_qa'
													,'STD.system.Job.Target()'
													,'nonfcra'
													,1
													}
												,{'thor_data400::key::fcra::areacode_change_plus_qa'
														,'STD.system.Job.Target()'
														,'fcra'
														,1
													}
												,{'thor_data400::key::codes_v3_qa'
														,'STD.system.Job.Target()'
														,'nonfcra'
														,1
													}
												,{'thor_data400::key::liensv2::bdid_qa'
														,'STD.system.Job.Target()'
														,'nonfcra'
														,1
													}
											]
																	,vaultcopy.IngestModule(p_superfilesuffix := p_superfilesuffix
																				,p_location := p_location
																				,p_processname := p_processname).rVaultFileList),,vaultcopy.IngestModule(p_superfilesuffix := p_superfilesuffix
																				,p_location := p_location
																				,p_processname := p_processname).vVaultFileList,overwrite);
															