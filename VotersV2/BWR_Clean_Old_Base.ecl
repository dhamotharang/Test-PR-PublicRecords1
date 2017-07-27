AddSuper := sequential(FileServices.StartSuperFileTransaction(),
											 FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Delete',
																								VotersV2.cluster + 'in::Voters::OLD_BASE::Old',, true),
											 FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Old'),
											 FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Old', 
																								VotersV2.cluster + 'in::Voters::OLD_BASE::Superfile',, true),
											 FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Superfile'),
											 FileServices.AddSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Superfile', 
																								VotersV2.cluster + 'out::voters::cleaned_old_base_'+thorlib.wuid()), 
											 FileServices.FinishSuperFileTransaction(),
											 FileServices.ClearSuperFile(VotersV2.cluster + 'in::Voters::OLD_BASE::Delete',true));

cleaned_old_base := output(VotersV2.Fix_Voters_VoteHistory_mapping,,VotersV2.Cluster + 'out::voters::cleaned_old_base_'+thorlib.wuid(),overwrite);
											 
export BWR_Clean_Old_Base := sequential(cleaned_old_base, AddSuper);