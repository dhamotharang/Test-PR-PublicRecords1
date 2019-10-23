import doxie,data_services;
d := Files.Payload;

export key_SCCM := INDEX(d, {case_Program_State
														//,case_Program_Code
														,Case_Identifier
														,Client_Identifier
														,string8 beginDate := eligibility_period_start_raw
															}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::SCCM_' + doxie.version_superkey);