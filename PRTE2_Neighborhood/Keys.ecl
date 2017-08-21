IMPORT PRTE2_Neighborhood, Address_Attributes, FBI_UCR, doxie, ut, Data_Services, STD;

EXPORT Keys := MODULE

	EXPORT aca_geolink := index(Files.ACA_Institute,{geolink}, {Files.ACA_Institute},
															Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::aca_institutions_geolink');
																	
	EXPORT Neighborhood_stats_geolink := index(Files.Neighborhood_Stats,{geolink}, {Files.Neighborhood_Stats},
																							Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::neighborhoodstats::geolink');
																								
	EXPORT businesses_geolink := index(Files.Businesses,{geolink, bdid}, {Files.Businesses},
																			Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::businesses_geolink');
																					
	EXPORT sexoffender_geolink := index(Files.SexOffender,{geolink}, {Files.SexOffender},
																			Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::sex_offender_geolink');
																					
	EXPORT school_geolink := index(Files.Schools,{geolink}, {Files.Schools},
																	Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::schools::geolink');
																			
	EXPORT colleges_geolink := index(Files.Colleges,{geolink}, {Files.Colleges},
																				Constants.KEY_PREFIX + doxie.Version_SuperKey+ '::colleges::geolink');
																				
	EXPORT CIUS_city_addr := index(Files.FBI_CIUS,{state, city}, {Files.FBI_CIUS},
																	Constants.KEY_PREFIX + doxie.Version_SuperKey + '::fbi_cius_city::address');
																			
	EXPORT FireDepartment_geolink := index(Files.FireDept,{geolink}, {Files.FireDept},
																					Constants.KEY_PREFIX + doxie.Version_SuperKey + '::fire_department_geolink');
																							
	EXPORT LawEnforcement_geolink := index(Files.LawEnforcement,{geolink}, {Files.LawEnforcement},
																					Constants.KEY_PREFIX + doxie.Version_SuperKey + '::law_enforcement_geolink');
																							
	EXPORT GeoLinkDistance_GeoLink := index(Files.GEOLinkDistance, {geolink1, dist_100th}, {geolink2},
																					Constants.KEY_PREFIX + doxie.Version_SuperKey + '::geolink_to_geolink::geolink_dist_100th');
																							
	EXPORT GeoLink_LatLon := index(Files.GEOBlk_LatLon, {lat1000}, {geolink,lat,lon},
																	Constants.KEY_PREFIX + doxie.Version_SuperKey + '::geoblk_latlon');
																		
	EXPORT GeoInfo_Geolink := index(Files.GEOBlkInfo, {geolink}, {lat, long},
																	Constants.KEY_PREFIX + doxie.Version_SuperKey + 'geoblk_info_geolink');
																			
	//crime::geolink key is a copy of the key in Production - not needed as code added to create a copy of Production key
	// EXPORT crime_geolink := index(Files.CrimeGeoLink,{geolink}, {Files.CrimeGeoLink},
																// Constants.KEY_PREFIX + doxie.Version_SuperKey + '::crime::geolink');
																		
END;