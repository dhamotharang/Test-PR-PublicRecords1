EXPORT proc_build_CA(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_CA_All_Available(fdate).dospray,
                                                                                           Map_CA_AllAvailable(fdate).buildprep
																																													    ),
																	 
																									                            Output('CA License type '+lictype +'is new' )
											);
																	
											
																
end;