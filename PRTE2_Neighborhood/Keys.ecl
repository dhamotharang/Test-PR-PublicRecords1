IMPORT PRTE2_Neighborhood, Address_Attributes, FBI_UCR, doxie, ut, Data_Services, STD;

EXPORT Keys := MODULE

	EXPORT aca_geolink := index(Files.ACA_Institute,{geolink}, {Files.ACA_Institute},
															Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::aca_institutions_geolink');
																	
	EXPORT businesses_geolink := index(Files.Businesses,{geolink, bdid}, {Files.Businesses},
																			Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::businesses_geolink');
																					
	EXPORT sexoffender_geolink := index(Files.SexOffender,{geolink}, {Files.SexOffender},
																			Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::sex_offender_geolink');
																					
	EXPORT school_geolink := index(Files.Schools,{geolink}, {Files.Schools},
																	Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::schools::geolink');
																			
	EXPORT colleges_geolink := index(Files.Colleges,{geolink}, {Files.Colleges},
																				Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::colleges::geolink');
																				
	EXPORT FireDepartment_geolink := index(Files.FireDept,{geolink}, {Files.FireDept},
																					Constants.KEY_PREFIX + doxie.Version_SuperKey + '::fire_department_geolink');
																							
	EXPORT LawEnforcement_geolink := index(Files.LawEnforcement,{geolink}, {Files.LawEnforcement},
																					Constants.KEY_PREFIX + doxie.Version_SuperKey + '::law_enforcement_geolink');
																		
END;