EXPORT proc_build_PA (string fdate, string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential (  Spray_PA_All_Available(fdate).dospray,
                                                                                              Map_PA_All_Available(fdate).buildprep
																	                                                          ),
																	 
																									                               Output('PA License type '+lictype +'is new' )
											    );
											
																
end;