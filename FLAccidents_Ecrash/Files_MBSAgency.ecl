IMPORT Orbit3;

EXPORT Files_MBSAgency := MODULE

  EXPORT isAgency := TRUE:STORED('MBSAgency');
  EXPORT isAgencyQC := FALSE:STORED('MBSAgency_QC');
  EXPORT isAgencyDev := FALSE:STORED('MBSAgency_Dev');
  EXPORT MBSAgency_FilePath := '':STORED('MBSAgencyFilePath');	

  EXPORT TrimString(STRING str) := TRIM(str, LEFT, RIGHT);	

  EXPORT mac_fn_GetPrefix(iLabel) := FUNCTIONMACRO
    Prefix := TrimString(
                         MAP(isAgencyQC  => Files_MBSAgency_QC.iLabel,  
                             isAgencyDev => Files_MBSAgency_Dev.iLabel, 
                             isAgency    => Files_MBSAgency_Prefix.iLabel,
                             Files_MBSAgency_Prefix.iLabel)
                        );
    RETURN Prefix;	 
  ENDMACRO;

//#################################################################################
//                      Agency Prefix
//#################################################################################
  EXPORT SPRAY_PREFIX := mac_fn_GetPrefix(SPRAY_AGENCY_PREFIX);
  EXPORT BASE_PREFIX := mac_fn_GetPrefix(BASE_AGENCY_PREFIX);
							
//#################################################################################
//                      Agency Suffix 
//#################################################################################
  EXPORT SUFFIX := 'mbsagency';
	
//###########################################################################
//                 Agency Logical Spray File Definition
//###########################################################################	
  EXPORT FILE_SPRAY_AGENCY_LF(STRING pDate) := SPRAY_PREFIX + '::' + pDate + '::' + SUFFIX;																													

//###########################################################################
//               Agency Spray Dataset Super File Definition
//###########################################################################
  EXPORT FILE_SPRAY_AGENCY_SF := SPRAY_PREFIX + '::QA::' + SUFFIX;

//###########################################################################
//               Agency Spray Dataset Definition
//###########################################################################  
  EXPORT DS_SPRAY_AGENCY := DATASET(FILE_SPRAY_AGENCY_SF,
																		Layout_MBSAgency.agency_spray,
																		csv(terminator(['|\n', '\n', '\nr', '\r', '\rn']), separator('|\t|'),quote('"')))
														(Agency_ID != 'Agency_ID');

//###########################################################################
//              Agency Build Logical File Name Settings
//###########################################################################
  EXPORT FILE_BASE_AGENCY_SF := BASE_PREFIX + '::QA::' + SUFFIX;
	EXPORT FILE_BASE_AGENCY_FATHER_SF := BASE_PREFIX + '::FATHER::' + SUFFIX;
	EXPORT FILE_BASE_AGENCY_GRANDFATHER_SF := BASE_PREFIX + '::GRANDFATHER::' + SUFFIX;
	
//###########################################################################
//              Agency Build Base File Dataset Definition  
//###########################################################################	
  EXPORT DS_BASE_AGENCY := DATASET(FILE_BASE_AGENCY_SF, Layout_MBSAgency.agency, THOR, OPT);
   
//###########################################################################
//              Agency Orbit Profile Dataset Definition
//###########################################################################	
  EXPORT DS_AGENCY_BASE_PROFILE := DATASET([{OrbitConstants(ProductName.MBS_AgencyBuild).ProfileName, 
                                             OrbitConstants(ProductName.MBS_AgencyBuild).ProfileType}],
																						Orbit3.Layouts.RequestGetProfileLayout);	
END;