IMPORT Inql_FFD, Doxie, ut, dx_PhonesPlus, std, data_services;

EXPORT Data_Keys (boolean pFCRA = false) := Module

shared f_source_level_base_current := PhonesPlus_V2.In_Source_Level_Base(current_rec and trim(cellphone)<>'');


EXPORT source_level_payload := project(f_source_level_base_current,
                                Transform(dx_PhonesPlus.Layouts.i_source_level_payload
																				 ,self := left
								  												));

EXPORT source_level_phone := project(f_source_level_base_current,
                                Transform(dx_PhonesPlus.Layouts.i_source_level_phone
																				 ,self := left
								  												));
																					
EXPORT source_level_cellphoneidkey := project(f_source_level_base_current,
                                Transform(dx_PhonesPlus.Layouts.i_source_level_cellphoneidkey
																				 ,self := left
								  												));


shared f_source_level_base_current_did := f_source_level_base_current(did<>0);
EXPORT source_level_did := project(f_source_level_base_current_did,
                                Transform(dx_PhonesPlus.Layouts.i_source_level_did
																				 ,self := left
																			));																					
end;