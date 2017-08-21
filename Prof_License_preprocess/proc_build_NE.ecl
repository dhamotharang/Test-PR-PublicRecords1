EXPORT proc_build_NE(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_NE_All_Available(fdate).dospray,
                                                                                           Map_NE_All_Available(fdate).buildprep
																																													    ),
																	 
																									                            Output('NE License type '+lictype +'is new' )
											);
																	
											
																
end;