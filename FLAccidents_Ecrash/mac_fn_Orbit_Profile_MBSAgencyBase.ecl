EXPORT mac_fn_Orbit_Profile_MBSAgencyBase(BuildDate,
																				  ProductID,
																					ProfileDistribution) := FUNCTIONMACRO

  IMPORT Orbit3SOA, _Control;

	GetBuildStatus := Orbit3SOA.GetBuildInstanceStatus(BuildDate,
                                                     OrbitConstants(ProductID).masterbuildname) : INDEPENDENT; 																									 
	
  RunOrbitProfiles := SEQUENTIAL(MAP(GetBuildStatus = 'D' => FAIL('Use Launch and Prep to Create Orbit Builds'),
                                     GetBuildStatus = 'R' => FAIL('Build Instance Status is set to Build Requires Review the build was halted.') ,
                                     GetBuildStatus = 'A' => FAIL('Build Instance Status is Production Ready and we can not overwrite that in Standard Code.') ,
                                     GetBuildStatus = 'U' => FAIL('Build Instance Status is Unknown and the build is UNAVAILABLE. Please Check Orbit InsuranceUS')),
                                     // ELSE : CONTINUE
                                 ProfileDistribution,
                                 mac_fn_Orbit_Write_Profile_MBSAgency(BuildDate,
																																		  ProductID)
                                 );            

  RETURN RunOrbitProfiles;
	
ENDMACRO;