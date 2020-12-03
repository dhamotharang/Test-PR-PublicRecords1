 EXPORT mac_fn_Orbit_Write_Profile_MBSAgency(BuildDate,
																						 ProductID) := FUNCTIONMACRO

  IMPORT Orbit3SOA, STD, _Control;
	
  BaseDist      := Orbit3SOA.GetPopulationStats(OrbitConstants(ProductID).ProfileWorkunitName);

	OUTPUT (BaseDist);
	
  RETURN Orbit3SOA.WriteProfileStats(BaseDist, 
                                     BuildDate, 
                                     OrbitConstants(PID).ProfileSuffixName,
                                     OrbitConstants(PID).SubsetName, 
                                     OrbitConstants(ProductID).ProfilePrefix,
                                     OrbitConstants(ProductID).ProfileType); 
                
ENDMACRO;