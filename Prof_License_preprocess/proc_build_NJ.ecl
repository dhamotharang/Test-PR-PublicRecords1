EXPORT proc_build_NJ (string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_NJ_All_Available(fdate).dospray,
                                                                                              Map_NJ_All_Available(fdate).buildprep
																	                                                          ),
																	 
																									                            Output('NJ License type '+lictype +'is new' )
											);
											
																
end;