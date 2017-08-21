EXPORT proc_build_OK (string fdate, string lictype) := module

export  prepall :=   map ( StringLib.StringToLowerCase(lictype) = 'medical' => Sequential (  Spray_OK_Medical(fdate).dospray,
                                                                                             Map_OK_Medical(fdate).buildprep
																																														  ),
																	 
																									                            Output('OK License type '+lictype +'is new' )
											    );
																	
											
																
end;