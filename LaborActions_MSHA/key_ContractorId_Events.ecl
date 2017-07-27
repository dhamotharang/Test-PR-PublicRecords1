import doxie, LaborActions_MSHA;

events_base := files().base_events_base.qa(trim(Contractor_Id,left,right) <> '');				   

export key_ContractorId_Events := index(events_base,
																			 {Contractor_Id},
																			 {events_base},
																			 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::ContractorId_Events');