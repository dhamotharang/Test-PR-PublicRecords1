import doxie,data_services;
d := Files.Payload;

export key_SC := INDEX(d, {case_Program_State
														//,case_Program_Code
														,Client_Identifier
															}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::SC_' + doxie.version_superkey);
