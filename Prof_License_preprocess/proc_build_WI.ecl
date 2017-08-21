EXPORT proc_build_WI(string fdate, string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_WI_All_Available(fdate).dospray,
                                                                                             Map_WI_All_Available(fdate).buildprep
																	                                                          ),
																	 
																									                            Output('WI License type '+lictype +'is new' )
											);
											
											
																
end;