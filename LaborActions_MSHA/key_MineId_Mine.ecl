import doxie, LaborActions_MSHA;

mine_base := files().base_mine_base.qa(trim(Mine_Id,left,right) <> '');				   

export key_MineId_Mine := index(mine_base,
							           {Mine_Id},
							           {mine_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Mine');