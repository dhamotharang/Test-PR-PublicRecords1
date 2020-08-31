EXPORT proc_build_CT(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'available' => Sequential ( Spray_CT_All_Available(fdate).dospray,
                                                                                           Map_CT_All_Available(fdate).buildprep
																	                                                       ),
																	 
																									                            Output('CT License type '+lictype +'is new' )
																									
												);
											
																
end;