import doxie,data_services;
d := Files().Base;

export key_SCCM := INDEX(d, {string2 Case_State:=Case_state_abbreviation
														,string20 Case_Identifier:=Case_Identifier
														,string20 Client_Identifier:=Client_Identifier
														,string6 Benefit_month:=Case_benefit_month
																		}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC::key::SCCM_' + doxie.version_superkey);