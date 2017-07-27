import doxie, LaborActions_MSHA;

accident_base := files().base_accident_base.qa(trim(Mine_Id,left,right) <> '');				   

export key_MineId_Accident := index(accident_base,
							           {Mine_Id},
							           {accident_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Accident');