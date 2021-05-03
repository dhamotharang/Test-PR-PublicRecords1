IMPORT Orbit3, STD, _control;

EXPORT fn_Orbit_CreateOrUpdateBuildInstance(STRING BuildDate
																					 ,STRING ProductName
																					 ,STRING BuildStatus
                                           ,BOOLEAN RunCreateBuild = FALSE
																					 ,BOOLEAN AddComponentsToBuild = TRUE
																					 ,DATASET(Orbit3.Layouts.rPlatformStatus)  Platform    = DATASET([], Orbit3.Layouts.rPlatformStatus)																					
																					 ,STRING EmailList = OrbitConstants(productName).orbit_creBuildErr_email
																					 ) := FUNCTION
																					 
	CreateOrUpdateBI := ORBIT3.CreateOrUpdateBuildInstance(BuildDate, 
																													 TRIM(OrbitConstants(ProductName).MasterBuildName, LEFT, RIGHT),
																													 TRIM(OrbitConstants(ProductName).BuildName, LEFT, RIGHT),
                                                           BuildStatus,
                                                           RunCreateBuild,
																													 Platform,
																													 TRUE, /*exclude scorecard*/
                                                           EmailList,
																												   , /*pFromEmail*/ 
																												   , /*pBuildView*/
																												   AddComponentsToBuild
                                                          );

	RETURN CreateOrUpdateBI;
	
END;