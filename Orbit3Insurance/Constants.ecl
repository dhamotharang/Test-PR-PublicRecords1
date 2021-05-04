import STD,Orbit3;
EXPORT Constants(string Env = 'N',string platform_status = 'ON_DEVELOPMENT') := module

r := Orbit3.Layouts.rPlatformStatus;

 export  dataset(r) platform_upd :=  map (     Env = 'N|B|F'  => dataset([{'Non FCRA Roxie',platform_status},{'Boolean Roxie Production',platform_status},{'FCRA Roxie Production',platform_status}],r),
                                                                              Env = 'N|T|F'  => dataset([{'Non FCRA Roxie',platform_status},{'Customer Test Roxie Production',platform_status},{'FCRA Roxie Production',platform_status}],r),
                                        Env = 'N|B' => dataset([{'Non FCRA Roxie',platform_status},{'Boolean Roxie Production',platform_status}],r),
                                        Env = 'F' => dataset([{'FCRA Roxie Production',platform_status}],r),
										Env = 'T' => dataset([{'Customer Test Roxie Production',platform_status}],r),
																				Env = 'B' => dataset([{'Boolean Roxie Production',platform_status}],r),
																				Env = 'HC' => dataset([{'HC',platform_status}],r),
																				dataset([{'Non FCRA Roxie',platform_status}],r)
																		);
																		
	export which_env := map ( Env = 'N|B|F'  => 'NonFCRA, Boolean and FCRA',
	                                              Env = 'N|T|F'  => 'NonFCRA, Customer Test and FCRA',
	                       Env = 'N|B' => 'NonFCRA and Boolean',
	                       Env = 'F' => 'FCRA',
						   Env = 'T' => 'Customer Test',
												 Env = 'B' => 'Boolean',
												 Env = 'HC' => 'HealthCare',
												 'NonFCRA'
												);
   
end;