import STD,_control;
/*EXPORT SprayRegions := 	Std.File.SprayVariable(_control.IPAddress.edata12,
							'/hds_3/DowJones/mappings/regions.csv',
							12000,',',,'"',
							'thor400_60',		//_control.TargetGroup.ADL_400,
							'~thor::DowJones::regions',
							,,,true,false,false
						);*/
// temp						
EXPORT SprayRegions := 	Std.File.SprayVariable(_control.IPAddress.bctlpedata10,
							'/data/hds_3/DowJones/mappings/regions.csv.test',
							12000,',',,'"',
							'thor400_44',		//_control.TargetGroup.ADL_400,
							'~thor::DowJones::regions',
							,,,true,false,false
						);