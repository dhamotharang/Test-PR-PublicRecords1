import doxie, LaborActions_MSHA;

operator_base := files().base_operator_base.qa(trim(Mine_Id,left,right) <> '');				   

export key_MineId_Operator := index(operator_base,
							           {Mine_Id},
							           {operator_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::MineId_Operator');