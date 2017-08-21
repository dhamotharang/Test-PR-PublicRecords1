export File_SIC_Code_Lookup := dataset('~thor_data50::lookup::sic_code_table',Layouts.SIC_Code_Lookup,
																			 csv(heading(0),
																				   separator('|'),
																					 quote('"')
																			    )
																			 
																			);