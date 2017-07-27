import doxie, LaborActions_MSHA;

contractor_base := files().base_contractor_base.qa(trim(Contractor_Id,left,right) <> '');				   

export key_ContractorId_Contractor := index(contractor_base,
																					 {Contractor_Id},
																					 {contractor_base},
																					 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+doxie.Version_SuperKey+'::ContractorId_Contractor');