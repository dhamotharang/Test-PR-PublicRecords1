import SANCTN_Mari,_Control, lib_stringlib;

export proc_Midex_ClearTransfer_superfiles(string filedate) := function

//Clear superfiles
incident_transfer := sequential(FileServices.StartSuperFileTransaction()
                                 ,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_delete'
                                                            ,SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_grandfather',, true)
																,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_grandfather')
																,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_grandfather'
																														,SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_father',, true)
																,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_father')
																,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_father' 
                                                            ,SANCTN_Mari.cluster_name + 'base::sanctn::np::incident',, true)
																,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident')
																,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident'
                                                            ,SANCTN_Mari.cluster_name + 'base::sanctn::np::'+filedate+'::incident_base')
																,FileServices.FinishSuperFileTransaction()
																,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incident_delete',true));
											 
party_transfer := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_delete'
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::party_grandfather',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_grandfather')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_grandfather'
																												,SANCTN_Mari.cluster_name + 'base::sanctn::np::party_father',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_father')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_father' 
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::party',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party'
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::'+filedate+'::party_base')
															,FileServices.FinishSuperFileTransaction()
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::party_delete',true));

incidenttext_transfer := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_delete'
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_grandfather',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_grandfather')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_grandfather'
																												,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_father',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_father')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_father' 
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext'
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::'+filedate+'::incident_text')
															,FileServices.FinishSuperFileTransaction()
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidenttext_delete',true));

incidentcd_transfer := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_delete'
																												,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_grandfather',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_grandfather')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_grandfather'
																												,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_father',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_father')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_father' 
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode',, true)
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode')
															,FileServices.AddSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode'
                                                         ,SANCTN_Mari.cluster_name + 'base::sanctn::np::'+filedate+'::midex_cds')
															,FileServices.FinishSuperFileTransaction()
															,FileServices.ClearSuperFile(SANCTN_Mari.cluster_name + 'base::sanctn::np::incidentcode_delete',true));

base_transfer := parallel(incident_transfer,party_transfer,incidenttext_transfer,incidentcd_transfer);

			return base_transfer;
END;