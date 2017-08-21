//profession : Physician

EXPORT proc_build_MA(string fdate,string lictype) := module

export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'physician' => Sequential ( Spray_MA_Physician(fdate).dospray,
                                                                                             Map_MA_Physician(fdate).buildprep
																	                                                            ),
																	 
																									                            Output('MA License type '+lictype +'is new' )
											);
											
																
end;