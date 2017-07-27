import doxie, LaborActions_MSHA;

events_base := files().base_events_base.qa(trim(Mine_Id,left,right) <> '');				   

export key_MineId_Events := index(events_base,
							           {Mine_Id},
							           {events_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Events');