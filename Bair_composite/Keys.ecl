import doxie, tools,Bair_ExternalLinkKeys;

export Keys(string pversion, boolean pUseDelta = false

) :=
module

export all:= sequential(
							if(pUseDelta,
									sequential(
										Fileservices.StartSuperFileTransaction()
										,Fileservices.ClearSuperFile('~thor400_data::base::composite_public_safety_data_building')
										,Fileservices.addsuperfile('~thor400_data::base::composite_public_safety_data_building','~thor400_data::base::composite_public_safety_data_delta',addcontents := true)
										,Fileservices.FinishSuperFileTransaction()
														)
									,sequential(
										Fileservices.StartSuperFileTransaction()
										,Fileservices.ClearSuperFile('~thor400_data::base::composite_public_safety_data_building')
										,Fileservices.addsuperfile('~thor400_data::base::composite_public_safety_data_building','~thor400_data::base::composite_public_safety_data_full',addcontents := true)
										,Fileservices.FinishSuperFileTransaction()
															)
								),
					Bair_ExternalLinkKeys.Proc_GoExternal(pversion,pUseDelta).Proc_GoExternal1
					);
	
end;
