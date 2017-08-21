import doxie, LaborActions_MSHA;

events_base := files().base_events_base.qa(trim(Mine_Id,left,right) <> '');				   

events_key	:= project(events_base,transform(Layouts_Base_Events.MineId_Events_Key,self := left));

export key_MineId_Events := index(events_key,
																	{Mine_Id},
																	{events_key},
																	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Events');