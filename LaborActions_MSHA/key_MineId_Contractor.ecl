import doxie, LaborActions_MSHA;

contractor_base := files().base_contractor_base.qa(trim(Mine_Id,left,right) <> '');				   

export key_MineId_Contractor := index(contractor_base,
							           {Mine_Id},
							           {contractor_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Contractor');