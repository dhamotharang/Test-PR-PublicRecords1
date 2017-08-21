import lib_StringLib;
EXPORT proc_build_AL(string fdate,string lictype) := module

    export  prepall :=  map ( StringLib.StringToLowerCase(lictype) = 'medical' => 
		                                                                Sequential ( Spray_AL_Medical(fdate).dospray,
                                                                              Map_AL_Medical(fdate).buildprep
																	                                            ),
																									                  Output('AL License type '+lictype +'is new' )
																									
												) :  success(Send_Email('AL').buildsuccess), failure(Send_Email('AL').buildfailure);

											
																
end;