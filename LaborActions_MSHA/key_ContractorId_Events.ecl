import doxie, LaborActions_MSHA;

events_base := files().base_events_base.qa(trim(Contractor_Id,left,right) <> '');				   

events_key	:= project(events_base,transform(Layouts_Base_Events.ContractorId_Events_Key,self := left));

export key_ContractorId_Events := index(events_key,
																			 {Contractor_Id},
																			 {events_key},
																			 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::ContractorId_Events');