﻿import STD,_Control;
EXPORT Constants(string Env = 'N',string platform_status = 'ON_DEVELOPMENT') := module

r := Orbit3.Layouts.rPlatformStatus;

 export  dataset(r) platform_upd :=  map (     Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => dataset([{'NonFCRA',platform_status},{'Boolean',platform_status},{'FCRA',platform_status}],r),
                                                                            Env = 'N|B' => dataset([{'NonFCRA',platform_status},{'Boolean',platform_status}],r),
                                                                             Env = 'F' => dataset([{'FCRA',platform_status}],r),
														  Env = 'B' => dataset([{'Boolean',platform_status}],r),
														  Env = 'PN'  and _Control.ThisEnvironment.Name <> 'Prod_Thor' => dataset([{'PRCT',platform_status}],r),
														   Env = 'PN'  and _Control.ThisEnvironment.Name = 'Prod_Thor' => dataset([{'PRTE NonFCRA',platform_status}],r),
	                                                                        Env = 'PF'  and _Control.ThisEnvironment.Name <> 'Prod_Thor' => dataset([{'FCRA PRCT',platform_status}],r),
														  Env = 'PF'  and _Control.ThisEnvironment.Name = 'Prod_Thor' => dataset([{'PRTE FCRA',platform_status}],r),
														Env = '' and _Control.ThisEnvironment.Name = 'Prod_Thor' => dataset([{' ',platform_status}],r),
														dataset([{'NonFCRA',platform_status}],r)
																		);
																		
	export which_env := map ( Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => 'NonFCRA, Boolean and FCRA',
	                                              Env = 'N|B' => 'NonFCRA and Boolean',
	                                               Env = 'F' => 'FCRA',
										Env = 'B' => 'Boolean',
										Env = 'PN' => 'PRTE NonFCRA',
										Env = 'PF' => 'PRTE  FCRA',
										Env = '' => 'No Platform',
										'NonFCRA'
												);
   
end;