EXPORT proc_build_HI(string fdate,string lictype) := module

export  prepall := map ( StringLib.StringToLowerCase(lictype) = 'available' =>  Sequential ( Spray_HI_All_Available(fdate).dospray,
                                                                                             Map_HI_All_Available(fdate).prep
																	                                                             ),
																																														
																	 
																									                            Output('HI License type '+lictype +'is new' )
											);
											
																
end;