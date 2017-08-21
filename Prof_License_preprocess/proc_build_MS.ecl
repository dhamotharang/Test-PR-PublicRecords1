EXPORT proc_build_MS(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_MS_All_Available(fdate).dospray,
                                                                                           Map_MS_All_Available(fdate).buildprep
																																													    ),
																	 
																									                            Output('MS License type '+lictype +'is new' )
											);
																	
											
																
end;