IMPORT STD, _control;

EXPORT Constants_MBSAgency := MODULE

	EXPORT EmailTarget := '':STORED('EmailTarget');
	
	EXPORT AgencyBuildName := 'eCrash MBSAgency';

// ###########################################################################
// Landing Zone and Thor Settings
// ###########################################################################
	EXPORT LandingZone := Constants.LandingZone;
	
	EXPORT ThorDest := Constants.DestinationCluster;

	EXPORT LocationPrefix := '~';
	
	EXPORT AgencyLZPathPrefix := '/data/super_credit/ecrash/incoming/mbs';
	EXPORT AgencyLZFilename := 'mbs_ecrash_v_agency_hpcc_export.txt';
	
	EXPORT FileSeparator := '/';
	EXPORT RecordSeparator := '|';
	
	EXPORT SprayFileDaysToExpire := 5;


// ###########################################################################   
// Set ProdID
// ###########################################################################	
   EXPORT ProdID  :=   AgencyBuildName;
                                    
	
//###########################################################################
//                     Email settings.
//@DataOpsEmailTarget   : Data Operations and Orbit Entry errors
//@DevEmailTarget       : Development Email receving team  
//@BuildEmailTarget     : Insurance Ecrash Data Build, data_ops_email_target
//###########################################################################
  EXPORT DataOpsEmailTarget := IF (EmailTarget = '', 'Sudhir.Kasavajjala@lexisnexisrisk.com', EmailTarget);
  EXPORT DevEmailTarget := IF (EmailTarget = '', 'DataDevelopment-InsRiskeCrash@lexisnexisrisk.com', EmailTarget);	
  EXPORT ProdEmailTarget := IF (EmailTarget = '', 'DataDevelopment-InsRiskeCrash@lexisnexisrisk.com' + ', ' + DataOpsEmailTarget, EmailTarget);
  EXPORT BuildEmailTarget := IF (_control.ThisEnvironment.Name <> 'Prod', DevEmailTarget, ProdEmailTarget);


// ###########################################################################
//                       Builds Status
// ###########################################################################
	 EXPORT BUILD_STATUS_NO_INPUT_FILE := 'Input File Missing';
	 EXPORT BUILD_STATUS_EMPTY_INPUT_FILE := 'Input File Is Empty';
	 EXPORT BUILD_STATUS_SUCCESS := 'Build Successful';
	 EXPORT BUILD_STATUS_FAILURE := 'Build Failure';
	 

// ###########################################################################
//                   Email Type for Build Status
// ###########################################################################
   EXPORT UNSIGNED1 EMAIL_TYPE_SUCCESS := 0;
   EXPORT UNSIGNED1 EMAIL_TYPE_FAILURE := 1;
   EXPORT UNSIGNED1 EMAIL_TYPE_BILLING := 2;
	
END;