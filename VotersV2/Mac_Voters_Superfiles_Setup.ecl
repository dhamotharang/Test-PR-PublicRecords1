
export Mac_Voters_Superfiles_Setup := macro

#uniquename(Create_Superfiles)

%Create_Superfiles%  := sequential(FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AR::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AR::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AR::Old',false) 
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AK::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AK::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::AK::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CO::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CO::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CO::Old',false) 
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CT::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CT::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::CT::Old',false)
																	,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DC::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DC::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DC::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DE::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DE::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::DE::Old',false)
							                    ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::FL::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::FL::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::FL::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::LA::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::LA::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::LA::Old',false)
									                ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MA::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MA::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MA::Old',false)
																	,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MI::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MI::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MI::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MN::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MN::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::MN::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NC::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NC::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NC::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NJ::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NJ::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NJ::Old',false) 
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NV::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NV::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NV::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NY::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NY::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::NY::Old',false)		
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OH::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OH::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OH::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OK::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OK::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OK::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::RI::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::RI::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::RI::Old',false)
																	,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::SC::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::SC::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::SC::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::TX::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::TX::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::TX::Old',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::UT::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::UT::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::UT::Old',false)
																	,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::WI::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::WI::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::WI::Old',false)																	
																	,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OLD_BASE::Superfile',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OLD_BASE::Delete',false)
                                  ,FileServices.CreateSuperFile(VotersV2.Cluster + 'in::Voters::OLD_BASE::Old',false) 
                                  );

#uniquename(Mother_Superfile)

%Mother_Superfile% := sequential(FileServices.StartSuperFileTransaction()
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::AR::Superfile')
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::AK::Superfile')
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::CO::Superfile')  
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::CT::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::DC::Superfile')
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::DE::Superfile')  
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::FL::Superfile')
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::LA::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::MA::Superfile')
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::MI::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::MN::Superfile')
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::NC::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::NJ::Superfile')  
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::NV::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::NY::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::OH::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::OK::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::RI::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::SC::Superfile') 
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::TX::Superfile') 
                                 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::UT::Superfile')
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::WI::Superfile')
																 ,FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile'
								                           ,VotersV2.Cluster + 'in::Voters::OLD_BASE::Superfile') 
                                 ,FileServices.FinishSuperFileTransaction());


#uniquename(do_super)
%do_super% := output('Creating superfiles for Emerges Voters') : success(
																	sequential(%Create_Superfiles%,%Mother_Superfile%));

sequential(%do_super%);

endmacro;
