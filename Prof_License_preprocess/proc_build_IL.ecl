EXPORT proc_build_IL(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_IL_All_Available(fdate).dospray,
                                                                                           Map_IL_All_Available(fdate).buildprep
																	                                                       ),
																	 
																									                            Output('IL License type '+lictype +'is new' )
																									
												);
											
																
end;