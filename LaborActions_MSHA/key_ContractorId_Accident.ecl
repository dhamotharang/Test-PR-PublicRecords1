import doxie, LaborActions_MSHA;

accident_base := files().base_accident_base.qa(trim(Contractor_Id,left,right) <> '');				   

export key_ContractorId_Accident := index(accident_base,
							           {Contractor_Id},
							           {accident_base},
												 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::ContractorId_Accident');