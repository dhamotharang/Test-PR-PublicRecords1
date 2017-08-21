//Profession : Medical

EXPORT proc_build_MD(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'medical' => Sequential ( Spray_MD_Medical(fdate).dospray,
                                                                                       Map_MD_Medical(fdate).buildprep
																	                                                     ),
																	 
																									                            Output('MD License type '+lictype +'is new' )
											);
											
																
end;