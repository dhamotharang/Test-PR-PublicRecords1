IMPORT HealthCare_Provider_Header.Constants AS modConstants;
//CURRENTLY NOT USED
EXPORT modSourceTools := Module
  
  EXPORT SourceIsDeath(STRING src)                    := src = 'DEATH';
  EXPORT SourceIsSanctions(string src)                := src = 'SANCTIONS';
  EXPORT aSourceIsGCID(UNSIGNED iGCID, UNSIGNED iNum)    := iNum = iGCID;
  EXPORT aSourceIsDEA(STRING sSrc)                      := sSrc = modConstants.SourceCategory.DEA;
  EXPORT aSourceIsPL(STRING sSrc)                       := sSrc = modConstants.SourceCategory.License;
	
END;
