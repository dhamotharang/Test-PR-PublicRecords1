import STD;
EXPORT Constants(string Env = 'N',string platform_status = 'ON_DEVELOPMENT') := module

r := Orbit3.Layouts.rPlatformStatus;

 export  dataset(r) platform_upd :=  map (     Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => dataset([{'Roxie Production',platform_status},{'Boolean Roxie Production',platform_status},{'FCRA Roxie Production',platform_status}],r),
                                        Env = 'N|B' => dataset([{'Roxie Production',platform_status},{'Boolean Roxie Production',platform_status}],r),
                                        Env = 'F' => dataset([{'FCRA Roxie Production',platform_status}],r),
																				Env = 'B' => dataset([{'Boolean Roxie Production',platform_status}],r),
																				Env = 'HC' => dataset([{'HC',platform_status}],r),
																				dataset([{'Roxie Production',platform_status}],r)
																		);
																		
	export which_env := map ( Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => 'NonFCRA, Boolean and FCRA',
	                       Env = 'N|B' => 'NonFCRA and Boolean',
	                       Env = 'F' => 'FCRA',
												 Env = 'B' => 'Boolean',
												 Env = 'HC' => 'HealthCare',
												 'NonFCRA'
												);
   
end;